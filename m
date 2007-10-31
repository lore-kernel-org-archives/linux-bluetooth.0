Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 31 Oct 2007 18:06:42 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193849542.32459.74.camel@violet>
Message-ID: <Pine.LNX.4.63.0710311758430.25155@redbean.intranet.gw-instruments.de>
References: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
	<1193849542.32459.74.camel@violet>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] multi-frequency scanning & possible contract work
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


Hi Marcel, 

> the use of an directional antenna with a Bluetooth chip is illegal as
> far as I know. You really wanna check the regulations here.

I don't think so. What you have to observe is that the maximum isotropic 
radiation does not exceed +20dBm. So if you use an directional antenna 
with a gain of, lets say +16 dBm (a somehow typical value) than the 
maximum transmit power that can be used is +4 dBm. And you have to 
convince the regulartory body that this will not be exceeded  under all 
circumstances.....

Ciao, 

Peter 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
