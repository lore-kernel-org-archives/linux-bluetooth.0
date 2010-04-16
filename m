Return-Path: <cyrus@holtmann.org>
Message-ID: <315060.46799.qm@web94904.mail.in2.yahoo.com>
Date: Fri, 16 Apr 2010 19:58:53 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: killing stalled ACL connection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <p2u2d5a2c101004160102uafada73az98db61259c9e2d21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--- On Fri, 16/4/10, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Subject: Re: killing stalled ACL connection
> To: "Pavan Savoy" <pavan_savoy@yahoo.co.in>
> Cc: linux-bluetooth@vger.kernel.org
> Date: Friday, 16 April, 2010, 1:32 PM
> Hi,
> 
> On Thu, Apr 15, 2010 at 10:25 PM, Pavan Savoy <pavan_savoy@yahoo.co.in>
> wrote:
> > I am working on a platform which has a very aggressive
> power management features.
> > So consider a situation, where an a2dp connection
> exists with a headset, and i pause the media over AVRCP, so
> my phone now goes into suspend state (shutting off UART
> clocks),
> >
> > and when I wake-up (resume) using the AVRCP
> connection, via the play/pause button, I see the platform
> waking up and media player receiving the input, However I
> also see this,
> >
> > hci0  ACL tx timeout.
> > killing stalled ACL connection.
> >
> > and media is not able to play on the headset anymore.
> > Although the media player thinks it's being played.
> >
> > Now where should I look into, as to why a perfectly
> nice ACL (l2cap, a2dp) connection was dropped during the
> suspend ?
> 
> I guess you mean the system is suspended, to be honest I
> thought that
> would mean shutting down the bluetooth chip too which
> obviously will
> drop all the connections, but that doesn't seems to be the
> case here,
> does it? Anyway if you shutdown the bus which you
> communicate with the
> chip it could eventually timeout, I guess in such situation
> it is
> better to enter sniff mode, use some kind of bus that can
> wakeup/powerup automatically if there is data to transfer
> or a
> combination of both.

UART does this kind of automatically, I mean there is no s/w calls that are made it go into suspend state. (there is a hardware module which does that - we just have to configure it)

And yes, bluetooth chip is actually alive and active after suspend/resume.
However it's only the ACL connections that are getting dropped.

Is there some sort of timeout involved ? with these ACL connections ?
because I guess even the LMP's time to leave messages would not be going to headset (if there is such a thing called TTL messages).

I need some hint as to how I can debug this ...
> 
> -- 
> Luiz Augusto von Dentz
> Computer Engineer
> 


