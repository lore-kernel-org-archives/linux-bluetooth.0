Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Carlos Azevedo <carlosarazevedo@netcabo.pt>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411291935.12702.carlosarazevedo@netcabo.pt>
Subject: [Bluez-users] snd-bt-sco problems (Brad, Marcel)
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
Date: Mon, 29 Nov 2004 19:35:12 +0000

Greetings,

=46irst, thanks for your continuing help. Now your questions :

Brad : I don't have any other dongle or headset, but I've tested both on
Windows and they work together; aplay exists after a 9-10 second timeout; I=
'm
not running any kind of X because this is a telephony server machine (or wi=
ll
be); I've tried with the following modules.conf but to no avail :

options snd major=3D116 cards_limit=3D2 device_mode=3D0660 device_gid=3D29
device_uid=3D0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

alias snd-card-0 snd_via82xx
alias snd-card-1 snd_bt_sco

alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-slot-2 snd-card-2
alias sound-slot-3 snd-card-3

since I'm running LFS, a do-it-yourself distro, I don't have a specific
startup script, I just load the modules (snd-via82xx and snd-bt-sco) with t=
he
following result :

Module=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 Used by
snd_bt_sco=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 11328=A0 0
snd_hwdep=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6912=A0 1 snd_bt_sco
snd_via82xx=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20800=A0 0
snd_ac97_codec=A0=A0=A0=A0=A0=A0=A0=A0 63136=A0 1 snd_via82xx
snd_pcm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 80000=A0 2 snd_bt_sco,=
snd_via82xx
snd_timer=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 20288=A0 1 snd_pcm
snd_page_alloc=A0=A0=A0=A0=A0=A0=A0=A0=A0 7752=A0 3 snd_bt_sco,snd_via82xx,=
snd_pcm
snd_mpu401_uart=A0=A0=A0=A0=A0=A0=A0=A0 5952=A0 1 snd_via82xx
snd_rawmidi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 17728=A0 1 snd_mpu401_uart
snd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 40740=A0 8
snd_bt_sco,snd_hwdep,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu40=
1_
uart,snd_rawmidi soundcore=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7712=
=A0 1 snd

Marcel : hciconfig -a reports :

hci0:=A0=A0 Type: USB
=A0=A0=A0=A0=A0=A0=A0 BD Address: 00:0B:0D:31:73:A4 ACL MTU: 120:20=A0 SCO =
MTU: 64:0
=A0=A0=A0=A0=A0=A0=A0 UP RUNNING PSCAN ISCAN
=A0=A0=A0=A0=A0=A0=A0 RX bytes:664249 acl:34 sco:13006 events:48 errors:0
=A0=A0=A0=A0=A0=A0=A0 TX bytes:763 acl:22 sco:0 commands:20 errors:0
=A0=A0=A0=A0=A0=A0=A0 Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
=A0=A0=A0=A0=A0=A0=A0 Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
=A0=A0=A0=A0=A0=A0=A0 Link policy: RSWITCH HOLD SNIFF PARK
=A0=A0=A0=A0=A0=A0=A0 Link mode: SLAVE ACCEPT
=A0=A0=A0=A0=A0=A0=A0 Name: 'BlueZ (0)'
=A0=A0=A0=A0=A0=A0=A0 Class: 0x3e0100
=A0=A0=A0=A0=A0=A0=A0 Service Classes: Networking, Rendering, Capturing
=A0=A0=A0=A0=A0=A0=A0 Device Class: Computer, Uncategorized
=A0=A0=A0=A0=A0=A0=A0 HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LM=
P Subver: 0x757
=A0=A0=A0=A0=A0=A0=A0 Manufacturer: Silicon Wave (11)

I'm running 2.6.9 and LFS (www.linuxfromscratch.org); I've seen (with
 hcidump) that packets flow as soon as the SCO connection is established but
 I haven't yet looked at them; I'll gladly send a patch against the CVS HEAD
 as soon as I get this working.

Now for more interesting info... As I said in the previous posting I've
sprinkled the driver code with dprintks; at function entry and inside the
thread function (called below work thread). This is a commented snippet from
kern.log :

## Started btsco in the background...
Nov 29 02:46:41 mainserver kernel: snd-bt-sco: poll
Nov 29 02:46:47 mainserver last message repeated 8 times
Nov 29 02:46:47 mainserver kernel: snd-bt-sco: ioctl
Nov 29 02:46:47 mainserver kernel: snd-bt-sco: ioctl : interrupting the work
thread
Nov 29 02:46:47 mainserver kernel: snd-bt-sco: ioctl : File descriptor
 changed Nov 29 02:46:47 mainserver kernel: snd-bt-sco: work thread : waiti=
ng
 for data Nov 29 02:46:47 mainserver kernel: snd-bt-sco: work thread :
 wait_event ## ... Last 2 messages are repeated a lot of times ...
Nov 29 02:46:54 mainserver kernel: snd-bt-sco: poll
Nov 29 02:46:54 mainserver kernel: snd-bt-sco: write
Nov 29 02:46:54 mainserver kernel: snd-bt-sco: poll
Nov 29 02:47:09 mainserver last message repeated 15 times
## Started aplay...
Nov 29 02:47:09 mainserver kernel: snd-bt-sco: playback_open
Nov 29 02:47:09 mainserver kernel: snd-bt-sco: playback_prepare
Nov 29 02:47:09 mainserver kernel: snd-bt-sco: prepare ok bps: 16000 size:
8000 count: 2000
Nov 29 02:47:09 mainserver kernel: snd-bt-sco: playback_trigger 1
Nov 29 02:47:09 mainserver kernel: snd-bt-sco: setting playback to bspcm
Nov 29 02:47:10 mainserver kernel: snd-bt-sco: poll
## Notice the 10 second period with no other action
Nov 29 02:47:19 mainserver last message repeated 9 times
Nov 29 02:47:19 mainserver kernel: snd-bt-sco: playback_trigger 0
Nov 29 02:47:19 mainserver kernel: snd-bt-sco: setting playback to NULL
Nov 29 02:47:20 mainserver kernel: snd-bt-sco: poll
Nov 29 02:47:26 mainserver last message repeated 6 times
Nov 29 02:47:26 mainserver kernel: snd-bt-sco: ioctl
Nov 29 02:47:26 mainserver kernel: snd-bt-sco: ioctl : interrupting the work
thread
Nov 29 02:47:26 mainserver kernel: snd-bt-sco: work thread : wait_event
Nov 29 02:47:26 mainserver kernel: snd-bt-sco: Disposing of previous socket
count 2
Nov 29 02:47:26 mainserver kernel: snd-bt-sco: work thread : wait_event

Something that strikes me as odd is that as soon as aplay starts the bt-sco
thread (that receives and sends data to the SCO socket) stalls. Running
'hcidump &' just before aplay spits out lots of '> SCO data: handle 0x0100
dlen 48' which I presume to be voice data but for 10 seconds (the aplay
timeout) no activity in the thread is seen.

As always, any thoughts ?

Thanks,

Carlos A. R. Azevedo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
