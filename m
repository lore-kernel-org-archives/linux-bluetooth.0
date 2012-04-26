Return-Path: <cyrus@holtmann.org>
Message-ID: <4F990878.9020607@gmail.com>
Date: Thu, 26 Apr 2012 10:34:00 +0200
From: =?ISO-8859-1?Q?=C1ngel_Mart=EDnez_Cavero?= <anmarca6@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Unable to run bluez test health scripts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear bluez list,

this is my first message to the list so thanks in advance for your time 
reading me :-)

I want to develop some health field applications (in C code) so I've 
just start playing with the latest blueZ libraries (4.99 version) 
available for download. First thing was try to understand the logical 
process and routines involved in the API through the test scripts shared 
with the blueZ project (under "test" folder). The problem is that my 
system is not able to run all those scripts related with the health 
profile unfortunately, that is: "test-health" and "test-health-sink" 
files getting always the same output as result (the others works fine: 
simple-agent, test-discovery, etc):

First script output
=============
./test-health
Select 1. source or 2. sink: 2
  Select a data type: 1004
ERROR:dbus.connection:Unable to set arguments ({'DataType': 
dbus.UInt16(1004), 'Role': 'Sink', 'Description': 'Test sink'},) 
according to signature None: <type 'exceptions.TypeError'>: an integer 
is required
Traceback (most recent call last):
   File "./test-health", line 110, in <module>
     "Role": role})
   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in 
__call__
     return self._proxy_method(*args, **keywords)
   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in 
__call__
     **keywords)
   File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 620, 
in call_blocking
     message.append(signature=signature, *args)
TypeError: an integer is required

Second script output
===============
./test-health-sink
ERROR:dbus.connection:Unable to set arguments ({'DataType': 
dbus.UInt16(4103), 'Role': 'sink'},) according to signature None: <type 
'exceptions.TypeError'>: an integer is required
Traceback (most recent call last):
   File "./test-health-sink", line 18, in <module>
     "Role": "sink"})
   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in 
__call__
     return self._proxy_method(*args, **keywords)
   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in 
__call__
     **keywords)
   File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 620, 
in call_blocking
     message.append(signature=signature, *args)
TypeError: an integer is required

I'm working with Ubuntu 11.10 OS (32 bits). Any advice would be greatly 
appreciated.
Best regards.
