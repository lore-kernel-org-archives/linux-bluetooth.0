Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] killing a persisted pand session
Date: Sun, 7 Mar 2004 03:07:49 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com> <200403070244.05285.wim.delvaux@adaptiveplanet.com> <1078624545.2807.17.camel@pegasus>
In-Reply-To: <1078624545.2807.17.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403070307.49974.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

On Sunday 07 March 2004 02:55, Marcel Holtmann wrote:
> Hi Wim,
>
> > When the ioctl locks I get the following dmesg
> >
> > unregister_netdevice: waiting for bnep0 to become free. Usage count = 2
>
> then your suspend don't clean up everything. What kernel are you using?
> Maybe it is impossible to do a suspend while you have a BNEP connection
> opened.


	it is the Ipaq that suspends and the desktop that hangs !
	Ipaq  2.4.19 Desktop 2.6.4.rc2 (bleeding edge !)
	
	I do not do a real suspend.  I bring the network down using a
	script in the suspend_scripts dir and bring it back up in the resume
	
	W
