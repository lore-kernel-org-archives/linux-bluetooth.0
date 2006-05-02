Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0605021103u5641f8f0gcbe172ff78fa7637@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus and two inquiries
In-Reply-To: <4450A0A7.1000504@service2media.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4450A0A7.1000504@service2media.com>
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
Date: Tue, 2 May 2006 15:03:24 -0300

Hi Herman,

If you have two local Bluetooth adapter, it's possible run two
inquiries simultaneously.
You can reproduce sending the inquiry command using dbus-send:
$dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
/org/bluez/hci0 org.bluez.Adapter.DiscoverDevices
$dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
/org/bluez/hci1 org.bluez.Adapter.DiscoverDevices

If you have just one local adapter, the second inquiry request can be
processed after the DiscoveryCompleted signal only.

Regards,
Claudio.

On 4/27/06, Herman Meerlo <herman@service2media.com> wrote:
> Hi all,
>
> I noticed that when I try to perform two inquiries on two different
> devices simultaneously (using DBus), that one of the two will report
> 'Discover already in progress'. Is this by design and if so why?
>
> Regards,
> Herman Meerlo
>
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
