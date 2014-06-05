Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jun 2014 14:53:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: bharat panda <bharat22bhusan@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Bharat Panda <bharat.panda@samsung.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH ] profiles: Fix crash due to NULL pointer access
Message-ID: <20140605115322.GA18816@t440s.lan>
References: <1401966105-31223-1-git-send-email-bharat.panda@samsung.com>
 <0DD74990-7D04-4415-810D-3D75B073742A@holtmann.org>
 <CANBo3n89N56u8NCpd52EoEZSPxDmZjN9_GxHjSXVnT_V=5BO2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANBo3n89N56u8NCpd52EoEZSPxDmZjN9_GxHjSXVnT_V=5BO2A@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, Jun 05, 2014, bharat panda wrote:
> >> NULL pointer check is added after memory allocation
> >> to prevent core dump due to NULL pointer access.
> >>
> >> Signed-off-by: Bharat Panda <bharat.panda@samsung.com>
> >> ---
> >> profiles/audio/a2dp.c  |    8 ++++++++
> >> profiles/audio/avctp.c |    4 ++++
> >> profiles/audio/avdtp.c |   16 ++++++++++++++++
> >> profiles/health/hdp.c  |    4 +++-
> >> profiles/health/mcap.c |    2 ++
> >> 5 files changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> >> index c9dac9a..580cb60 100644
> >> --- a/profiles/audio/a2dp.c
> >> +++ b/profiles/audio/a2dp.c
> >> @@ -523,6 +523,8 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
> >>                                                       a2dp_sep->user_data);
> >>
> >>       codec_caps = g_malloc0(sizeof(*codec_caps) + length);
> >> +     if(!codec_caps)
> >> +             return -ENOMEM;
> >
> > the only way this can return NULL is when the size argument is 0. In all other cases it will abort the program.
> >
> In one of our a2dp connection test, we found it restarted bluetoothd,
> and failed to store the capabilities because of NULL pointer abort.
> Just to avoid same issue in other cases, I have added this check to
> ignore the abort.

It might be ok to add such checks to allocations where it's possible
that we pass a size 0 to g_malloc, however any other allocation GLib
will never give you NULL but simply call abort() if something fails.
Adding a NULL check doesn't help at all then since the program has
already aborted before g_malloc returns.

However, even for the cases where we might pass 0 usually a better fix
is to have a zero-check somewhere earlier in the function (e.g. if
you're allocating "length * sizeof(foo)" maybe length value 0 is an
invalid value to be passed to the function and should make it fail much
earlier.

Either way you'll need to fix up both of the patches you sent to follow
the above principles.

Johan
