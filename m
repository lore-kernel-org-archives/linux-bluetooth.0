Return-Path: <krose@nausicaa.valley-of-wind.krose.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
	<1097185188.7325.75.camel@pegasus>
	<khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
	<1097186322.7325.79.camel@pegasus>
	<khnk6u289o5.fsf@hunter-killer.kendall.corp.akamai.com>
	<87ekk82ar4.fsf@nausicaa.krose.org> <1097342518.12972.3.camel@pegasus>
From: Kyle Rose <krose+bluez@krose.org>
Date: Sat, 09 Oct 2004 15:45:05 -0400
In-Reply-To: <1097342518.12972.3.camel@pegasus> (Marcel Holtmann's message of
	"Sat, 09 Oct 2004 19:21:59 +0200")
Message-ID: <87zn2v1xry.fsf@nausicaa.krose.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Kyle Rose <krose@nausicaa.valley-of-wind.krose.org>
List-ID: <bluez-users.lists.sourceforge.net>

> are you sure that your settings are the same on both machine. Show us
> the output of "hciconfig -a".

I did the diff between the 64-bit install and a different machine
running the 32-bit install to keep me from having to reboot.  Here's
the diff:

--- /tmp/32.txt 2004-10-09 15:43:24.475967740 -0400
+++ /tmp/64.txt 2004-10-09 15:43:17.187060956 -0400
@@ -1,13 +1,13 @@
 hci0:  Type: USB
-       BD Address: 00:07:61:07:2B:41 ACL MTU: 192:8  SCO MTU: 64:8
+       BD Address: 00:07:61:15:3C:79 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
-       RX bytes:683597 acl:41770 sco:0 events:1153 errors:0
-       TX bytes:3189 acl:116 sco:0 commands:31 errors:0
+       RX bytes:516464 acl:36254 sco:0 events:733 errors:0
+       TX bytes:6111 acl:155 sco:0 commands:181 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
-       Name: 'san-0'
+       Name: 'nausicaa-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized

Only differences are where I would expect them (node name, status, and
bluetooth address).

Cheers,
Kyle
