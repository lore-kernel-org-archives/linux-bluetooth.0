Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
From: Marcel Holtmann <marcel@holtmann.org>
To: EXT-Somil.Asthana@nokia.com
Cc: d.mackie@ru.ac.za, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E320A8529CF07E4C967ECC2F380B0CF90140382A@bsebe001.americas.nokia.com>
References: 
	 <E320A8529CF07E4C967ECC2F380B0CF90140382A@bsebe001.americas.nokia.com>
Content-Type: text/plain
Message-Id: <1086595869.12811.28.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 07 Jun 2004 10:11:09 +0200

Hi Somil,

>   This is getting interesting looks like I am completing my Masters thesi=
s & you are mentoring (or vice versa).=20
>  You don't need a scatterent to connect two piconet. Two piconets (basica=
lly piconet devices) can be connected via an ethernet wire or WLAN AP. I ha=
ve done that its not magic. After connecting we can create an IP infrastruc=
ture make every device IP addressable (that is where I said there can be so=
me IP addressing problem and I am trying to solve & publish it anyway its n=
o concern here). Now the question comes sending SDP records - to know what =
kind of service each piconet device provides etc ?? If we have an IP infras=
tructure then why nt use UPnP protocol we don't need BTH SDP protocol (I gu=
ess UPnP protocol provides more flexibility than SDP (I am nt an expert in =
UPnP)). But if you still want BTH SDP then send SDP records in IP packets (=
not good). (Make IP connections between devices to transfer data etc no nee=
d to make RFCOMM connections run thousands of legacy IP applications withou=
t modifying a single line of code, I am nt able to understand why people ar=
e pushing for RFCOMM etc but nt what we are discussing here).=20

actually I don't think the point here is building the scatternet or
using IP to extend it. We already know that if we use PAN this is
working perfect and with Linux bridging, VLAN and NAT it is possible to
create this in an easy way. I've done this before without Bluetooth so
am not really interested in this way, because it is the same and nothing
really new.

However David mentioned he wants to talk to a phone and right now I
haven't seen any phone with PAN or UPnP. To support legacy devices you
need a distributed SDP database (you must keep it up-to-date) and use
somekind of tunneling for the RFCOMM channels. The RFCOMM tunnel is very
easy to achieve. It is a simple mapping from a TCP stream to a RFCOMM
stream. You can also map it to different channel numbers on each side.
The real problem here is the SDP database. Think about it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
