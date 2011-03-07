Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D754A84.1020609@interlinx.bc.ca>
References: <4D6EF7ED.2090905@interlinx.bc.ca>
	<4D740AA7.5080209@interlinx.bc.ca>
	<AANLkTin3-+9txbUyFxyrirySnkjwWVeMHrZtCqGfz-4m@mail.gmail.com>
	<4D754A84.1020609@interlinx.bc.ca>
Date: Mon, 7 Mar 2011 16:57:00 -0600
Message-ID: <AANLkTikbv=9T3t_Y6LO4faqC5k1X_usWYH8ghmt8TGHV@mail.gmail.com>
Subject: Re: how to set adapter to master with bluez 4.69?
From: Andrei Warkentin <andreiw@motorola.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: public-linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>




On Mon, Mar 7, 2011 at 3:13 PM, Brian J. Murrell <brian@interlinx.bc.ca> wrote:
> On 11-03-06 08:08 PM, Brad Midgley wrote:
>> Brian,
>
> Hi Brad,
>
>> It has been really quiet.
>
> Indeed.
>

Does that mean I really should be posting to LKML for patch RFCs? To
get more eyes, hopefully?

>> I got the latest bluez and looked through doc/ and test/ for
>> references to link mode. I think maybe mentions of L2CAP_LM_MASTER in
>> test/l2test.c might be on the right track.
>
> OK.
>
>> You could probably follow
>> that model and set the l2cap link mode to get what you want. I didn't
>> see it in any gui I could find. A patch to a gui would be ambitious
>> but would end up being the nicest user experience in the end.
>
> Agreed.  Unfortunately, unlike quite a bit of technology, I am a total
> end-user of B/T.  I don't even really know what the stack looks like.  I
> guess I just have not had the bandwidth to dive in.
>
> That said, it seems odd that without a knob to give total control to the
> user, that the implicit behavior is not to make the adapter the master,
> if it can be.
>
> Understood, yes, that there might be a situation such as B/T networking
> where there are two hosts with adapters, so one would have to fall back,
> but for the more common case such as mice, headsets, etc. if the adapter
> needs to be master for them to co-exist peacefully, I wonder why that's
> not being done implicitly.
>
> Can in inquire from userspace which devices are master/slave?  hcitool
> looks interesting but I can't seem to get it to report master/slave of
> devices or the local adapter.
>
> Ahhh.  Wait.  I just did (after turning the mouse on):
>
> $ hcitool con
> Connections:
>        > ACL 00:1F:20:0F:30:6A handle 11 state 1 lm MASTER
>
> So it seems the mouse, which is the only remote device that's on, is master.
>
> When I try to change that I get:
>
> $ sudo hcitool sr 00:1F:20:0F:30:6A slave
> Switch role request failed: Input/output error
>
> b.
>
>
>
>

What do you get for hcitool info 00:1F:20:0F:30:6A?


