Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 22 Apr 2008 23:45:05 +0530
Message-Id: <1208888105.16346.18.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] Telephony plugin framework
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel/Johan, 

Here is the summary of the telephony plugin framework discussion we had
on IRC. Can you please verify it? 


1. 'hcid' maintains a list of 'telephony devices'[a GList]. it also
exports methods to create, destroy, update these devices.

2. 'hcid' also maintains a list of 'telephony drivers'[a GList]. it also
exports methods to register, unregister  these drivers.
     
3. 'hcid' exports telephony methods. (which will be called by the
services).

4. A service(example: audio) will register a telephony device with
'hcid' using 'register_telephony_device()'.

5. A telephony plugin will register a telephony driver with 'hcid' using
'register_telephony_driver()'.

6. Once the driver is registered, it scans through the list of devices,
and if a suitable registered device is found (matches the driver name to
device name, like in the linux kernel), it calls the 'probe' of the
driver.  

Question. What information does the 'struct device' going to hold? In
linux device driver senario, it holds the resource (IRQ, memory etc)
information. 
 
7. The probe function can initializes the telephony subsystem. It also
registers a structure of "callbacks" with hcid. These callbacks are
function pointers to the C functions in the plugin which interact with
the telephony system.

8. These callbacks will allow services to call functions in the
plugin(via hcid).

9. But to allow the plugin to notify the services (a response to a
previously issued command or issuing a new command to the audio
service), it uses a hcid exported function
'update_telephony_status(telephony_device)'. 

10. The service will take action on the changed status of the device. 


-Alok.


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
