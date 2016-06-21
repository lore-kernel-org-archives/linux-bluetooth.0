Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 21 Jun 2016 09:01:55 -0400 (EDT)
From: Jaroslav Skarvada <jskarvad@redhat.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <1606210521.630724.1466514115545.JavaMail.zimbra@redhat.com>
In-Reply-To: <1181776782.627257.1466513205835.JavaMail.zimbra@redhat.com>
Subject: Unable to pair with Genius Navigator 900 Pro mouse
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

hopefully this is the right list (please don't blame me if not :)

It seems it is no more possible to pair with Genius Navigator 900
Pro mouse. It seems it's older mouse probably with no SSP/
built-in PIN.

# bluetoothctl
[bluetooth]# pair ADDR
[CHG] Device ADDR Connected: yes
[CHG] Device ADDR Connected: no
[CHG] Device ADDR Connected: yes
Failed to pair: org.bluez.Error.AuthenticationRejected
[CHG] Device ADDR Connected: no

Hcitool "trick":
# hcitool cc ADDR;hcitool auth ADDR
HCI authentication request failed: Input/output error

The above error is shown before the PIN dialog appears. I also
tried Blueman GUI, but it tracebacks (report also sent).

Moreover:
# hciconfig hci0 sspmode 0
Can't set Simple Pairing mode on hci0: Input/output error (5)

So I cannot try without SSP. It seems there is nothing related
in dmesg.

IIRC the mouse worked in the past.

$ uname -r
4.5.7-200.fc23.x86_64

OS: Fedora 23
userspace: bluez-5.39

machine: Lenovo ThinkPad X240
adapter probably: Intel Centrino 7260 2 x 2 AC+ BT 4.0
module: btintel: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq

Could you advice some other tricks how to get it working? 
I could also bisect the problem later

thanks & regards

Jaroslav
