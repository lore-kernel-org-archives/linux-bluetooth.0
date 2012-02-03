Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328284991.2062.35.camel@aeonflux>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328284991.2062.35.camel@aeonflux>
Date: Fri, 3 Feb 2012 15:00:54 -0200
Message-ID: <CAA37ikaaWG8v8=_BbdudHw=nH=vTSUsy-SzEiB3vV2KVWaRXug@mail.gmail.com>
Subject: Re: [PATCHv1 2/2] Bluetooth: Helper removes duplicated code
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 3, 2012 at 2:03 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Andrei,
>
>> Use __check_timout helper to remove duplicated code
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> ---
>> =A0net/bluetooth/hci_core.c | =A0 31 +++++++++++++------------------
>> =A01 files changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 9a56a40..95eeae5 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -2390,22 +2390,25 @@ static inline int __get_blocks(struct hci_dev *h=
dev, struct sk_buff *skb)
>> =A0 =A0 =A0 return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block=
_len);
>> =A0}
>>
>> -static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
>> +static inline void __check_timeout(struct hci_dev *hdev, unsigned int c=
nt)
>> =A0{
>> - =A0 =A0 struct hci_chan *chan;
>> - =A0 =A0 struct sk_buff *skb;
>> - =A0 =A0 int quote;
>> - =A0 =A0 unsigned int cnt;
>> -
>> =A0 =A0 =A0 if (!test_bit(HCI_RAW, &hdev->flags)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ACL tx timeout must be longer than maximu=
m
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* link supervision timeout (40.9 seconds)=
 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!hdev->acl_cnt && time_after(jiffies, hdev=
->acl_last_tx +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!cnt && time_after(jiffies, hdev->acl_last=
_tx +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_link_tx_to(hdev, ACL_LIN=
K);
>> =A0 =A0 =A0 }
>> +}
>>
>> - =A0 =A0 cnt =3D hdev->acl_cnt;
>> +static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
>> +{
>> + =A0 =A0 unsigned int cnt =3D hdev->acl_cnt;

cnt is initialized here.

>> + =A0 =A0 struct hci_chan *chan;
>> + =A0 =A0 struct sk_buff *skb;
>> + =A0 =A0 int quote;
>> +
>> + =A0 =A0 __check_timeout(hdev, cnt);
>>
>> =A0 =A0 =A0 while (hdev->acl_cnt &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (chan =3D hci_chan_sent(hdev=
, ACL_LINK, &quote))) {
>> @@ -2438,20 +2441,12 @@ static inline void hci_sched_acl_pkt(struct hci_=
dev *hdev)
>>
>> =A0static inline void hci_sched_acl_blk(struct hci_dev *hdev)
>> =A0{
>> + =A0 =A0 unsigned int cnt =3D hdev->block_cnt;

And cnt is initialized here, for block count.

>> =A0 =A0 =A0 struct hci_chan *chan;
>> =A0 =A0 =A0 struct sk_buff *skb;
>> =A0 =A0 =A0 int quote;
>> - =A0 =A0 unsigned int cnt;
>> -
>> - =A0 =A0 if (!test_bit(HCI_RAW, &hdev->flags)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* ACL tx timeout must be longer than maximum
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* link supervision timeout (40.9 seconds) *=
/
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!hdev->block_cnt && time_after(jiffies, hd=
ev->acl_last_tx +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_link_tx_to(hdev, ACL_LINK)=
;
>> - =A0 =A0 }
>>
>> - =A0 =A0 cnt =3D hdev->block_cnt;
>
> maybe the patch is just funnily trying to be too smart, but I am missing
> the cnt init here.

And yes, the patch itself looks confusing but it was because of how
git created the changes. I think the patch looks good.

>> + =A0 =A0 __check_timeout(hdev, cnt);
>>
>> =A0 =A0 =A0 while (hdev->block_cnt > 0 &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (chan =3D hci_chan_sent(hdev=
, ACL_LINK, &quote))) {
>
> Regards
>
> Marcel

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
