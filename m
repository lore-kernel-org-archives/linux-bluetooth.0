Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0604100502v165e6d29g32480d6115d51090@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Device temporary discoverable
In-Reply-To: <ef9938ec0604071315t3043c95cy9f72231bf2daa7c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <000001c65a72$b5321e10$052a650a@virgo.atlantico.net.br>
	 <ef9938ec0604071315t3043c95cy9f72231bf2daa7c6@mail.gmail.com>
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
Date: Mon, 10 Apr 2006 09:02:48 -0300

Hi Renan,

Now, there is D-Bus method available.
Try:

dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
/org/bluez/Adapter/hci0 org.bluez.Adapter.SetDiscoverableTimeout
uint32:60000

Setting to discoverable mode: Discoverable and connectable
dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
/org/bluez/Adapter/hci0 org.bluez.Adapter.SetMode string:discoverable

*** After x seconds the daemon is automatically sends the HCI command
to change the discoverable mode to connectable only. If you want
change to other mode again try the following  commands:

Setting to discoverable mode: Connectable only
dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
/org/bluez/Adapter/hci0 org.bluez.Adapter.SetMode string:connectable


Setting to discoverable mode: invible/off
dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.bluez
/org/bluez/Adapter/hci0 org.bluez.Adapter.SetMode string:off


For more information about BlueZ D-Bus API read the documentation:
hcid/dbus-api.txt


Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


On 4/7/06, Albert Huang <ashuang@gmail.com> wrote:
> see hciconfig
>
> -albert
>
>
> On 4/7/06, Renan <renan@atlantico.com.br> wrote:
> >
> >
> >
> >
> > Hello Everyone !
> >
> >
> >
> > How to make a device temporary discoverable under Linux?
> >
> > I would like to make a device discoverable just for 1 minute, for examp=
le.
> >
> >
> >
> > Thanks in advance.
> >
> >
> >
> > Renan Martins
> >
> >
>
>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
