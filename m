Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Slow connect time for devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <bd72c4b0602151628v14d53ae7vab573412bb56d6c@mail.gmail.com>
References: <bd72c4b0602151628v14d53ae7vab573412bb56d6c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140070041.29234.11.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 16 Feb 2006 07:07:21 +0100

Hi Gareth,

> I'm working on a project on a Intel XScale processor, connecting to
> bluetooth heart rate monitors and headsets. Connections currently have
> 7 attempts to work, though leaving a debug flag on (which slows the
> handshake down) gets a near-instant connection. I would like to get
> the connections normal without slowing down the BT device after the
> connection is made.
> 
> Any normal connection, regardless of whether there's an authorization
> segment, will fail (errors 104 & 110 - 'Connection timed out' and
> 'Connection reset by peer') 7 times before connecting. It'll usually
> alternate between the two errors, and the 7 is fairly constant.
> 
> I have found that I can get the total connection time by reducing
> these two variables down to 2 seconds each. It still takes seven
> attempts. Once the first device is connected, any others will either
> be instant or have one timeout/reset.
> 
> (rfcomm.h)
> #define RFCOMM_CONN_TIMEOUT (HZ * 2)
> #define RFCOMM_DISC_TIMEOUT (HZ * 2)
> 
> I later found that enabling a debug flag will give me instant
> connections (how I assume things should be), because it is slowing
> down the process. The flag is HCI_CORE_DEBUG in bluetooth.h, which
> affects the fines hci_core.c, hci_conn.c and hci_event.c. I have
> isolated it to the hci_core.c file that needs to be slowed down.
> 
> I can't, however, leave the prints on or a loop to slow it down or
> sleep, as the SCO voice connection becomes unusable with them on once
> it is connected.
> 
> Can someone please suggest an approach to targeting and slowing down
> the handshake and the not the resulting connection?

this looks like a hardware limitation. What kind of dongles/chips are
you using?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
