Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Dec 2013 10:21:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: Re: [PATCH] android/pts: Add PICS, PIXITs and PTS for L2CAP
Message-ID: <20131219082152.GD31549@x220.p-661hnu-f1>
References: <2115852EF878384FA984E6B76A9F379E164297@IRSMSX104.ger.corp.intel.com>
 <1387395146-28084-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387395146-28084-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wed, Dec 18, 2013, Sebastian Chlad wrote:
> This allows better tracking of the current state of implementation
> ---
>  android/pics-l2cap.txt  | 157 ++++++++++++++++++++++++++
>  android/pixit-l2cap.txt |  39 +++++++
>  android/pts-l2cap.txt   | 293 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 489 insertions(+)
>  create mode 100644 android/pics-l2cap.txt
>  create mode 100644 android/pixit-l2cap.txt
>  create mode 100644 android/pts-l2cap.txt

Looks otherwise fine to me, but are you've forgotten to add these to
EXTRA_DIST in android/Makefile.am. Otherwise the files would not get
included in the next release tarball we make.

Johan
