Return-Path: <cyrus@holtmann.org>
Message-ID: <4A5B3B14.2080304@infracont.hu>
Date: Mon, 13 Jul 2009 15:48:04 +0200
From: =?ISO-8859-2?Q?Tak=E1cs_=C1ron?= <takacs.aron@infracont.hu>
Reply-To: takacs.aron@infracont.hu
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: cannot open rfcomm connection from Windows
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using bluez on an embedded (ARM) board with linux and try to create
a serial connection to a Windows XP Pc.  (I use two USB Bluetooth
dongles.) My goal is to establish a connection in this direction: linux
is listening, windows is "calling". Now, the situation is the following:
I can pair the two systems, but at the end hcid and dbus-daemon do exit.
I can establish a connection when the WIndows is listening and the linux
(embedded board) is calling. In the opposite - needed - direction I
cannot create the connection. On the Windows machine I get the message:
"Cannot open port COM9. Check the port settings". On the linux board
rfcomm gets 'Terminated", hcid and dbus-daemon exit.

After experiencing this, I made some tests with a linux PC and made the
following observations:

1; If hcid terminates dbus-daemon does also.
2, hcid terminats always with the following messages:
    hcid[3663]: Got disconnected from the system message bus
    hcid[3663]: Shutting down local server
    hcid[3663]: Exit
3; If I try to pair the embedded board with the Linux PC, the situation
is the same as with the Windows PC: pairing ok, but at the end on the
embedded board hcid and dbus-daemon do exit.
4; If I try hcitool cc from the Linux PC, they don't get connected, but
hcid and dbus-daemon do exit (on the embedded board).
5;  I can establish rfcomm connection  between the embedded board
(linux) and the Linux PC in both directions.
6; I can establish a pan connection between the two.  Now the connection
is shown by hcitool con. If I disconnect them by hcitool dc, on the
embedded board hcid and dbus-daemon do exit.

Thank you for your help!


Áron Takács

