Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 25 Mar 2013 11:41:45 -0400
Message-ID: <CAB8sVA-XJeACK9YHEB0V3vLHbskPaVe6A+C9_oM6t2jP-UV+pQ@mail.gmail.com>
Subject: Problem Running Bluez Tests
From: Brendan West <extremeskateboarding@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am attempting to run the tests (such as "test-discovery" and
"test-heartrate") located in the Bluez 5.2 tar package, and am running
into some problems. Whenver I try to run one of these tests, I am
getting the following error:
root@interndebian:/home/user/Downloads/bluez-5.2/test# ls
bluezutils.py sap_client.py service-spp.xml test-adapter test-health
test-nap test-thermometer
bluezutils.pyc service-did.xml simple-agent test-alert
test-health-sink test-network
dbusdef.py service-ftp.xml simple-endpoint test-cyclingspeed
test-heartrate test-profile
list-devices service-opp.xml simple-player test-device test-hfp test-proximity
monitor-bluetooth service-record.dtd simple-service test-discovery
test-manager test-sap-server
root@interndebian:/home/user/Downloads/bluez-5.2/test#
./test-heartrate -i hci1 -b FC:4E:09:DC:68:44
Traceback (most recent call last):
File "./test-heartrate", line 62, in <module>
managed_objects = bluezutils.get_managed_objects()
File "/home/user/Downloads/bluez-5.2/test/bluezutils.py", line 11, in
get_managed_objects
return manager.GetManagedObjects()
File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
return self._proxy_method(*args, **keywords)
File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
**keywords)
File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651,
in call_blocking
message, timeout)
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "GetManagedObjects"
with signature "" on interface "org.freedesktop.DBus.ObjectManager"
doesn't exist
root@interndebian:/home/user/Downloads/bluez-5.2/test#

I have tried searching the internet for solutions to this problem, but
I haven't been able to find anything. I am running Debian Wheezy on a
Raspberry Pi, my end goal being to connect to a Bluetooth Smart heart
rate monitor.
This may be an easy fix, but my knowledge of Linux (especially the
finer points) is limited, so hopefully someone else will know an
answer. Any help would be greatly appreciated. Thanks.

Brendan West

P.S.
I did follow the instructions to make and install the package, but I'm
still attempting to run the tests out of the package folder because I
couldn't find them anywhere else (I'm assuming they aren't installed
with the rest of the package since they are just tests, but I could be
wrong). I'm not sure if that is relevant, but I thought I would
mention it.
