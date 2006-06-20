Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4496DADD.5050208@cormack.org>
References: <4496DADD.5050208@cormack.org>
Date: Tue, 20 Jun 2006 11:55:37 +0200
Message-Id: <1150797337.18381.35.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluez NAP refuses connection if PANU clent
	has	deleted pairing.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Alec,

> I am using openslug 2.7 linux on Linksys NSLU2 server to create a 
> Bluetooth NAP.
> 
> The packages are a bit out of date but they are the latest available for 
> the NSLU2.
> 
> bluez-utils-nodbus - 2.21-r0 -
> kernel-module-bluetooth - 2.6.12.2-r17.4 -
> libbluetooth1 - 2.21-r0 -
> 
> The NAP works perfectly allowing clients to connect, enter the PIN and 
> gain internet access via tle Bluez NAP.  Once clients have paired once 
> they can re-connect without a PIN.
> 
> The problem I get is if a client deletes its pairing but the server 
> still has its pairing in /var/lib/bluetooth/{ADDR}/linkkeys.  Under 
> these circumstances the client is refused access until I delete the 
> pairing on the server - at which point the client is prompted to re-pair 
> and everything then works fine again.
> 
> I assumed there was some combination of settings in hcid.conf that would 
> overcome this (pairing multi looked promising! but made no difference) 
> and I have tried every variation of  settings I can think of. 

you are in security mode 3 (auth and encrypt enabled). Don't do this.
Simply start pand with -A and -E options. You should also update your
bluez-utils to the latest version, because the handling of the link keys
might contain a bug and this is the reason why you see this issue.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
