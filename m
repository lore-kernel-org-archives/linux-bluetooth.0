Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA938703F60CE5@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
Cc: "Light, John" <john.light@intel.com>
Subject: [Bluez-users] PAN between BlueZ and WindowsXP SP 2
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
Date: Wed, 28 Jul 2004 23:34:36 -0700

Hello -- a member of our team has identified a subtle problem with the
BlueZ core which is triggered when trying to use the PAN profile of the
Microsoft WindowsXP SP2 built-in Bluetooth stack.

Included below is the report from the engineer who discovered the
problem.

	Trevor


The problem is that after successful connection between the Windows
Bluetooth stack and the Linux Bluez stack, no packets from the device
ever reach the PC running Windows XP Service Pack 2.  That is, a ping
from the PC never receives a response, and a ping from BlueZ never
reaches the PC (as shown by the PC packet statistics.)  Linux packet
statistics (ifconfig) show that PC packets are received, but all return
traffic seems to be routed over the lo interface.

Immediately after creating the BNEP connection with Bluez, the Windows
Bluetooth stack sends a BNEP_FILTER_NET_TYPE_SET_MSG with an effective
length of zero.  Bluez interprets this message (in
bluetooth/bnep/core.c) to mean that no filter ranges should be allowed.
Specifically, the code in bnep_ctrl_set_netfilter zeros the first entry
in the filter list, which is interpreted by bnep_net_proto_filter in
netdev.c as meaning that no ranges of acceptable packets are available.
This interpretation leads to all packets being rejected by BNEP.

The Bluetooth BNEP specification clearly states the following:

The length (in octets) of this message is 4+4*N, where N is the number
of disjoint ranges of Networking protocol types that form the complete
set. Note that N=3D0 (empty set) denotes a reset to default filters (if
any) supported by the remote device.=20

Instead of resetting to default filters, Bluez eliminates all filters,
disallowing all traffic.

Since the proper solution involves reorganizing the default filter
initialization code, I am leaving to more capable hands the actual code
changes to make the code operate according to the specification.

I supply the following one line hack for those interested in running
with the Windows Bluetooth stack until the proper fix is available.
Change the line in bnep_ctrl_set_netfilter from

            if (i < BNEP_MAX_PROTO_FILTERS)

to

            if (i > 0 && i < BNEP_MAX_PROTO_FILTERS)


This works as long as explicit filters have not previously overridden
the defaults.

=20

John Light
Intel Research
jjlight@ibeam.intel.com



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
