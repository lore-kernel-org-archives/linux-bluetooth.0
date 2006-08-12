Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 12 Aug 2006 11:41:22 -0400
From: Phil Frost <indigo@bitglue.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060812154121.GB28903@unununium.org>
MIME-Version: 1.0
Subject: [Bluez-users] Transfering contacts, pictures, etc on samsung a640
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

I just got a Samsung A640 and I've been trying to get some sort of
commuinication between it and my linux box working. I'd like to be able
to transfer contacts and pictures between the two machines. The device
info screen on the phone says it supports the "OPP" bluetooth profile,
and when I run sdptool browse at the phone I get this output:

Service Name: OBEX Object Push
Service RecHandle: 0x10000
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

The phone has in most of the menus when viewing a contact or picture or
whatnot a "send contact" option, so I figure what I want to do should be
at least possible.

However, I'm a little confused about what to actually do, and my
confused attempts have been unsucessful. After much searching I found
this page <http://www.caside.lancs.ac.uk/java_bt.php#BlueZ_-_OBEX> that
has a link to a tarball with programs "opd" and "ussp-push". I found
that ussp-push is available from most distributions so I've been using
that, but I can't find this opd anywhere else, although from the mailing
list archives it seems some people are using it.

I tried running the opd as suggested on previously mentioned page:

$ opd --mode OBEX --channel 10 --path /tmp/opd --sdp --metadata
opd[6614]: OBEX Push Daemon - version 0.2 started
opd[6614]: OBEX Object Push service registered with sdpd
opd[6614]: OBEX server listening on channel 10

All seems well; I can see the service on local with sdptool:

$ sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: OBEX Object Pus
Service RecHandle: 0x10000
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 10
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

However, when I ask the phone to send a contact, it asks, "would you
like to search?", to which I reply "yes", and it will then display
"searching..." and a busy indicator for 20 seconds or so, then report
that no devices were found. If I run hcidump during this process I see
no output. Here is my hcid.conf, which I believe should make my computer
discoverable:

options {
        autoinit yes;
        security auto;
        pairing multi;
        passkey "613273";
}

device {
        name "%h-%d";
        class 0xff0100;         (have tried 0xff0200 as well, with identical results)
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
}

"All right", I thought, "maybe I can send something to the phone". From
above output of sdptool browse it seems that the obex object push
service is running on channel 1 of the phone. So, I run the command:

sudo rfcomm bind /dev/rfcomm1 00:12:D1:C4:5F:BB 1

all good there. Now:

-------------------
$ echo foo > foo.txt
$ ussp-push /dev/rfcomm1 foo.txt foo.txt

pushing file foo.txt
name=foo.txt, size=4
Registered transport

set user data

created new objext

started a new request
reqdone
Command (00) has now finished, rsp: 20Connected!

Connection return code: 0, id: 0
Connection established
connected to server
Sending file: foo.txt, path: foo.txt, size: 4
reqdone
Command (02) has now finished, rsp: 4freqdone
Command (01) has now finished, rsp: 20Disconnect done!pushed!!
------------------

This seems to have worked, but I can't figure out what the phone did
with it! Is there some file format or additional options I need to use
to do something useful, like upload some text notes or a contact? Thanks
for any help.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
