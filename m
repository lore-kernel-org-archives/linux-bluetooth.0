Return-Path: <cyrus@holtmann.org>
Message-ID: <4A8080DC.2010204@gmail.com>
Date: Mon, 10 Aug 2009 22:19:40 +0200
From: Till Kamppeter <till.kamppeter@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: PATCHES: Device discovery of the "bluetooth" CUPS backend does not
 work
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using Bluez 4.47, and I can set up a Bluetooth printer only 
manually by running the "bluetooth" CUPS backend from the command line with

/usr/lib/cups/backend/bluetooth

and then pasting the URI into the field for individual URI input in 
system-config-printer ("Others" in the device list). Then I also need to 
choose manufacturer and model manually. My expectation is that I only 
need to click the printer's make model name in the devices list and 
choose "Bluetooth" under the connection types and then the driver gets 
selected automatically as it is the case for the same printer on USB or 
WLAN.

I have found out why it does not work.

First, the CUPS Bluetooth backend asks the bluez D-Bus service whether 
there are printers available and which device ID they have. The access 
permissions for the bluez D-Bus service do not permit the CUPS system 
user "lp" to access, and exactly as this user the Bluetooth backend is 
running. Therefore I have modified /etc/dbus-1/system.d/bluetooth.conf 
to grant this permission.

I have added the following lines into the <busconfig> section:


   <!-- allow users of lp group (printing subsystem) to communicate with 
hcid -->
   <policy group="lp">
     <allow send_destination="org.bluez"/>
   </policy>


Second, the output of the CUPS Bluetooth backend was not very good for 
the printer setup tools doing the right thing. I have patched the 
backend to let the device class of the Bluetooth printers to be "direct" 
and not "network", as users expect a Bluetooth printer rather under the 
local printers than under the network printers. I have also filled the 
make-and-model field instead of putting a hard-coded "Unknown" there. 
The change is here:


--- bluez-4.47/cups/main.c	2009-07-03 00:43:14.000000000 +0200
+++ bluez-4.47.new/cups/main.c	2009-08-10 20:09:32.000000000 +0200
@@ -226,7 +226,7 @@
  		 bdaddr[9], bdaddr[10],
  		 bdaddr[12], bdaddr[13],
  		 bdaddr[15], bdaddr[16]);
-	printf("network %s \"Unknown\" \"%s (Bluetooth)\"", uri, escaped);
+	printf("direct %s \"%s\" \"%s (Bluetooth)\"", uri, escaped, escaped);
  	if (id != NULL)
  		printf(" \"%s\"\n", id);
  	else


See also my Ubuntu bug report:

https://bugs.launchpad.net/bugs/411610

I am very grateful if you could apply these changes to Bluez upstream, 
as this makes the bluetooth CUPS backend just work.

Thank you very much in advance.

    Till


http://www.openprinting.org/

