Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Aug 2012 09:56:50 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Garbat Rafal <rafal.garbat@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Santiago Carot-Nemesio <sancane@gmail.com>
Subject: Re: [PATCH v2 01/13] Heart Rate Profile API
Message-ID: <20120828165650.GA3165@x220.sheraton.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
 <1344870497-6929-2-git-send-email-rafal.garbat@tieto.com>
 <20120814095636.GA7055@x220>
 <20120828152058.GA18913@x220.sheraton.com>
 <503CE72D.2030501@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <503CE72D.2030501@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Tue, Aug 28, 2012, Garbat Rafal wrote:
> >>I'm wondering if it wouldn't make more sense to have these
> >>RegisterWatcher APIs (thermometer, heart rate, others?) per-adapter
> >>instead of per-device. That would be much friendlier to applications in
> >>that they wouldn't need to separately search for paired/configured
> >>devices supporting a specific service. Moving this to be per-adapter
> >>would also mean that the first parameter of the Watcher methods would be
> >>the object path of which device is in question.
> >So any comments on this? I'd like to get this moving forward and finally
> >merged upstream.
> 
> Sorry for a late reply.
> I guess that moving RegisterWatcher methods to the adapter iface
> sounds reasonable, but we need to think how to do it i.e. to
> properly handle devices that support several profiles based on
> registering watchers (do we want to register watcher for all the
> profiles or have a parameter for Watcher methods to specify the
> target), etc.
> Correct me if I'm wrong or missing something.
> I'd suggest merging heartrate as this profile is quite similar to
> the thermometer and it works (and no one have any objections to the
> code) and re-factor this later on.
> Unfortunately I'll be off for the next three weeks, but I can get
> back to this when I'm back.

Since it's not just a refactoring but an API change/break I'd rather get
this right from the start. The thermometer API should also be updated to
be per-adapter for our next release (BlueZ 5).

Johan
