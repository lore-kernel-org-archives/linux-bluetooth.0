Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand connection to XP SP2 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1103024795.4097.65.camel@justakiss>
References: <1103024795.4097.65.camel@justakiss>
Content-Type: text/plain
Message-Id: <1103024932.2143.156.camel@pegasus>
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
Date: Tue, 14 Dec 2004 12:48:52 +0100

Hi Erwin,

> I want to establish a pand connection to XP/SP2 with a MSI-6967 dongle.
> I have installed the MSI driver for WinXP with SP2. The client is a
> Laptop with a CBT100C card, Linux 2.4.22-mh7, bluez-libs+utils 2.12.
> When I try to connect to the XP box with 
>   pand --role PANU -c <ADR>
> Windows is asking for the Pin. After entering the correct pin, I'm
> always getting the following pand error:
> 
> ...
> pand[15249]: Connecting to <ADR>
> hcid[15183]: link_key_request (sba=..., dab=...)
> pand[15249]: Connect to <ADR> failed. Protocol error(71)
> 
> I'm able to connect to a PC running Bluez with the same setup.

show us the output of "hcidump -X" (as root) while your are connecting.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
