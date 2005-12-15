Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43A114D1.4000506@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] avrcp volume control
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Dec 2005 00:01:37 -0700

Guys,

My best guess at volume control over avrcp is to send volume up/down
commands to the panel subunit on the headset. It doesn't seems to do
anything (no ack/nak or change in volume on bluetake iphono mini). I was
able to confirm the operand codes with a helpful 1394 developer by the way.

Does anyone here on the list know how this really should be framed so we
can control the headset volume?

The packet I'm sending to raise the volume looks something like this in hex:

 20 transaction_label=2, packet type=single, cr=command_frame, ipid=0
 11 pid lo
 0e pid hi
 00 ctype = passthrough command
 48 subunit type=panel(9), subunit id=0
 7c opcode? (this is what the headset always puts here in its cmds)
 41 volume-up lo
 00 volume-up hi

help :)

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
