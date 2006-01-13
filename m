Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C70696.4010307@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] headset wont work <sdp?>
References: <43C581DE.6030205@cs.bgu.ac.il> <43C69CA3.1060606@cs.bgu.ac.il> <43C6DBA0.9050002@cs.bgu.ac.il>
In-Reply-To: <43C6DBA0.9050002@cs.bgu.ac.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Date: Fri, 13 Jan 2006 03:47:02 +0200

blacky niv # hcid -n   
hcid[28261]: Bluetooth HCI daemon
hcid[28261]: Can't open system message bus connection: Failed to connect 
to socket /var/run/dbus/system_bus_socket: No such file or directory
hcid[28261]: Starting security manager 0
hcid[28261]: Registering DBUS Path: /org/bluez/Device/hci0
Segmentation fault
blacky niv # ls -la /var/run/dbus/system_bus_socket
ls: /var/run/dbus/system_bus_socket: No such file or directory
blacky niv # locate system_bus_socket
blacky niv # /etc/init.d/dbus
dbus            dbus.init-0.60 
blacky niv # /etc/init.d/dbus
dbus            dbus.init-0.60 
blacky niv # /etc/init.d/dbus start
 * Starting D-BUS system messagebus 
...                                   [ ok ]
blacky niv # hcid -n
hcid[28466]: Bluetooth HCI daemon
hcid[28466]: Starting security manager 0
hcid[28466]: Registering DBUS Path: /org/bluez/Manager/default/Controller
hcid[28466]: Registering DBUS Path: /org/bluez/Manager/hci0/Controller
hcid[28466]: Registering DBUS Path: /org/bluez/Device/hci0

wait a min , aint dbus in the dependend /etc/init.d/bluetooth ?


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
