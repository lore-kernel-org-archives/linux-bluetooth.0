Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Sybren Stuvel <sybren@thirdtower.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200311050945.34166.sybren@thirdtower.com>
References: <200311050945.34166.sybren@thirdtower.com>
Content-Type: text/plain
Message-Id: <1068027414.10388.149.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 05 Nov 2003 11:16:54 +0100

Hi Sybren,

> I've been working with bluetooth for a few months now, trying to let BlueZ (on 
> my PC) talk to Affix (on my Zaurus). One difficulty is that rfcom doesn't 
> flush it's stdout when a new (incoming and/or outgoing) connection has been 
> made.
> 
> With the attached patch, scripts can use rfcomm to connect via bluetooth and 
> fork() the process in order to start using the connection (ie. by running 
> pppd over it).

I have no problem with the patch, but if you talk about PPP over RFCOMM
you should better use dund. And why do you need this for scripting? You
can bind a RFCOMM channel to a device and all stuff would be done in
background without user interaction.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
