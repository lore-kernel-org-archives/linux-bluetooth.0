Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with Bridging and PAN Profile
From: Fredrik Noring <noring@nocrew.org>
To: Christoph Scholz <scholz@cs.uni-bonn.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1073656142.3037.32.camel@willie.informatik.uni-bonn.de>
References: <1073656142.3037.32.camel@willie.informatik.uni-bonn.de>
Content-Type: text/plain
Message-Id: <1073853082.22680.58.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
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
Date: Sun, 11 Jan 2004 21:31:23 +0100

Hi Christoph,

fre 2004-01-09 klockan 14.49 skrev Christoph Scholz:
> Does anyone of you experienced similar problems? Any ideas on how to
> resolve this?

I'm trying to use a PAN too. After some initial problems I finally
had a working bnep0 interface between two Linux computers and it worked
for about 20 minutes. For some strange reason though, the bnep0
interface disappeared every few minutes so I had to do "pand --connect
xxx" to get it back again.

After those 20 minutes, "pand --connect xxx" stopped working too and 
began to crash mostly with "Connection timed out(110)" and sometimes
"Function not implemented(38)". Some things that worked before for
example "l2ping" also stopped working at this point. 

The "hcitool scan" command still displayed the other device though
and "hciconfig -a" produced something that looks OK to me:

hci0:   Type: USB
        BD Address: 00:03:C9:2A:C4:A8 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:60997 acl:1045 sco:0 events:986 errors:0
        TX bytes:136820 acl:1072 sco:0 commands:154 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: '0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 0x1007
        Manufacturer: Broadcom Corporation (15)

One of the boxes runs a Fedora kernel and the other is patched with
patch-2.4.18-mh10 (Dec 15, 2003). The other tools are "bluez-libs-2.5",
"bluez-utils-2.4", "bluez-sdp-1.5", "bluez-pan-1.1", "bluez-bluefw-1.0".

Is it possible to have a reliable PAN based connection between two Linux
computers? The Bluez/pand combination appears a bit unstable to me as it
works for a few minutes at a time and then stops working until reboot.

Thanks,
Fredrik




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
