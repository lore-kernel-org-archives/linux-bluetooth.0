Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 13:22:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Add sbc cap null case while GST AVDTP Signaling.
Message-ID: <20120416102211.GA26861@x220.P-661HNU-F1>
References: <1334419155.16897.148.camel@aeonflux>
 <1334545199-25012-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334545199-25012-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Mon, Apr 16, 2012, chanyeol.park@samsung.com wrote:
> Due to RF condition or headset malfunctioning, gst audio plug-in
> could not get sbc(mandatory codec) information.
> ---
>  audio/gstavdtpsink.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Applied. Thanks.

Also, please use v2, v3 etc in the future. It makes it easier for me to
track new patches vs new revisions of existing ones.

Johan
