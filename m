Return-Path: <SRS0+824b9af48ed8284d9739+263+infradead.org+dwmw2@baythorne-075349.srs.infradead.org>
Subject: Re: [Bluez-devel] autoconf breaks portability. Film at 11.
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084398405.25099.118.camel@pegasus>
References: <1084268833.11301.0.camel@hades.cambridge.redhat.com>
	 <1084368666.25099.38.camel@pegasus>
	 <1084369122.4426.106.camel@hades.cambridge.redhat.com>
	 <1084369703.25099.56.camel@pegasus>
	 <1084371089.4426.148.camel@hades.cambridge.redhat.com>
	 <1084382619.25099.81.camel@pegasus>
	 <1084384989.4426.450.camel@hades.cambridge.redhat.com>
	 <1084398405.25099.118.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084431228.21553.75.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Thu, 13 May 2004 07:53:48 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 23:46 +0200, Marcel Holtmann wrote:
> > hades /hades/bluez/libs2 $ ./configure
> > -bash2: ./configure: No such file or directory
> 
> There must be another problem. Please do a clean CVS checkout.

A clean checkout on a third machine shows the same problem. It seems I
can make it build by running 'libtoolize' or manually copying in
ltmain.sh from one of the five different versions of automake which is
installed.

Perhaps someone needs to write 'autoauto' to help people automate all
this gratuitous package automation?

Personally, I'll stick with M-x makefile-mode :)

-- 
dwmw2
