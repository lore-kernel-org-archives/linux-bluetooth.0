Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 23 Mar 2010 17:41:54 +0800
Message-ID: <8396c2281003230241i7dd14d5fnb3f98152392e05d3@mail.gmail.com>
Subject: Can't turn off bluetooth with discoverable mode on Lucid
From: Chao Deng <dcs1983@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When I use "hciconfig" to turn off Bluetooth, I meet a problem that it
can't be turned off correctly when discoverable. I need to run
"hciconfig hci0 down" twice to turn off it, following is the log
information.
[LOG]
root@ubuntu-laptop:/home/ubuntu# hciconfig
hci0: Type: SDIO
        BD Address: 00:24:23:10:97:A3 ACL MTU: 1021:7 SCO MTU: 240:3
        UP RUNNING PSCAN ISCAN
        RX bytes:2324 acl:0 sco:0 events:71 errors:0
        TX bytes:2746 acl:0 sco:0 commands:71 errors:0

root@ubuntu-laptop:/home/ubuntu# hciconfig hci0 down
root@ubuntu-laptop:/home/ubuntu# hciconfig
hci0: Type: SDIO
        BD Address: 00:24:23:10:97:A3 ACL MTU: 1021:7 SCO MTU: 240:3
        UP RUNNING PSCAN
        RX bytes:3467 acl:0 sco:0 events:105 errors:0
        TX bytes:4227 acl:0 sco:0 commands:105 errors:0

root@ubuntu-laptop:/home/ubuntu# hciconfig hci0 down
root@ubuntu-laptop:/home/ubuntu# hciconfig
hci0: Type: SDIO
        BD Address: 00:24:23:10:97:A3 ACL MTU: 1021:7 SCO MTU: 240:3
        DOWN
        RX bytes:3477 acl:0 sco:0 events:106 errors:0
        TX bytes:4234 acl:0 sco:0 commands:106 errors:0

[/LOG]
At the first time of "hciconfig hci0 down", the bluetooth adapter is
turned off and then turned on again (who turn on it?). The mode is
changed from "UP RUNNING PSCAN ISCAN" to "DOWN" (I can't capture this
change), and then from "DOWN" to "UP RUNNING PSCAN" (This is what we
see after run this command). You can see the time stamp in the log
file (syslog)
At the second time, the bluetooth adapter is turned off, mode is
changed to "DOWN".

This is part of the /var/log/syslog, you can see the state of "HCI dev 0"
[LOG]
Jul 29 08:54:01 ubuntu-laptop bluetoothd[1061]: Bluetooth daemon 4.60
Jul 29 08:54:01 ubuntu-laptop bluetoothd[1062]: Starting SDP server
Jul 29 08:54:01 ubuntu-laptop bluetoothd[1062]: Starting experimental
netlink support
Jul 29 08:54:01 ubuntu-laptop bluetoothd[1062]: Failed to find
Bluetooth netlink family
Jul 29 08:54:01 ubuntu-laptop bluetoothd[1062]: Failed to init netlink plugin
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: Can't create GN bridge
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: Unable to start SCO
server socket
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: Failed to init audio plugin
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: HCI dev 0 registered
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: Failed to open RFKILL
control device
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: accept: Socket
operation on non-socket (88)
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: HCI dev 0 up
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: Starting security manager 0
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: Parsing
/etc/bluetooth/serial.conf failed: No such file or directory
Jul 29 08:54:02 ubuntu-laptop bluetoothd[1062]: Adapter
/org/bluez/1061/hci0 has been enabled
Jul 29 08:54:15 ubuntu-laptop AptDaemon: INFO: Initializing daemon
Jul 29 08:54:33 ubuntu-laptop bluetoothd[1062]: HCI dev 0 down
Jul 29 08:54:33 ubuntu-laptop bluetoothd[1062]: Adapter
/org/bluez/1061/hci0 has been disabled
Jul 29 08:54:33 ubuntu-laptop bluetoothd[1062]: Stopping security manager 0
Jul 29 08:54:33 ubuntu-laptop bluetoothd[1062]: HCI dev 0 up
Jul 29 08:54:33 ubuntu-laptop bluetoothd[1062]: Starting security manager 0
Jul 29 08:54:33 ubuntu-laptop bluetoothd[1062]: Adapter
/org/bluez/1061/hci0 has been enabled
Jul 29 08:59:16 ubuntu-laptop AptDaemon: INFO: Quiting due to inactivity
Jul 29 08:59:16 ubuntu-laptop AptDaemon: INFO: Shutdown was requested
Jul 29 09:06:29 ubuntu-laptop bluetoothd[1062]: HCI dev 0 down
Jul 29 09:06:29 ubuntu-laptop bluetoothd[1062]: Adapter
/org/bluez/1061/hci0 has been disabled
Jul 29 09:06:29 ubuntu-laptop bluetoothd[1062]: Stopping security manager 0
Jul 29 09:06:29 ubuntu-laptop bluetoothd[1062]: HCI dev 0 up
Jul 29 09:06:29 ubuntu-laptop bluetoothd[1062]: Starting security manager 0
Jul 29 09:06:29 ubuntu-laptop bluetoothd[1062]: Adapter
/org/bluez/1061/hci0 has been enabled
Jul 29 09:06:41 ubuntu-laptop bluetoothd[1062]: HCI dev 0 down
Jul 29 09:06:41 ubuntu-laptop bluetoothd[1062]: Adapter
/org/bluez/1061/hci0 has been disabled
Jul 29 09:06:41 ubuntu-laptop bluetoothd[1062]: Stopping security manager 0

[/LOG]

The release of Ubuntu that I use is Ubuntu Lucid.
    root@ubuntu-laptop:/home/ubuntu# lsb_release -rd
    Description: Ubuntu lucid (development branch)
    Release: 10.04
And the bluez version is 4.60-0ubuntu5.
The kernel version is 2.6.32.9.
The test platform that I use is Dove (ARM platform), and the Bluetooth
Adapter is Marvell SD8688.

By the way, I have test it on Karmic with the same kernel and driver,
it's workable. I also try to downgrade the Bluez version from 4.60 to
4.51(used in Karmic release), but it doesn't help, the problem still
exists.
Then, I kill the process "bluetoothd" and try it again, I can run
"hciconfig hci0 down" only once to turn off it (from "UP RUNNING PSCAN
ISCAN" to "DOWN"). So maybe something happens and lets "bluetoothd" to
turn on the adapter, how to trace it?

Do anyone else have the same problem like me? Or could you share some
methods to debug it?
