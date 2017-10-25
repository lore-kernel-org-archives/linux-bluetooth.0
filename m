Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <7127E793-A2AE-413D-AA65-239B23229380@holtmann.org>
References: <1508830195-13824-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <F0B9BF0A-BC07-4074-923E-518E6A227DF0@holtmann.org> <20171024085831.GA3889@x1c>
 <7127E793-A2AE-413D-AA65-239B23229380@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Wed, 25 Oct 2017 11:14:42 +0530
Message-ID: <CAJzH+brrT25AQw_EDRxPCqc2P+eeKfs4AsdPzf0CAjghHMG8OA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix potential memory leak
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Johan,

On Tue, Oct 24, 2017 at 6:13 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>>>> index 1fba2a0..58045ee 100644
>>>> --- a/net/bluetooth/mgmt.c
>>>> +++ b/net/bluetooth/mgmt.c
>>>> @@ -6383,6 +6383,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
>>>>     if (skb_queue_empty(&req.cmd_q) ||
>>>>         !hdev_is_powered(hdev) ||
>>>>         hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
>>>> +           skb_queue_purge(&req.cmd_q);
>>>>             rp.instance = cp->instance;
>>>>             err = mgmt_cmd_complete(sk, hdev->id,
>>>>                                     MGMT_OP_REMOVE_ADVERTISING,
>>>
>>> this does not look right to me. It most likely has side affects. The
>>> fix must be differently if there is a memory leak.
>>
>> Actually, it looks like the right fix to me. We don't have a separate
>> helper to clean up a hci_request that never got used, and
>> skb_queue_purge is what other places in the code seem to be doing in
>> this kind of cases.
>
> then we need a helper to do this. This is pretty bad style if we hook into the queue directly with a skb_queue_purge. Since that cmd_q should be a hidden detail.

I have raised v1 with the suggested changes.

Thanks,
Jaganath
