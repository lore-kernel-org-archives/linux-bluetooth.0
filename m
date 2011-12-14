Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Dec 2011 13:35:57 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] Add support for getting the Encryption Key
 Size via btio
Message-ID: <20111214163557.GA17841@samus>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
 <CABBYNZJzb6nSbq6JpKOn3HxcaYvLSw0JWzzHQsYh+DtfFfb+7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZJzb6nSbq6JpKOn3HxcaYvLSw0JWzzHQsYh+DtfFfb+7w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 14:09 Wed 14 Dec, Luiz Augusto von Dentz wrote:
> Hi Vinicius,
> 
> On Wed, Dec 14, 2011 at 1:57 AM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > +static gboolean get_key_size(int sock, BtIOType type, int *size,
> > +                                                               GError **err)
> > +{
> > +       struct bt_security sec;
> > +       socklen_t len;
> > +
> > +       memset(&sec, 0, sizeof(sec));
> > +       len = sizeof(sec);
> > +       if (getsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) == 0) {
> > +               *size = sec.key_size;
> > +               return TRUE;
> > +       }
> > +
> > +       return FALSE;
> > +}
> 
> It doesn't seems that the type is used for anything here, so you can
> probably removed it.

True. I will fix it.

> 
> -- 
> Luiz Augusto von Dentz


Cheers,
-- 
Vinicius
