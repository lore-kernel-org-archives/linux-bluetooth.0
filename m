Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <193720484730124@lycos-europe.com>
References: <193720484730124@lycos-europe.com>
Date: Sat, 11 Aug 2007 20:08:25 +0200
Message-Id: <1186855705.6698.20.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluetooth audio
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Joakim,

> I'm trying to intall the alsa-lib plugins for bluetooth audio.
> I have followed the instructions at:
> http://bluetooth-alsa.sourceforge.net/build.html
> install libsbc works well but when I install plugz I get errors ?
> I have attached the output of make whare I get the errors.
> 
> Do I need a newer kernel? I have 2.6.16.27-0.9-default
> I have alsa version 1.0.14
> My distribution is SLED10 / opensuse 10.1

your kernel is really old, but it should be good enough. However you
might wanna consider an update anyway.

The plugz code is basically dead. Actually it works, but the mainstream
solution is the Bluetooth audio service from the bluez-utils CVS. It now
has A2DP support and this one should be used. It is still a little bit
buggy and we have no good documentation for setting it up, but you might
find enough information in the wiki or on IRC to get this going.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
