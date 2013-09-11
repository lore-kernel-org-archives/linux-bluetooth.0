Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Sep 2013 13:23:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Change __FUNCTION__ to __func__
Message-ID: <20130911102311.GA18429@x220.p-661hnu-f1>
References: <1378454530-24686-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1378454530-24686-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378454530-24686-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 06, 2013, Andrei Emeltchenko wrote:
> checkpatch.pl recommends to use __func__ instead of __FUNCTION__.
> ---
>  attrib/gattrib.c    | 2 +-
>  gobex/gobex-debug.h | 2 +-
>  obexd/src/log.h     | 2 +-
>  src/log.h           | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

I've applied this patch with a more thorough explanation in the commit
message.

Johan
