Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0605161138g5f1bcab4p6440e191cb7a6c84@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ management through DBus
In-Reply-To: <446A0F06.3030009@palmsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <446A0F06.3030009@palmsource.com>
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
Date: Tue, 16 May 2006 15:38:18 -0300

Hi Fred,

If you have access through a developer account, checkout the latest
version. The anonymous CVS is NOT updated. The core(Adapter and
Manager) interface is working fine, it is almost stable :).
Currently, we are implementing SDP and RFCOMM services.

Read the API description hcid/dbus-api.txt to get more information
about the provided services. There is a D-Bus client for test
available at:
http://extindt01.indt.org/connectivity/bluez/gbluezconf-00.24.tar.gz

Regarding the release, only Marcel can answer :)

Regards,
Claudio.
--=20
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


On 5/16/06, Frederic Danis <frederic.danis@palmsource.com> wrote:
> Hello,
>
> I took a look to the new management interface through DBus in cvs. It
> brings a lot of interesting stuff : do you have any idea when this will
> be released ?
>
> Thanks
>
> Fred
>
> --
> -----------------------------------------------
> It is not by improving the oil lamp that one invents the electric bulb!
> -----------------------------------------------
> Danis Frederic            PalmSource Europe
> Software engineer
> Mail : mailto:frederic.danis@palmsource.com
> -----------------------------------------------
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


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
