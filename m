Return-Path: <pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060519204815.GA8424@esaurito.net>
References: <20060519204815.GA8424@esaurito.net>
Content-Type: text/plain
Date: Mon, 29 May 2006 15:16:21 +0200
Message-Id: <1148908581.31689.35.camel@localhost>
Mime-Version: 1.0
Cc: 322732-submitter@bugs.debian.org, 322732@bugs.debian.org,
        bluez-devel@lists.sf.net, control@bugs.debian.org
Subject: [Pkg-bluetooth-maintainers] Bug#322732: [Bluez-devel] more on this
	bug (was: rfcomm bind fails with obscure error message)
Reply-To: Marcel Holtmann <marcel@holtmann.org>, 322732@bugs.debian.org
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-bluetooth-maintainers>
List-Post: <mailto:pkg-bluetooth-maintainers@lists.alioth.debian.org>
List-Help: <mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=subscribe>
Sender: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
Errors-To: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Filippo,

> > When the 'rfcomm' kernel module isn't compiled with CONFIG_BT_RFCOMM_TTY
> > enabled, 'rfcomm bind' will fail with an obscure error message, "Can't
> > create device: Operation not supported".  It does this when it's trying to
> > bind to a device in /dev.
> > 
> > Could this be changed to report something more useful, such as "Check
> > rfcomm.ko is compiled with TTY support"?
> 
> Hi,
> I agree with this bug and the ioctl is mostly likely to fail when there is no
> rfcomm tty support, here is my proposed patch:
> 
> --- rfcomm/main.c       (revision 154)
> +++ rfcomm/main.c       (working copy)
> @@ -172,8 +172,10 @@
>                         req.channel = 1;
>         }
> 
> -       if ((err = ioctl(ctl, RFCOMMCREATEDEV, &req)) < 0 )
> +       if ((err = ioctl(ctl, RFCOMMCREATEDEV, &req)) < 0 ){
>                 perror("Can't create device");
> +               fprintf(stderr, "Check RFCOMM TTY availabily");
> +    }
> 
>         return err;
>  }
> 
> comments? 

check for EOPNOTSUPP error code and only then print this error.

Regards

Marcel




_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers
