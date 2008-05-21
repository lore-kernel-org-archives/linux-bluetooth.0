Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4831F991.2080801@deltamobile.com>
References: <mailman.269331.1211068363.29930.bluez-users@lists.sourceforge.net>
	<4831F991.2080801@deltamobile.com>
Date: Wed, 21 May 2008 16:36:19 +0200
Message-Id: <1211380579.13248.70.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bccmd set PS Key issue
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

Hi Ellen,

> I'm using a CSR casira kit with BC04 ROM to connect to a Linux PC 
> through UART. 
> 
> By "hciattach", the casira board is attached to Bluez stack and the 
> "hciconfig hci0 up" could initiate the device. 
> 
> The issue is with "bccmd psset" command.  I used "bccmd pslist" and 
> "bccmd psread" to check the PS Keys that are configured in persistent 
> stores and found that PSKEY_ANA_FREQ was not in the list.  To get the 
> casira board running, I tried to set the Bluetooth address and crystal 
> frequency of the BC04 ROM by "bccmd psset".   Writing a new bdaddr to 
> PSKEY_BDADDR is OK while writing to PSKEY_ANA_FREQ fails.  From hcidump, 
> I found that to write data to a PS Key, it first reads the PS Key from 
> RAM and check the length of the variable.  For PS Keys that are not 
> configured yet, like the anafreq in my case, the length of the variable 
> would be 0 and the cmd_psset function in bccmd.c exits with error, not 
> trying to write.  So the "psset anafreq" always fails with "Can't 
> execute command: No such device or address (6)".  Since PSKEY_BDADDR 
> already has a default value, it's ok to use psset to change the value. 

the bccmd has the capability to load (psload) a PSR file. These kind of
files are a collection of PS keys. The bluez-utils contains an
example.psr and you will find the whole documentation on the CSR support
website.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
