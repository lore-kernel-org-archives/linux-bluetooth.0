Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 13:33:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/3] shared: Remove static address assignment in
 hciemu
Message-ID: <20130430103332.GB11268@x220.ger.corp.intel.com>
References: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
 <1365693884-15423-3-git-send-email-jefferson.delfes@openbossa.org>
 <CAJdJm_My7fTEfmaUteynUyT5WvxNviPctO8yASR8H86R=fKBjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_My7fTEfmaUteynUyT5WvxNviPctO8yASR8H86R=fKBjA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Apr 11, 2013, Anderson Lizardo wrote:
> On Thu, Apr 11, 2013 at 11:24 AM, Jefferson Delfes
> <jefferson.delfes@openbossa.org> wrote:
> > diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
> > index 60a4f47..8cd6548 100644
> > --- a/src/shared/hciemu.c
> > +++ b/src/shared/hciemu.c
> > @@ -192,20 +192,12 @@ static guint create_source_btdev(int fd, struct btdev *btdev)
> >  static bool create_vhci(struct hciemu *hciemu)
> >  {
> >         struct btdev *btdev;
> > -       uint8_t bdaddr[6];
> > -       const char *str;
> > -       int fd, i;
> > +       int fd;
> >
> >         btdev = btdev_create(hciemu->btdev_type, 0x00);
> >         if (!btdev)
> >                 return false;
> >
> > -       str = hciemu_get_address(hciemu);
> > -
> > -       for (i = 5; i >= 0; i--, str += 3)
> > -               bdaddr[i] = strtol(str, NULL, 16);
> > -
> > -       btdev_set_bdaddr(btdev, bdaddr);
> 
> Looks like you can remove btdev_set_bdaddr() (in a patch after this
> one) because it was the only user of this function.

Yep. I already went ahead and pushed such a patch upstream.

Johan
