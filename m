Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1082655413.408802b54131b@webmail.natdesign.m.se>
From: Fredrik Hallgarde <bluez@tedde.nu>
To: Marian Gasparovic <marosg@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluetooth/gprs problem
References: <20040422171637.33680.qmail@web20405.mail.yahoo.com>
In-Reply-To: <20040422171637.33680.qmail@web20405.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 22 Apr 2004 19:36:53 +0200

Hi,

> Fredrik, I looked in .config and I don't know what to
> change, can somebody here help ? I include both USB
> and Bluetooth sections. It is 2.4.25-mh3
> Thank you in advance
> Marian

> # CONFIG_USB_EHCI_HCD is not set
> CONFIG_USB_UHCI_ALT=y
> # CONFIG_USB_OHCI is not set

Unfortunately I don't have access to that machine right now but IIRC I tried
using EHCI or OHCI instead of UHCI. I can verify that tonight and post more info
tonight (if my cable works) or tomorrow (New York time)
Since you are using USB debugging, are you getting any errors or similar?
Does other Bluetooth connections work?

/Fredrik


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
