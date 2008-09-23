Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Sep 2008 14:09:53 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: denis kenzior <denis.kenzior@trolltech.com>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <867478754.8791222159193326.JavaMail.root@mbv7.indiatimes.com>
In-Reply-To: <63475.65.249.24.198.1222100847.squirrel@ice-gw.trolltech.com.au>
Subject: Re: OpenOBEX ObexFTPd problem on BlueZ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks, the current situation works for me. 
Windows [MS generic bluetooth radio] bluetooth stack has send and recieve file features, for this...

If I run "obexftpd" on board and do a send file [without PASSKEY] feature, then it works.

If I click on recieve file on PC and do a obexftp it doesn't work.
However If I do a sdptool browse and get to know the channel number (1) and then give it to obexftp, it seems to work.

Now, the question...
1. How do I enable the passkey feature [bluepin doesn't exist in 3.36] ?
**All option of security in hcid.conf has the same effect...

2. How I check the services of my board, to make it work for other stacks??
[even the services request from current setup doesn;t seem to work, its like the sdp server is not started at all on blueZ side, even though the messages show it runs...]


Thanks in advance.



----- Original Message -----
From: Denis Kenzior <denis.kenzior@trolltech.com>
To: pavan savoy <pavan_savoy@indiatimes.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Mon, 22 Sep 2008 21:57:27 +0530 (IST)
Subject: Re: OpenOBEX ObexFTPd problem on BlueZ

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



--
Will the all new Indica Vista zip ahead of the Suzuki Swift? Read the expert review on Zigwheels.com
http://zigwheels.com/b2cam/reviewsDetails.action?name=Ro11_20080829&path=/INDT/Reviews/Ro11_20080829&page=1&pagecount=9
