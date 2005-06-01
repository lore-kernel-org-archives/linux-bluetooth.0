Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Gabor Fekete <feketga@delfin.unideb.hu>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200506011659.08000.feketga@delfin.unideb.hu>
Subject: [Bluez-devel] IPv6 stateless address autoconf on bnep iface in down state
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 1 Jun 2005 16:59:07 +0300

Hi,

I have a problem with bnepX interfaces.
I use stateless address autoconfiguration to set up the address
on a bnep0 interface. It works fine.
But when I 'ip link set bnep0 down' then after seeing the routes
and ip addresses of bnep0 disappear, they appear again.
That is, ip addresses and routes are created for bnep interfaces
even if they are down.
After putting the interface down
o the global ip address appears in 'ip -6 addr' for bnep0
o the link-local address does NOT appear
o the prefix routes appear for bnep0 in 'ip -6 route'
o the default route for bnep0 appears in 'ip -6 route'
This happens only for bnep interfaces. For wired and
WLAN interfaces, the addresses and routes disappear as they should
and never come back unless the interface is put "up" again.

Is this the normal behaviour for bnep interfaces or a bug?
This behavious causes a problem for example MIPL2 (MIPv6).

Thanks,
Gabor Fekete


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
