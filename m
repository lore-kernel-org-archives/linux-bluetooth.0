Return-Path: <cyrus@holtmann.org>
Subject: Re: bug in hci_read_remote_name?
From: Marcel Holtmann <marcel@holtmann.org>
To: Erik Stackenland <erik@mobileinteraction.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49345A86.1040902@mobileinteraction.com>
References: <49345A86.1040902@mobileinteraction.com>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 02:52:53 +0100
Message-Id: <1229046773.22285.28.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Erik,

> I'm new to bluetooth and BlueZ, so it might be that I just don't know what I'm
> talking about but this does not seem right.
> 
> The problem is in hci_read_remote_name
> 
> <code>
> ...
> char bt[20];
> ba2str(&bdaddr, bt);
> printf("get name: %s\n", bt);
> 
> /* Get the name */
> if (hci_read_remote_name(dd, &bdaddr, sizeof(name_str), name_str, timeOut) < 0)
> {
>   return -1;
> }
> 
> printf("found name: %s\n",name_str);
> ...
> </code>
> 
> <printout>
> ...
> get name: 00:17:D5:5A:86:85
> get name: 00:1E:45:08:36:28
> found name: SGH-X820
> ...
> </printout>
> 
> The problem here is that I know for a fact that 00:1E:45:08:36:28 is not
> SGH-X820, but should be named W910i, and that 00:17:D5:5A:86:85 is SGH-X820.
> 
> I'm using 1000 millis timeout for hci_read_remote_name, so my assumption is that
> the time runs out before the response is received and when I ask with an other
> bt address a few millis later I get the response for the earlier request.
> 
> So is it possible that this is a bug?
> 
> System is debian-40r5 standard installation installed today. Dont know how to
> check BlueZ version.

you could call this a bug, but it is just a limitation with the name
request that is always problematic. Use the D-Bus interface to get the
names and this will be not a problem anymore.

Regards

Marcel


