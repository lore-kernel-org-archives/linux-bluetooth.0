Return-Path: <cyrus@holtmann.org>
Message-ID: <63475.65.249.24.198.1222100847.squirrel@ice-gw.trolltech.com.au>
In-Reply-To: <1799979551.320401222084735025.JavaMail.root@mbv7.indiatimes.com>
References: <1799979551.320401222084735025.JavaMail.root@mbv7.indiatimes.com>
Date: Tue, 23 Sep 2008 02:27:27 +1000 (EST)
Subject: Re: OpenOBEX ObexFTPd problem on BlueZ
From: "Denis Kenzior" <denis.kenzior@trolltech.com>
To: pavan_savoy@indiatimes.com
Cc: linux-bluetooth@vger.kernel.org
Reply-To: denis.kenzior@trolltech.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

You actually need to register the SDP record for the Windows application
to know what RFCOMM port to connect to.  You need to use sdptool or better
yet use the BlueZ DBUS API for registering SDP records.

To get you started, if you're using obexftpd as a PUSH server, use:
sdptool add --channel=<obexftpd rfcomm channel> opush
or ftp, use:
sdptool add --channel=<obexftpd rfcomm channel> ftp

If you want to use the BlueZ DBUS API, use the
AddServiceRecordFromXML and pass in the record in XML format.

To get a sample of how the XML record looks like, you can run:
sdptool get --xml <record handle, most likely 0x10000>

For more, I suggest you read the BlueZ DBUS API documentation.

Regards,
-Denis

> Hi,
>
>
> I have the BlueZ utilities cross-compiled to a particular Arm- target, and
> cannot get the openobex working.
>
> I start of the server,
> $ hcid -s
> $ hciattach -- with relevant parameters
> $ hciconfig -a -- doesnt show any Service classes
> $ obexftpd -c ./ -b -- throws up a msg waiting for connection
> $ hciconfig -a -- now shows the Capturing, Object transfer as service
> classes
>
>
> But If I start an windows application, to connect to this device, it shows
> services not found.
>
> Any other hints as to properly starting off obexftpd and using obexftp
> client?
>



-----------------------------------------
Nokia Pty Ltd, Level 1, 53 Brandl St, Eight Mile Plains, 4113, Queensland, Australia
