Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110127075924.GJ874@null>
References: <AANLkTimqtWzKS4H+veJE2PCXH0o5CLJwrspMTfQyd=AR@mail.gmail.com>
	<20110127075924.GJ874@null>
Date: Thu, 27 Jan 2011 11:58:49 -0200
Message-ID: <AANLkTimuyH3yywh59xifxrTKp-U1wQnpA8r7RFrrBToX@mail.gmail.com>
Subject: Re: [RFC 1/1] Device initialization and controller type resolving
From: =?UTF-8?Q?Andr=C3=A9_Dieb?= <andre.dieb@signove.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On Thu, Jan 27, 2011 at 5:59 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Andre,
>
> On Wed, Jan 26, 2011 at 12:34:02PM -0200, ext André Dieb wrote:
>> From: André Dieb Martins <andre.dieb@signove.com>
>>
>> This patch proposes to use LMP features in order to resolve the controller
>> type. Currently there's very few code (mostly inside drivers) that cares
>> about differentiating controller types (BR/EDR, BR/EDR/LE, LE only, AMP).
>>
>> Once determined dev_type, the idea would be to implement controller-type
>> specific initialization procedures. There's an initialization code for BR/EDR
>> devices and some early adaptation for BR/EDR/LE, but nothing regarding
>> LE-only - and I'm willing to tackle that, based on your pointers.
>>
>> Would it be better to always let drivers modify their device's dev_type?
>>
>> What would be the correct approach?
>>
>> PS: Please don't bother the CC2540 hack. Consider it a joke :-).
>
> Separate it to another patch then. I have these dongles but they had some
> proprietary interface. From where did you get fw with hci interface? it would
> be nice to test also with LE only hw.
>

Great to know there's more people interested in getting this working.

We were trying to use the proprietary fw. TI argued it supported BLE,
but we still couldn't use it properly - commands missing, events not
being generated, etc. There has been some development on this issue -
if you're interested check my blog's latest posts
(http://genuinepulse.blogspot.com).

If you're interested in helping us, my code is living under
http://gitorious.org/~dieb/bluetooth-next/dieb-bluetooth-next/commits/controller-type.
Also notice I rebased against 2.6-next and split it into separate
patches.

>>
>> Signed-off-by: André Dieb Martins <andre.dieb@signove.com>
>> ---
>>  include/net/bluetooth/hci.h      |   78 ++++++++++++++++++++++++++++++-------
>>  include/net/bluetooth/hci_core.h |    3 +
>>  net/bluetooth/hci_core.c         |    8 ++--
>>  net/bluetooth/hci_event.c        |   24 ++++++++++++
>>  net/bluetooth/hci_sysfs.c        |    4 ++
>>  5 files changed, 98 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 036fdae..ae9f095 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -55,6 +55,8 @@
>>  /* HCI controller types */
>>  #define HCI_BREDR    0x00
>>  #define HCI_AMP              0x01
>> +#define HCI_BREDRLE 0x02
>> +#define HCI_LE               0x03
>>
>>  /* HCI device quirks */
>>  enum {
>> @@ -163,6 +165,8 @@ enum {
>>  #define LE_LINK              0x80
>>
>>  /* LMP features */
>> +
>> +/* byte 0 */
>>  #define LMP_3SLOT    0x01
>>  #define LMP_5SLOT    0x02
>>  #define LMP_ENCRYPT  0x04
>> @@ -172,6 +176,7 @@ enum {
>>  #define LMP_HOLD     0x40
>>  #define LMP_SNIFF    0x80
>>
>> +/* byte 1 */
>>  #define LMP_PARK     0x01
>>  #define LMP_RSSI     0x02
>>  #define LMP_QUALITY  0x04
>> @@ -181,22 +186,65 @@ enum {
>>  #define LMP_ULAW     0x40
>>  #define LMP_ALAW     0x80
>>
>> -#define LMP_CVSD     0x01
>> -#define LMP_PSCHEME  0x02
>> +/* byte 2 */
>> +#define LMP_CVSD             0x01
>> +#define LMP_PSCHEME          0x02
>>  #define LMP_PCONTROL 0x04
>> -
>> -#define LMP_ESCO     0x80
>> -
>> -#define LMP_EV4              0x01
>> -#define LMP_EV5              0x02
>> -#define LMP_LE               0x40
>> -
>> -#define LMP_SNIFF_SUBR       0x02
>> -#define LMP_EDR_ESCO_2M      0x20
>> -#define LMP_EDR_ESCO_3M      0x40
>> -#define LMP_EDR_3S_ESCO      0x80
>> -
>> -#define LMP_SIMPLE_PAIR      0x08
>> +#define LMP_TSYNC            0x08
>> +#define LMP_FLOWLAGLSB  0x10
>> +#define LMP_FLOWLAGMB        0x20
>> +#define LMP_FLOWLAGMSB       0x40
>> +#define LMP_BROADCAST_ENCRYPTION 0x80
>> +
>> +/* byte 3 */
>> +// 0x01 reserved
>> +#define LMP_ENHANCED_DATA_RATE_2MBPS 0x02
>> +#define LMP_ENHANCED_DATA_RATE_3MBPS 0x04
>> +#define LMP_ENHANCED_INQUIRY_SCAN    0x08
>> +#define LMP_INTERLACED_INQUIRY_SCAN  0x10
>> +#define LMP_INTERLACED_PAGE_SCAN     0x20
>> +#define LMP_RSSI_WITH_INQUIRY_RES    0x40
>> +#define LMP_ESCO                                     0x80
>> +
>> +/* byte 4 */
>> +#define LMP_EV4                                      0x01
>> +#define LMP_EV5                                      0x02
>> +// 0x04 reserved
>> +#define LMP_AFH_CAPABLE_SLAVE        0x08
>> +#define LMP_AFH_CLASSIF_SLAVE        0x10
>> +#define LMP_NOT_BREDR                        0x20
>> +#define LMP_LE                                       0x40
>> +#define LMP_3EDR                             0x80
>> +
>> +/* byte 5 */
>> +#define LMP_5EDR                             0x01
>> +#define LMP_SNIFF_SUBR                       0x02
>> +#define LMP_PAUSE_ENCRYP             0x04
>> +#define LMP_AFH_CAPABLE_MASTER       0x08
>> +#define LMP_AFH_CLASSIF_MASTER       0x10
>> +#define LMP_EDR_ESCO_2M                      0x20
>> +#define LMP_EDR_ESCO_3M                      0x40
>> +#define LMP_EDR_3S_ESCO                      0x80
>> +
>> +/* byte 6 */
>> +#define LMP_EXT_INQ_RESPONSE                         0x01
>> +#define LMP_SIMUL_LE_BREDR_SAME_DEVICE               0x02
>> +// 0x04 reserved for Core V4.0
>> +#define LMP_SIMPLE_PAIR                                              0x08
>> +#define LMP_ENCAPSULATED_PDU                                 0x10
>> +#define LMP_ERR_DATA_REPORT                          0x20
>> +#define LMP_NONFLUSH_PACKET_BOUNDARY_FLAG    0x40
>> +// 0x80 reserved for Core V4.0
>> +
>> +/* byte 7 */
>> +#define LMP_LINK_SUPERVISION_TIMEOUT_CHANGED_EVENT   0x01
>> +#define LMP_INQ_TX_POWER_LEVEL                                               0x02
>> +#define LMP_ENHANCED_POWER_CONTROL                                   0x04
>> +// 0x08 reserved
>> +// 0x10 reserved
>> +// 0x20 reserved
>> +// 0x40 reserved
>> +// 0x80 reserved
>>
>
> Add only definition you are using in the code.

Ok.

>
>>  /* Connection modes */
>>  #define HCI_CM_ACTIVE        0x0000
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index cfbe56c..9a86281 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -480,7 +480,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>>  #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
>>  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>>  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
>> +
>
> Extra line here?

You're right. No need to separate those macros.

>
>>
>>  #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
>> +#define lmp_bredr_unsupported(dev)   ((dev)->features[4] & LMP_NOT_BREDR)
>> +#define lmp_le_only(dev)                (lmp_le_capable(dev) &&
>> lmp_bredr_unsupported(dev))
>>
>>  /* ----- HCI protocols ----- */
>>  struct hci_proto {
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 0e98ffb..b110114 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -259,6 +259,8 @@ static void hci_le_init_req(struct hci_dev *hdev,
>> unsigned long opt)
>>  {
>>       BT_DBG("%s", hdev->name);
>>
>> +     BT_INFO("%s LE-specific initialization", hdev->name);
>> +
>
> I think these info messages could be left out from final version.

Sure.

>
>>       /* Read LE buffer size */
>>       hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
>>  }
>> @@ -501,10 +503,6 @@ int hci_dev_open(__u16 dev)
>>       if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
>>               set_bit(HCI_RAW, &hdev->flags);
>>
>> -     /* Treat all non BR/EDR controllers as raw devices for now */
>> -     if (hdev->dev_type != HCI_BREDR)
>> -             set_bit(HCI_RAW, &hdev->flags);
>> -
>
> Won't this break AMP controller support?

Yes. But it's not what I want to propose. I'd like to divide my
question in smaller ones. I'm sorry about the lame patch, my
experience with kernel-bt is pretty limited and I've just started
playing with it... experienced input is and will be very much
appreciated. :)

1. Can we determine all hdev->dev_type through LMP? Core V4.0
determines Read Local Supported Features Command must be supported by
all controllers, so perhaps we could resolve hdev->dev_type before
doing everything else.

2. Once determined (if possible) hdev->dev_type through LMP, we could
have something like:

// Common initialization for all types
hci_common_init_req();

// type-specific initialization
switch (hdev->dev_type) {
case HCI_BREDR:
   hci_bredr_init_req();
   break;
case HCI_BREDRLE:
   hci_bredr_init_req();
   hci_le_init_req();
   break;
case HCI_LE:
   hci_le_init_req();
   break;
case HCI_AMP:
   hci_amp_init();
   break;
default: // RAW?
   break;
}

>
>>       if (hdev->open(hdev)) {
>>               ret = -EIO;
>>               goto done;
>> @@ -514,6 +512,8 @@ int hci_dev_open(__u16 dev)
>>               atomic_set(&hdev->cmd_cnt, 1);
>>               set_bit(HCI_INIT, &hdev->flags);
>>
>> +             BT_INFO("Initializing %s", hdev->name);
>> +
>
> Ditto
>
>>               //__hci_request(hdev, hci_reset_req, 0, HZ);
>>               ret = __hci_request(hdev, hci_init_req, 0,
>>                                       msecs_to_jiffies(HCI_INIT_TIMEOUT));
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 57560fb..18932a2 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -445,6 +445,16 @@ static void hci_cc_read_local_commands(struct
>> hci_dev *hdev, struct sk_buff *skb
>>       memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
>>  }
>>
>> +#define is_texas_dongle(hdev) \
>> +     (hdev->features[0] == 0x00 && \
>> +      hdev->features[1] == 0x00 && \
>> +      hdev->features[2] == 0x00 && \
>> +      hdev->features[3] == 0x60 && \
>> +      hdev->features[4] == 0x00 && \
>> +      hdev->features[5] == 0x00 && \
>> +      hdev->features[6] == 0x00 && \
>> +      hdev->features[7] == 0x00)
>> +
>
> Should be fixed in dongle fw. And if not possible maybe some quirk could be
> used instead of device specific hacks.
>

Sure. I wonder if TI would provide us the fw's source or actually
provide a fixed fw.

>>  static void hci_cc_read_local_features(struct hci_dev *hdev, struct
>> sk_buff *skb)
>>  {
>>       struct hci_rp_read_local_features *rp = (void *) skb->data;
>> @@ -498,6 +508,20 @@ static void hci_cc_read_local_features(struct
>> hci_dev *hdev, struct sk_buff *skb
>>                                       hdev->features[2], hdev->features[3],
>>                                       hdev->features[4], hdev->features[5],
>>                                       hdev->features[6], hdev->features[7]);
>> +
>> +     /* Fix features endianess bug on CC2540 firmware */
>> +     if (is_texas_dongle(hdev)) {
>> +             hdev->features[3] = 0x00;
>> +             hdev->features[4] = 0x60;
>> +     }
>> +
>> +     if (lmp_le_capable(hdev) && lmp_bredr_unsupported(hdev)) {
>> +             hdev->dev_type = HCI_LE;
>> +             BT_INFO("%s is a LE-only controller", hdev->name);
>
> Ditto
>
>> +     } else if (lmp_le_capable(hdev)) {
>> +             hdev->dev_type = HCI_BREDRLE;
>> +             BT_INFO("%s is a BR/EDR/LE controller", hdev->name);
>
> Ditto
>
>> +     }
>>  }
>>
>>  static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
>> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
>> index 5fce3d6..5846297 100644
>> --- a/net/bluetooth/hci_sysfs.c
>> +++ b/net/bluetooth/hci_sysfs.c
>> @@ -196,6 +196,10 @@ static inline char *host_typetostr(int type)
>>               return "BR/EDR";
>>       case HCI_AMP:
>>               return "AMP";
>> +     case HCI_BREDRLE:
>> +             return "BR/EDR/LE";
>> +     case HCI_LE:
>> +             return "LE";
>>       default:
>>               return "UNKNOWN";
>>       }
>
> --
> Ville
>
>
