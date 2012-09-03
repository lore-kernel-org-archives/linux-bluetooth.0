Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v2 15/15] hciemu: Fix build errors due to unaligned memory access
Date: Mon, 3 Sep 2012 08:42:37 +0200
Message-ID: <12472077.AZx2ltQR6g@uw000953>
In-Reply-To: <CAJdJm_NHUsbuWvLwquROhq83+O0vQcv-w=g=CfpCje7rmSDdBA@mail.gmail.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com> <1346416811-23484-16-git-send-email-szymon.janc@tieto.com> <CAJdJm_NHUsbuWvLwquROhq83+O0vQcv-w=g=CfpCje7rmSDdBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 31 of August 2012 18:19:59 Anderson Lizardo wrote:
> Hi  Szymon,

Hi Anderson,

> On Fri, Aug 31, 2012 at 8:40 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > --- a/test/hciemu.c
> > +++ b/test/hciemu.c
> > @@ -426,8 +426,10 @@ static void num_completed_pkts(struct vhci_conn *conn)
> >         np = (void *) ptr; ptr += EVT_NUM_COMP_PKTS_SIZE;
> >         np->num_hndl = 1;
> >
> > -       *((uint16_t *) ptr) = htobs(conn->handle); ptr += 2;
> > -       *((uint16_t *) ptr) = htobs(vdev.acl_cnt); ptr += 2;
> > +       bt_put_be16(conn->handle, ptr);
> > +       ptr += 2;
> > +       bt_put_be16(vdev.acl_cnt, ptr);
> > +       ptr += 2;
> 
> These should be bt_put_le16().

Will fix that in next version.
Thx for spotting this!

> 
> Regards,
> 

-- 
BR
Szymon Janc
