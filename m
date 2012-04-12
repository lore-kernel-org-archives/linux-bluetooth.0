Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 14:40:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2 1/3] MAP: Mark filter strings const
Message-ID: <20120412114017.GB18837@x220.ger.corp.intel.com>
References: <1334069261-3668-1-git-send-email-lkslawek@gmail.com>
 <CABBYNZ+Rd8Gh+yZUOhtnqHc-r4PKuxqgzMDYRJMoPpvhKv=jAQ@mail.gmail.com>
 <CA+i+Aw2=gfaoQimn4bG8hSYRRacwMbCy9SNigs7ji-ejy0kr-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+i+Aw2=gfaoQimn4bG8hSYRRacwMbCy9SNigs7ji-ejy0kr-w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Wed, Apr 11, 2012, Slawomir Bochenski wrote:
> On Wed, Apr 11, 2012 at 3:19 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Slawomir,
> >
> > On Tue, Apr 10, 2012 at 5:47 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> >> This structure is used for giving filters as input argument to
> >> messages_get_messages_listing(). There is no need for the string members
> >> to be modifiable in this context. And making them const plays well with
> >> map_ap_get_string(), from which the values of these members are going to
> >> be retrieved.
> >> ---
> >> v2: Turn on verbose mode in commit messages
> >>
> >>  plugins/messages.h |    8 ++++----
> >>  1 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/plugins/messages.h b/plugins/messages.h
> >> index 00a040c..2cdd92f 100644
> >> --- a/plugins/messages.h
> >> +++ b/plugins/messages.h
> >> @@ -111,11 +111,11 @@ struct messages_event {
> >>  struct messages_filter {
> >>        uint32_t parameter_mask;
> >>        uint8_t type;
> >> -       char *period_begin;
> >> -       char *period_end;
> >> +       const char *period_begin;
> >> +       const char *period_end;
> >>        uint8_t read_status;
> >> -       char *recipient;
> >> -       char *originator;
> >> +       const char *recipient;
> >> +       const char *originator;
> >>        uint8_t priority;
> >>  };
> >>
> >> --
> >> 1.7.5.1
> >
> > Don't you need to free them at some point? If it is just a reference
> > then it is probably fine, but if you have to free them then it might
> > be better this way.
> 
> Just reference to strings stored in another data structure, which
> takes care of freeing them when request is finished.

That should be mentioned in the commit message (and if it had been from
the start all this unnecessary discussion could have been avoided).

Johan
