Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: bring device down when closing HCI_CHANNEL_USER socket
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150828111605.GA30700@t440s.lan>
Date: Fri, 28 Aug 2015 08:58:55 -0700
Cc: Simon Fels <simon.fels@canonical.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <B7E3E9FD-264E-47A6-96F3-9451D9C43036@holtmann.org>
References: <1440759270-23099-1-git-send-email-simon.fels@canonical.com> <1440759270-23099-2-git-send-email-simon.fels@canonical.com> <20150828111605.GA30700@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> When a HCI_CHANNEL_USER socket is open and should be closed we first
>> try to close the device which will fail as hci_dev_close checks for
>> HCI_CHANNEL_USER being set and if it is it just fails to close the
>> device. Clearing the HCI_CHANNEL_USER flag first before trying to
>> close the device fixes this.
>> 
>> Signed-off-by: Simon Fels <simon.fels@canonical.com>
>> ---
>> backports/net/bluetooth/hci_sock.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/backports/net/bluetooth/hci_sock.c b/backports/net/bluetooth/hci_sock.c
>> index 9a2732f..c84c13e 100644
>> --- a/backports/net/bluetooth/hci_sock.c
>> +++ b/backports/net/bluetooth/hci_sock.c
>> @@ -503,8 +503,8 @@ static int hci_sock_release(struct socket *sock)
>> 
>> 	if (hdev) {
>> 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
>> -			hci_dev_close(hdev->id);
>> 			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
>> +			hci_dev_close(hdev->id);
>> 			mgmt_index_added(hdev);
>> 		}
> 
> Thanks for catching this and coming up with a patch proposal!
> 
> My main concern is that there's code within the hci_dev_close() path
> that assumes HCI_USER_CHANNEL may be set. E.g. this in
> hci_dev_do_close() (which hci_dev_close calls):
> 
> 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> 	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> 	    test_bit(HCI_UP, &hdev->flags)) {
> 		/* Execute vendor specific shutdown routine */
> 		if (hdev->shutdown)
> 			hdev->shutdown(hdev);
> 	}
> 
> With your change the hdev->shutdown() callback would get called which
> seems to be what the above if-statement tries to protect against.

commit 9380f9eacfbbee701daa416edd6625efcd3e29e1 flipped them around. And I was worried about that at that time, but since I forgot to add a comment, I could not remember why I ordered them in that way in the first place. I just had a hunch that I did it for a reason.

So we might need to look at this one again and make sure this time we get this right and comment on it.

Regards

Marcel

