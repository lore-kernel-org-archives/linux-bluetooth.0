Return-Path: <cyrus@holtmann.org>
Subject: Handling HID Connections for certain devices externally
From: Carl =?ISO-8859-1?Q?=D6nnheim?= <carl@onnheim.se>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 Aug 2010 00:15:56 +0200
Message-ID: <1281046556.26788.29.camel@knazboll>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am working on a project to integrate the Sony PS3 Remote to LIRC.
BlueZ supports the use of this device by translating key presses to
keyboard events. It is possible for me to read these translated keyboard
events to figure out what happens on the remote, but the application is
more stable if I can get hold of the raw data stream from the remote
directly. This ability would also allow for separate development for
other special devices that communicate as HID devices (e.g. the
WII-remotes).

I have not been able to get a hold of that datastream (except by
stopping bluez and then listening directly on the relevant PSM's, but
since bluez need to run for all other purposes that is not really an
option). So my question is:

1. Is there a possibility that I have missed for a separate user-space
program to "steal" the interrupt and control channels from BlueZ for a
specific HID Device?

2. If not, will you consider adding this possibility? I have
experimented with one option; the fake_hid functionality is extended so
that when a HID device connects it tries to connect to a unix socket
with a predefined name
(e.g. /var/run/bluez/fakehid_<vendor_id>_<product_id>). If a program
listens on that socket, the data channels will be passed over. If not,
bluez will continue as usual.

I have a patch that does this more or less ready to go, and I would be
happy to contribute further if I can. Other options can of course be
considered (e.g. exposing new DBus methods). But I wanted to check your
initial views before going into more details. You can see all details
about the project I am working on at
http://sourceforge.net/projects/sonyps3remote/.

The patch can be found in the svn tree there as well:
http://sonyps3remote.svn.sourceforge.net/viewvc/sonyps3remote/bluez/patches/bluez-4.69-sonyps3.diff.gz?view=log

Thanks in advance
//Carl

