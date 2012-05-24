Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120524102342.GQ24715@aemeltch-MOBL1>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
	<1337821964-4618-2-git-send-email-gustavo@padovan.org>
	<1337821964-4618-3-git-send-email-gustavo@padovan.org>
	<1337821964-4618-4-git-send-email-gustavo@padovan.org>
	<20120524093958.GL24715@aemeltch-MOBL1>
	<20120524102342.GQ24715@aemeltch-MOBL1>
Date: Thu, 24 May 2012 08:17:23 -0300
Message-ID: <CAA37ikZvK=woaW_grv1t6PK0x0d3uz98MmjQL46z9PHPCJA0nA@mail.gmail.com>
Subject: Re: [RFC 3/8] Bluetooth: Add l2cap_chan->ops->ready()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, May 24, 2012 at 7:23 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi,
>
> On Thu, May 24, 2012 at 12:39:59PM +0300, Andrei Emeltchenko wrote:
>> Hi Gustavo,
>>
>> On Wed, May 23, 2012 at 10:12:39PM -0300, Gustavo Padovan wrote:
>> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>> >
>> > This move socket specific code to l2cap_sock.c.
>> >
>> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>> > ---
>> >  include/net/bluetooth/l2cap.h |    1 +
>> >  net/bluetooth/l2cap_core.c    |   18 +++---------------
>> >  net/bluetooth/l2cap_sock.c    |   21 +++++++++++++++++++++
>> >  3 files changed, 25 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> > index 29f7b06..d1f6819 100644
>> > --- a/include/net/bluetooth/l2cap.h
>> > +++ b/include/net/bluetooth/l2cap.h
>> > @@ -530,6 +530,7 @@ struct l2cap_ops {
>> >     void                    (*state_change) (void *data, int state);
>> >     struct sk_buff          *(*alloc_skb) (struct l2cap_chan *chan,
>> >                                            unsigned long len, int nb);
>> > +   void                    (*ready) (void *data);
>>
>> Again, why void *data ?
>
> I mean here that for fixed channels we do not need this function at this
> point since initialization is different.

So? What do you mean? This needs to be generic, I think. It's an
abstraction after all.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
