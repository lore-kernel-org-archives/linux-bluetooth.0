Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 11:04:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] BlueZ: l2test: Use defined L2CAP extended feature
 mask
Message-ID: <20110726080400.GB9775@dell>
References: <1309938516-510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309938516-510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jul 06, 2011, Emeltchenko Andrei wrote:
> Sync l2cap.h from kernel concerning L2CAP extended feature mask.
> ---
>  lib/l2cap.h   |   12 ++++++++++++
>  test/l2test.c |   20 ++++++++++----------
>  2 files changed, 22 insertions(+), 10 deletions(-)

Both patches have been applied, but before that I had to fix the commit
messages (e.g. no need for BlueZ prefix) and split this first patch into
two (the lib/l2cap.h change should be separate).

Johan
