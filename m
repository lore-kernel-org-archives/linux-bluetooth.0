Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Dmitry Torokhov <dtor@insightbb.com>
To: Om Narasimhan <om.turyx@gmail.com>
Date: Sun, 17 Sep 2006 21:21:33 -0400
References: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
In-Reply-To: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200609172121.36247.dtor@insightbb.com>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] bluetooth drivers : kmalloc to kzalloc conversion
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sunday 17 September 2006 20:54, Om Narasimhan wrote:
> --- a/drivers/bluetooth/hci_usb.c
> +++ b/drivers/bluetooth/hci_usb.c
> @@ -147,10 +147,9 @@ static struct usb_device_id blacklist_id
> =

> =A0static struct _urb *_urb_alloc(int isoc, gfp_t gfp)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0struct _urb *_urb =3D kmalloc(sizeof(struct _urb) +
> +=A0=A0=A0=A0=A0=A0=A0struct _urb *_urb =3D kzalloc(sizeof(struct _urb) +
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0sizeof(struct usb_iso_packet_descriptor) * isoc, gf=
p);
> =A0=A0=A0=A0=A0=A0=A0=A0if (_urb) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0memset(_urb, 0, sizeof(*_ur=
b));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usb_init_urb(&_urb->urb);
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0return _urb;
> =


Note that only beginning if the aloocated memory was zeroed in original
code; your patch may introduce slowdowns.

-- =

Dmitry
-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
