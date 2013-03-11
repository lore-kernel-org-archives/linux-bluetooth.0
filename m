Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Mar 2013 17:16:31 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 0/7] One remote UUID per btd_profile
Message-ID: <20130311001631.GA9533@x220.amr.corp.intel.com>
References: <1362146353-23799-1-git-send-email-mikel.astiz.oss@gmail.com>
 <CANT-zCXP8_8phAqjNYCJsakjXjRb3F9sVzk0z+u0ruOG2++r+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANT-zCXP8_8phAqjNYCJsakjXjRb3F9sVzk0z+u0ruOG2++r+A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Mar 07, 2013, Mikel Astiz wrote:
> On Fri, Mar 1, 2013 at 2:59 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> > From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> >
> > Still not a lot of excitement after v1 but the patchset is required (or very convenient) for a later discussion which several people have shown interest in: the introduction of btd_service (or similar concept, to be discussed).
> >
> > Claudio pointed out several issues affecting patch v1 3/7, which have been improved in this v2, including:
> > - Fix premature release of resources in cleanup_monitor().
> > - Fix boolean literal in monitor_unregister_linkloss (which should be FALSE).
> >
> > Luiz also triggered an interesting point affecting patch v1 2/7 but I considered it unrelated to this patchset, stricly speaking, and has been therefore left aside.
> >
> > Looking forward to your feedback.
> >
> > From original cover-letter:
> >
> > Disclaimer: this RFC is WIP and hasn't been tested, specially because I don't have the necessary hardware for it.
> >
> > The goal is to have one remote_uuid per btd_profile. There are only a few exceptions to this rule, and this patchset tries to fix three of them. This basically means splitting one btd_profile per role.
> >
> > Mikel Astiz (7):
> >   avrcp: Refactor server registration
> >   audio: Split AVRCP into two btd_profile
> >   proximity: Split internal monitor registration API
> >   proximity: Split monitor into three btd_profile
> >   gatt: List only GATT_UUID as remote UUID
> >   health: Split health into two btd_profile
> >   profile: Limit to one remote UUID per profile
> >
> >  profiles/audio/avrcp.c               | 114 +++++++++++++-----
> >  profiles/audio/avrcp.h               |   6 +-
> >  profiles/audio/manager.c             |  75 ++++++++----
> >  profiles/cyclingspeed/cyclingspeed.c |   2 +-
> >  profiles/deviceinfo/deviceinfo.c     |   2 +-
> >  profiles/gatt/gas.c                  |   2 +-
> >  profiles/health/hdp_manager.c        |  20 +++-
> >  profiles/heartrate/heartrate.c       |   2 +-
> >  profiles/input/hog.c                 |   2 +-
> >  profiles/input/manager.c             |   2 +-
> >  profiles/network/manager.c           |   6 +-
> >  profiles/proximity/manager.c         | 100 ++++++++++++----
> >  profiles/proximity/monitor.c         | 220 ++++++++++++++++++++++++++++-------
> >  profiles/proximity/monitor.h         |  17 ++-
> >  profiles/scanparam/scan.c            |   2 +-
> >  profiles/thermometer/thermometer.c   |   2 +-
> >  src/device.c                         |  49 +++-----
> >  src/profile.c                        |  25 ++--
> >  src/profile.h                        |   4 +-
> >  19 files changed, 466 insertions(+), 186 deletions(-)
> >
> > --
> > 1.8.1
> >
> 
> Ping.

This patch set has been hanging around the list long enough. After a
basic review which didn't show any obvious issues I went a head and did
a rebase against latest git and pushed it upstream. Let's hope any
issues caused by it get caught before we do the next release.

Johan
