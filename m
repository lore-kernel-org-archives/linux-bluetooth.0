Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matthew Marshall <mmarshall@myrealbox.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Audio service class?
References: <200509181632.29044.mmarshall@myrealbox.com> <200509181721.55295.mmarshall@myrealbox.com> <432E34E5.3070704@xmission.com>
In-Reply-To: <432E34E5.3070704@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509191651.47272.mmarshall@myrealbox.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Sep 2005 16:51:46 +0000

Hi Brad,

Thanks for the help!

Turns out I made a stupid mistake... I was using ciptool instead of hcitool :$
I guess the fact that the Audio service class isn't show doesn't matter?

Anyway, although I am now able to detect the headset, I'm still having 
problems.  I'll play with it some more, and come back here if I cannot figure 
it out on my own :P

Thanks!

MWM

On Monday 19 September 2005 03:47 am, Brad Midgley wrote:
> Matthew,
>
> Device class on the host seems to be a first-level service advertisement
> queried by devices initiating a connection to the host. Device class,
> sdp record, and listening/server socket are all necessary to accept a
> new connection "cold" from the headset. We don't support this currently,
> but we should.
>
> We do have a lot of trouble with dual boot systems or using a dongle on
> different hosts to talk to the same headset. Are you doing either of
> those? (we have some hints on bluetooth-alsa.sf.net)
>
> You're putting the headset in pairing mode before the scan, right? Most
> sets flash between blue and red while in pairing mode.
>
> Brad
>
> Matthew Marshall wrote:
> > On Sunday 18 September 2005 10:02 pm, Brad Midgley wrote:
> >>Matthew
> >>
> >>>haven't been able get the dongle to pick up the headset.
> >>
> >>what does this mean? it isn't found by 'hcitool scan' or something?
> >
> > Yeah, that's what I mean.
> >
> >>>The class is set to 0x3e0100, but Audio is not included in the Service
> >>>Classes list.  (I assume this is the reason why the headset is not being
> >>>detected.)
> >>
> >>the host sets the service class mask--it's not a feature of the dongle.
> >
> > That's what I thought.  From the hcid.conf man page, I see that Audio is
> > bit 6 which is set by 0x3e.  So why isn't Audio listed?  (For that
> > matter, 0x3e should also enable Object Transfer, which isn't in the list
> > either.)  I tried other classes as well, with no success.  (Such as
> > 0x200100, which should give me only Audio, but gives me nothing.)
> >
> > Any clue what is causing this?
> >
> > Thanks!
> >
> > MWM
> >
> >
> > -------------------------------------------------------
> > SF.Net email is sponsored by:
> > Tame your development challenges with Apache's Geronimo App Server.
> > Download it for free - -and be entered to win a 42" plasma tv or your
> > very own Sony(tm)PSP.  Click here to play:
> > http://sourceforge.net/geronimo.php
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
