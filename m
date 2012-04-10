Return-Path: <cyrus@holtmann.org>
Message-ID: <1334021750.90626.YahooMailClassic@web140306.mail.bf1.yahoo.com>
Date: Mon, 9 Apr 2012 18:35:50 -0700 (PDT)
From: Misaligned Access <misalignedaccess@yahoo.com>
Subject: org.bluez.Telephony interface
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new Telephony interface implementation does not appear to be synchronized in at least the Debian distribution.  I would appreciate any help to make this work correctly, because I need this to work for Asterisk chan_mobile support, which does not appear to work at the moment.

Thank you,

Andrew

#  dpkg-query -l bluez
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  bluez          4.99-2         Bluetooth tools and daemons

# bluez-test-device list
00:1D:FD:ED:C7:87 NokiaE51

# bluez-test-telephony connect 00:1D:FD:ED:C7:87
Traceback (most recent call last):
  File "/usr/bin/bluez-test-telephony", line 57, in <module>
    headset.Connect()
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 143, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with signature "" on interface "org.bluez.Headset" doesn't exist

# dpkg-query -l blueman
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  blueman        1.23-1         Graphical bluetooth manager

# ls -las /usr/share/pyshared/blueman/bluez
total 72K
 4K drwxr-xr-x 2 toor root  4096 Apr  9 14:40 .
 4K drwxr-xr-x 8 toor root  4096 Apr  9 14:40 ..
12K -rw-r--r-- 1 toor root 10566 Mar 28 19:14 Adapter.py
 8K -rw-r--r-- 1 toor root  5705 Mar 28 19:14 Agent.py
 4K -rw-r--r-- 1 toor root  2256 Mar 28 19:14 BaseInterface.py
 4K -rw-r--r-- 1 toor root  2946 Mar 28 19:14 BlueZInterface.py
 8K -rw-r--r-- 1 toor root  4777 Mar 28 19:14 Device.py
 8K -rw-r--r-- 1 toor root  4636 Mar 28 19:14 errors.py
 4K -rw-r--r-- 1 toor root  1013 Mar 28 19:14 __init__.py
 8K -rw-r--r-- 1 toor root  4775 Mar 28 19:14 Manager.py
 4K -rw-r--r-- 1 toor root  1532 Mar 28 19:14 ServiceInterface.py
 4K -rw-r--r-- 1 toor root  1382 Mar 28 19:14 utils.py




