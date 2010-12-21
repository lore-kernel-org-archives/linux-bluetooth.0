Return-Path: <cyrus@holtmann.org>
From: "Goubert, TonyX" <tonyx.goubert@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 21 Dec 2010 08:53:47 +0000
Subject: problem to disconnect with bluez-test
Message-ID: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CAB2@irsmsx501.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I use bluez-4.76.2.6 i586.rpm and bluez-test-4.76.2.6.i586.rpm in order to discover, connect, ...  

Link : repo.meego.com/MeeGo/builds/trunk/1.1.80.10.20101214.1/core/repos/ia32/packages/i586/

I have paired a handset with a laptop by using 'simple-agent' bluez-test script
BUT I can't disconnect it when I use the bluez stack.
I can remove it (./test-device remove xx:xx:xx:xx:xx:xx) but I want to be able to connect/disconnect/connect...

Is there a command?

Some handset traces:
[root@localhost test]# ./list-devices
    [ /org/bluez/369/hci0/dev_xx_xx_xx_xx_xx_xx ]
        Name = tllab54
        Paired = 1
        Adapter = /org/bluez/369/hci0
        Alias = tllab54
        Connected = 1
        UUIDs = 0x110a 0x110c 0x110e 0x1112 0x1115 0x1116 0x1117 0x111f 
        Address = xx:xx:xx:xx:xx:xx
        Services = dbus.Array([], signature=dbus.Signature('o'), variant_level=1)
        Class = 0x000000
        Trusted = 0
        Blocked = 0

[root@localhost test]# ./test-device disconnect xx:xx:xx:xx:xx:xx
Unknown command

[root@localhost test]# ./test-input disconnect xx:xx:xx:xx:xx:xx 
Traceback (most recent call last):
  File "./test-input", line 42, in <module>
    input.Disconnect()
  File "/usr/lib/python2.6/site-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.6/site-packages/dbus/proxies.py", line 140, in __call__
    **keywords)
  File "/usr/lib/python2.6/site-packages/dbus/connection.py", line 630, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Method "Disconnect" wt

BR

--
Tony Goubert
tonyx.goubert@intel.com

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

