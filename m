Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] newbie fedora2 & bluez questions
From: Marcel Holtmann <marcel@holtmann.org>
To: David Zhu <saki96@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040901183311.1763.qmail@web11601.mail.yahoo.com>
References: <20040901183311.1763.qmail@web11601.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1094458705.5145.1.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 06 Sep 2004 10:18:25 +0200

Hi David,

> I tried following the many howto guides on the web but
> I always seem to have problems after a certain step. 
> So I hope I'm not offending anyone with what may be a
> really simple issue.  Here we go...
> 
> I have a DLink DBT-120 Rev 4 USB Bluetooth adapter,
> which I have confirmed is supported on the hardware
> page.
> 
> I've installed the necessary packages from the fedora
> core 2:
> 
> bluez-libs-2.5-2.1
> bluez-utils-2.4-3
> gnome-bluetooth-0.4.1-7
> bluez-sdp-1.5-2.1
> 
> I'm running kernel 2.6.8
> 
> so when I do a "hcitool scan" I am able to find:
> 00:02:EE:E0:2A:E6       Nokia 6820
> 
> but when I do a "sdptool browse" I always get 
> Inquiring ...
> Failed to connect to SDP server on 00:02:EE:E0:2A:E6:
> Function not implemented

you enabled auth and encrypt and this means you set your device into
security mode 3. Don't do this and check my previous mails in the
mailing list archive for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
