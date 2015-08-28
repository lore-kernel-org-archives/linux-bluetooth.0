Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Aug 2015 10:54:48 +0200 (CEST)
From: Maxime Chevallier <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org
Message-ID: <1926580325.138210.1440752088084.JavaMail.zimbra@openwide.fr>
Subject: Bluez 5.31 PAN cannot setup GN master role
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

I currently have to test PAN on an embedded linux platform, running 
linux 3.10.17, bluez5.31 with a marvell 8887 chip.

Please forgive my mistakes, I am not a native english speaker.

My goal is to successfully setup a PAN network with NAP and GN roles 
with my board as a master. I successfully setup a NAP using the test-nap
script given as an example, having setup a bridge manually beforehand, 
but I cannot manage to setup a GN network.

After having a look at the API, it seems to me that setting-up a GN role
should be very similar to NAP, so I made a test-gn script from test-nap,
only changing the 'UUID' parameter from 'nap' to 'gn'. 
Unfortunately, this does not work, I get a 'connection refused(111)' 
error upon trying to join the network.

I can see the 'GN' record correctly added to the SDP server.

Currently, what I am doing is : 

# Setup the bridge

brctl addbr bnep0
brctl setfd bnep0 0
brctl stp bnep0 off
ip addr add 192.168.0.1/24 dev bnep0
ip link set bnep0 up

dnsmasq --interface=bnep0 --except-interface=lo --bind-interfaces --dhcp-range=192.168.0.2,192.168.0.10,12h --conf-file=/dev/null

# launch GN server

/usr/lib/bluez/test/test-gn

which gives me :
Server for gn registered for bnep0
Press CTRL-C to disconnect

And then try to connect from my laptop, running ubuntu 15.04, 
with bluez 4.101 :

pand --connect 98:F1:70:6E:90:BC

which outputs in logs :

Bluetooth PAN daemon version 4.101
Connecting to 98:F1:70:6E:90:BC
Connect to 98:F1:70:6E:90:BC failed. Connection refused(111)

After quite some time researching on the web, I struggle to find relevant
informations to help me solve this, the vast majority of resources 
recommend using 'pand', which is not available anymore.

I might be taking the wrong approach here, but currently I can see no 
other way of setting-up a GN master, since it is impossible with
raw dbus-send, and utils like connman does not allow me to register a GN
server ( though using NAP with 'connmanctl tether bluetooth on' 
works fine ).

I made sure that the correct bluetooth.conf dbus policy file was used.

I would be very grateful if someone would point me to the right direction,
I think that I came to a dead-end trying to solve this with my own skills.

Thank you for your time,

Maxime Chevallier
