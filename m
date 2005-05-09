Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Guillermo Menguez Alvarez <phestar@usuarios.retecal.es>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050509115206.7c304470@casa.milicia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Some doubts about dund
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 9 May 2005 11:52:06 +0200

Hi, 

I'm trying to get internet on a sony ericsson k700 through bluetooth
using dund (has anybody done it? There are a lot of tutorials on the
net about doing it with the P800 and P900, but those phones seem to
initiate the conection to the pc by themselves), and I have some doubts
about dund. I hope you could help me.

1. Is pppd started just after dund starts or when dund receives an
incoming connection?. I'm using:

# /usr/bin/dund --nodetach --listen --msdun --persist --channel 3 call
dun 
dund[28659]: Bluetooth DUN daemon version 2.16

And that's all I get, no message about pppX <> rfcommX or anything else,
and pppd is not started.

2. Should I start pppd by hand using /dev/rfcomm0 (it's the one I'm
using) then?

3. Do I have to connect previosly rfcomm0? I currently have it binded
to my phone bluetooth address, this way:

$ rfcomm
rfcomm0: 00:0F:DE:C2:D2:50 channel 2 clean

But I can also release the device and use rfcomm connect (I've tried it
and that way I can send AT commands through /dev/rfcomm0 and the mobile
does things).

Thanks in advance, and excuse me for my horrible English.

Note: channel 2 is serial port 1 on the phone, channel 3 is local
serial port on my pc, added with sdptool add --channel=3 SP before
calling dund, and 00:0F:DE:C2:D2:50 is the bt adress of the phone.

Config files follow:

$ cat /etc/bluetooth/rfcomm.conf
rfcomm0 {
        # Automatically bind the device at startup
        bind yes;

        # Bluetooth address of the device
        #device 11:22:33:44:55:66;
        device 00:0F:DE:C2:D2:50;

        # RFCOMM channel for the connection
        channel 2;

        # Description of the connection
        comment "Acceso Por Bluetooth";
}

$ cat /etc/ppp/peers/dun
noauth
crtscts
lock
proxyarp
passive
ipcp-accept-local
ipcp-accept-remote
ms-dns 127.0.0.1 # I have a dns-cache, so 127.0.0.1 is correct
192.168.1.1:192.168.1.2


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
