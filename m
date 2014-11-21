Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25SvTOSn0quv7TWcNEwAYxRfUeqS2bwYg7+auW=wmO_H6A@mail.gmail.com>
References: <1416506185-30315-1-git-send-email-jpawlowski@google.com>
	<CAHrH25SvTOSn0quv7TWcNEwAYxRfUeqS2bwYg7+auW=wmO_H6A@mail.gmail.com>
Date: Fri, 21 Nov 2014 09:57:50 -0800
Message-ID: <CAD0=r8wb0RV88WRp+0yT2RztZHsZxtXq_Yuif=KuN-TfEMxojA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] Bluetooth: start and stop service discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 20, 2014 at 3:33 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Jakub,
>
>> On Thu, Nov 20, 2014 at 9:56 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> This patch introduces start service discovery and stop service
>> discovery methods. The reason behind that is to enable users to find
>> specific services in range by UUID. Whole filtering is done in
>> mgmt_device_found.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>>  include/net/bluetooth/hci.h      |   1 +
>>  include/net/bluetooth/hci_core.h |  11 ++
>>  include/net/bluetooth/mgmt.h     |  24 ++++
>>  net/bluetooth/hci_core.c         |   1 +
>>  net/bluetooth/mgmt.c             | 296 +++++++++++++++++++++++++++++++++++++--
>>  5 files changed, 324 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 2f0bce2..97b0893 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -204,6 +204,7 @@ enum {
>>         HCI_BREDR_ENABLED,
>>         HCI_LE_SCAN_INTERRUPTED,
>>         HCI_LE_SCAN_RESTARTING,
>> +       HCI_SERVICE_FILTER,
>
> I'm not sure if this really belongs in this enum. I don't think
> HCI_SERVICE_FILTER really respresents "a state from the controller".
> So perhaps this should be part of the QUIRK enum instead? Maybe Johan
> should chime in on this.
>

So I was asked to put HCI_SERVICE_FILTER into hdev->dev_flags, and I
looked through the code, and it looks like hdev->dev_flags uses this
enum so I just added my thing there.

>>  };
>>
>>  /* A mask for the flags that are supposed to remain when a reset happens
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 36211f9..39009f2 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -68,6 +68,7 @@ struct discovery_state {
>>         struct list_head        all;    /* All devices found during inquiry */
>>         struct list_head        unknown;        /* Name state not known */
>>         struct list_head        resolve;        /* Name needs to be resolved */
>> +       struct list_head        uuid_filter;
>>         __u32                   timestamp;
>>         bdaddr_t                last_adv_addr;
>>         u8                      last_adv_addr_type;
>> @@ -146,6 +147,12 @@ struct oob_data {
>>         u8 rand256[16];
>>  };
>>
>> +struct uuid_filter {
>> +       struct list_head list;
>> +       s8 rssi;
>> +       u8 uuid[16];
>> +};
>> +
>>  #define HCI_MAX_SHORT_NAME_LENGTH      10
>>
>>  /* Default LE RPA expiry time, 15 minutes */
>> @@ -502,6 +509,7 @@ static inline void discovery_init(struct hci_dev *hdev)
>>         INIT_LIST_HEAD(&hdev->discovery.all);
>>         INIT_LIST_HEAD(&hdev->discovery.unknown);
>>         INIT_LIST_HEAD(&hdev->discovery.resolve);
>> +       INIT_LIST_HEAD(&hdev->discovery.uuid_filter);
>>  }
>>
>>  bool hci_discovery_active(struct hci_dev *hdev);
>> @@ -1328,6 +1336,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
>>  #define DISCOV_INTERLEAVED_INQUIRY_LEN 0x04
>>  #define DISCOV_BREDR_INQUIRY_LEN       0x08
>>
>> +#define DISCOV_LE_RESTART_DELAY msecs_to_jiffies(300)
>> +
>>  int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
>>  int mgmt_new_settings(struct hci_dev *hdev);
>>  void mgmt_index_added(struct hci_dev *hdev);
>> @@ -1394,6 +1404,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>                          u16 max_interval, u16 latency, u16 timeout);
>>  void mgmt_reenable_advertising(struct hci_dev *hdev);
>>  void mgmt_smp_complete(struct hci_conn *conn, bool complete);
>> +void mgmt_clean_up_service_discovery(struct hci_dev *hdev);
>>
>>  u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
>>                       u16 to_multiplier);
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index b391fd6..202caf7 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -495,6 +495,30 @@ struct mgmt_cp_set_public_address {
>>  } __packed;
>>  #define MGMT_SET_PUBLIC_ADDRESS_SIZE   6
>>
>> +#define MGMT_OP_START_SERVICE_DISCOVERY        0x003A
>
> I think I commented before that I don't like that this command is
> called "Service Discovery" which makes me think of SDP or even GATT
> instead of a "device scan filtered by service UUID". So I don't know
> if it's too late to change the name of the command, I guess Marcel
> needs to be in that fight too. Something like "Start Filtered Device
> Scan" would be much more intuitive IMO, since we have proximity
> filters here as well.
>

I think that marcel was having some concerns about naming generic*
methods I introducet in mgmt.c, but didn't say anything about this
one. Actually I think that I took this name from his patch to
doc/mgmt-api.txt so it should be ok.
http://marc.info/?l=linux-bluetooth&m=141293816613415&w=2

>> +#define MGMT_START_SERVICE_DISCOVERY_SIZE 1
>> +
>> +#define MGMT_RANGE_NONE                        0x00
>> +#define MGMT_RANGE_RSSI                        0x01
>> +#define MGMT_RANGE_PATHLOSS            0x02
>> +
>
> Do these represent the different proximity filters? Then we should
> name this accordingly; MGMT_RANGE_* sounds to generic to me, maybe
> MGMT_PROXIMITY_FILTER_* (or something like that)?
>
> Also, what is the *_PATHLOSS macro for? Aren't we always filtering by
> RSSI? Actually, why aren't we always filtering by pathloss? Eitherway,
> if PATHLOSS is unused I would just remove it for now.
>

All MGMT_RANGE_* are no longer used, I forgot to remove that.

>> +struct mgmt_uuid_filter {
>> +       __s8 rssi;
>> +       __u8 uuid[16];
>> +} __packed;
>> +
>> +struct mgmt_cp_start_service_discovery {
>> +       __u8 type;
>> +       __le16 filter_count;
>> +       struct mgmt_uuid_filter filter[0];
>> +} __packed;
>> +
>> +#define MGMT_OP_STOP_SERVICE_DISCOVERY 0x003B
>> +struct mgmt_cp_stop_service_discovery {
>> +       __u8 type;
>> +} __packed;
>> +#define MGMT_STOP_SERVICE_DISCOVERY_SIZE 1
>> +
>>  #define MGMT_EV_CMD_COMPLETE           0x0001
>>  struct mgmt_ev_cmd_complete {
>>         __le16  opcode;
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 858cf54..fab6755 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3853,6 +3853,7 @@ static void le_scan_disable_work(struct work_struct *work)
>>         BT_DBG("%s", hdev->name);
>>
>>         cancel_delayed_work_sync(&hdev->le_scan_restart);
>> +       mgmt_clean_up_service_discovery(hdev);
>>
>>         hci_req_init(&req, hdev);
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index f650d30..ed67060 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -93,6 +93,8 @@ static const u16 mgmt_commands[] = {
>>         MGMT_OP_READ_CONFIG_INFO,
>>         MGMT_OP_SET_EXTERNAL_CONFIG,
>>         MGMT_OP_SET_PUBLIC_ADDRESS,
>> +       MGMT_OP_START_SERVICE_DISCOVERY,
>> +       MGMT_OP_STOP_SERVICE_DISCOVERY,
>>  };
>>
>>  static const u16 mgmt_events[] = {
>> @@ -1258,6 +1260,23 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
>>         }
>>  }
>>
>> +void mgmt_clean_up_service_discovery(struct hci_dev *hdev)
>> +{
>
> Can you perhaps add a comment somewhere that this function in effect
> cleans up the state set up by the "Start Service Discovery" function.
> It's not easy to make that association just by looking at the function
> name while we have a dozen functions with the name "discovery" in it
> that correspond to the other mgmt device discovery command.
>
>> +       struct uuid_filter *filter;
>> +       struct uuid_filter *tmp;
>> +
>> +       if (!test_and_clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags))
>> +               return;
>> +
>> +       cancel_delayed_work_sync(&hdev->le_scan_restart);
>> +
>> +       list_for_each_entry_safe(filter, tmp, &hdev->discovery.uuid_filter,
>> +                                list) {
>> +               __list_del_entry(&filter->list);
>> +               kfree(filter);
>> +       }
>> +}
>> +
>>  static bool hci_stop_discovery(struct hci_request *req)
>>  {
>>         struct hci_dev *hdev = req->hdev;
>> @@ -1270,6 +1289,7 @@ static bool hci_stop_discovery(struct hci_request *req)
>>                         hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
>>                 } else {
>>                         cancel_delayed_work(&hdev->le_scan_disable);
>> +                       mgmt_clean_up_service_discovery(hdev);
>>                         hci_req_add_le_scan_disable(req);
>>                 }
>>
>> @@ -3742,23 +3762,75 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
>>         generic_start_discovery_complete(hdev, status, MGMT_OP_START_DISCOVERY);
>>  }
>>
>> +static void start_service_discovery_complete(struct hci_dev *hdev, u8 status)
>> +{
>> +       generic_start_discovery_complete(hdev, status,
>> +                                        MGMT_OP_START_SERVICE_DISCOVERY);
>> +}
>> +
>> +static int init_service_discovery(struct hci_dev *hdev,
>> +                                 struct mgmt_uuid_filter *filters,
>> +                                 u16 filter_cnt)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < filter_cnt; i++) {
>> +               struct mgmt_uuid_filter *key = &filters[i];
>> +               struct uuid_filter *tmp;
>> +
>> +               tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
>> +               if (!tmp)
>> +                       return -ENOMEM;
>> +
>> +               memcpy(tmp->uuid, key->uuid, 16);
>> +               tmp->rssi = key->rssi;
>> +               INIT_LIST_HEAD(&tmp->list);
>> +
>> +               list_add(&tmp->list, &hdev->discovery.uuid_filter);
>> +       }
>> +       set_bit(HCI_SERVICE_FILTER, &hdev->dev_flags);
>> +       return 0;
>> +}
>> +
>>  static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
>>                                    void *data, u16 len, uint16_t opcode)
>>  {
>> -       struct mgmt_cp_start_discovery *cp = data;
>>         struct pending_cmd *cmd;
>>         struct hci_cp_le_set_scan_param param_cp;
>>         struct hci_cp_le_set_scan_enable enable_cp;
>>         struct hci_cp_inquiry inq_cp;
>>         struct hci_request req;
>> +       struct mgmt_uuid_filter *serv_filters = NULL;
>>         /* General inquiry access code (GIAC) */
>>         u8 lap[3] = { 0x33, 0x8b, 0x9e };
>>         u8 status, own_addr_type, type;
>>         int err;
>> +       u16 serv_filter_cnt = 0;
>>
>>         BT_DBG("%s", hdev->name);
>>
>> -       type = cp->type;
>> +       if (opcode == MGMT_OP_START_SERVICE_DISCOVERY) {
>> +               struct mgmt_cp_start_service_discovery *cp = data;
>> +               u16 expected_len, filter_count;
>> +
>> +               type = cp->type;
>> +               filter_count = __le16_to_cpu(cp->filter_count);
>> +               expected_len = sizeof(*cp) +
>> +                       filter_count * sizeof(struct mgmt_uuid_filter);
>> +
>> +               if (expected_len != len) {
>> +                       return cmd_complete(sk, hdev->id, opcode,
>> +                                           MGMT_STATUS_INVALID_PARAMS, &type,
>> +                                           sizeof(type));
>> +               }
>> +
>> +               serv_filters = cp->filter;
>> +               serv_filter_cnt = filter_count;
>> +       } else {
>> +               struct mgmt_cp_start_discovery *cp = data;
>> +
>> +               type = cp->type;
>> +       }
>>
>>         hci_dev_lock(hdev);
>>
>> @@ -3897,7 +3969,17 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
>>                 goto failed;
>>         }
>>
>> -       err = hci_req_run(&req, start_discovery_complete);
>> +       if (serv_filters != NULL) {
>> +               err = init_service_discovery(hdev, serv_filters,
>> +                                            serv_filter_cnt);
>> +               if (err)
>> +                       goto failed;
>> +       }
>> +
>> +       if (opcode == MGMT_OP_START_SERVICE_DISCOVERY)
>> +               err = hci_req_run(&req, start_service_discovery_complete);
>> +       else
>> +               err = hci_req_run(&req, start_discovery_complete);
>>
>>         if (err < 0)
>>                 mgmt_pending_remove(cmd);
>> @@ -3956,18 +4038,31 @@ static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
>>         generic_stop_discovery_complete(hdev, status, MGMT_OP_STOP_DISCOVERY);
>>  }
>>
>> +static void stop_service_discovery_complete(struct hci_dev *hdev, u8 status)
>> +{
>> +       generic_stop_discovery_complete(hdev, status,
>> +                                       MGMT_OP_STOP_SERVICE_DISCOVERY);
>> +}
>> +
>>  static int generic_stop_discovery(struct sock *sk, struct hci_dev *hdev,
>>                                   void *data, u16 len, uint16_t opcode)
>>  {
>>         struct pending_cmd *cmd;
>>         struct hci_request req;
>> -       struct mgmt_cp_stop_discovery *mgmt_cp = data;
>>         int err;
>>         u8 type;
>>
>>         BT_DBG("%s", hdev->name);
>>
>> -       type = mgmt_cp->type;
>> +       if (opcode == MGMT_OP_STOP_SERVICE_DISCOVERY) {
>> +               struct mgmt_cp_stop_service_discovery *mgmt_cp = data;
>> +
>> +               type = mgmt_cp->type;
>> +       } else {
>> +               struct mgmt_cp_stop_discovery *mgmt_cp = data;
>> +
>> +               type = mgmt_cp->type;
>> +       }
>>
>>         hci_dev_lock(hdev);
>>
>> @@ -3994,7 +4089,10 @@ static int generic_stop_discovery(struct sock *sk, struct hci_dev *hdev,
>>
>>         hci_stop_discovery(&req);
>>
>> -       err = hci_req_run(&req, stop_discovery_complete);
>> +       if (opcode == MGMT_OP_STOP_SERVICE_DISCOVERY)
>> +               err = hci_req_run(&req, stop_service_discovery_complete);
>> +       else
>> +               err = hci_req_run(&req, stop_discovery_complete);
>>
>>         if (!err) {
>>                 hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
>> @@ -5707,6 +5805,20 @@ unlock:
>>         return err;
>>  }
>>
>> +static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
>> +                                  void *data, u16 len)
>> +{
>> +       return generic_start_discovery(sk, hdev, data, len,
>> +                                      MGMT_OP_START_SERVICE_DISCOVERY);
>> +}
>> +
>> +static int stop_service_discovery(struct sock *sk, struct hci_dev *hdev,
>> +                                 void *data, u16 len)
>> +{
>> +       return generic_stop_discovery(sk, hdev, data, len,
>> +                                     MGMT_OP_STOP_SERVICE_DISCOVERY);
>> +}
>> +
>>  static const struct mgmt_handler {
>>         int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
>>                      u16 data_len);
>> @@ -5771,6 +5883,8 @@ static const struct mgmt_handler {
>>         { read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
>>         { set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
>>         { set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
>> +       { start_service_discovery, true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
>> +       { stop_service_discovery, false, MGMT_STOP_SERVICE_DISCOVERY_SIZE },
>>  };
>>
>>  int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
>> @@ -6837,6 +6951,135 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
>>         mgmt_pending_remove(cmd);
>>  }
>>
>> +struct parsed_uuid {
>> +       struct list_head list;
>> +       u8 uuid[16];
>> +};
>> +
>> +/* this is reversed hex representation of bluetooth base uuid. We need it for
>> + * service uuid parsing in eir.
>> + */
>> +static const u8 reverse_base_uuid[] = {
>> +                       0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
>> +                       0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
>> +};
>> +
>> +static int add_uuid_to_list(struct list_head *uuids, u8 *uuid)
>> +{
>> +       struct parsed_uuid *tmp_uuid;
>> +
>> +       tmp_uuid = kmalloc(sizeof(*tmp_uuid), GFP_KERNEL);
>> +       if (tmp_uuid == NULL)
>> +               return -ENOMEM;
>> +
>> +       memcpy(tmp_uuid->uuid, uuid, 16);
>> +       INIT_LIST_HEAD(&tmp_uuid->list);
>> +       list_add(&tmp_uuid->list, uuids);
>> +       return 0;
>> +}
>> +
>> +static void free_uuids_list(struct list_head *uuids)
>> +{
>> +       struct parsed_uuid *uuid, *tmp;
>> +
>> +       list_for_each_entry_safe(uuid, tmp, uuids, list) {
>> +               __list_del_entry(&uuid->list);
>> +               kfree(uuid);
>> +       }
>> +}
>> +
>> +static int eir_parse(u8 *eir, u8 eir_len, struct list_head *uuids)
>> +{
>> +       size_t offset;
>> +       u8 uuid[16];
>> +       int i, ret;
>> +
>> +       offset = 0;
>> +       while (offset < eir_len) {
>> +               uint8_t field_len = eir[0];
>> +
>> +               /* Check for the end of EIR */
>> +               if (field_len == 0)
>> +                       break;
>> +
>> +               if (offset + field_len > eir_len)
>> +                       return -EINVAL;
>> +
>> +               switch (eir[1]) {
>> +               case EIR_UUID16_ALL:
>> +               case EIR_UUID16_SOME:
>> +                       for (i = 0; i + 3 <= field_len; i += 2) {
>> +                               memcpy(uuid, reverse_base_uuid, 16);
>> +                               uuid[13] = eir[i + 3];
>> +                               uuid[12] = eir[i + 2];
>> +                               ret = add_uuid_to_list(uuids, uuid);
>> +                               if (ret)
>> +                                       return ret;
>> +                       }
>> +                       break;
>> +               case EIR_UUID32_ALL:
>> +               case EIR_UUID32_SOME:
>> +                       for (i = 0; i + 5 <= field_len; i += 4) {
>> +                               memcpy(uuid, reverse_base_uuid, 16);
>> +                               uuid[15] = eir[i + 5];
>> +                               uuid[14] = eir[i + 4];
>> +                               uuid[13] = eir[i + 3];
>> +                               uuid[12] = eir[i + 2];
>> +                               ret = add_uuid_to_list(uuids, uuid);
>> +                               if (ret)
>> +                                       return ret;
>> +                       }
>> +                       break;
>> +               case EIR_UUID128_ALL:
>> +               case EIR_UUID128_SOME:
>> +                       for (i = 0; i + 17 <= field_len; i += 16) {
>> +                               memcpy(uuid, eir + i + 2, 16);
>> +                               ret = add_uuid_to_list(uuids, uuid);
>> +                               if (ret)
>> +                                       return ret;
>> +                       }
>> +                       break;
>> +               }
>> +
>> +               offset += field_len + 1;
>> +               eir += field_len + 1;
>> +       }
>> +       return 0;
>> +}
>> +
>> +enum {
>> +       NO_MATCH,
>> +       SERVICE_MATCH,
>> +       FULL_MATCH
>> +};
>> +
>> +static u8 find_match(struct uuid_filter *filter, u8 uuid[16], s8 rssi)
>> +{
>> +       if (memcmp(filter->uuid, uuid, 16) != 0)
>> +               return NO_MATCH;
>> +       if (rssi >= filter->rssi)
>> +               return FULL_MATCH;
>> +
>> +       return SERVICE_MATCH;
>> +}
>> +
>> +static u8 find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids)
>> +{
>> +       struct uuid_filter *filter;
>> +       struct parsed_uuid *uuidptr, *tmp_uuid;
>> +       int match_type = NO_MATCH, tmp;
>> +
>> +       list_for_each_entry_safe(uuidptr, tmp_uuid, uuids, list) {
>> +               list_for_each_entry(filter, &hdev->discovery.uuid_filter,
>> +                                   list) {
>> +                       tmp = find_match(filter, uuidptr->uuid, rssi);
>> +                       if (tmp > match_type)
>> +                               match_type = tmp;
>> +               }
>> +       }
>> +       return match_type;
>> +}
>> +
>>  void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>                        u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>>                        u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
>> @@ -6844,6 +7087,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>         char buf[512];
>>         struct mgmt_ev_device_found *ev = (void *) buf;
>>         size_t ev_size;
>> +       LIST_HEAD(uuids);
>> +       int err = 0;
>> +       u8 match_type;
>>
>>         /* Don't send events for a non-kernel initiated discovery. With
>>          * LE one exception is if we have pend_le_reports > 0 in which
>> @@ -6882,7 +7128,31 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>>         ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
>>         ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
>>
>> -       mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
>> +       if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags)) {
>> +               mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
>> +               return;
>> +       }
>> +
>> +       err = eir_parse(eir, eir_len, &uuids);
>> +       if (err) {
>> +               free_uuids_list(&uuids);
>> +               return;
>> +       }
>> +
>> +       match_type = find_matches(hdev, rssi, &uuids);
>> +       free_uuids_list(&uuids);
>> +
>> +       if (match_type == NO_MATCH)
>> +               return;
>> +
>> +       if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)) {
>> +               queue_delayed_work(hdev->workqueue,
>> +                                  &hdev->le_scan_restart,
>> +                                  DISCOV_LE_RESTART_DELAY);
>> +       }
>
> You don't need the curly braces for the above if statement.
>
>> +       if (match_type == FULL_MATCH)
>> +               mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
>> +                          ev_size, NULL);
>>  }
>>
>>  void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>> @@ -6915,10 +7185,18 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
>>
>>         BT_DBG("%s discovering %u", hdev->name, discovering);
>>
>> -       if (discovering)
>> +       if (discovering) {
>>                 cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
>> -       else
>> +               if (cmd == NULL)
>> +                       cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY,
>> +                                               hdev);
>> +
>> +       } else {
>>                 cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
>> +               if (cmd == NULL)
>> +                       cmd = mgmt_pending_find(MGMT_OP_STOP_SERVICE_DISCOVERY,
>> +                                               hdev);
>> +       }
>>
>>         if (cmd != NULL) {
>>                 u8 type = hdev->discovery.type;
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks,
> Arman
