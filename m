Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 23:23:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: Re: [PATCH 1/2] g_string_free shell be used in IRMC
Message-ID: <20101111212303.GG24514@jh-x301>
References: <1289508380-8873-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289508380-8873-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Nov 11, 2010, Dmitriy Paliy wrote:
> g_string_free instead of string_free shell be used in IRMC plugin.
> string_free is a callback function specific to filesystem plugin
> only and used by OBEX drivers to close an OBEX object.
> ---
>  plugins/irmc.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)

Thanks, pushed upstream after I fixed your email address (should be
@nokia.com, check your gitconfig) and summary line (which should start
with Add/Fix/Make/Use etc to be consistent with the rest of the commit
history.

Johan
