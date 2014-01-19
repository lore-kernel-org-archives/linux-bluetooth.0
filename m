Return-Path: <cyrus@holtmann.org>
Message-ID: <3acdc59c6e879f4cac76a6e0690da043.squirrel@mungewell.org>
In-Reply-To: <1565501.U8ecNLfzyG@athlon>
References: <1390153036-10030-1-git-send-email-szymon.janc@gmail.com>
    <d1fe03c920dacec62bc0f59c62a8932c.squirrel@mungewell.org>
    <1565501.U8ecNLfzyG@athlon>
Date: Sun, 19 Jan 2014 15:57:18 -0500
Subject: Re: [PATCH] lib: Use bigger IMTU when connecting SDP
From: simon@mungewell.org
To: "Szymon Janc" <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"David Herrmann" <dh.herrmann@gmail.com>,
	"Frank Praznik" <frank.praznik@oh.rr.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140119155717_87125"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_20140119155717_87125
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>>
>> I note that the cache file for the DS4's mac picks up some details on a
>> SDP browse, but not a complete record. This is on an older machine, so
>> BT chipset might be a factor.
>>
>> Anything I can try?
>> Simon
>
> It looks like you are using BT 2.0 dongle. I suggest trying with 2.1.
> I didn't check with 2.0 yet.

Yep, it's official my laptop's crap ;-) I tried my wife's fancy laptop and
the patched version of bluez worked (normal version didn't).
--
[liveuser@localhost ~]$ bluetoothctl
[NEW] Controller 60:D8:19:B3:6E:E5 BlueZ 5.13 [default]
[bluetooth]# power on
[CHG] Controller 60:D8:19:B3:6E:E5 Class: 0x00010c
Changing power on succeeded
[CHG] Controller 60:D8:19:B3:6E:E5 Powered: yes
[bluetooth]# scan on
Discovery started
[CHG] Controller 60:D8:19:B3:6E:E5 Discovering: yes
[NEW] Device 1C:66:6D:07:C3:E0 Wireless Controller
[bluetooth]# connect 1C:66:6D:07:C3:E0
Attempting to connect to 1C:66:6D:07:C3:E0
[CHG] Device 1C:66:6D:07:C3:E0 Connected: yes
[CHG] Device 1C:66:6D:07:C3:E0 Modalias: usb:v054Cp05C4d0100
[CHG] Device 1C:66:6D:07:C3:E0 Modalias: usb:v054Cp05C4d0100
[CHG] Device 1C:66:6D:07:C3:E0 UUIDs has unsupported type
[CHG] Device 1C:66:6D:07:C3:E0 Paired: yes
Connection successful
--

The patched rpm is here is anyone else wants to try/confirm.
https://dl.dropboxusercontent.com/u/34518077/bluez-5.13-1.fc20.i686.rpm


Although, I would note that under Debian (bluez 4.99) on my 'crappy'
laptop I was able to receive the SDP record as noted here.
http://marc.info/?l=linux-bluetooth&m=138993853328540&w=2

>
> BTW
> This patch is not going to be merge in current form. I'll be sending V2
> later.

I look forward to it, and will help where I can.

Cheers,
Simon
------=_20140119155717_87125
Content-Type: text/plain; name="fancy_cache.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fancy_cache.txt"

W0dlbmVyYWxdCk5hbWU9V2lyZWxlc3MgQ29udHJvbGxlcgoKW1NlcnZpY2VSZWNvcmRzXQoweDAw
MDEwMDAxPTM2MDI2MTA5MDAwMDBBMDAwMTAwMDEwOTAwMDEzNTAzMTkxMTI0MDkwMDA0MzUwRDM1
MDYxOTAxMDAwOTAwMTEzNTAzMTkwMDExMDkwMDA2MzUwOTA5NjU2RTA5MDA2QTA5MDEwMDA5MDAw
OTM1MDgzNTA2MTkxMTI0MDkwMTAwMDkwMDBEMzUwRjM1MEQzNTA2MTkwMTAwMDkwMDEzMzUwMzE5
MDAxMTA5MDEwMDI1MTM1NzY5NzI2NTZDNjU3MzczMjA0MzZGNkU3NDcyNkY2QzZDNjU3MjA5MDEw
MTI1MEY0NzYxNkQ2NTIwNDM2RjZFNzQ3MjZGNkM2QzY1NzIwOTAxMDIyNTFCNTM2RjZFNzkyMDQz
NkY2RDcwNzU3NDY1NzIyMDQ1NkU3NDY1NzI3NDYxNjk2RTZENjU2RTc0MDkwMjAwMDkwMTAwMDkw
MjAxMDkwMTExMDkwMjAyMDgwODA5MDIwMzA4MDAwOTAyMDQyODAwMDkwMjA1MjgwMTA5MDIwNjM2
MDE2QzM2MDE2OTA4MjIyNjAxNjQwNTAxMDkwNUExMDE4NTAxMDkzMDA5MzEwOTMyMDkzNTE1MDAy
NkZGMDA3NTA4OTUwNDgxMDIwOTM5MTUwMDI1MDc3NTA0OTUwMTgxNDIwNTA5MTkwMTI5MEUxNTAw
MjUwMTc1MDE5NTBFODEwMjc1MDY5NTAxODEwMTA1MDEwOTMzMDkzNDE1MDAyNkZGMDA3NTA4OTUw
MjgxMDIwNjA0RkY4NTAyMDkyNDk1MjRCMTAyODVBMzA5MjU5NTMwQjEwMjg1MDUwOTI2OTUyOEIx
MDI4NTA2MDkyNzk1MzRCMTAyODUwNzA5Mjg5NTMwQjEwMjg1MDgwOTI5OTUyRkIxMDIwNjAzRkY4
NTAzMDkyMTk1MjZCMTAyODUwNDA5MjI5NTJFQjEwMjg1RjAwOTQ3OTUzRkIxMDI4NUYxMDk0ODk1
M0ZCMTAyODVGMjA5NDk5NTBGQjEwMjA2MDBGRjg1MTEwOTIwMTUwMDI2RkYwMDc1MDg5NTREODEw
MjA5MjE5MTAyODUxMjA5MjI5NThEODEwMjA5MjM5MTAyODUxMzA5MjQ5NUNEODEwMjA5MjU5MTAy
ODUxNDA5MjY5NjBEMDE4MTAyMDkyNzkxMDI4NTE1MDkyODk2NEQwMTgxMDIwOTI5OTEwMjg1MTYw
OTJBOTY4RDAxODEwMjA5MkI5MTAyODUxNzA5MkM5NkNEMDE4MTAyMDkyRDkxMDI4NTE4MDkyRTk2
MEQwMjgxMDIwOTJGOTEwMjg1MTkwOTMwOTYyMjAyODEwMjA5MzE5MTAyMDY4MEZGODU4MjA5MjI5
NTNGQjEwMjg1ODMwOTIzQjEwMjg1ODQwOTI0QjEwMjg1OTAwOTMwQjEwMjg1OTEwOTMxQjEwMjg1
OTIwOTMyQjEwMjg1OTMwOTMzQjEwMjg1QTAwOTQwQjEwMjg1QTQwOTQ0QjEwMkMwMDkwMjA3MzUw
ODM1MDYwOTA0MDkwOTAxMDAwOTAyMDgyODAwMDkwMjA5MjgwMTA5MDIwQTI4MDEwOTAyMEIwOTAx
MDAwOTAyMEMwOTFGNDAwOTAyMEQyODAwMDkwMjBFMjgwMAoweDAwMDEwMDAyPTM1NTIwOTAwMDAw
QTAwMDEwMDAyMDkwMDAxMzUwMzE5MTIwMDA5MDAwNDM1MEQzNTA2MTkwMTAwMDkwMDAxMzUwMzE5
MDAwMTA5MDAwOTM1MDgzNTA2MTkxMjAwMDkwMTAzMDkwMjAwMDkwMTAzMDkwMjAxMDkwNTRDMDkw
MjAyMDkwNUM0MDkwMjAzMDkwMTAwMDkwMjA0MjgwMTA5MDIwNTA5MDAwMgo=
------=_20140119155717_87125
Content-Type: text/plain; name="fancy_hciconfig.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="fancy_hciconfig.txt"

hci0:	Type: BR/EDR  Bus: USB
	BD Address: 60:D8:19:B3:6E:E5  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING PSCAN INQUIRY 
	RX bytes:634454 acl:33222 sco:0 events:132 errors:0
	TX bytes:5739 acl:43 sco:0 commands:76 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ 5.13'
	Class: 0x00010c
	Service Classes: Unspecified
	Device Class: Computer, Laptop
	HCI Version: 3.0 (0x5)  Revision: 0x2ec
	LMP Version: 3.0 (0x5)  Subversion: 0x4203
	Manufacturer: Broadcom Corporation (15)

------=_20140119155717_87125--


