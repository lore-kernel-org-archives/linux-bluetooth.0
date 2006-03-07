Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SDP in Motorola phones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <440DB456.3030401@yahoo.com>
References: <440DB456.3030401@yahoo.com>
Content-Type: text/plain
Message-Id: <1141751166.4258.12.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 07 Mar 2006 18:06:06 +0100

Hi Pedro,

> I am experiencing problems getting SDP information from some new 
> Motorola phones (I am dealing with E770). Running "sdptool browse 
> BDADDR", I get the attached hcidump. As it can be seen, after the SDP 
> SSA request, the mobile phone does not respond any data and after 20 
> seconds (the SDP timeout compiled in bluez-libs), sdptool issues an ACL 
> disconnect. During this time, the phone freezes completely. If I want to 
> get a specific service (say, OBEX), there are no problems.
> 
>  From my understanding, the problem is that the Motorola phone does not 
> deal correctly with the SDP query issued by bluez. I have been trying to 
> debug sdptool and comparing to other implementations (Symbian seems to 
> work OK with Motorola) but, as Marcel says, SDP is a horrible protocol.
> 
> Has anybody experienced any similar problem?

this problem also exists on the RARZ V3x and I called it ByeByeMoto,
because it stalls my complete phone. There can't be an easy workaround.
It is a really serious bug from Motorola and they should provide free
software upgrades to anyone. However I have no idea how they passed the
Bluetooth qualification with these devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
