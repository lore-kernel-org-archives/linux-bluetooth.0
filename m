Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4333FE27.1050909@cyph.ath.cx>
References: <432D6F49.80304@cyph.ath.cx>
	 <20050919092548.1173.2@@vodafone.es>
	 <1127217202.5168.36.camel@localhost.localdomain>
	 <4333EA05.7090707@cyph.ath.cx>
	 <1127483592.5623.5.camel@localhost.localdomain>
	 <4333FE27.1050909@cyph.ath.cx>
Content-Type: text/plain
Message-Id: <1127485700.5623.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 23 Sep 2005 16:28:20 +0200

Hi,

> I patched the kernel with 
> http://www.holtmann.org/linux/kernel/patch-2.4.20-mh18.gz and there is 
> test for HCI_QUIRK_RESET_ON_INIT in  hci_core.c, although the 
> surrounding has changed a bit since then. So all I did was to add the 
> flag to hci_ldisc.c, and hcidump verified a reset was issued.

I don't support the 2.4 kernel anymore and I don't have the hardware to
verify if this should work anyhow. I need the test hardware for it or
you need to send a full decoded strace to see what they are doing.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
