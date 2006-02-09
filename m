Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Heba <Heba.Khamis@csiro.au>
Message-ID: <loom.20060209T033130-898@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Belkin F8T009 and Linux
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
Date: Thu, 9 Feb 2006 02:48:02 +0000 (UTC)

I am developing an application for automatic network discovery using bluetooth
i.e. Running the application will result in connections to any other computers
running the same application:
- Each application is running a server which accepts connections (once a
connection is made, the connection is maintained until a transmission 
error occcurs or the socket is closed by either party); 
- and a client which repeatedly queries for bluetooth devices to connect to.

So in total an application makes and 
maintains 2*(#other applications) connections.

This causes no problems when using the Belkin F8T003 Bluetooth USB Adaptor
(this is a bluetooth v1.1 compliant device).

However, when using the Belkin F8T009 Bluetooth USB Adaptor 
(this is a bluetooth v1.2 compliant device) 
"Device or Resource Busy" errors are observed 
when the application tries to query 
when there are 3 or more connections maintained by it.

Is this a bluetooth hardware issue, 
a Bluez stack issue, 
or does Bluez just not support this particular device??

I have installed all the latest versions:
- Bluez-lib
- Bluez-hcidump
I am running Fedora core 4 with the latest available updates of the kernel.

Please advise if I am overlooking something, or if this is not a Bluez issue,
could you please direct me to the appropriate contact.

Thanks
Heba



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
