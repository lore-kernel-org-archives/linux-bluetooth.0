Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: bheemsen <bheemsenk@gmail.com>
Date: Mon, 6 Feb 2017 19:33:10 +0530
Message-ID: <CAE+w0_T88Dfqv8C5y3tSMpgRX1ZTVqKzDyLZhQ9Pt7mWMZrP+A@mail.gmail.com>
Subject: Unable browse over BNEP
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

We are trying to setup NAP server over WLAN bridge. The remote PANU is
able to connect to the NAP server, while it is unable to browse/ping
to network.

For setting up NAP, we are using BlueZ 5.41 underlying kernel 4.9.0.
We do follow below steps to setup bridge and connect BNEP over same,

Bringup WLAN:

wlan0     Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx

          inet addr:192.168.43.100  Bcast:192.168.43.255  Mask:255.255.255.0

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:6 errors:0 dropped:0 overruns:0 frame:0

          TX packets:11 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:1000

          RX bytes:890 (890.0 B)  TX bytes:1862 (1.8 KiB)

Setup bridge:

# brctl addbr br0

# ip addr add 192.168.100.1 dev br0

# ip link set br0 up

# ifconfig

br0       Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx

          inet addr:192.168.43.7 Bcast:0.0.0.0  Mask:255.255.255.255

          inet6 addr: fe80::94a7:c5ff:fe36:c3d6/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:0 errors:0 dropped:0 overruns:0 frame:0

          TX packets:7 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0

          RX bytes:0 (0.0 B)  TX bytes:640 (640.0 B)

Iptable setup:

# iptables -A FORWARD -i wlan0 -o br0 -m state --state
ESTABLISHED,RELATED -j ACCEPT

echo " Enabling SNAT (MASQUERADE) functionality on $EXTIF"

# iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

echo " Enabling forwarding.."

# echo "1" > /proc/sys/net/ipv4/ip_forward

To power on BT,

 -> hciconfig hci0 up

-> hciconfig hci0 piscan

-> Run bluetoothd with "-ndE"

-> tools/test-nap br0 &

-> bluetoothctl

# agent on

# default agent

# pair <dev_addr>

# trust <dev_addr>

Now initiate NAP connection from remote device (Android device). The
device gets connected to NAP server with below bnep configuration
(without configuring inet). Though it says connected, on Android
device we are unable to ping/browse to internet.

bluetoothd[737]: src/agent.c:agent_ref() 0x9856c90: ref=3

bluetoothd[737]: src/agent.c:agent_unref() 0x9856c90: ref=2

bluetoothd[737]: src/agent.c:agent_unref() 0x9856c90: ref=1

bluetoothd[737]: profiles/network/bnep.c:bnep_getsuppfeat() supported
features: 0x1

bluetoothd[737]: bnep: bridge br0: interface bnep0 added

#ifconfig

bnep0     Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx

          inet6 addr: fe80::7aff:57ff:fe00:a400/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:10 errors:0 dropped:0 overruns:0 frame:0

          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:1000

          RX bytes:1845 (1.8 KiB)  TX bytes:80 (80.0 B)

Even though no ip address assigned dynamically for bnep after
connection, configured static IP, but still not able to browse/ping.

Please provide your input to resolve the issue.

Thanks & Regards
Bheemsen
