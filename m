Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Martin van Vliet <martin.van.vliet@quantiq.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1078934232.26029.3.camel@rainier>
Mime-Version: 1.0
Subject: [Bluez-users] Connecting to MIDP using RFCOMM
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
Date: Wed, 10 Mar 2004 16:57:12 +0100

Hello,

I am trying to get an application to work that communicates between a
desktop
and mobile phone using Bluetooth. The handheld is running a Java MIDP
application that exposes a service. The desktop connects to the service
to
exchange data.

I have this application working when using 2 mobile phones, but the part
with
the desktop is giving me problems. I am using a Fedora Core system and
Bluez.
The desktop is able to find the Java service on the mobile running on
channel 4
(but only when I specifically search for Serial Port services, ie.
'sdptool
search --bdaddr <address> SP'. If I browse the services on the phone it
is not
listed). To communicate I setup an RFCOMM connection to this channel and
attempt
to open it by doing a cat to the device. The following is the hcidump
output of
that process:

$> rfcomm bind /dev/rfcomm0 <address> 4
$> cat > /dev/rfcomm0

< L2CAP(s): Connect req: psm 3 scid 0x0040
> L2CAP(s): Connect rsp: dcid 0x0082 scid 0x0040 result 1 status 2
> L2CAP(s): Connect rsp: dcid 0x0082 scid 0x0040 result 0 status 0
< L2CAP(s): Config req: dcid 0x0082 flags 0x0000 clen 4
  MTU 1024
> L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< L2CAP(s): Config rsp: scid 0x0082 flags 0x0000 result 0 clen 0
> L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
  MTU 672
< L2CAP(d): cid 0x82 len 4 [psm 3]
    RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> L2CAP(d): cid 0x40 len 4 [psm 3]
    RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< L2CAP(d): cid 0x82 len 14 [psm 3]
    RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
    dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size 667
max_retrans 0 credits 7
> L2CAP(d): cid 0x40 len 14 [psm 3]
    RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
    dlci 8 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size 667
max_retrans 0 credits 3
< L2CAP(d): cid 0x82 len 4 [psm 3]
    RFCOMM(s): SABM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xc9
> L2CAP(d): cid 0x40 len 4 [psm 3]
    RFCOMM(s): DM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xe3
< L2CAP(d): cid 0x82 len 4 [psm 3]
    RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< L2CAP(s): Disconn req: dcid 0x0082 scid 0x0040
> L2CAP(d): cid 0x40 len 4 [psm 3]
    RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> L2CAP(s): Disconn rsp: dcid 0x0082 scid 0x0040

Somehow the mobile does not allow a connection on dlci 8. As I said, I
am able
to connect from another mobile. Also, using the above method to connect
to
channel 1 on the phone works -- I can give it AT commands using seyon.

Has anyone tried this successfully before? Any ideas on what might be
wrong?

Thanks for any help!

Martin van Vliet
Amsterdam, the Netherlands



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
