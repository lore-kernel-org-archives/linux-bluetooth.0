Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 20 Aug 2013 11:21:08 +0200
Message-ID: <CAOJw-HZR2w0bKBbGmt8zmX+28juTEmXco-hh1xkU5Xb9aJ-zOA@mail.gmail.com>
Subject: python scripts not working
From: Markus Roppelt <markus.roppelt@peus-testing.de>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=047d7b111d2bb9123304e45d933b
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b111d2bb9123304e45d933b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have problems to get the python test scripts running.

My configuration is Ubuntu 13.10 with Kernel 3.8.0-27-generic. For the
installation of Bluez 5.7 I used the following commands:

./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc
--localstatedir=/var -disable-systemd
make
make install

Then I changed the init.d script to the new bluetoothd, as pointed out
here: http://permalink.gmane.org/gmane.linux.bluez.kernel/35011

/etc/init.d/bluetooth stop
# do a backup of the original executable
mv /usr/sbin/bluetoothd  /usr/sbin/bluetoothd.orig
ln -s /usr/libexec/bluetooth/bluetoothd /usr/sbin/bluetoothd
/etc/init.d/bluetooth start

Everything worked fine and I can connect to the Bluetooth chip (Nordic
nrf51822) using the command:
sudo gatttool -b D1:83:15:3C:26:F0 -t random --interactive
I can read the descriptions, enable notifications as expected.

However, when I start the python heart rate example, I get the following error.

markus@markus-G33M-DS2R:~/ble-server/bluez-5.7/test$ sudo
./test-heartrate -b D1:83:15:3C:26:F0
Traceback (most recent call last):
  File "./test-heartrate", line 71, in <module>
    heartrateManager.RegisterWatcher(path)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
651, in call_blocking
    message, timeout)
dbus.exceptions.DBusException:
org.freedesktop.DBus.Error.UnknownMethod: Method "RegisterWatcher"
with signature "s" on interface "org.bluez.HeartRateManager1" doesn't
exist

Attached you'll find a dump (btmon -w btmon.dump) during the
./test-heartrate call as mentioned
here:http://article.gmane.org/gmane.linux.bluez.kernel/37419
I suspect that the dump is empty because of the small file size.

How can I get the script running?

Best Regards
 Markus

--047d7b111d2bb9123304e45d933b
Content-Type: application/octet-stream; name="btmon.dump"
Content-Disposition: attachment; filename="btmon.dump"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkkwkc5n0

YnRzbm9vcAAAAAABAAAH0QAAABAAAAAQAAAAAAAAAAAA4cIQcRz+CAABOORpgxUAaGNpMAAAAAA=
--047d7b111d2bb9123304e45d933b--
