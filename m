Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 11:50:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix default disabled values in audio.conf
Message-ID: <20120416085038.GA24652@x220.ger.corp.intel.com>
References: <1334382204-17937-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334382204-17937-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Sat, Apr 14, 2012, chanyeol.park@samsung.com wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
> 
> Disabled features in audio.conf should be the same with source code
> "audio/manager.c:struct enabled_interfaces enabled".
> ---
>  audio/audio.conf |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
