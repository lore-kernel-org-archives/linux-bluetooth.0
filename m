Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4421421C.1020601@blueyonder.co.uk>
From: Sid Boyce <sboyce@blueyonder.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] skype_bt_hijacker problem
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
Date: Wed, 22 Mar 2006 12:25:00 +0000

I have to run "btscorunner" as root to get it to see the headset.
lancelot@barrabas:~> btscorunner
Error: control open (hw:2): No such device
Error: Can't find device. Bail
Error: control open (hw:2): No such device
Error: Can't find device. Bail
Error: control open (hw:2): No such device
Error: Can't find device. Bail

lancelot@barrabas:~> l /dev/dsp* /dev/mixer*
crw------- 1 lancelot audio 14,  3 2006-03-22 01:01 /dev/dsp
crw-rw---- 1 lancelot audio 14, 35 2006-03-22 01:04 /dev/dsp2
crw------- 1 lancelot audio 14,  0 2006-03-22 01:01 /dev/mixer
crw------- 1 lancelot audio 14, 16 2006-03-22 01:01 /dev/mixer1
crw-rw---- 1 lancelot audio 14, 32 2006-03-22 01:04 /dev/mixer2

Running as root, it connects OK. I next call echo123 and the speaker/mic 
works, but pressing the headset button gives the errors below. I can use 
the headset in the normal way, runining "btsco -v <BTADDR>" and 
selecting /dev/dsp2 in options.
  barrabas:~ # btscorunner
Traceback (most recent call last):
   File "/usr/local/bin/skype_pickup.py", line 78, in ?
     main()
   File "/usr/local/bin/skype_pickup.py", line 74, in main
     api_object = Api_obj()
   File "/usr/local/bin/skype_pickup.py", line 11, in __init__
     system_service_list = 
remote_bus.get_service('org.freedesktop.DBus').get_object('/org/freedesktop/DBus', 
'org.freedesktop.DBus').ListServices()
AttributeError: 'SystemBus' object has no attribute 'get_service'
Traceback (most recent call last):
   File "/usr/local/bin/skype_pickup.py", line 78, in ?
     main()
   File "/usr/local/bin/skype_pickup.py", line 74, in main
     api_object = Api_obj()
   File "/usr/local/bin/skype_pickup.py", line 11, in __init__
     system_service_list = 
remote_bus.get_service('org.freedesktop.DBus').get_object('/org/freedesktop/DBus', 
'org.freedesktop.DBus').ListServices()
AttributeError: 'SystemBus' object has no attribute 'get_service'
Traceback (most recent call last):
   File "/usr/local/bin/skype_pickup.py", line 78, in ?
     main()
   File "/usr/local/bin/skype_pickup.py", line 74, in main
     api_object = Api_obj()
   File "/usr/local/bin/skype_pickup.py", line 11, in __init__
     system_service_list = 
remote_bus.get_service('org.freedesktop.DBus').get_object('/org/freedesktop/DBus', 
'org.freedesktop.DBus').ListServices()
AttributeError: 'SystemBus' object has no attribute 'get_service'
Traceback (most recent call last):
   File "/usr/local/bin/skype_pickup.py", line 78, in ?
     main()
   File "/usr/local/bin/skype_pickup.py", line 74, in main
     api_object = Api_obj()
   File "/usr/local/bin/skype_pickup.py", line 11, in __init__
     system_service_list = 
remote_bus.get_service('org.freedesktop.DBus').get_object('/org/freedesktop/DBus', 
'org.freedesktop.DBus').ListServices()
AttributeError: 'SystemBus' object has no attribute 'get_service'

# ps fax|grep btsco
  9824 pts/17   S+     0:00  |   |           \_ /bin/bash 
/usr/local/bin/btscorunner
  9827 pts/17   S+     0:00  |   |  \_ btsco -s 00:03:89:60:F9:CF

---------- 1 root root 0 2006-03-22 12:08 /tmp/bt_headset_connected

Any ideas?
Thanks and Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
