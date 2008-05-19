Return-Path: <cyrus@holtmann.org>
Message-ID: <4831F991.2080801@deltamobile.com>
Date: Mon, 19 May 2008 17:05:05 -0500
From: "Ellen (Yi) Zhang" <ezhang@deltamobile.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <mailman.269331.1211068363.29930.bluez-users@lists.sourceforge.net>
In-Reply-To: <mailman.269331.1211068363.29930.bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] bccmd set PS Key issue
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

Hi all,

I'm using a CSR casira kit with BC04 ROM to connect to a Linux PC 
through UART. 

By "hciattach", the casira board is attached to Bluez stack and the 
"hciconfig hci0 up" could initiate the device. 

The issue is with "bccmd psset" command.  I used "bccmd pslist" and 
"bccmd psread" to check the PS Keys that are configured in persistent 
stores and found that PSKEY_ANA_FREQ was not in the list.  To get the 
casira board running, I tried to set the Bluetooth address and crystal 
frequency of the BC04 ROM by "bccmd psset".   Writing a new bdaddr to 
PSKEY_BDADDR is OK while writing to PSKEY_ANA_FREQ fails.  From hcidump, 
I found that to write data to a PS Key, it first reads the PS Key from 
RAM and check the length of the variable.  For PS Keys that are not 
configured yet, like the anafreq in my case, the length of the variable 
would be 0 and the cmd_psset function in bccmd.c exits with error, not 
trying to write.  So the "psset anafreq" always fails with "Can't 
execute command: No such device or address (6)".  Since PSKEY_BDADDR 
already has a default value, it's ok to use psset to change the value. 

Could anyone give any hints what I did wrong?  Your help is highly 
appreciated.

Best regards,
Ellen


Linux 2.6.22
bluez-libs 3.24
bluez-utils 3.24
1. Configure Bluetooth address:
 > sudo bccmd psset -s default bdaddr 0xfa 0x00 0x0d 0xc1 0x55 0x00 0x0c 
0x00
[Corresponding hcidump:]
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0xc5c
    LMP Version: 2.0 (0x3) LMP Subversion: 0xc5c
    Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Vendor (0x3f|0x0000) plen 19
    BCCMD: Get req: len 9 seqno 0 varid 0x3006 status 0
      PS_SIZE: key 0x0001 stores 0x0000
 > HCI Event: Vendor (0xff) plen 19
    BCCMD: Get rsp: len 9 seqno 0 varid 0x3006 status 0
      PS_SIZE: key 0x0001 len 0x0004
< HCI Command: Vendor (0x3f|0x0000) plen 25
    BCCMD: Set req: len 12 seqno 1 varid 0x7003 status 0
      PSKEY: key 0x0001 len 4 stores 0x0000
        BDADDR: bdaddr 00:55:C1:0D:00:FA
 > HCI Event: Vendor (0xff) plen 25
    BCCMD: Get rsp: len 12 seqno 1 varid 0x7003 status 0
      PSKEY: key 0x0001 len 4 stores 0x0000
        BDADDR: bdaddr 00:55:C1:0D:00:FA

2. Configure crystal frequency:
 > sudo bccmd psset -s default anafreq 0x6590
Can't execute command: No such device or address (6)
[Corresponding hcidump:]
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0xc5c
    LMP Version: 2.0 (0x3) LMP Subversion: 0xc5c
    Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Vendor (0x3f|0x0000) plen 19
    BCCMD: Get req: len 9 seqno 0 varid 0x3006 status 0
      PS_SIZE: key 0x01fe stores 0x0000
 > HCI Event: Vendor (0xff) plen 19
    BCCMD: Get rsp: len 9 seqno 0 varid 0x3006 status 8
      PS_SIZE: key 0x01fe len 0x0000



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
