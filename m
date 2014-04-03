Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Apr 2014 10:06:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: USB autosuspend causing trouble on Intel bluetooth (Linux 3.14)
Message-ID: <20140403070636.GA18305@t440s.lan>
References: <533C8F3C.6090306@archlinux.org>
 <922DC347-921E-4B82-9843-7758BD096854@holtmann.org>
 <533C97A3.8080104@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <533C97A3.8080104@archlinux.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Thu, Apr 03, 2014, Thomas Bächler wrote:
> > You can easily check by running the "Inquiry (LIAC)” test from
> > tools/hci-tester. Problem is that some of the HCI events are not
> > making it to the host. They get delivered as soon as the device
> > wakes up again. In this test case it is the Inquiry Complete event.
> > If you poke the controller and send a new command, the even will be
> > magically dequeued.
> 
> I cannot figure out how to compile hci-tester. The Makefiles from
> bluez.git won't build it.

A quick look at Makefile.tools shows that you'll probably need to pass
--enable-experimental to configure in order to build it.

Johan
