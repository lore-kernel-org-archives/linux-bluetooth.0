Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A808B013-E121-4A50-9AEF-09C5B2F6DA39@holtmann.org>
References: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
	<1362783979-10142-2-git-send-email-andre.guedes@openbossa.org>
	<A808B013-E121-4A50-9AEF-09C5B2F6DA39@holtmann.org>
Date: Mon, 11 Mar 2013 14:24:48 -0300
Message-ID: <CACJA=fVCPZ6ScP8H2qxOfc_Gazy_fQ1=6TQhcdDUxYm+Q=iBPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Bluetooth: Update hci_le_scan to use HCI request
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 8, 2013 at 10:24 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>> This patch changes hci_le_scan helper so it uses the HCI request
>> framework to enable LE scanning.
>>
>> Also, the LE scanning disable timeout was removed from the helper
>> and it is now handled in mgmt start_discovery code.
>
> just a heads up, these need to become way more verbose. Explain what you =
are doing.

Ok, I'll be more verbose here.

>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/hci_core.h |  3 +--
>> net/bluetooth/hci_core.c         | 29 +++++++++++++++++----------
>> net/bluetooth/mgmt.c             | 43 ++++++++++++++++++++++++++++++++++=
++----
>> 3 files changed, 59 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index d6c3256..964b270 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1173,8 +1173,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le1=
6 ediv, __u8 rand[8],
>>                                                       __u8 ltk[16]);
>> int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>> int hci_cancel_inquiry(struct hci_dev *hdev);
>> -int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window=
,
>> -             int timeout);
>> +int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 win=
dow);
>> int hci_cancel_le_scan(struct hci_dev *hdev);
>>
>> u8 bdaddr_to_le(u8 bdaddr_type);
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index a49c445..59f583b 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1945,25 +1945,34 @@ static void le_scan_work(struct work_struct *wor=
k)
>>                      param->timeout);
>> }
>>
>> -int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window=
,
>> -             int timeout)
>> +int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 win=
dow)
>> {
>> -     struct le_scan_params *param =3D &hdev->le_scan_params;
>> +     struct hci_dev *hdev =3D req->hdev;
>> +     struct hci_cp_le_set_scan_param param_cp;
>> +     struct hci_cp_le_set_scan_enable enable_cp;
>>
>>       BT_DBG("%s", hdev->name);
>>
>>       if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
>>               return -ENOTSUPP;
>>
>> -     if (work_busy(&hdev->le_scan))
>> -             return -EINPROGRESS;
>> +     if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> +             return -EALREADY;
>
> This check in here is silly. Why bother initializing a request and then a=
bort it later. You know it ahead of time. This whole thing of hci_req_init =
in on part and the hci_req_add somewhere else is not a good idea. See comme=
nt below.
>
> I am serious, that I want to get rid of this spaghetti type of coding. Th=
e HCI transaction should be simple and easy to understand. That is why I in=
sisted on that Johan having to redo his patch set many times. It needs to r=
ead like this:
>
>         start transaction
>
>         add something
>         add something more
>
>         run it
>
> And that should be all in one function so that people can actually follow=
 what is happening when we do something like enabling LE scanning. I do not=
 want to look into 3-4 different functions to see what is going on.
>
>> +
>> +     memset(&param_cp, 0, sizeof(param_cp));
>> +     param_cp.type =3D type;
>> +     param_cp.interval =3D cpu_to_le16(interval);
>> +     param_cp.window =3D cpu_to_le16(window);
>> +
>> +     hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
>> +                 &param_cp);
>>
>> -     param->type =3D type;
>> -     param->interval =3D interval;
>> -     param->window =3D window;
>> -     param->timeout =3D timeout;
>> +     memset(&enable_cp, 0, sizeof(enable_cp));
>> +     enable_cp.enable =3D 0x01;
>> +     enable_cp.filter_dup =3D 0x01;
>>
>> -     queue_work(system_long_wq, &hdev->le_scan);
>> +     hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
>> +                 &enable_cp);
>>
>>       return 0;
>> }
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 39395c7..fbf3265 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -2428,11 +2428,34 @@ int mgmt_interleaved_discovery(struct hci_dev *h=
dev)
>>       return err;
>> }
>>
>> +static void enable_le_scan_complete(struct hci_dev *hdev, u8 status)
>> +{
>> +     BT_DBG("status %d", status);
>> +
>> +     if (status)
>> +             return;
>> +
>> +     switch (hdev->discovery.type) {
>> +     case DISCOV_TYPE_LE:
>> +             queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable=
,
>> +                                msecs_to_jiffies(LE_SCAN_TIMEOUT_LE_ONL=
Y));
>> +             break;
>> +
>> +     case DISCOV_TYPE_INTERLEAVED:
>> +             queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable=
,
>> +                                msecs_to_jiffies(LE_SCAN_TIMEOUT_BREDR_=
LE));
>> +             break;
>> +     default:
>> +             BT_ERR("Invalid discovery type %d", hdev->discovery.type);
>> +     }
>> +}
>> +
>
> Why don't we have one complete handler for LE only and one for interleave=
d scanning. Seriously, it gets all smashed together for no apparent reason.=
 I fully understand that before this was needed, but with the request frame=
work, the core takes care of everything for you. It makes sure that the rig=
ht complete handler gets call. So lets stop being silly here.

Fair enough. I'll separate them and we'll have a callback for LE-only
and another for interleaved.

> On a different note, can we please get rid of this msecs_to_jiffies calls=
 in place. They should be made part of the constant definition. It is a was=
te of space and they just clutter up the code.

This is done in Patch 5. I'll move that patch to the beginning of v3 patch =
set.

>> static int start_discovery(struct sock *sk, struct hci_dev *hdev,
>>                          void *data, u16 len)
>> {
>>       struct mgmt_cp_start_discovery *cp =3D data;
>>       struct pending_cmd *cmd;
>> +     struct hci_request req;
>>       int err;
>>
>>       BT_DBG("%s", hdev->name);
>> @@ -2485,8 +2508,14 @@ static int start_discovery(struct sock *sk, struc=
t hci_dev *hdev,
>>                       goto failed;
>>               }
>>
>> -             err =3D hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
>> -                               LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
>> +             hci_req_init(&req, hdev);
>> +
>> +             err =3D hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
>> +                               LE_SCAN_WIN);
>> +             if (err)
>> +                     break;
>> +
>> +             err =3D hci_req_run(&req, enable_le_scan_complete);
>>               break;
>
> So this is one thing I do not want to see. I want hci_req_init, hci_req_a=
dd and hci_req_run in the same function. No go off and call some magic help=
er that does 4 other things. Put the HCI opcodes and parameters right where=
 they are suppose to be.

Ok, I'll put hci_req_init, hci_req_add and hci_req_run in start_discovery.

> If you need to put the transaction into a separate function because it is=
 shared or more complex, then also hci_req_init and hci_req_run should go i=
nto that function.

This is not the case for hci_le_scan for now. So, I'll also remove
hci_le_scan helper.

We might need a separate function to enable LE scanning in future
since this feature will be used by device discovery and LE connection.
However, if this is the case, I'll add the function in LE connection
patch set.

>>       case DISCOV_TYPE_INTERLEAVED:
>> @@ -2497,8 +2526,14 @@ static int start_discovery(struct sock *sk, struc=
t hci_dev *hdev,
>>                       goto failed;
>>               }
>>
>> -             err =3D hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT, LE_SC=
AN_WIN,
>> -                               LE_SCAN_TIMEOUT_BREDR_LE);
>> +             hci_req_init(&req, hdev);
>> +
>> +             err =3D hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
>> +                               LE_SCAN_WIN);
>> +             if (err)
>> +                     break;
>> +
>> +             err =3D hci_req_run(&req, enable_le_scan_complete);
>>               break;
>
> What is the difference between the code statement above and the one be be=
low now.
>
> So you smash the different handling into the complete callback to save sp=
ace, but then the calling side is duplicated. You can do better than this.

To keep this patch simpler, I did the smashing in the subsequent
patch. However, since we'll have a separate callback for LE-only and
interleaved, this cases won't be the same anymore.

Regards,

Andre
