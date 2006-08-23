Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <1597.216.47.59.131.1156371924.squirrel@webmail.feline-soul.net>
Date: Wed, 23 Aug 2006 16:25:24 -0600 (MDT)
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
References: 
In-Reply-To: 
Subject: [Bluez-users] Logitech Traveler Headset. Progress but not there
 yet. Advice wanted.]
Reply-To: Bearcat@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

In addition to the information below, when when the snd_bt_sco module
loads at boot time i get the following in my dmsg log file:

#
#
snd-bt-sco revision 1.12 $
#

#
==========================================
#
[ BUG: lock recursion deadlock detected! |
#
------------------------------------------
#

#
modprobe/2715 is trying to acquire this lock:
#
 [ffff81003e00a880] {snd_card_bt_sco_probe}
#
.. held by:          modprobe: 2715 [ffff81003cda86f0, 125]
#
... acquired at:               alsa_card_bt_sco_init+0xba/0x2f1
[snd_bt_sco]
#
... trying at:                 alsa_card_bt_sco_init+0x13a/0x2f1
[snd_bt_sco]
#
------------------------------
#
| showing all locks held by: |  (modprobe/2715 [ffff81003cda86f0, 125]): #
------------------------------
#

#
#001:             [ffff81003e00a880] {snd_card_bt_sco_probe}
#
... acquired at:               alsa_card_bt_sco_init+0xba/0x2f1
[snd_bt_sco]
#

#

#
modprobe/2715's [current] stackdump:
#

#

#
Call Trace: <ffffffff8023719a>{report_deadlock+319}
#
       <ffffffff8805919d>{:snd_bt_sco:alsa_card_bt_sco_init+314}
#
       <ffffffff80237310>{check_deadlock+346}
<ffffffff80237330>{debug_mutex_add_waiter+21}
#
       <ffffffff8805919d>{:snd_bt_sco:alsa_card_bt_sco_init+314}
#
       <ffffffff805c072e>{__mutex_lock_slowpath+240}
<ffffffff80209f82>{child_rip+0}
#
       <ffffffff8805919d>{:snd_bt_sco:alsa_card_bt_sco_init+314}
#
       <ffffffff8023aada>{sys_init_module+4722}
<ffffffff8020954e>{system_call+126}
#

#
Showing all blocking locks in the system:
#
S            init:    1 [ffff81003ff81450, 117] (not blocked on mutex) #
R     ksoftirqd/0:    2 [ffff81003ff80da0, 134] (not blocked on mutex) #
S      watchdog/0:    3 [ffff81003ff806f0,   0] (not blocked on mutex) #
S        events/0:    4 [ffff81003ff80040, 110] (not blocked on mutex) #
S         khelper:    5 [ffff81003ff9b490, 110] (not blocked on mutex) #
S         kthread:    6 [ffff81003ff9ade0, 110] (not blocked on mutex) #
S       kblockd/0:    8 [ffff81003ff9a080, 110] (not blocked on mutex) #
S          kacpid:    9 [ffff81003fe5d4d0, 120] (not blocked on mutex) #
S           khubd:  144 [ffff81003fc16300, 110] (not blocked on mutex) #
S         kseriod:  146 [ffff81003fe5c0c0, 110] (not blocked on mutex) #
S         pdflush:  233 [ffff81003f8f8830, 120] (not blocked on mutex) #
S         pdflush:  234 [ffff81003f8f8180, 115] (not blocked on mutex) #
S         kswapd0:  235 [ffff81003f9035d0, 125] (not blocked on mutex) #
S           aio/0:  236 [ffff81003f902f20, 120] (not blocked on mutex) #
S           jfsIO:  237 [ffff81003f902870, 120] (not blocked on mutex) #
S       jfsCommit:  238 [ffff81003f9021c0, 120] (not blocked on mutex) #
S         jfsSync:  239 [ffff81003f6e9610, 120] (not blocked on mutex) #
S       xfslogd/0:  240 [ffff81003f6e8f60, 120] (not blocked on mutex) #
S      xfsdatad/0:  241 [ffff81003f6e88b0, 120] (not blocked on mutex) #
S           ata/0:  915 [ffff81003ed8eda0, 110] (not blocked on mutex) #
S       scsi_eh_0:  922 [ffff81003ed98de0, 111] (not blocked on mutex) #
S       scsi_eh_1:  923 [ffff81003ed99490, 111] (not blocked on mutex) #
S       scsi_eh_2:  924 [ffff81003ed564c0, 111] (not blocked on mutex) #
S       scsi_eh_3:  925 [ffff81003ed65910, 111] (not blocked on mutex) #
S       scsi_eh_4:  935 [ffff81003ed65260, 111] (not blocked on mutex) #
S       scsi_eh_5:  936 [ffff81003f045890, 111] (not blocked on mutex) #
S       scsi_eh_6:  939 [ffff81003ed8e6f0, 111] (not blocked on mutex) #
S       scsi_eh_7:  940 [ffff81003ed8f450, 111] (not blocked on mutex) #
S        khpsbpkt:  959 [ffff81003ed64bb0, 117] (not blocked on mutex) #
D       scsi_eh_8:  983 [ffff81003ed57220, 110] (not blocked on mutex) #
S     usb-storage:  984 [ffff81003f8f8ee0, 110] (not blocked on mutex) #
D   usb-stor-scan:  986 [ffff81003ed8e040, 110] (not blocked on mutex) #
S       kpsmoused: 1010 [ffff81003f0451e0, 111] (not blocked on mutex) #
S       kcryptd/0: 1014 [ffff81003ed98730, 111] (not blocked on mutex) #
S      reiserfs/0: 1021 [ffff81003eda2770, 111] (not blocked on mutex) #
S            init: 1027 [ffff81003f044b30, 116] (not blocked on mutex) #
S              rc: 1028 [ffff81003f70b0a0, 125] (not blocked on mutex) #
S            need: 1087 [ffff81003f6e8200, 125] (not blocked on mutex) #
S              rc: 1088 [ffff81003f70a340, 116] (not blocked on mutex) #
S              rc: 1091 [ffff81003f7150e0, 119] (not blocked on mutex) #
S            need: 1092 [ffff81003f700300, 119] (not blocked on mutex) #
S              rc: 1093 [ffff81003f715790, 115] (not blocked on mutex) #
S              rc: 1096 [ffff81003ff9a730, 119] (not blocked on mutex) #
S            need: 1097 [ffff81003ed56b70, 119] (not blocked on mutex) #
S              rc: 1098 [ffff81003fc169b0, 115] (not blocked on mutex) #
S              rc: 1101 [ffff81003ed578d0, 120] (not blocked on mutex) #
S            need: 1102 [ffff81003f714a30, 120] (not blocked on mutex) #
S              rc: 1103 [ffff81003fc17710, 119] (not blocked on mutex) #
S              rc: 1106 [ffff81003fc17060, 116] (not blocked on mutex) #
R           udevd: 1319 [ffff81003eda2e20, 114] (not blocked on mutex) #
S         shpchpd: 2111 [ffff81003f88d690, 111] (not blocked on mutex) #
S      kgameportd: 2118 [ffff81003f88c930, 111] (not blocked on mutex) #
S            need: 2433 [ffff81003f882240, 116] (not blocked on mutex) #
S      hwclock.sh: 2434 [ffff81003d6c4300, 118] (not blocked on mutex) #
S      hwclock.sh: 2438 [ffff81003fe5c770, 121] (not blocked on mutex) #
S            need: 2440 [ffff81003f044480, 121] (not blocked on mutex) #
S     mountall.sh: 2441 [ffff81003f8828f0, 120] (not blocked on mutex) #
S     mountall.sh: 2445 [ffff81003f8f9590, 116] (not blocked on mutex) #
S   fsck.reiserfs: 2503 [ffff81003f883650, 118] (not blocked on mutex) #
S            need: 2558 [ffff81003c849550, 116] (not blocked on mutex) #
S        modutils: 2559 [ffff81003f701710, 123] (not blocked on mutex) #
R        modutils: 2599 [ffff81003ed98080, 125] (not blocked on mutex) #
R        modutils: 2714 [ffff81003eda20c0, 125] (not blocked on mutex) #
R        modprobe: 2715 [ffff81003cda86f0, 125] (not blocked on mutex) #
R        modprobe: 2717 [ffff81003f7009b0, 125] (not blocked on mutex) #

#
---------------------------
#
| showing all locks held: |
#
---------------------------
#

#
#001:             [ffff81003ed86850] {scsi_host_alloc}
#
.. held by:     usb-stor-scan:  986 [ffff81003ed8e040, 110]
#
... acquired at:               scsi_scan_host_selected+0xaa/0x113
#

#
#002:             [ffff81003ed86c98] {storage_probe}
#
.. held by:       usb-storage:  984 [ffff81003f8f8ee0, 110]
#
... acquired at:               usb_stor_control_thread+0x46/0x19e
#

#
#003:             [ffff81003e00a880] {snd_card_bt_sco_probe}
#
.. held by:          modprobe: 2715 [ffff81003cda86f0, 125]
#
... acquired at:               alsa_card_bt_sco_init+0xba/0x2f1
[snd_bt_sco]
#

#
=============================================
#

#
[ turning off deadlock detection. Please report this. ]
#

#
snd-bt-sco: snd-bt-scod thread starting
#
Adding 2097144k swap on /swapfile.  Priority:-1 extents:205
across:2318040k

---------------------------- Original Message ----------------------------
Subject: Re: [Bluez-users] Logitech Traveler Headset. Progress but not
there yet. Advice wanted.
From:    "Bearcat M. Sandor" <Linux@feline-soul.com>
Date:    Tue, August 22, 2006 00:37
To:      bluez-users@lists.sourceforge.net
--------------------------------------------------------------------------

Ok, I am getting further. I have the snd_bt_sco module loaded.

Doing a btsco  00:0D:44:4F:37:72 gives me

Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable

I'm a newbie at this bluetooth stuff. I'm not sure if i'm supposed to start
the rfcomm program or what parameters i should send.

My config files are listed in the preceding emails.

Thank you for the help so far,

Bearcat M. Sandor
On Monday 21 August 2006 21:31 in an email titled "Re: [Bluez-users] Logitech
Traveler Headset. Progress but not there yet. Advice wanted." Bearcat M. 
Sandor wrote:
>Brad,
>Thank you. That was immensely helpful. I have btsco installed.  I have
followed the steps at the link you provided.
>I change to root user.
>After the "hciconfig hci0 voice 0x0060" is given my hciconfig looks like:
hci0:   Type: USB
>        BD Address: 00:07:61:1C:9F:D3 ACL MTU: 192:8 SCO MTU: 64:8 UP
RUNNING PSCAN
>        RX bytes:3908436 acl:279025 sco:0 events:1181 errors:0
>        TX bytes:1936 acl:16 sco:0 commands:192 errors:0
>        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH HOLD SNIFF PARK
>        Link mode: SLAVE ACCEPT
>        Name: 'BlueZ (0)'
>        Class: 0x3e0100
>        Service Classes: Networking, Rendering, Capturing, Object
Transfer,
>Audio
>        Device Class: Computer, Uncategorized
>        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver:
> 0x34e Manufacturer: Cambridge Silicon Radio (10)
>Then i issue the "btsco 00:0D:44:4F:37:72" and i get:
>Error: hwdep next device (hw:0): Operation not permitted
>Error: hwdep next device (hw:1): Operation not permitted
>Error: control open (hw:2): No such device
>Error: Can't find device. Bail
>Bearcat M. Sandor
>On Monday 21 August 2006 20:35 in an email titled "Re: [Bluez-users]
> Logitech Traveler Headset. Progress but not there yet. Advice wanted."
Brad
> Midgley
>wrote:
>>Bearcat
>>> on button to get it to start paring. Then i issue a "hidd --connect
00:0D:44:4F:37:72" After awhile the headset stops blinking and "Can't
get
>>> device information: Function not implemented" is returned for the hidd
--connect.
>>hidd is for connecting the keyboard/mouse/etc but not the headset. Check
with the docs at bluetooth-alsa.sf.net.
>>Brad
>>-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services,
security?
>>Get stuff done quickly with pre-integrated technology to make your job
>> easier Download IBM WebSphere Application Server v.1.0.1 based on
Apache
>> Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users






-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
