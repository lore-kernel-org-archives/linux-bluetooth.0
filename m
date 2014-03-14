Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Mar 2014 12:23:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 02/20] lib: Remove bt_put_le16()
Message-ID: <20140314102340.GA4683@localhost.P-661HNU-F1>
References: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394742168-31073-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394742168-31073-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Mar 13, 2014, Claudio Takahasi wrote:
> ---
>  android/hidhost.c |  3 ++-
>  lib/bluetooth.h   | 10 ----------
>  src/eir.c         |  3 ++-
>  tools/l2test.c    |  4 +++-
>  tools/rctest.c    |  4 +++-
>  tools/scotest.c   |  4 +++-
>  6 files changed, 13 insertions(+), 15 deletions(-)

This would have to be split into two patches: one to convert all users
and another for removing from lib. This is particularly important since
I'm not sure Marcel is ok with removing symbols from the library (even
though it now days defaults to not being installed by default), i.e. if
it's not ok you wouldn't have to resend but I could just skip the
removal patches.

Same goes for any other patches you might have that mix lib removals
with other changes.

Johan
