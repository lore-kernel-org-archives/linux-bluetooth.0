Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: sjok1 <sjok1@student.cs.ucc.ie>
To: Bluez-devel@lists.sourceforge.net
Message-ID: <40500CFF@webmail.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [Bluez-devel] Bluetooth Headset Profile
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 Mar 2004 14:20:23 +0000

Hi,

I don't know if this is the right list to put this but I've been following 
what's being posted for the last couple of weeks and it seems like people 
might know how to help me.

   I'm writing an application for a PC that (tries to :) ) emulates a 
Bluetooth Headset. I want the the PC application to be the one to create the 
initial RFCOMM connection and I just need to know specifically what the phone 
tries to do when I send the AT+CKPD=200 command for the first time? Or do I 
need to send this command at all, can I just listen for an SCO connection? 
Will the phone try to verify that the PC supports the Headset/Handsfree 
Profile at this time?

Thanks,

Steven.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
