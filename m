Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Oct 2013 13:09:34 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] android: Cleanup error handling
Message-ID: <20131025100933.GE6113@aemeltch-MOBL1>
References: <1382690606-20721-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZK4B5_3wP3Og=XWgohDV0UmdqZnBro-1Onv5gtJViNgKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZK4B5_3wP3Og=XWgohDV0UmdqZnBro-1Onv5gtJViNgKw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 25, 2013 at 12:26:12PM +0300, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Fri, Oct 25, 2013 at 11:43 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Remove unneeded assignment err=errno and instead use errno directly.
> > ---
> >  android/hal-ipc.c |   26 ++++++++++----------------
> >  1 file changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/android/hal-ipc.c b/android/hal-ipc.c
> > index 6566ebb..20421db 100644
> > --- a/android/hal-ipc.c
> > +++ b/android/hal-ipc.c
> > @@ -150,9 +150,8 @@ static int accept_connection(int sk)
> >
> >         err = poll(&pfd, 1, CONNECT_TIMEOUT);
> >         if (err < 0) {
> > -               err = errno;
> > -               error("Failed to poll: %d (%s)", err, strerror(err));
> > -               return -1;
> > +               error("Failed to poll: %d (%s)", errno, strerror(errno));
> > +               return err;
> >         }
> >
> >         if (err == 0) {
> > @@ -161,11 +160,9 @@ static int accept_connection(int sk)
> >         }
> >
> >         new_sk = accept(sk, NULL, NULL);
> > -       if (new_sk < 0) {
> > -               err = errno;
> > -               error("Failed to accept socket: %d (%s)", err, strerror(err));
> > -               return -1;
> > -       }
> > +       if (new_sk < 0)
> > +               error("Failed to accept socket: %d (%s)", errno,
> > +                                                       strerror(errno));
> >
> >         return new_sk;
> >  }
> > @@ -178,9 +175,8 @@ bool hal_ipc_init(void)
> >
> >         sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
> >         if (sk < 0) {
> > -               err = errno;
> > -               error("Failed to create socket: %d (%s)", err,
> > -                                                       strerror(err));
> > +               error("Failed to create socket: %d (%s)", errno,
> > +                                                       strerror(errno));
> >                 return false;
> >         }
> >
> > @@ -190,16 +186,14 @@ bool hal_ipc_init(void)
> >         memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
> >
> >         if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> > -               err = errno;
> > -               error("Failed to bind socket: %d (%s)", err, strerror(err));
> > +               error("Failed to bind socket: %d (%s)", errno, strerror(errno));
> >                 close(sk);
> >                 return false;
> >         }
> >
> >         if (listen(sk, 2) < 0) {
> > -               err = errno;
> > -               error("Failed to listen on socket: %d (%s)", err,
> > -                                                               strerror(err));
> > +               error("Failed to listen on socket: %d (%s)", errno,
> > +                                                       strerror(errno));
> >                 close(sk);
> >                 return false;
> >         }
> > --
> > 1.7.10.4
> 
> Since the HAL is running multiple threads Im afraid errno can be
> overwritten and at least strerror_r should be used instead or use %m
> that afaik should be thread safe.

I will check does bionic supports %m %d and send the path

Best regards 
Andrei Emeltchenko 
