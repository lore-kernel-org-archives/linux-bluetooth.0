Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 May 2014 14:50:51 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv3 02/12] android/hal-audio-hsp: Add open_output_stream()
Message-ID: <20140508115049.GD21149@aemeltch-MOBL1>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399536103-19052-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZ+VMbaapx1F+ySnf5zY8z203sGbcJYUCMnYfA3fLX0xpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+VMbaapx1F+ySnf5zY8z203sGbcJYUCMnYfA3fLX0xpQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 08, 2014 at 02:24:15PM +0300, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Thu, May 8, 2014 at 11:01 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Function adds audio_open_output_stream() and sets dummy callbacks.
> > ---
> >  android/hal-sco.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 176 insertions(+), 3 deletions(-)
> >
> > diff --git a/android/hal-sco.c b/android/hal-sco.c
> > index c7ba504..bc7d987 100644
> > --- a/android/hal-sco.c
> > +++ b/android/hal-sco.c
> > @@ -25,22 +25,195 @@
> >
> >  #include "hal-log.h"
> >
> > +#define AUDIO_STREAM_DEFAULT_RATE      44100
> > +#define AUDIO_STREAM_DEFAULT_FORMAT    AUDIO_FORMAT_PCM_16_BIT
> > +
> > +#define OUT_BUFFER_SIZE                        2560
> > +
> > +struct hsp_audio_config {
> > +       uint32_t rate;
> > +       uint32_t channels;
> > +       audio_format_t format;
> > +};
> > +
> > +struct hsp_stream_out {
> > +       struct audio_stream_out stream;
> > +       struct hsp_audio_config cfg;
> > +};
> > +
> >  struct hsp_audio_dev {
> >         struct audio_hw_device dev;
> > -       struct a2dp_stream_out *out;
> > +       struct hsp_stream_out *out;
> >  };
> 
> Please rename hsp to sco, also fix where you actually introduced
> a2dp_stream_out.
> 
> Tip: you can use git rebase -i origin/master change the commit that
> want to fix from pick to edit once you are done do git add and git
> rebase --continue

This might be done with git filter-branch which renames it in all patches.

Best regards 
Andrei Emeltchenko 

