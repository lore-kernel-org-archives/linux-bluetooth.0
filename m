Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0608281114l3b6a29barfb8c6b29b7197638@mail.gmail.com>
Date: Mon, 28 Aug 2006 15:14:46 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <e4f1f0110608280930l3475b147ob2f7f3e5e6bf5efe@mail.gmail.com>
MIME-Version: 1.0
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
	<e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
	<e4f1f0110608280930l3475b147ob2f7f3e5e6bf5efe@mail.gmail.com>
Subject: Re: [Bluez-users] How do I reset a pairing?
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

On 8/28/06, jonny Linux <jonnylinux@gmail.com> wrote:
>
>
>
> On 8/28/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> > Hi Jonny,
> >
> > You can use the D-Bus services to do remove the link key:
> > $dbus-send --system --type=method_call --print-reply
> --dest=org.bluez/org/bluez/hci0 org.bluez.Adapter.RemoveBonding
> > string:XX:XX:XX:XX:XX:XX
> >
> >
> > or remove the entry in the file:
> > /var/lib/bluetooth/local_bt_address/linkkeys
>
>
>
> Thanks Claudio, I couldn't get that command to work, I got an error:
> Must use org.mydomain.Interface.Method notation, no dot in
> "string:00:16:53:03:1D:31"
> So I removed the entry in the linkkeys file.
>
> The NXT device asks me for a PIN, but the computer doesn't ask for a pin, I
> then get a connection error in the perl script I'm using which says "Invalid
> Exchange".
>
> Below is the results of hcidump -X -a -V:
>
> Any ideas?
>
> Thanks,
>
> Jonny
>
> HCI sniffer - Bluetooth packet analyzer ver 1.30
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:16:53:03:1D:31
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>     bdaddr 00:16:53:03:1D:31
> > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>     status 0x00 bdaddr 00:16:53:03:1D:31
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:16:53:03:1D:31
> < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
>     bdaddr 00:16:53:03:1D:31
> > HCI Event: Command Complete (0x0e) plen 10
>     PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
>     status 0x00 bdaddr 00:16:53:03:1D:31
[Claudio Takahasi]
This "Negative Reply" means that you don't have a passkey agent running.
Try the bluez-gnome passkey agent:
http://www.bluez.org/download.html

BR,
Claudio.


> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x06 handle 11 bdaddr 00:16:53:03:1D:31 type ACL encrypt 0x00
>     Error: PIN or Key Missing
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>     bdaddr 00:16:53:03:1D:31 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:16:53:03:1D:31
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>     bdaddr 00:16:53:03:1D:31
> > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>      status 0x00 bdaddr 00:16:53:03:1D:31
>
>
>
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>


-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
