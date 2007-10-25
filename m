Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <685df2130710250927m3f56731au9e6e508f851e9cf3@mail.gmail.com>
References: <685df2130710250927m3f56731au9e6e508f851e9cf3@mail.gmail.com>
Date: Fri, 26 Oct 2007 00:45:31 +0200
Message-Id: <1193352331.6184.284.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Audio service with multiple adapters
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

Hi Joshua,

> I am using BlueZ for a project and it is working well. I have a
> question concerning multiple adapters.
> 
> I am able to connect my headset to the default adapter through the
> audio service. However I cannot connect a headset to a second adapter
> (hci1) through the audio service. I can bond my headset to the second
> adapter, but I cannot create a sco connection. 
> 
> Is it possible to start the audio service on the non-default adapter
> (hci1)?
> Is it possible to run the audio service for both adapters? I would
> like to have 2 adapters each supporting a separate headset.

the audio service can used with any attached adapter. It is designed to
deal with them. However having two SCO channels open at the same time
might be limited by your hardware.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
