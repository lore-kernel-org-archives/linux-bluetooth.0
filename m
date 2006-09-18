Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6b4e42d10609171924v1bb5d238l597fae8a21641a4d@mail.gmail.com>
Date: Sun, 17 Sep 2006 19:24:39 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
In-Reply-To: <200609172121.36247.dtor@insightbb.com>
MIME-Version: 1.0
References: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
	<200609172121.36247.dtor@insightbb.com>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 9/17/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Sunday 17 September 2006 20:54, Om Narasimhan wrote:
> > --- a/drivers/bluetooth/hci_usb.c
> > +++ b/drivers/bluetooth/hci_usb.c
> > @@ -147,10 +147,9 @@ static struct usb_device_id blacklist_id
> >
> > static struct _urb *_urb_alloc(int isoc, gfp_t gfp)
> > {
> > -struct _urb *_urb = kmalloc(sizeof(struct _urb) +
> > +struct _urb *_urb = kzalloc(sizeof(struct _urb) +
> > sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
> > if (_urb) {
> > -memset(_urb, 0, sizeof(*_urb));
> > usb_init_urb(&_urb->urb);
> > }
> > return _urb;
> >
>
> Note that only beginning if the aloocated memory was zeroed in original
> code; your patch may introduce slowdowns.
Would it? I thought memset() uses block move operation which doesn't
scale linearly.
And, usb_init_urb() calls memset() anyway, so the previously existed
memset() was superfluous.

Thanks for the comment.
Regards,
Om.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
