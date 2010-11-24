Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Nov 2010 17:10:25 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management
 interface callbacks
Message-ID: <20101124191025.GA2592@vigoh>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
 <1290609575-28435-3-git-send-email-johan.hedberg@gmail.com>
 <AANLkTimFz=FRPiGT31xt9wMjWoxC5cuKBubEqYNT0s=5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimFz=FRPiGT31xt9wMjWoxC5cuKBubEqYNT0s=5@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2010-11-24 11:38:22 -0400]:

> Hi Johan,
> 
> On Wed, Nov 24, 2010 at 10:39 AM,  <johan.hedberg@gmail.com> wrote:
> >  static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
> >  {
> > -       struct sockaddr_hci *haddr = (struct sockaddr_hci *) addr;
> > +       struct sockaddr_hci haddr;
> 
> Just out of curiosity: why is this change necessary (i.e. make a stack
> copy of addr data and use it instead of using a cast of addr)?
> 
> >        struct sock *sk = sock->sk;
> >        struct hci_dev *hdev = NULL;
> > -       int err = 0;
> > +       int len, err = 0;
> >
> >        BT_DBG("sock %p sk %p", sock, sk);
> >
> > -       if (!haddr || haddr->hci_family != AF_BLUETOOTH)
> > +       if (!addr)
> > +               return -EINVAL;
> > +
> > +       memset(&haddr, 0, sizeof(haddr));
> > +       len = min_t(unsigned int, sizeof(haddr), addr_len);
> > +       memcpy(&haddr, addr, len);
> 
> Looks like you are playing safe here, but looking at least a few
> ->bind() implementations I see most just cast the original struct
> sockaddr, which is has size (sizeof(unsigned short) + 14).

Older userspace versions can use smaller struct sockaddr, so it's a
better idea move to th stack and zero-filling the the struct before the
copy the data, this way if the size of the data copied is smaller than
the struct, the fields in the end of the struct will be filled with
zeros and not something stranger.

-- 
Gustavo F. Padovan
http://profusion.mobi
