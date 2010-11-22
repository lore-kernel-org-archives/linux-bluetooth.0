Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101122170525.GA13003@jh-x301>
References: <AANLkTinQAeN8jyBmmPnw0tMWDfvOVamOU5+gBXLF-hTT@mail.gmail.com>
 <1290437712-28991-1-git-send-email-santoscadenas@gmail.com> <20101122170525.GA13003@jh-x301>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Mon, 22 Nov 2010 20:14:42 +0100
Message-ID: <AANLkTi=GuNr9X_hELW4y98LU3swck4L9OwvfS_35zADG@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix: increment MDL and MCL reference counter in IO watchers.
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/11/22 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Jose,
>
> On Mon, Nov 22, 2010, Jose Antonio Santos Cadenas wrote:
>> When a io_watcher is added to an MDL or an MCL channel, its reference
>> should be incremented because the watcher should keep its own
>> reference the the structure.
>>
>> Also  a destroy function is added in order to decrement the reference
>> once the watcher is removed.
>> ---
>>  health/mcap.c |   28 +++++++++++++++++++---------
>>  1 files changed, 19 insertions(+), 9 deletions(-)
>
> Thanks. Pushed upstream, but I still had to tweak the summary line a
> little bit (take a look at the upstream tree if you're interested).

I have to avoid dots at the end of the commit message I always think
that, but sometimes my fingers are quicker than my mind. Sorry :) .

>
> Johan
>
