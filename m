Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1191747315.5622.9.camel@Gentoo-desktop.lan>
References: <1191696694.2049.7.camel@Gentoo-desktop.lan>
	<d89ddf300710062041q59531981xe2a3c693960bff40@mail.gmail.com>
	<1191740426.5622.4.camel@Gentoo-desktop.lan>
	<1191746631.10698.176.camel@violet>
	<1191747315.5622.9.camel@Gentoo-desktop.lan>
Date: Sun, 07 Oct 2007 11:01:50 +0200
Message-Id: <1191747710.10698.182.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How do I get a bluetooth headset working?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Aniruddha,

> I did make a texfile in my home directory named '.asoundrc' with the
> following input (I obtained the address through hcitool)
> 
> pcm.bluetooth {
>    type bluetooth
>    device 00:11:22:33:44:55
> }
> 
> But how do I proceed using it with Skype? 

you need to also change the default PCM or select the Bluetooth headset
within Skype. However as Brad mentioned earlier, Skype might not work
since it has a broken usage of the ALSA interface.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
