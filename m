Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Nov 2010 11:45:20 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix avoid starting AVDTP disconnect timer twice
Message-ID: <20101101144520.GA26116@jh-x301>
References: <AANLkTikPhBzAhQ=CeDkQokMK39k=c-VxU3re5GtMdiFZ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikPhBzAhQ=CeDkQokMK39k=c-VxU3re5GtMdiFZ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Mon, Nov 01, 2010, Daniel Örstadius wrote:
> Remove starting the timer when setting the AVDTP state to idle. If
> needed, the timer should probably already have been started in
> avdtp_unref when the reference count goes to one.
> 
> Since reference counting is handled in avdtp_ref and avdtp_unref, it
> seems reasonable that not to inspect the count outside of those
> functions.
> 
> The issue was found when using Device.Disconnect to disconnect a
> headset. It was revealed by commit
> c72ce0f12a8387a70a6f0109f13bd6f414f32be8.
> 
> Before the commit, the timer was removed and then started again.
> After applying it, the idle callback (disconnect_timeout) is called
> twice, causing a crash.

Thanks for investigating and fixing this. avdtp_unref indeed does
already take care of the timer so the call in set_state seems redundant
(in addition to being in a questionable place to begin with). The patch
has been pushed upstream.

Johan
