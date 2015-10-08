Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <56152FA0.50808@mentor.com>
References: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
	<9DBA7668-848C-41B3-A6E5-2C1ABC41E5A6@holtmann.org>
	<CABBYNZ+YvTZMwg7O8TAJ10GZda-DnP1QJYudSesc1W1ENVNCQw@mail.gmail.com>
	<56152FA0.50808@mentor.com>
Date: Thu, 8 Oct 2015 11:59:55 +0300
Message-ID: <CABBYNZJ5990W=SC+q_mua7xEVM1_-h8dCGcXtzSqsJaPcCyg3Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Avoid L2CAP ERTM shutdown hung tasks
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Joshua_Frkuska@mentor.com,
	"Craske, Mark" <Mark_Craske@mentor.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Wed, Oct 7, 2015 at 5:43 PM, Dean Jenkins <Dean_Jenkins@mentor.com> wrot=
e:
> Hi Luiz,
>
> On 07/10/15 15:09, Luiz Augusto von Dentz wrote:
>>
>> Hi Dean,
>>
>> On Sat, Jun 6, 2015 at 7:13 AM, Marcel Holtmann <marcel@holtmann.org>
>> wrote:
>>>
>>> Hi Dean,
>>>
>>>> Details of the issue are described in the thread
>>>> [RFC] Bluetooth ERTM L2CAP deadlocks (hung tasks) due to
>>>> l2cap_sock_shutdown()
>>>> and kernel.org Bugzilla
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D99301
>>
>> Are you still working on this? I can still lock bluetoothd on close,
>> btw it seems you are not aware of the following:
>>
>>         SO_LINGER
>>                When enabled, a close(2) or shutdown(2) will not return
>> until all queued messages for the socket have been successfully sent
>> or the linger timeout  has  been  reached.   Otherwise,  the  call
>> returns immediately and the closing is done in the background.
>>
>> So according to the text above we should never call __l2cap_wait_ack
>> on l2cap_sock_shutdown since it should return immediately, only when
>> SO_LINGER is used it is allowed to block. Also there doesn't seems to
>> be anything prevent us to send a L2CAP Disconnect request while there
>> are unacked packets, at least I could find anything on the core about
>> waiting for unacked nor the test spec has any test for it.
>>
> Thanks for the information about SO_LINGER time. So it sounds like furthe=
r
> changes to the logic of the code are needed.
>
> Yes, we are still working on this issue. We have devised a fix for our
> commercial ARM kernel 3.14. and so far we have no reported failures.
>
> In our fix, we had to ensure "L2CAP Disconnect request" took precedence o=
ver
> shutdown.

Alright but then __l2cap_wait_ack should probably not be needed
anymore since the remote should discard any data not processed yet, or
if did process send the pending acks before the disconnect response,
which makes me question why we have this code in the first place.

> Note that ACKS are only used for L2CAP ERTM and so only some BT services
> risk getting hung such as audio media browsing over BT.

Actually for AVRCP browsing it does not matter since it won't transfer
persistent data, GOEP 2.0 would perhaps be a problem since it means
data transfers, which could be files in case of FTP, may not be
complete but OBEX don't have segmentation so you always need to wait
the final of GET or PUT command even in Single Response Mode which
means if the we disconnect before the data completes we should discard
the data so there is no point in waiting for unacked packets in GOEP
2.0.

> We are currently preparing a patchset for bluetooth-next of our 2nd attem=
pt
> at resolving the locking issue.

I wonder if you tried removing __l2cap_wait_ack and related code?

Btw, Ive trace down the original commit introduce this logic to:

commit 6161c0382bbab883a634d284f7367a88bbe88534
Author: Gustavo F. Padovan <padovan@profusion.mobi>
Date:   Sat May 1 16:15:44 2010 -0300

    Bluetooth: Add wait_queue to wait ack of all sent packets

    To guarantee that all packets we sent were received we need to wait for
    theirs ack before shutdown the socket.

    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
    Reviewed-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@profusion.mobi>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

It looks to me it was trying to prevent that the scenario where you
send a bunch of data and disconnect, probably l2test would do that,
which means there is no protocol on top, which Im now suspecting
doesn't even work with BlueZ as a receiving part because we only ack
if the window is 3/4ths full.

--=20
Luiz Augusto von Dentz
