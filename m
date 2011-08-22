Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 11:07:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH Bluez v2] Fix get/set_hfp_active to match name conventions
Message-ID: <20110822080752.GB11306@dell>
References: <1313256696.2254.11.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313256696.2254.11.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Sat, Aug 13, 2011, Peter Hurley wrote:
> These two functions are defined exclusively for headsets, so
> follow established name conventions.
> ---
> 
> v2: Commit was missing a file
> 
>  audio/headset.c |    4 ++--
>  audio/headset.h |    4 ++--
>  audio/main.c    |    2 +-
>  audio/manager.c |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Applied, but again the patch wasn't clean. You really need to fix your
editor settings to show you whitespace errors as well as check yourself
with "git am" if you're still unsure if the patch is clean or not:

/home/jh/src/bluez/.git/rebase-apply/patch:20: trailing whitespace.
gboolean headset_get_hfp_active(struct audio_device *dev)
/home/jh/src/bluez/.git/rebase-apply/patch:28: trailing whitespace.
void headset_set_hfp_active(struct audio_device *dev, gboolean active)
/home/jh/src/bluez/.git/rebase-apply/patch:42: trailing whitespace.
gboolean headset_get_hfp_active(struct audio_device *dev);
/home/jh/src/bluez/.git/rebase-apply/patch:43: trailing whitespace.
void headset_set_hfp_active(struct audio_device *dev, gboolean active);
/home/jh/src/bluez/.git/rebase-apply/patch:56: trailing whitespace.
		if (!headset_get_hfp_active(device)) {
warning: squelched 1 whitespace error
warning: 6 lines add whitespace errors.

Johan
