Return-Path: <cyrus@holtmann.org>
Subject: Re: Sony BD Remote (the saga continues)
From: Bastien Nocera <hadess@hadess.net>
To: Simon Kenyon <simon@koala.ie>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <492FCDD1.1010304@koala.ie>
References: <492FC4A3.4020601@koala.ie>  <492FCDD1.1010304@koala.ie>
Content-Type: text/plain
Date: Fri, 28 Nov 2008 14:22:06 +0000
Message-Id: <1227882126.26649.1099.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2008-11-28 at 10:54 +0000, Simon Kenyon wrote:
> Simon Kenyon wrote:
> > so i decided to start working my way through the code and found 
> > references to uinput in input/device.c
> > this gave me another keyword to use in google and lo and behold this 
> > popped up:
> >
> > Fri Oct 17 2008 - Bastien Nocera <bnocera@redhat.com 
> > <mailto:bnocera@redhat.com>> - 4.14-2
> > - Add script to autoload uinput on startup, so the PS3 remote
> >  works out-of-the-box
> >
> >
> > sure enough i did not have this module in my kernel.
> > just building now in hope that this might be the issue
> well that got me nowhere - still no events
> but at least i now have a /dev/input/uinput

You need to press buttons on the remote for it to connect to the
computer. It will disconnect automatically after some time of idleness.

After that you need to use a new enough X server, or LIRC to get the
events to your X applications.

