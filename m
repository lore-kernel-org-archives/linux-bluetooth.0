Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Fix discovering new devices
Date: Thu, 16 Jan 2014 11:22:55 +0100
Message-ID: <3622437.o5mxG3O6lC@uw000953>
In-Reply-To: <20140114113920.GD4709@x220.p-661hnu-f1>
References: <1389691863-4827-1-git-send-email-szymon.janc@tieto.com> <20140114113920.GD4709@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tuesday 14 of January 2014 13:39:20 Johan Hedberg wrote:
> Hi Szymon,
> 
> On Tue, Jan 14, 2014, Szymon Janc wrote:
> > +	} else {
> > +		GSList *l;
> > +
> > +		for(l = devices; l; l = g_slist_next(l)) {
> 
> Coding style thing here (space after 'for'). You might wanna consider a
> helper function and g_slist_foreach here tough.
> 
> > +static bool device_found_needed(struct device *dev)
> > +{
> > +	if (!dev)
> > +		return true;
> > +
> > +	if (dev->bond_state == HAL_BOND_STATE_BONDED)
> > +		return false;
> > +
> > +	return !dev->found;
> > +}
> 
> I think you should provide lots more code comments here with proper
> explanations of each if-statement. E.g. your commit message doesn't
> mention anything about bonded devices and yet you have a check for this
> state here.

Now I think this check is not really needed, if paired remote is responding to
inquiry then just notify HAL as with any other device found.

I'll send V2 shortly.


-- 
Best regards, 
Szymon Janc
