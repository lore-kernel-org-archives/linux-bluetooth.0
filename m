Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: paivakil@gmail.com (Mahesh T. Pai)
Date: Wed, 31 Jan 2007 09:19:28 +0530
Message-ID: <87tzy73lfb.fsf@nandini.home>
References: <87tzy89q6p.fsf@nandini.home>
Mime-Version: 1.0
Subject: Re: [Bluez-users] 'hcitool scan' failing
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

paivakil@gmail.com (Mahesh T. Pai) writes:

> I  am trying to  set up  bluetooth networking  on two  systems running
> debian  unstable. One  is an  i386 and  other is  running  amd64.  The
> OS/software is otherwise identical for both systems.

And here is the output of syslog at bootup:-

# grep -i blue /var/log/syslog

Jan 31 02:14:10 nandini hcid[4736]: Default passkey agent (:1.9, /org/bluez/applet) registered
Jan 31 02:34:47 nandini hcid[4736]: Releasing agent :1.9, /org/bluez/applet
Jan 31 02:34:47 nandini hcid[4736]: Unregister path:/org/bluez/hci0
Jan 31 02:34:47 nandini hcid[4736]: Unregister path:/org/bluez
Jan 31 02:34:48 nandini hcid[5383]: Bluetooth HCI daemon
Jan 31 02:34:48 nandini sdpd[5385]: Bluetooth SDP daemon
Jan 31 02:34:48 nandini pand[5387]: Bluetooth PAN daemon version 3.7
Jan 31 02:34:48 nandini hcid[5383]: Register path:/org/bluez fallback:1
Jan 31 02:34:48 nandini hcid[5383]: Register path:/org/bluez/hci0 fallback:0
Jan 31 02:34:49 nandini hcid[5383]: Default passkey agent (:1.9, /org/bluez/applet) registered
Jan 31 02:53:03 nandini hcid[5383]: Register path:/org/bluez/hci0 fallback:0
Jan 31 02:53:03 nandini hcid[5383]: D-Bus failed to register /org/bluez/hci0 object
Jan 31 09:04:47 nandini kernel: Bluetooth: Core ver 2.10
Jan 31 09:04:47 nandini kernel: Bluetooth: HCI device and connection manager initialized
Jan 31 09:04:47 nandini kernel: Bluetooth: HCI socket layer initialized
Jan 31 09:04:47 nandini kernel: Bluetooth: HCI USB driver ver 2.9
Jan 31 09:04:48 nandini usbmgr[1891]: "bluetooth" was loaded
Jan 31 09:05:08 nandini hcid[2492]: Bluetooth HCI daemon
Jan 31 09:05:08 nandini hcid[2492]: Register path:/org/bluez fallback:1
Jan 31 09:05:08 nandini hcid[2492]: Register path:/org/bluez/hci0 fallback:0
Jan 31 09:05:08 nandini kernel: Bluetooth: L2CAP ver 2.8
Jan 31 09:05:08 nandini kernel: Bluetooth: L2CAP socket layer initialized
Jan 31 09:05:08 nandini sdpd[2495]: Bluetooth SDP daemon
Jan 31 09:05:08 nandini kernel: Bluetooth: RFCOMM socket layer initialized
Jan 31 09:05:08 nandini kernel: Bluetooth: RFCOMM TTY layer initialized
Jan 31 09:05:08 nandini kernel: Bluetooth: RFCOMM ver 1.8
Jan 31 09:05:08 nandini kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Jan 31 09:05:08 nandini kernel: Bluetooth: BNEP filters: protocol multicast
Jan 31 09:05:08 nandini pand[2514]: Bluetooth PAN daemon version 3.7



-- 
 Mahesh T. Pai <<>> http://paivakil.blogspot.com/
Netiquette Guidelines ==>> http://tools.ietf.org/html/rfc1855


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
