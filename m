Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4335003A.6000400@cyph.ath.cx>
From: Ho Ming Shun <cyph@cyph.ath.cx>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
References: <432D6F49.80304@cyph.ath.cx>	 <20050919092548.1173.2@@vodafone.es>	 <1127217202.5168.36.camel@localhost.localdomain>	 <4333EA05.7090707@cyph.ath.cx>	 <1127483592.5623.5.camel@localhost.localdomain>	 <4333FE27.1050909@cyph.ath.cx> <1127485700.5623.8.camel@localhost.localdomain>
In-Reply-To: <1127485700.5623.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sat, 24 Sep 2005 15:28:58 +0800

Hi,

I just did an interesting experiment:

After the phone's native stack was initialized, I killed off all 
processes. Then I did a hciattach to ttyS1, followed by "hciconfig hci0 
up". The BD_ADDR still shows 00:00:00:00:00:00.

It seems that the chip can still operate with READ_BD_ADDR returning 
00:00:00:00:00:00. The phone's stack though already knows the BD_ADDR 
through some other means (which I have not discovered).


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
