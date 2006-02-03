Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Message-Id: <C51EAF6C-EE61-4B77-BC7F-3FADB91E923B@epfl.ch>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: bluez-users@lists.sourceforge.net
From: Thomas Lochmatter <thomas.lochmatter@epfl.ch>
Subject: [Bluez-users] Concurrent access
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 3 Feb 2006 10:08:08 +0100

Hi

We have several devices (robots) that we want to access at the same  
time from several processes via bluetooth (rfcomm virtual serial  
port). Each process first opens a connection to one robot (/dev/ 
rfcommNN), then communicates with the robot for a while and finally  
disconnects.

When I launch several processes (about 3-5) at the same time, usually  
only one of them succeeds to connect. If I constantly try to open the  
devices (in a loop, wait a second and call "open" again), a couple of  
them are connected after a while, but not all. Is there a way to make  
that work? Does anyone else have experience with concurrent access to  
the bluetooth libs?

Thomas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
