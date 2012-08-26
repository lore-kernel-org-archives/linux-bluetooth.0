Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Aug 2012 10:29:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] input: Fix signedness issue on POSIX error code
 usage
Message-ID: <20120826072935.GB32318@x220>
References: <1345842229-11935-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345842229-11935-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Aug 24, 2012, Anderson Lizardo wrote:
> By convention, error variables containing POSIX error code (usually
> called "err") are negative. This commit fixes a couple of places where
> positive values are expected.
> ---
>  profiles/input/hog_device.c |    2 +-
>  profiles/input/server.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
