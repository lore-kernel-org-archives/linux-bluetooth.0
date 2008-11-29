Return-Path: <cyrus@holtmann.org>
Subject: Re: Sony BD Remote (the saga continues)
From: Bastien Nocera <hadess@hadess.net>
To: Simon Kenyon <simon@koala.ie>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49307404.6080003@koala.ie>
References: <492FC4A3.4020601@koala.ie>  <492FCDD1.1010304@koala.ie>
	 <1227882126.26649.1099.camel@cookie.hadess.net> <49307404.6080003@koala.ie>
Content-Type: text/plain
Date: Sat, 29 Nov 2008 00:59:41 +0000
Message-Id: <1227920381.26649.1749.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2008-11-28 at 22:43 +0000, Simon Kenyon wrote:
> Bastien Nocera wrote:
<snip>
> > You need to press buttons on the remote for it to connect to the
> > computer. It will disconnect automatically after some time of idleness.
> >
> > After that you need to use a new enough X server, or LIRC to get the
> > events to your X applications.
> >   
> what causes the /dev/input/eventX file to be created?
> ie. is it bluetoothd or hidd?

It is obviously bluetoothd (actually bluetoothd's input plugin) as I've
said a couple of days ago (and on numerous occasions on this list) that
hidd has no code to handle the PS3 BD remote's protocol. If you're using
hidd, it won't ever work, period.

If the PS3 remote isn't connected properly, it won't show up in
bluetooth-properties.

