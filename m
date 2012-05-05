Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1205041444580.22429@mathewm-linux>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
	<1335976922-19456-4-git-send-email-mathewm@codeaurora.org>
	<CAA37ikaut-vNWLS1d9vGUWV=rLMH6Ud72j8Mwn3+u18-a_Bf-w@mail.gmail.com>
	<alpine.DEB.2.02.1205041444580.22429@mathewm-linux>
Date: Fri, 4 May 2012 22:11:55 -0300
Message-ID: <CAA37ikZFFC-eyQ578aks3hiO8DYGwvbQADntZG82TUOkb91ALA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Lock the L2CAP channel when sending
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org, pkrystad@codeaurora.org,
	andrei.emeltchenko.news@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Fri, May 4, 2012 at 6:54 PM, Mat Martineau <mathewm@codeaurora.org> wrote:
>
> Hi Ulisses -
>
>
> On Fri, 4 May 2012, Ulisses Furquim wrote:
>
>> Hi Mat,
>>
>> On Wed, May 2, 2012 at 1:42 PM, Mat Martineau <mathewm@codeaurora.org>
>> wrote:
>>>
>>> The ERTM and streaming mode transmit queue must only be accessed while
>>> the L2CAP channel lock is held.  Locking the channel before calling
>>> l2cap_chan_send ensures that multiple threads cannot simultaneously
>>> manipulate the queue when sending and receiving concurrently.
>>>
>>> L2CAP channel locking had previously moved to the l2cap_chan struct
>>> instead of the associated socket, so some of the old socket locking
>>> can also be removed in this patch.
>>>
>>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>>> ---
>>>  include/net/bluetooth/bluetooth.h |    2 --
>>>  net/bluetooth/l2cap_sock.c        |   15 ++++++++-------
>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>>
>> Looks good. I'm just wondering if we still have issues with chan lock
>> versus sock lock elsewhere. Maybe you've done some auditing of this?
>
> I did an extensive review of the locking code with respect to ERTM last
> week, and I'm satisfied with the use of chan_lock there.
>
> The work to decouple l2cap_chan from sockets is not yet complete, so there
> are still socket locking calls at connect and disconnect time. The data path
> looks like it is clear of socket locks now.

Thanks, that's good to know.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
