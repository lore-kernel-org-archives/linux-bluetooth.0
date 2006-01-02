Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
References: <1136205591.20731.42.camel@saag.bunker.heddley.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD1B5315-1B8A-41E0-9D9B-766B3D59634E@shirishranjit.com>
From: Shirish Ranjit <Shirish.Ranjit@shirishranjit.com>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Fwd: bluez util bluetooth dongle
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
Date: Mon, 2 Jan 2006 11:03:51 -0500


>> I am working on bluetooth devices on a debian linux installed in  
>> hp pavilion
>> ze5460us machine.  I have a usb bluetooth dongle Actiontec BTM200B  
>> that I use
>> for working with bluetooth devices. I am working on learning  
>> bluetooth
>> programming with python with pybluez. However, the usb dongle  
>> seems to
>> disapper after once I do the query such as  
>> bluetooth.discover_devices().
>>
>> I run the program once and then I have to reboot my debian linux  
>> to run the
>> program again. Once the dicover_devices() call fails, I try to to  
>> the hcitool scan and it
>> says time out.
>>
>> I have the latest debian linux installed through network install a  
>> week ago.
>> Following is the output from the uname
>> uname -a
>> Linux ranlinux 2.4.27-2-386 #1 Wed Aug 17 09:33:35 UTC 2005 i686  
>> GNU/Linux
>>
>>
>> Following is the error  from the bluetooth call
>>
>> performing inquiry...
>> Traceback (most recent call last):
>>     nearby_devices = bluetooth.discover_devices()
>>   File "/usr/local/lib/python2.3/site-packages/bluetooth.py", line  
>> 172, in
>> discover_devices
>>     raise BluetoothError("error communicating with local bluetooth  
>> device")
>> bluetooth.BluetoothError: error communicating with local bluetooth  
>> device
>> ----
>>
>> This is the output from the hciconfig -a
>>
>> ranlinux:/home/sranjit# hciconfig -a
>> hci0:   Type: USB
>>         BD Address: 00:20:E0:CC:2B:8D ACL MTU: 192:8 SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:1570 acl:0 sco:0 events:41 errors:0
>>         TX bytes:409 acl:0 sco:0 commands:30 errors:0
>>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK
>>         Link mode: SLAVE ACCEPT
>> Can't read local name on hci0: Connection timed out (110)
>>
>> !DSPAM:43b86354198356491211187!
>>
Regards,

Shirish Ranjit
shirish.ranjit@shirishranjit.com


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
