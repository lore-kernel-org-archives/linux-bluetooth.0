Return-Path: <cyrus@holtmann.org>
Message-ID: <2f1d248c0810062355r2871da61td3cca6b66a9d77a6@mail.gmail.com>
Date: Tue, 7 Oct 2008 14:55:18 +0800
From: "chen chong" <byrbzdl@gmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: How to disable authentication when using bluetooth on Linux?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, all

When pushing a file to bluetooth mobile phone from a Linux PC, how to
disable bluetooth authentication mechanism (in kernel or user level ?
), so that the phone won't prompt a window ask for PIN code?


I'm a freshman on bluez, now I'm trying to write an application on
Linux PC,  to send files to mobile phones with OBEX. The PC has a USB
bluetooth stick to communication with the phone.

Now I have successfully sent a file to phone using the following commands:
1. "hcitool scan" and "sdptool browse"
2. "passkey-agent --default 1234" and "ussp-push --dev 0
BTADDR@CHANNEL desk.jpg desk.jpg"

but the phone ask for a PIN code at the start.

To get rid of this, I had tried to comment out
"start_security_manager()" in bluez-utils-3.7/hcid/main.c,  and
recompile it, then restart the bluetooth service. But PIN code was
still prompted, and after if I input some characters,  the command
"ussp-push --dev 0 --debug  BTADDR@CHANNEL desk.jpg desk.jpg", failed
with the following error:

root@debian:~/bluetooth# pushing file desk.jpg
name=desk.jpg, size=24762
__obex_connect: client_context_t = 0x80540f0
Registered transport
Set user data
Created new objext
cobex_write
Local device 00:01:02:03:04:01
Remote device 00:01:02:03:04:05 (11)
Write error: Transport endpoint is not connected
obex_event: client_context_t = 0x80540f0
cobex_disconnect
Link broken!
Started a new request
cobex_close
__obex_connect: error=-2
Unable to connect to the server
Error
