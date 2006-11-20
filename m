Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: "BlueZ users " <bluez-users@lists.sourceforge.net>
From: "Philip Barnes" <phil@trig222.f9.co.uk>
Date: Mon, 20 Nov 2006 14:19:00 0000
Mime-Version: 1.0
Message-Id: <20061120142002.D8ED11C0013E@mwinf7009.orange.net>
Subject: Re: [Bluez-users] emulating a GPRS modem with a linux PC
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I use this a lot to connect my palm T2 to the net through my pc. I am currently running fc6, however my config has not changed from fc5.

<pedant>
I suspect you mean use, the linux box as a WAP/router, GPRS is a GSM data protocol.
</pedant>

The relevant parts of my rc.local file are below.

HTH Phil

-- start of rc.local
mknod /dev/rfcomm0 c 216 0
mknod /dev/rfcomm1 c 216 1
/sbin/modprobe rfcomm
#
# Start configuration of Bluetooth network
/usr/sbin/hciconfig hci0 up
/usr/sbin/hcid
/usr/sbin/sdpd
dund --listen --msdun 192.168.1.200:192.168.1.201
echo '1' > /proc/sys/net/ipv4/ip_forward
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/sbin/iptables -A FORWARD -i ppp0 -j ACCEPT
/sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED
#
-- end of rc.local


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
