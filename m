Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix device_match_pattern function
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimoISCAwCfv8zktLF7OxT0aT5glDAXYeFM0mUvF@mail.gmail.com>
References: <1274350142-19083-1-git-send-email-sancane@gmail.com>
	 <AANLkTimv6CRgS-lPeadePxKXEmNmhEM7oLx-uTHuZfNF@mail.gmail.com>
	 <AANLkTimoISCAwCfv8zktLF7OxT0aT5glDAXYeFM0mUvF@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 20 May 2010 16:04:41 +0200
Message-ID: <1274364281.2018.44.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

El jue, 20-05-2010 a las 15:00 +0200, Luiz Augusto von Dentz escribió:
> Hi,
> 
> On Thu, May 20, 2010 at 2:52 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Santiago,
> >
> > On Thu, May 20, 2010 at 12:09 PM, Santiago Carot-Nemesio
> > <sancane@gmail.com> wrote:
> >> This patch fixes a problem adding uuids to list provided when a
> >> driver is probed. Without this patch the same uuids were added
> >> more than once to list and if two or more uuids were in the
> >> same class id list only the first one was included repeatedly
> >> ---
> >>  src/device.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/src/device.c b/src/device.c
> >> index 6ba1612..d0768ce 100644
> >> --- a/src/device.c
> >> +++ b/src/device.c
> >> @@ -1053,7 +1053,7 @@ static GSList *device_match_pattern(struct btd_device *device,
> >>                        continue;
> >>
> >>                if (record_has_uuid(rec, match_uuid))
> >> -                       uuids = g_slist_append(uuids, profile_uuid);
> >> +                       uuids = g_slist_append(uuids, match_uuid);
> >>        }
> >>
> >>        return uuids;
> >
> >
> > It doesn't look right, if we do that the device will be probed by the
> > matched uuid which would not happen to have a record in the storage.
> > So in other words the list of uuids you get in the probe may not match
> > with the one present in the drivers .uuids. Also this would probably
> > break serial driver, did you tried this before submitting this to the
> > list?
> 
> Ok, I did apply you change to see what it happens, first it didn't
> compile, but anyway I add cast just to make sure what would gonna
> happen:
> 

Sorry, you are right I sent an erroneous patch, please excuse me that
was quite a slip-up. I'll revise it more in deep for next time. In any
case, it seems that there is a problem retrieving the service class ID
List when there are more than one entry. At current moment only the
first one is being provided when driver is probed. Please, note that I'm
speaking about profiles like HDP that can registry one or two entries
(Sink, Source or both if it is playing a dual role) although other else
profiles could want to do that too.

I'll revise that issue more in deep if you don't have any objection.

Sorry for the inconvenience and thank for your time and your attention.

Best regards.

