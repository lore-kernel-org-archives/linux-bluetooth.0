Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: oliver@onesteprevolution.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187689633.6051.5.camel@ascension>
References: <1187689633.6051.5.camel@ascension>
Date: Fri, 24 Aug 2007 14:21:15 +0200
Message-Id: <1187958075.15402.163.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Sillicon Wave alternative
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

Hi Oliver,

> I've been attempting to get my Motorola HS810 (bluetooth headset) to
> work with Linux, but I've not had much luck.
> 
> [oli@ascension ~]$ sudo /usr/sbin/hciconfig -a | grep Manufacturer
>         Manufacturer: Silicon Wave (11)
> 
> I take I'm out of luck with my bluetooth adapter? It works fine for file
> transfers and so on! Is there any timeline for when these adapters might
> worth with audio?
> 
> If I have to get a new adapter, what would you recommend (in the UK)?

for A2DP stereo high quality audio support you should have no problem,
but if you wanna use your voice headset, then this might take some
additional rounds of hacking around the kernel. Not sure when we get
this done.

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
