Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <516BE15C-ECD3-496B-AE6B-08E63F804F9F@holtmann.org>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1512374873-1956-2-git-send-email-jaganathx.kanakkassery@intel.com>
 <CABBYNZ+4cbbOHuN0qLK2ONuK5Ocd69mWZf38KNB6SCDVvjuimw@mail.gmail.com>
 <68C5E7A6-B4A6-4EA9-BF40-9ACFDAAE7749@holtmann.org> <CAJzH+boK8AE+MiK2bOBZMoEy+EHwB=GzORsjNYw7moPowKBijQ@mail.gmail.com>
 <516BE15C-ECD3-496B-AE6B-08E63F804F9F@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 5 Mar 2018 17:26:06 +0530
Message-ID: <CAJzH+bqPZ73eOLa+g6V9aSxHbmBQbGrbbsnZ+J1CtMbcJFuwiw@mail.gmail.com>
Subject: Re: [RFC 1/9] Bluetooth: Read no of adv sets during init
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On Sat, Dec 9, 2017 at 12:04 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Jaganath,
>
>>>>> This patch reads the number of advertising sets in the controller
>>>>> during init and save it in hdev.
>>>>>
>>>>> Currently host only supports upto HCI_MAX_ADV_INSTANCES (5).
>>>>>
>>>>> Instance 0 is reserved for "Set Advertising" which means that
>>>>> multi adv is supported only for total sets - 1.
>>>>>
>>>>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.co=
m>
>>>>> ---
>>>>> include/net/bluetooth/hci.h      |  7 +++++++
>>>>> include/net/bluetooth/hci_core.h |  4 ++++
>>>>> net/bluetooth/hci_core.c         | 11 +++++++++--
>>>>> net/bluetooth/hci_event.c        | 20 ++++++++++++++++++++
>>>>> net/bluetooth/mgmt.c             |  6 +++---
>>>>> 5 files changed, 43 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.=
h
>>>>> index f0868df..59df823 100644
>>>>> --- a/include/net/bluetooth/hci.h
>>>>> +++ b/include/net/bluetooth/hci.h
>>>>> @@ -398,6 +398,7 @@ enum {
>>>>> #define HCI_LE_SLAVE_FEATURES          0x08
>>>>> #define HCI_LE_PING                    0x10
>>>>> #define HCI_LE_DATA_LEN_EXT            0x20
>>>>> +#define HCI_LE_EXT_ADV                 0x10
>>>>> #define HCI_LE_EXT_SCAN_POLICY         0x80
>>>>>
>>>>> /* Connection modes */
>>>>> @@ -1543,6 +1544,12 @@ struct hci_cp_le_ext_conn_param {
>>>>>        __le16 max_ce_len;
>>>>> } __packed;
>>>>>
>>>>> +#define HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS  0x203b
>>>>> +struct hci_rp_le_read_num_supported_adv_sets {
>>>>> +       __u8  status;
>>>>> +       __u8  num_of_sets;
>>>>> +} __packed;
>>>>> +
>>>>> /* ---- HCI Events ---- */
>>>>> #define HCI_EV_INQUIRY_COMPLETE                0x01
>>>>>
>>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
>>>>> index 554671c..4a7a4ae 100644
>>>>> --- a/include/net/bluetooth/hci_core.h
>>>>> +++ b/include/net/bluetooth/hci_core.h
>>>>> @@ -219,6 +219,7 @@ struct hci_dev {
>>>>>       __u8            features[HCI_MAX_PAGES][8];
>>>>>       __u8            le_features[8];
>>>>>       __u8            le_white_list_size;
>>>>> +       __u8            le_no_of_adv_sets;
>>>>
>>>> I was expecting some flag that indicates if the instances would be
>>>> maintained by the controller or not, but perhaps this is covered in
>>>> other patches.
>>>>
>>>>>       __u8            le_states[8];
>>>>>       __u8            commands[64];
>>>>>       __u8            hci_ver;
>>>>> @@ -1154,6 +1155,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>>>>> #define bredr_sc_enabled(dev)  (lmp_sc_capable(dev) && \
>>>>>                               hci_dev_test_flag(dev, HCI_SC_ENABLED))
>>>>>
>>>>> +/* Extended advertising support */
>>>>> +#define ext_adv_capable(dev) ((dev)->le_features[1] & HCI_LE_EXT_ADV=
)
>>>>> +
>>>>> /* ----- HCI protocols ----- */
>>>>> #define HCI_PROTO_DEFER             0x01
>>>>>
>>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>>> index a91a09a..3472572 100644
>>>>> --- a/net/bluetooth/hci_core.c
>>>>> +++ b/net/bluetooth/hci_core.c
>>>>> @@ -716,6 +716,12 @@ static int hci_init3_req(struct hci_request *req=
, unsigned long opt)
>>>>>                       hci_req_add(req, HCI_OP_LE_READ_DEF_DATA_LEN, 0=
, NULL);
>>>>>               }
>>>>>
>>>>> +               if (ext_adv_capable(hdev)) {
>>>>> +                       /* Read LE Number of Supported Advertising Se=
ts */
>>>>> +                       hci_req_add(req, HCI_OP_LE_READ_NUM_SUPPORTED=
_ADV_SETS,
>>>>> +                                   0, NULL);
>>>>> +               }
>>>>> +
>>>>>               hci_set_le_support(req);
>>>>>       }
>>>>>
>>>>> @@ -2676,8 +2682,8 @@ int hci_add_adv_instance(struct hci_dev *hdev, =
u8 instance, u32 flags,
>>>>>               memset(adv_instance->scan_rsp_data, 0,
>>>>>                      sizeof(adv_instance->scan_rsp_data));
>>>>>       } else {
>>>>> -               if (hdev->adv_instance_cnt >=3D HCI_MAX_ADV_INSTANCES=
 ||
>>>>> -                   instance < 1 || instance > HCI_MAX_ADV_INSTANCES)
>>>>> +               if (hdev->adv_instance_cnt >=3D hdev->le_no_of_adv_se=
ts ||
>>>>> +                   instance < 1 || instance > hdev->le_no_of_adv_set=
s)
>>>>>                       return -EOVERFLOW;
>>>>>
>>>>>               adv_instance =3D kzalloc(sizeof(*adv_instance), GFP_KER=
NEL);
>>>>> @@ -2972,6 +2978,7 @@ struct hci_dev *hci_alloc_dev(void)
>>>>>       hdev->le_max_tx_time =3D 0x0148;
>>>>>       hdev->le_max_rx_len =3D 0x001b;
>>>>>       hdev->le_max_rx_time =3D 0x0148;
>>>>> +       hdev->le_no_of_adv_sets =3D HCI_MAX_ADV_INSTANCES;
>>>>>
>>>>>       hdev->rpa_timeout =3D HCI_DEFAULT_RPA_TIMEOUT;
>>>>>       hdev->discov_interleaved_timeout =3D DISCOV_INTERLEAVED_TIMEOUT=
;
>>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>>> index a26ae80..06d8c1b 100644
>>>>> --- a/net/bluetooth/hci_event.c
>>>>> +++ b/net/bluetooth/hci_event.c
>>>>> @@ -1243,6 +1243,22 @@ static void hci_cc_le_set_ext_scan_enable(stru=
ct hci_dev *hdev,
>>>>>       le_set_scan_enable_complete(hdev, cp->enable);
>>>>> }
>>>>>
>>>>> +static void hci_cc_le_read_num_adv_sets(struct hci_dev *hdev,
>>>>> +                                     struct sk_buff *skb)
>>>>> +{
>>>>> +       struct hci_rp_le_read_num_supported_adv_sets *rp =3D (void *)=
 skb->data;
>>>>> +
>>>>> +       BT_DBG("%s status 0x%2.2x No of Adv sets %u", hdev->name, rp-=
>status,
>>>>> +              rp->num_of_sets);
>>>>> +
>>>>> +       if (rp->status)
>>>>> +               return;
>>>>> +
>>>>> +       /* Instance 0 is reserved for Set Advertising */
>>>>> +       hdev->le_no_of_adv_sets =3D min_t(u8, rp->num_of_sets - 1,
>>>>> +                                       HCI_MAX_ADV_INSTANCES);
>>>>
>>>> Id say if the controller cannot support as many instances as the host
>>>> stack then we should keep using the software based scheduler, another
>>>> option would be to let the user select what scheduler it wants to use
>>>> since with host based scheduler it may get a much more consistent
>>>> behavior than with controller based which is especially important for
>>>> beacons.
>>>
>>> frankly this will not help either. The max instances reported from the =
controller is not a fixed guaranteed number. It is the most likely case. Ho=
wever a controller can run out of resources and decide to refuse an adverti=
sing instance.
>>>
>>
>> Does it mean that we need to retrieve no of supported adv sets every tim=
e
>> we enable advertising?
>>
>> or try enabling based on the initial no_of_sets and handle it for eg
>> if adv_set_param
>> failed with "Limit Reached" error?
>
> we need to handle the error case correctly.
>
>>> However having an extra flag for permanent / continuous offload would b=
e interesting. If not specified, then the kernel will rotate. For 4.x contr=
ollers it will rotate based on a single instance, for 5.x it will rotate wi=
th n instances. The extra flag could then indicate, please do not include m=
e into the rotation and keep me always active. Which is something that inst=
ance 0 would always inherit.
>>>
>>
>> So you want to still rotate adv instances by kernel wherein at a time
>> n adv sets/instances
>> would be enabled, where n is no of supported sets? and timer should be
>> running for the
>> min of scheduled adv instances duration and once timer expires then
>> replace it with the
>> next unscheduled instance.
>
> It would be some sort of round-robin. If we have more instances than sets=
, then timer has to run, and then we rotate, the oldest one moves out, the =
next moves in.
>

I was thinking of implementing this and we can have two approaches.

First as you said oldest one move out and next one moves in which adds and
removes one instance during each rotation. So basically if there are 2 sets
and 5 instances then it would be like 12 23 34 45 51 etc.

Another approach is disable all the current sets and schedule the new ones.
So in above scenario it would be like 12, 34, 45, 12 etc. I think with this=
 all
instances will be scheduled in lesser time.

Plz let me know your opinion.

Thanks,
Jaganath
