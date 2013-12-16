Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Dec 2013 12:50:19 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/5] l2cap-tester: Remove unneeded variable
Message-ID: <20131216105014.GB17473@aemeltch-MOBL1>
References: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1387184262-21439-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAJdJm_NJCUAeMkvGMYLah3L__DECCd_ocPyd-F46KrcdmCuGMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_NJCUAeMkvGMYLah3L__DECCd_ocPyd-F46KrcdmCuGMg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Mon, Dec 16, 2013 at 06:39:28AM -0400, Anderson Lizardo wrote:
> Hi Andrei,
> 
> On Mon, Dec 16, 2013 at 4:57 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > --- a/tools/l2cap-tester.c
> > +++ b/tools/l2cap-tester.c
> > @@ -489,15 +489,14 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm)
> >  {
> >         const uint8_t *master_bdaddr;
> >         struct sockaddr_l2 addr;
> > -       int sk, err;
> > +       int sk;
> >
> >         sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,
> >                                                         BTPROTO_L2CAP);
> >         if (sk < 0) {
> > -               err = -errno;
> >                 tester_warn("Can't create socket: %s (%d)", strerror(errno),
> >                                                                         errno);
> > -               return err;
> > +               return -errno;
> >         }
> >
> >         master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
> > @@ -517,11 +516,10 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm)
> >                 addr.l2_bdaddr_type = BDADDR_BREDR;
> >
> >         if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> > -               err = -errno;
> >                 tester_warn("Can't bind socket: %s (%d)", strerror(errno),
> >                                                                         errno);
> >                 close(sk);
> > -               return err;
> > +               return -errno;
> 
> This is not a good idea because close() will overwrite the original
> error if it fails as well. The previous situation is also valid
> because tester_warn() may call library functions that set errno.

Yes, though the return value is not used at all, we may just return -1.

Best regards 
Andrei Emeltchenko 

