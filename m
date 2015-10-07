Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9DBA7668-848C-41B3-A6E5-2C1ABC41E5A6@holtmann.org>
References: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
	<9DBA7668-848C-41B3-A6E5-2C1ABC41E5A6@holtmann.org>
Date: Wed, 7 Oct 2015 17:09:57 +0300
Message-ID: <CABBYNZ+YvTZMwg7O8TAJ10GZda-DnP1QJYudSesc1W1ENVNCQw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Avoid L2CAP ERTM shutdown hung tasks
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Joshua_Frkuska@mentor.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

On Sat, Jun 6, 2015 at 7:13 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Dean,
>
>> Details of the issue are described in the thread
>> [RFC] Bluetooth ERTM L2CAP deadlocks (hung tasks) due to l2cap_sock_shutdown()
>> and kernel.org Bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=99301

Are you still working on this? I can still lock bluetoothd on close,
btw it seems you are not aware of the following:

       SO_LINGER
              When enabled, a close(2) or shutdown(2) will not return
until all queued messages for the socket have been successfully sent
or the linger timeout  has  been  reached.   Otherwise,  the  call
returns immediately and the closing is done in the background.

So according to the text above we should never call __l2cap_wait_ack
on l2cap_sock_shutdown since it should return immediately, only when
SO_LINGER is used it is allowed to block. Also there doesn't seems to
be anything prevent us to send a L2CAP Disconnect request while there
are unacked packets, at least I could find anything on the core about
waiting for unacked nor the test spec has any test for it.

-- 
Luiz Augusto von Dentz
