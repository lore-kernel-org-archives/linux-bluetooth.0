Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Setting up an hotplug connection with USB dongles
References: <200411282132.37941.rdorsch@web.de> <1101740700.19573.48.camel@justakiss>
In-Reply-To: <1101740700.19573.48.camel@justakiss>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200412192323.20579.rdorsch@web.de>
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
Date: Sun, 19 Dec 2004 23:23:20 +0100

Hi Erwin,

thanks for that very useful link.

If have everything up an running, only two minor issues left on the PANU side:

1. It seems that I need to do an "hcitool scan" to make pand --search working, 
e.g.

              hcitool scan
              pand --nodetach --role PANU --search --encrypt 
--pidfile /var/run/pand.pid

It does work without hcitool scan, when I use the BT device address

              pand --connect <BT device address>

2. On the client side, I do not get dhcp to work. When I run 

               dhclient bnep0

I see on the PANU (from syslog):

Dec 19 23:07:42 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 5
Dec 19 23:07:42 topsi dhclient: send_packet: Network is down
Dec 19 23:07:47 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 10
Dec 19 23:07:47 topsi dhclient: send_packet: Network is down
Dec 19 23:07:49 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 10
Dec 19 23:07:49 topsi dhclient: send_packet: Network is down
Dec 19 23:07:57 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 14
Dec 19 23:07:57 topsi dhclient: send_packet: Network is down
Dec 19 23:07:59 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 1
Dec 19 23:07:59 topsi dhclient: send_packet: Network is down
Dec 19 23:08:00 topsi dhclient: No DHCPOFFERS received.
Dec 19 23:08:00 topsi dhclient: No working leases in persistent database.
Dec 19 23:08:00 topsi dhclient: Sleeping.
Dec 19 23:08:11 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 14
Dec 19 23:08:11 topsi dhclient: send_packet: Network is down
Dec 19 23:08:25 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 15
Dec 19 23:08:25 topsi dhclient: send_packet: Network is down
Dec 19 23:08:40 topsi dhclient: DHCPDISCOVER on bnep0 to 255.255.255.255 port 
67 interval 3
Dec 19 23:08:40 topsi dhclient: send_packet: Network is down
Dec 19 23:08:43 topsi dhclient: No DHCPOFFERS received.
Dec 19 23:08:43 topsi dhclient: No working leases in persistent database.
Dec 19 23:08:44 topsi dhclient: Sleeping.

There is no entry in the syslog file in the DHCP server (which is NAP). Its 
dhcpd.conf looks like this:

# Bluetooth
subnet 192.168.2.0 netmask 255.255.255.0 {
  range 192.168.2.100 192.168.2.150;
#  option broadcast-address 204.254.239.31;
  option domain-name "vix.com";
  option domain-name-servers 192.168.2.1;
  option broadcast-address 192.168.2.255;
  option routers 192.168.2.1;
}

Any ideas are welcome.

Thanks,
Rainer


Am Montag, 29. November 2004 16:05 schrieb Erwin Authried:
> Hi,
> here is a nice description for Debian:
>
> http://quozl.netrek.org/bluetooth/
>
> the interfaces aren't brought up directly by ifconfig, but by a "dev-up"
> script in /etc/bluetooth/pan. In addition, the "-persist" option for
> pand may be useful to keep the connection up.
>
> -Erwin

-- 
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
