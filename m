Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
From: Stefan Bellon <sbellon@sbellon.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <4d35810838sbellon@sbellon.de>
In-Reply-To: <4d35427939sbellon@sbellon.de>
References: <4d3382eb6csbellon@sbellon.de> <41F81D6F.3000908@xmission.com> <4d33b69105sbellon@sbellon.de> <4d348a05e8sbellon@sbellon.de> <41FC4BAF.4090201@xmission.com> <4d35427939sbellon@sbellon.de>
Content-Type: text/plain
Subject: [Bluez-users] Re: bluetooth-alsa and Jabra BT800
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
Date: Sun, 30 Jan 2005 20:15:04 +0100

Stefan Bellon wrote:
> Brad Midgley wrote:

> > How do you know you're using the right address? 

> Well, because of this:

> root@roma# hcitool info 00:07:A4:21:1D:86
> Requesting information ...
>         BD Address:  00:07:A4:21:1D:86
>         Device Name: Jabra BT800

[snip]

> > No sdp available doesn't look good.

> Hm, is this a mis-feature of the headset then? How does a handy talk
> to the headset then?

I have partial success here!

Don't ask me what I did change. I plugged the USB Bluetooth dongle into
my Windows notebook in order to see whether I can get the headset to
work there. Afterwards I plugged the same dongle into my GNU/Linux box
and now I get this (which didn't work previously!):

root@roma# sdptool search --bdaddr 00:07:A4:21:1D:86 0x1108
Class 0x1108
Searching for 0x1108 on 00:07:A4:21:1D:86 ...
Service Name: Headset
Service RecHandle: 0x10000
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

So, after all, the headset is not that silent when asked for a service.

When I start btsco, I now get the following:

sbellon@roma$ btsco 00:07:A4:21:1D:86  
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT*GNMK
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=09
Sending up speaker change 9
recieved AT+CKPD=200
disconnected SCO channel

However, I can only start btsco once, then it doesn't work. If I query
hciconfig after one btsco run, it tells me:

root@roma# hciconfig -a
hci0:   Type: USB
        BD Address: 00:04:0E:87:88:E9 ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:1170749 acl:51 sco:22922 events:74 errors:0
        TX bytes:1338 acl:39 sco:0 commands:31 errors:0
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: ACCEPT MASTER 
Can't read local name on hci0. Connection timed out(110)

Removing the USB Bluetooth dongle and inserting it again is a way to
get it working again. Then, btsco runs (but looks slightly different to
the one above):

sbellon@roma$ btsco 00:07:A4:21:1D:86
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 11 mic volume: 0
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=09
Sending up speaker change 9
recieved AT+CKPD=200
disconnected SCO channel

Ok, so far so good. However, when btsco is running, aplay should work.
But it doesn't:

sbellon@roma$ aplay -D plughw:Headset some.wav
Playing WAVE 'some.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono

Nothing to be heard in the headset (yes, I have set the volumes to max
in alsamixer).

Ok, I think we're not too far from the point where it works and where
you could add the BT800 to the list of working headsets. But what am I
missing now?

TIA.

-- 
Stefan Bellon


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
