Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid dies on socket connect attempt.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050709041029.GF16487@beta.private.mielke.cc>
References: <1120649879.8836.5.camel@pegasus>
	 <20050706120934.GW21449@beta.private.mielke.cc>
	 <1120652788.8836.7.camel@pegasus>
	 <20050706123359.GY21449@beta.private.mielke.cc>
	 <1120653839.8836.10.camel@pegasus>
	 <20050709041029.GF16487@beta.private.mielke.cc>
Content-Type: text/plain
Message-Id: <1120894994.29504.1.camel@notepaq>
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
Date: Sat, 09 Jul 2005 09:43:14 +0200

Hi Dave,

> On a Fedora Core 4 system we have:
> 
>    dbus-0.33-3
>    bluez-utils-2.15-7
>    bluez-libs-2.15-1
> 
> hcid starts up fine: 
> 
> ==============================================================================
> hcid -n
> hcid[12537]: Bluetooth HCI daemon
> hcid[12537]: Starting security manager 0
> ==============================================================================
> 
> As soon as I try to get a Bluetooth connection, however, it dies (see 
> below). 
> What might be wrong? 

last time I looked at the D-Bus 0.33 changes in the Fedora packages they
seemed to be wrong. Try it with the latest BlueZ CVS.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
