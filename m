Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Philip Barnes <phil@trig222.f9.co.uk>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1100803683.7164.74.camel@pegasus>
References: <cnhnd6$toe$1@sea.gmane.org>  <1100769119.7164.17.camel@pegasus>
	 <1100798738.3439.4.camel@localhost.localdomain>
	 <1100803683.7164.74.camel@pegasus>
Content-Type: text/plain
Message-Id: <1100808919.3433.12.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Bluez-sdp depreciated? Was Which fedora core?
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
Date: Thu, 18 Nov 2004 20:15:19 +0000

On Thu, 2004-11-18 at 19:48 +0100, Marcel Holtmann wrote:
> no it is not, because bluez-sdp and bluez-pan are deprecated.
> 
I have been connecting my Palm T2 to my network using bluez to create a
kind of dial-up network via bluetooth using bluez.

Below is my configuration script taken from core 2.

#
# Start configuration of Bluetooth network
hciconfig hci0 up
hcid
modprobe rfcomm
dund --listen --msdun --channel 1 10.2.0.1:10.2.0.10
echo '1' > /proc/sys/net/ipv4/ip_forward
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/sbin/iptables -A FORWARD -i ppp0 -j ACCEPT
/sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

Bluez-sdp appears to be fundamental to its operation. All is ok until I
reach dund, that line returns:-
dund: error while loading shared libraries: libsdp.so.2: cannot open
shared object file: No such file or directory

This is without installing bluez-sdp from core 2, if it is installed I
get an sdp error in the system logs at this line.

I have looked through the bluez site and searched google but cannot find
any explanation of why it has been depreciated, or what has replaced it.

Any pointers will be appreciated.

Thanks Phil




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
