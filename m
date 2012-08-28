Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Aug 2012 11:10:41 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Garbat Rafal <rafal.garbat@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Santiago Carot-Nemesio <sancane@gmail.com>
Subject: Re: [PATCH v2 01/13] Heart Rate Profile API
Message-ID: <20120828181041.GA7686@x220.sheraton.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
 <1344870497-6929-2-git-send-email-rafal.garbat@tieto.com>
 <20120814095636.GA7055@x220>
 <20120828152058.GA18913@x220.sheraton.com>
 <503CE72D.2030501@tieto.com>
 <20120828165650.GA3165@x220.sheraton.com>
 <CAJdJm_PWn--HEsaex1zqL_CqEBvjKQXSABBnPeYP9CVKgeA6Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PWn--HEsaex1zqL_CqEBvjKQXSABBnPeYP9CVKgeA6Wg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Aug 28, 2012, Anderson Lizardo wrote:
> On Tue, Aug 28, 2012 at 12:56 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > On Tue, Aug 28, 2012, Garbat Rafal wrote:
> >> I guess that moving RegisterWatcher methods to the adapter iface
> >> sounds reasonable, but we need to think how to do it i.e. to
> >> properly handle devices that support several profiles based on
> >> registering watchers (do we want to register watcher for all the
> >> profiles or have a parameter for Watcher methods to specify the
> >> target), etc.
> >> Correct me if I'm wrong or missing something.
> >> I'd suggest merging heartrate as this profile is quite similar to
> >> the thermometer and it works (and no one have any objections to the
> >> code) and re-factor this later on.
> >> Unfortunately I'll be off for the next three weeks, but I can get
> >> back to this when I'm back.
> >
> > Since it's not just a refactoring but an API change/break I'd rather get
> > this right from the start. The thermometer API should also be updated to
> > be per-adapter for our next release (BlueZ 5).
> 
> The registered "watcher" object will have different interface
> depending on the profile. The application which will call
> RegisterWatcher() needs to check that the device supports the expected
> GATT service (e.g. by checking the "UUIDs" property of that device
> object) before using the  org.bluez.HeartRate interface, therefore
> IMHO it makes sense to have RegisterWatcher() on the device object
> path.

I'm not quite following. You'd still have per-profile interfaces on the
adapter path.

> Unless you are proposing a generic Watcher API that could somehow be
> shared by all profiles (including a single shared interface for the
> watcher object)? How to represent data from profiles which are not
> "measurement" based?

I suppose you were directing this at Rafal and not me? I don't think it
makes sense to merge these. I was only saying that the interfaces should
go from Device to Adapter.

Johan
