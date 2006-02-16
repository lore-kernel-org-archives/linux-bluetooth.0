Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Heba Khamis <Heba.Khamis@csiro.au>
Message-ID: <loom.20060216T015926-491@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Belkin USB Adaptors and Failing =?utf-8?b?aGNpX2lucXVpcnk=?=
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
Date: Thu, 16 Feb 2006 01:08:09 +0000 (UTC)

Hi,

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

I've used hcidump to try and figure it out, but all it tells me is:
   HCI Command: Inquiry (0x01|0x0001) plen 5
     lap 0x9e8b33 len 8 num 255
   HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x0c ncmd 1
     Error: Command Disallowed

This really doesn't help me to understand why this is happening.
The status of that particular bluetooth device (a Belkin F8T003 Bluetooth USB 
bluetooth v1.1 compliant Adaptor) when the error occurs is as follows:
   a local server socket is listening for connections
   two remote clients are connected to the device
   a local client thread is attempting to query other devices using hci_inquiry

Please advise if I am overlooking something, or if this is not a Bluez issue,
could you please direct me to the appropriate contact.

Thanks,
Heba
 




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
