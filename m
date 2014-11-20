Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141119193755.GA28710@t440s.P-661HNU-F1>
References: <1415637211-11339-1-git-send-email-jpawlowski@google.com>
	<1415637211-11339-3-git-send-email-jpawlowski@google.com>
	<20141119193755.GA28710@t440s.P-661HNU-F1>
Date: Thu, 20 Nov 2014 09:51:19 -0800
Message-ID: <CAD0=r8wjGbfmfah4ecUtrhLUgbHZT7AZV8ZXjhjKrM=Zo7B9WQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Bluetooth: start and stop service discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 19, 2014 at 11:37 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Mon, Nov 10, 2014, Jakub Pawlowski wrote:
>>  /* Default LE RPA expiry time, 15 minutes */
>> @@ -307,6 +313,8 @@ struct hci_dev {
>>       struct discovery_state  discovery;
>>       struct hci_conn_hash    conn_hash;
>>
>> +     struct list_head discov_uuid_filter;
>
> Would it not make sense to include this inside the discovery_state
> struct?
>
>> +void mgmt_clean_up_service_discovery(struct hci_dev *hdev)
>> +{
>> +     struct uuid_filter *filter;
>> +     struct uuid_filter *tmp;
>> +
>> +     if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags))
>> +             return;
>> +
>> +     clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags);
>
> The above two test_bit & clear_bit calls could be combined into a single
> atomic test_and_clear_bit call:
>
>         if (!test_and_clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags)
>                 return;
>
>> +int init_service_discovery(struct hci_dev *hdev,
>> +                        struct mgmt_uuid_filter *filters, __le16 filter_cnt)
>
> Should this function not be declared static?
>
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < filter_cnt; i++) {
>
> filter_cnt is a little endian value so this is completely broken on any
> big endian architecture. The general principle we follow is to try to
> keep the protocol endianness only in the protocol PDUs and everywhere
> else in host endianness. So you should probably change this function to
> receive a u16 instead.
>
>>  static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
>>                                  void *data, u16 len, uint16_t opcode)
>>  {
>> -     struct mgmt_cp_start_discovery *cp = data;
>>       struct pending_cmd *cmd;
>>       struct hci_cp_le_set_scan_param param_cp;
>>       struct hci_cp_le_set_scan_enable enable_cp;
>>       struct hci_cp_inquiry inq_cp;
>>       struct hci_request req;
>> +     struct mgmt_uuid_filter *serv_filters = NULL;
>>       /* General inquiry access code (GIAC) */
>>       u8 lap[3] = { 0x33, 0x8b, 0x9e };
>>       u8 status, own_addr_type, type;
>>       int err;
>> +     __le16 serv_filter_cnt = 0;
>>
>>       BT_DBG("%s", hdev->name);
>>
>> -     type = cp->type;
>> +     if (opcode == MGMT_OP_START_SERVICE_DISCOVERY) {
>> +             struct mgmt_cp_start_service_discovery *cp = data;
>> +             u16 expected_len, filter_count;
>> +
>> +             type = cp->type;
>> +             filter_count = __le16_to_cpu(cp->filter_count);
>
> Ok, here I see the problem with this filter_count. Your code might
> actually work because you do have the endianness conversion here, but
> you have the wrong type for this variable. Since you're converting to
> host endianness you can't assign to a __le16 variable. Instead this
> variable should be declared u16. Static analyzers (e.g. sparse) should
> have given you a warning here.
>
>> +     if (serv_filters != NULL) {
>> +             err = init_service_discovery(hdev, serv_filters,
>> +                                          serv_filter_cnt);
>> +             if (err != 0)
>> +                     goto failed;
>
> I think "if (err)" is more common than "if (err != 0)".
>
>> +void free_uuids_list(struct list_head *uuids)
>
> Shouldn't this be declared static (you should be getting compiler
> warnings because of it).
>
>> +uint8_t find_match(struct uuid_filter *filter, u8 *uuid, s8 rssi)
>
> Why suddenly uint8_t (which btw should be u8) when you've everywhere
> else used "int" for the match type? Also, shouldn't this function be
> declared static? The uuid is probably better declared as "u8 uuid[16]"
> to make it clear that it has a fixed expected length.

I also found similar error in patch 2/3 introducing generic start/stop
discovery which I fixed  (I was using uint16_t instead of u16)

>
>> +int find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids)
>
> Missing static declaration again?
>
>>  void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>                      u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>>                      u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
>> @@ -6820,6 +7061,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>       char buf[512];
>>       struct mgmt_ev_device_found *ev = (void *) buf;
>>       size_t ev_size;
>> +     LIST_HEAD(uuids);
>> +     int ret = 0;
>> +     u8 match_type;
>>
>>       /* Don't send events for a non-kernel initiated discovery. With
>>        * LE one exception is if we have pend_le_reports > 0 in which
>> @@ -6858,7 +7102,29 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>       ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
>>       ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
>>
>> -     mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
>> +     if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags)) {
>> +             mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
>> +             return;
>> +     }
>> +
>> +     ret = eir_parse(eir, eir_len, &uuids);
>> +     if (list_empty(&uuids) || ret != 0)
>> +             return;
>
> I think I already mentioned this in a previous review but you've got a
> memory leak here if the list is not empty but eir_parse still fails (ret
> is not 0). Btw, please be consistent with your error variables - you
> used "err" in an earlier place (which I prefer) and the check can be "if
> (err)" instead of "if (err != 0)".

The other memory leak was in find_matches, and it's already fixed.

>
> Johan
