Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
Date: Mon, 28 Aug 2006 09:17:36 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
MIME-Version: 1.0
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
	<e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
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

Hi Jonny,

You can use the D-Bus services to do remove the link key:
$dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez/hci0 org.bluez.Adapter.RemoveBonding
string:XX:XX:XX:XX:XX:XX


or remove the entry in the file:
/var/lib/bluetooth/local_bt_address/linkkeys


Send us the hcidump(hcidump -X -a -V) if you still having problems.

BR,
Claudio.


On 8/27/06, jonny Linux <jonnylinux@gmail.com> wrote:
>
>
> >
> > If I try to connect from the laptop I get no problems connecting. But if I
> try to connect from the desktop I get a "Permission denied error", or if I
> try "hcitool cc <ba>" I get "Can't create connection: Input/output error".
> >
> > I don't get asked for a pin when I connect from the desktop, but I think I
> was once asked for a pin. So I think somehow the pairing between the devices
> has been broken. Is there anyway I can reset the pairing between the desktop
> and the NXT?
>
>
>
> Hi,
>
> Sorry to reply to my own post, but I'm still having problems with this and
> I'd really like to get it working. I've tried using hciconfig delkey, but
> nothing seems to happen. Is delkey the command I should be trying to use?
> Which address should I give as a parameter to delkey, should it be the
> address of the bluetooth device I'm trying to connect to (the NXT) or the
> local bluetooth device (the USB dongle plugged into the computer)?
>
> Whenever I try to use "hciconfig delkey" there is no output, and it always
> exits with exit code 0. Is there any way to make it ask me which pin I want
> to use with the device?
>
> Thanks,
>
> Jonny
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
