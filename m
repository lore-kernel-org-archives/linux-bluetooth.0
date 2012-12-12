Return-Path: <cyrus@holtmann.org>
From: Ting Chou <Ting.Chou@iaSolution.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 12 Dec 2012 11:57:38 +0800
Subject: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

The Problem
-----------

I am trying to connect to a BLE device (thermometer) by the D-Bus API with
following steps:

  1. Call org.bluez.Device1.Connect(), got org.bluez.Error.NotAvailable. But
     from the log of hcidump, the device is connected.
  2. Invoke org.bluez.Device1.Disconnect(), hcidump shows it is disconnected.
  3. Connect again, org.bluez.Device1.Connect() still throws
     org.bluez.Error.NotAvailable, but this time, there's nothing from hcidump,
     i.e., the device is not connected.

I'm not sure is this expected or it is a bug. If this is a bug, and you don't
have time to fix it, I'd love to help, but I may need a mentor.

Reproduce Steps
---------------

1. ting@user-OptiPlex-755:~/w/bluez$ sudo test/test-discovery -i hci0
   [ 00:07:80:4C:5F:17 ]
       Name = DKBLE112 thermometer
       Paired = 0
       Adapter = /org/bluez/hci0
       LegacyPairing = 0
       Alias = DKBLE112 thermometer
       Connected = 0
       Address = 00:07:80:4C:5F:17
       RSSI = -66
       Trusted = 0
       Blocked = 0
   ting@user-OptiPlex-755:~/w/bluez$ sudo test/test-device connect 00:07:80:4C:5F:17
   Traceback (most recent call last):
     File "test/test-device", line 104, in <module>
       device.ConnectProfile(args[2])
     File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
       return self._proxy_method(*args, **keywords)
     File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
       **keywords)
     File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in call_blocking
       message, timeout)
   dbus.exceptions.DBusException: org.bluez.Error.NotAvailable: Operation currently not available

2. ting@user-OptiPlex-755:~/w/bluez$ sudo test/test-device disconnect 00:1C:4D:00:09:02

3. ting@user-OptiPlex-755:~/w/bluez$ sudo test/test-device connect 00:07:80:4C:5F:17
   Traceback (most recent call last):
     File "test/test-device", line 104, in <module>
       device.ConnectProfile(args[2])
     File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
       return self._proxy_method(*args, **keywords)
     File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
       **keywords)
     File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in call_blocking
       message, timeout)
   dbus.exceptions.DBusException: org.bluez.Error.NotAvailable: Operation currently not available

I Found
-------

- I checked /var/log/syslog and src/device.c, and found connect_profiles() is
  called twice at the first time calling org.bluez.Device.Connect():

  - 1st time
    dev->svc_resolved==FALSE, device_resolve_svc() is invoked.

  - 2nd time
    dev->svc_resolved==TRUE
    In the for loop of iterating device profiles, there're two profiles:

      a) p->auto_connect==FALSE, p->name==deviceinfo, p->local_uuid==NULL
      b) p->auto_connect==FALSE, p->name==Health Thermometer GATT driver, p->local_uuid==NULL

    Since none of them have auto_connect TRUE, dev->pending==NULL, and
    btd_error_not_available() is called.

- I tried org.bluez.Device1.ConnectProfile() as well, but since all the profiles
  have local_uuid NULL, find_connectable_profile() return NULL and
  btd_error_invalid_args() is called.

Regards,
Ting
