Return-Path: <cyrus@holtmann.org>
Message-ID: <48A901E6.8060801@theforce.com.au>
Date: Mon, 18 Aug 2008 15:00:22 +1000
From: Grahame Jordan <gbj@theforce.com.au>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Cc: "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>
Subject: [Bluez-users] stalled ACL connection
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

Hi,

We are using a gumstix with Kernel 2.6.18gum with bluez-libs-2.24 and bluez-utils-2.24

Our device was setup as slave for PAN
PAND_OPTIONS="--role PANU --service GN --connect 00:15:83:C6:78:0f --persist"

This was connecting well with the BlueSoleil Windows BT Stack
However the BlueSoleil stack is fairly promiscuous and can trash other setting on a Windows machine.

We are using a 
Bus 006 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
which works with native WindowsXP SP2+ Bluetooth stack.

However the Windows stack requires that the PAN on our device is set to Master
PAND_OPTIONS="--role GN --service PANU --connect 00:15:83:C6:78:0f --persist"

Since it has been set to Master it does connect OK but it seems to consistently drop off after at least 12 hours of operation.

When I restarted the bluetooth stack I got this message.

Stopping Bluetooth subsystem:hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 71:78:C6:83:15:00
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection 71:78:C6:83:15:00
 pand dund rfcomm hidd sdpd hcid ttyS3.


Any help appreciated.

Thanks

Grahame Jordan


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
