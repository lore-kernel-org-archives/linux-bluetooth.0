Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Matthias Schmidt <Matthias.Schmidt@netpioneer.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: org.bluez.Adapter1 Powered API causes UnknownMethod: Method "Set"
 with signature "ssb"
Date: Thu, 26 Nov 2015 12:13:31 +0000
Message-ID: <147AA35329540D468455E185B7E55050D4FBE66D@valen.ka.netpioneer.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi *,
        
while using the Powered API from the "org.bluez.Adapter1" interface in bluez 5.36 to turn BLE on and off 
i'm getting this exeception every now and then - could not figure out any pattern:

    adapterInterface.Set(ADAPTER_IFACE, "Powered", state)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in call_blocking
    message, timeout)
DBusException: org.freedesktop.DBus.Error.UnknownMethod: Method "Set" with signature "ssb" on interface "org.freedesktop.DBus.Properties" doesn't exist

I'm running Linux 4.1.2 on armv7l

Is there any chance to nail this down?

cheers,

Matthias

Senior Systemarchitekt
Netpioneer GmbH, Ludwig-Erhard-Allee 20, 76131 Karlsruhe
Geschäftsführer: Axel Jahn
HRB: 107521 Handelsregister Mannheim

Tel: 0721 / 9 20 60 822
Fax: 0721 / 9 20 60 30
E-Mail: matthias.schmidt@netpioneer.de
www: http://www.netpioneer.de
