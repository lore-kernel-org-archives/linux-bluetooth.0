Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <447C5100.9070503@gmx.de>
Date: Tue, 30 May 2006 16:04:48 +0200
From: Jens Hottenroth <jens-hottenroth@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <mailman.301.1148929305.21349.bluez-users@lists.sourceforge.net>
In-Reply-To: <mailman.301.1148929305.21349.bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Instability Problem extended info
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

Hello Marcel,

thanks for beeing interested in helping me.


I send you the requested information (and a bit more):

The bbt is running Kernel 2.4.25-mh5, gcc 3.3.3 with denx elkd version 3.1
The PC is running suse 9.3 professional with kernel
2.6.11.4-21.11-default and gcc 3.3.5 (3.3.3 when cross compiling for PPC)

I tested some more hardware, the D-Link DBT-120 is revision B4 (got two
of these), an Acer BT-600, and a Typhoon 20006. Everything works fine
between two PC's, when used in bbt it still hangs.

One of my co-workers is suspecting the USB-Host chip, a timing or data
size problem inside the bbt, so i'll try to check that out, too.


The commands I use are very simple,

l2ping BD_ADDR -s <size>

with <size> = {0, 20, 40, 100, 200, 300, 400, 500}


I have some debugging info from the kernel (a small part
while l2ping is active):

__recv_frame: hci0 type 4 data c3d714e0 count 7
__recv_frame: new packet len 7
hci_recv_frame: hci0 type 4 len 7
hci_num_comp_pkts_evt: hci0 num_hndl 1
hci_send_to_sock: hdev c0325a00 len 7
hci_event_packet: hci0 evt 0x13
hci_num_comp_pkts_evt: hci0 num_hndl 1
hci_send_to_sock: hdev c0325a00 len 7
hci_event_packet: hci0 evt 0x13
hci_num_comp_pkts_evt: hci0 num_hndl 1
hci_tx_task: hci0 acl 8 sco 8
hci_sched_acl: hci0
hci_low_sent: conn 00000000 quote 0
hci_sched_sco: hci0
hci_low_sent: conn 00000000 quote 0
hci_rx_task: hci0

	Till here it looks normal to me, but what's that status -84?

hci_usb_rx_complete: hci0 urb c0301f34 type 2 status -84 count 192 flags 10
hci_usb_rx_complete: hci0 urb c0301f34 type 2 resubmit status 0
hci_usb_rx_complete: hci0 urb c0301f34 type 2 status 0 count 9 flags 10
__recv_frame: hci0 type 2 data c3fda800 count 9
__recv_frame: new packet len 25446
hci_usb_rx_complete: hci0 urb c0301f34 type 2 resubmit status 0
hci_usb_rx_complete: hci0 urb c0301f34 type 2 status 0 count 343 flags 10
__recv_frame: hci0 type 2 data c3fda800 count 343
hci_usb_rx_complete: hci0 urb c0301f34 type 2 resubmit status 0
hci_usb_rx_complete: hci0 urb c0301f34 type 2 status 0 count 73 flags 10
__recv_frame: hci0 type 2 data c3fda800 count 73
hci_usb_rx_complete: hci0 urb c0301f34 type 2 resubmit status 0
hci_usb_rx_complete: hci0 urb c0301f34 type 2 status 0 count 343 flags 10

	And that's all he's doing from now on till reset. It' allways 	
	shows that status -84, but sometimes (depending on <size>) it 		
startsretransmitting normal, sometimes it breaks down.



The hcidump tool made the following trace (not matching the above kernel
debug):

It's a bit bigger, so i made a link. The command was

l2ping -s 500 BD_ADDR

ho//tten//roth.info/files/hcidump.log (without that extra //)


To be a bit more precise, i can't update the Kernel of the bbt to 2.6
without problems.


Thanks for all input, comments and help!

Best regards from Germany

Jens

> Date: Mon, 29 May 2006 15:25:01 +0200
> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: [Bluez-users] Bluetooth instability problem
> To: bluez-users@lists.sourceforge.net
> Message-ID: <1148909101.31689.48.camel@localhost>
> Content-Type: text/plain
> 
> Hi Jens,
> 
>> I don't know if i'm at the right spot here, but i'll ask here first. I
>> have the following problem:
>>
>> I've 3 "PCs" (one is an embedded linux based broadband handheld tester,
>> afterwards refered to as bbt), all running linux with Kernels from 2.24
>> (bbt) to 2.26 (PCs), and identical bluetooth usb-sticks (D-Link BT120).
>>
>> Here's what i've done / what i know:
>>
>> Downloaded the latest bluez-libs and bluez-utils, compiled and
>> installed. Ran configure / make for a new kernel with only that
>> functions needed, installed it to the bbt.
>>
>> Running some tests with l2ping brought the following results. I can ping
>> the bbt, sometimes i get no response messages (max. 5 after another,
>> most times 4 in a row). This test runs for about 30 minutes, then i
>> canceled it. The bigger I define paketsize (defaults 44 Bytes) the
>> faster / more often come those no response messages and, here it comes!,
>> when more than 250 Bytes are specified, the connection hangs! Aprox. 2
>> minutes. The bigger the paketsize the faster it hangs.
>> After it once hung, only a total reset of the bbt gets it running again.
>>
>> Between those 2 PCs, I only had problems with rfcomm and dun, pan worked
>> just fine. After i updated the Systems (it's SuSe linux 9.1 and 9.3, i
>> forgot to say that) those problems where gone.
>>
>> The biggest Problem is, that i can't path or upgrade the kernel in the bbt.
> 
> what kernel versions are you using. You mentioned onyl the bluez-utils
> versions. Please specify the exact commands you are using for testing
> and include the output of "hcidump -X -V".
> 
> Regards
> 
> Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
