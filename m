Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <4.3.1.0.20010824144506.02100320@mail1>
Date: Fri, 24 Aug 2001 15:13:27 -0700
To: bluez-devel@lists.sourceforge.net
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] Serial port baud rate autodetection.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <http://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<http://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>

Folks,

I've been playing with the baud rate auto detection for a while.
I hacked hci_uart driver to provide nice read/write interface before actual HCI device registration.
This allows to reuse it serial stream parsing engine, so  you can read/write complete HCI frames
to/from tty. I also added baud rate detection logic to hcid.  
Algorithm is pretty simple (we've already discussed it):
	1. Start at highest speed (115200 for now).
	2. Send read local version command
	3. Wait for any event
		3.1 Timed out: decrease speed, goto 1
		3.2 Got it: proceed with initialization. 

All that seems to work. But here is the problem. For some reason EBDK|AK goes totally numb 
when you play with baud rate. And I could not got any event from it until hard reset. 
You can easily verify that yourself:
	Reset DK and start hcid on 57600.
	Everything works.
	Now do: 
		stty 115200 < /dev/ttyS0
		hciconfig hci0 version # or any other command, data, etc
		(Time out)
		stty 57600 < /dev/ttyS0
	That's it. After this point DK is not responding even though we switched back to 57600.
		hciconfig hci0 version
		(Time out)

There is only way to bring it back after above trick - hard reset. Same thing happens when hcid tries to scan baud rates.
I tried pretty much everything: flushing, sending bunch of zeros before command, voodoo dancing, etc. Nothing works.
So I thought hell with it, I'd rather do something more important (like PAN or role switch for example).
Is anybody else interested in playing with that ? 
I'll keep modified UART driver and hcid. Let me know if you need them.

Regards
Max

  



	
		  


	



Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/bluez-devel
