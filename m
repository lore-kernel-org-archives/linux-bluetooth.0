Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Aug 2012 13:20:36 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix trivial coding style issues on pointer
 declarations and casting
Message-ID: <20120826122036.GA3627@x220.spectrum.wifi>
References: <1345564164-15930-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345564164-15930-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Aug 21, 2012, Anderson Lizardo wrote:
> Avoid using C++ style pointer declarations like "char* ptr", as most
> BlueZ code uses "char *ptr".
> ---
> 
> This is a very trivial patch, but changes are so small that it was worthy to
> fix.
> 
> I avoided touching tools/ubcsp.c because it has even more coding style issues.
> 
> 
>  audio/gstavdtpsink.h     |    2 +-
>  audio/gstsbcutil.h       |    8 ++++----
>  lib/sdp.c                |    4 ++--
>  profiles/input/sixpair.c |    6 +++---
>  test/l2test.c            |    4 ++--
>  tools/hciattach.h        |    2 +-
>  tools/hciattach_ti.c     |   22 +++++++++++++---------
>  tools/ppporc.c           |    2 +-
>  tools/rfcomm.c           |    4 ++--
>  9 files changed, 29 insertions(+), 25 deletions(-)

Applied. Thanks.

Johan
