Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY102-F210C30E45F8EA3793EF85AD2BF0@phx.gbl>
From: "theresa g." <tereza99@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bluez-devel] hcid vs. hciconfig hci0 up
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
Date: Wed, 01 Dec 2004 09:18:41 -0800

I got my server app running on an Axis developer's board  83 with the use of 
an RFCOMM socket on channel one for the BT comm.  After flashing my board 
w/the new kernel (for BlueZ to work) I noticed I could not run the hcid 
daemon w/out the board either giving msgs about no kernel access to the 
device or even kernel panics when i put the hcid in a startup script.  (For 
those familiar w/this board, I can do a network boot of the same image and 
it all works fine)

I know this issue has nothing to do w/this list, but I wanted to know:

What is the difference between running the hcid and using "hciconfig hci0 
up" to bring up the device.  Since I cannot use hcid, I just use hciconfig 
to manually bring up the device and my app works fine.  Whats the difference 
between the two?  And is it better to use the daemon?

Thanks in advance,
Theresa




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
