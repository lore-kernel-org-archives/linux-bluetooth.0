Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Mar 2011 10:17:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, paulepanter@users.sourceforge.net,
	Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: [PATCH] sbc: better compatibility with ARM thumb/thumb2
Message-ID: <20110329071714.GA3915@jh-x301>
References: <1301353059-12776-1-git-send-email-siarhei.siamashka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301353059-12776-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Tue, Mar 29, 2011, Siarhei Siamashka wrote:
> ARM assembly optimizations fail to compile in thumb mode, but are fine
> for thumb2. Update ifdefs in the code to make use of ARM assembly only
> when it is safe and also make sure that no optimizations are missed
> when compiling for thumb2.
> 
> The problem was reported by Paul Menzel:
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-February/009022.html
> ---
>  sbc/sbc_math.h             |    2 +-
>  sbc/sbc_primitives_armv6.h |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
