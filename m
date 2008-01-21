Return-Path: <cyrus@holtmann.org>
Subject: Bluez-devel post from hidave.darkstar@gmail.com requires approval
From: bluez-devel-owner@lists.sourceforge.net
To: bluez-devel-owner@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530068705=="
Message-ID: <mailman.440294.1200885345.26582.bluez-devel@lists.sourceforge.net>
Date: Sun, 20 Jan 2008 19:15:45 -0800
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
Sender: sitelist-bounces@lists.sourceforge.net
Errors-To: sitelist-bounces@lists.sourceforge.net

--===============0530068705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

As list administrator, your authorization is requested for the
following mailing list posting:

    List:    Bluez-devel@lists.sourceforge.net
    From:    hidave.darkstar@gmail.com
    Subject: Re: [Bluez-devel] Oops involving RFCOMM and sysfs
    Reason:  Too many recipients to the message

At your convenience, visit:

    https://lists.sourceforge.net/lists/admindb/bluez-devel
        
to approve or deny the request.

--===============0530068705==
Content-Type: message/rfc822
MIME-Version: 1.0

Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list2-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JGn8S-0004OU-0p
	for bluez-devel@lists.sourceforge.net; Sun, 20 Jan 2008 19:15:44 -0800
Received: from wx-out-0506.google.com ([66.249.82.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JGn8W-0007DF-Cc
	for bluez-devel@lists.sourceforge.net; Sun, 20 Jan 2008 19:15:50 -0800
Received: by wx-out-0506.google.com with SMTP id s11so946779wxc.17
	for <bluez-devel@lists.sf.net>; Sun, 20 Jan 2008 19:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=/r4o9lhcSvjajIPpEQXiin4eUhdYY8/nDodkb4V/+Tw=;
	b=nlDfTb5mublMq3asSIC2qmGBZX8n3/+/6mnKlwXLoyzxADAnF1weWDE1x6ZFFcIatyCEKlNvLWtHdXbeG9mGTbxjqGP0ybOaY0ywZIhGHuinzfNQnP2f5JLUpzRUyt0Jiqzvy6TRyQdaaKMcCP+z+rMnuhgWg+PKAHYtUbqBfKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	b=lUN4j427/q/e41Hqj+18JxLWAz0j9gILPCgVW88HN/M88eVLL8tnljRsDKLTHDinm7rQIdD30Yq4GjN6ULGLaKx0RNhr/wdKaUcCDLxQOIDDybALiXvsl8Dz0BX8KfXTq+U5N/f8fLun1k5KKfO2+u0W0Jk1mZTIzJYer1EVglE=
Received: by 10.150.196.5 with SMTP id t5mr2087029ybf.40.1200885347526;
	Sun, 20 Jan 2008 19:15:47 -0800 (PST)
Received: by 10.150.182.9 with HTTP; Sun, 20 Jan 2008 19:15:47 -0800 (PST)
Message-ID: <a8e1da0801201915m5608ec7bnda31bd1db898f7e4@mail.gmail.com>
Date: Mon, 21 Jan 2008 11:15:47 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "Cornelia Huck" <cornelia.huck@de.ibm.com>
Subject: Re: [Bluez-devel] Oops involving RFCOMM and sysfs
Cc: "Gabor Gombas" <gombasg@sztaki.hu>, "Tejun Heo" <htejun@gmail.com>,
	"Al Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	bluez-devel@lists.sf.net, kay.sievers@vrfy.org,
	"Greg KH" <greg@kroah.com>, "Marcel Holtmann" <marcel@holtmann.org>,
	davem@davemloft.net
In-Reply-To: <20080118122625.370e2fba@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080108133215.GA15814@boogie.lpds.sztaki.hu>
	<20080116230646.GB6715@boogie.lpds.sztaki.hu>
	<a8e1da0801162324r2cd82684iede3fc8c2f8c391c@mail.gmail.com>
	<20080117081504.GA3123@darkstar.te-china.tietoenator.com>
	<20080117124259.19a88129@gondolin.boeblingen.de.ibm.com>
	<a8e1da0801171937r92a1c32l116315a76f334776@mail.gmail.com>
	<20080118101933.258bfae9@gondolin.boeblingen.de.ibm.com>
	<20080118112337.0b457c49@gondolin.boeblingen.de.ibm.com>
	<a8e1da0801180234k4b48fd1axaba6d7d334219430@mail.gmail.com>
	<20080118122625.370e2fba@gondolin.boeblingen.de.ibm.com>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001
	0.0 RCVD_BY_IP             Received by mail server with no name

On Jan 18, 2008 7:26 PM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Fri, 18 Jan 2008 18:34:55 +0800,
> "Dave Young" <hidave.darkstar@gmail.com> wrote:
>
>
> > On Jan 18, 2008 6:23 PM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > > On Fri, 18 Jan 2008 10:19:33 +0100,
> > > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > >
> > > > >
> > > > > 1314         if (IS_ERR(new_parent_kobj)) {
> > > > > 1315                 error = PTR_ERR(new_parent_kobj);
> > > > > 1316                 put_device(new_parent);
> > > > > 1317                 goto out;
> > > > > 1318         }
> > > > > 1319         pr_debug("DEVICE: moving '%s' to '%s'\n", dev->bus_id,
> > > > > 1320                  new_parent ? new_parent->bus_id : "<NULL>");
> > > > > 1321         error = kobject_move(&dev->kobj, new_parent_kobj);
> > > > > 1322         if (error) {
> > > > > 1323                 put_device(new_parent);
> > > > >
> > > > > imagine new_parent is NULL, then the new_parent_kobj should be put
> > > >
> > > > No, we would need a put_device_parent() (crappy name) which puts the
> > > > reference iff get_device_parent() grabbed it.
> > >
> > > And looking at Greg's patchset, it has cleanup_device_parent(), which
> > > does just that. But it is only called in device_del(), not when
> > > device_move() has errors.
> > >
> > > (get_device_parent() also always returns a pointer to a kobject or
> > > NULL, so we can get rid of those IS_ERR() checks in setup_parent() and
> > > device_move() as well.)
> > >
> >
> > Hmm, thanks.
> > I will be offline during weekend,  but I will still check the
> > device_move and other code if I have time.
>
> Just hacked together the following against Greg's tree:
>
> COMPLETELY UNTESTED DO NOT APPLY
>
> ---
>  drivers/base/core.c |   33 ++++++++++++++++-----------------
>  1 files changed, 16 insertions(+), 17 deletions(-)
>
> --- linux-2.6.orig/drivers/base/core.c
> +++ linux-2.6/drivers/base/core.c
> @@ -553,6 +553,8 @@ static struct kobject *get_device_parent
>  }
>
>  static inline void cleanup_device_parent(struct device *dev) {}
> +static inline void cleanup_glue_dir(struct device *dev,
> +                                   struct kobject *kobj) {}
>  #else
>  static struct kobject *virtual_device_parent(struct device *dev)
>  {
> @@ -617,27 +619,27 @@ static struct kobject *get_device_parent
>         return NULL;
>  }
>
> -static void cleanup_device_parent(struct device *dev)
> +static void cleanup_glue_dir(struct device *dev, struct kobject *kobj)
>  {
> -       struct kobject *glue_dir = dev->kobj.parent;
> -
>         /* see if we live in a "glue" directory */
> -       if (!dev->class || glue_dir->kset != &dev->class->class_dirs)
> +       if (!dev->class || kobj->kset != &dev->class->class_dirs)
>                 return;
>
> -       kobject_put(glue_dir);
> +       kobject_put(kobj);
> +}
> +
> +static void cleanup_device_parent(struct device *dev)
> +{
> +       cleanup_glue_dir(dev, dev->kobj.parent);
>  }
>  #endif
>
> -static int setup_parent(struct device *dev, struct device *parent)
> +static void setup_parent(struct device *dev, struct device *parent)
>  {
>         struct kobject *kobj;
>         kobj = get_device_parent(dev, parent);
> -       if (IS_ERR(kobj))
> -               return PTR_ERR(kobj);
>         if (kobj)
>                 dev->kobj.parent = kobj;
> -       return 0;
>  }
>
>  static int device_add_class_symlinks(struct device *dev)
> @@ -782,9 +784,7 @@ int device_add(struct device *dev)
>         pr_debug("device: '%s': %s\n", dev->bus_id, __FUNCTION__);
>
>         parent = get_device(dev->parent);
> -       error = setup_parent(dev, parent);
> -       if (error)
> -               goto Error;
> +       setup_parent(dev, parent);
>
>         /* first, register with generic layer. */
>         error = kobject_add(&dev->kobj, dev->kobj.parent, "%s", dev->bus_id);
> @@ -862,6 +862,7 @@ int device_add(struct device *dev)
>         kobject_uevent(&dev->kobj, KOBJ_REMOVE);
>         kobject_del(&dev->kobj);
>   Error:
> +       cleanup_device_parent(dev);
>         if (parent)
>                 put_device(parent);
>         goto Done;
> @@ -1303,15 +1304,12 @@ int device_move(struct device *dev, stru
>
>         new_parent = get_device(new_parent);
>         new_parent_kobj = get_device_parent (dev, new_parent);
> -       if (IS_ERR(new_parent_kobj)) {
> -               error = PTR_ERR(new_parent_kobj);
> -               put_device(new_parent);
> -               goto out;
> -       }
> +
>         pr_debug("device: '%s': %s: moving to '%s'\n", dev->bus_id,
>                  __FUNCTION__, new_parent ? new_parent->bus_id : "<NULL>");
>         error = kobject_move(&dev->kobj, new_parent_kobj);
>         if (error) {
> +               cleanup_glue_dir(dev, new_parent_kobj);
>                 put_device(new_parent);
>                 goto out;
>         }
> @@ -1334,6 +1332,7 @@ int device_move(struct device *dev, stru
>                                 klist_add_tail(&dev->knode_parent,
>                                                &old_parent->klist_children);
>                 }
> +               cleanup_glue_dir(dev, new_parent_kobj);
>                 put_device(new_parent);
>                 goto out;
>         }
>

Looks good.


--===============0530068705==
Content-Type: message/rfc822
MIME-Version: 1.0

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: confirm 09e5e391c27bf6449154333347c02ba14ce68034
Sender: bluez-devel-request@lists.sourceforge.net
From: bluez-devel-request@lists.sourceforge.net

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
--===============0530068705==--
