Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 14:00:28 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add support for notyfying pbap about more parts
 from backend
Message-ID: <20110209220028.GC11911@jh-x301>
References: <1297237127-16286-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297237127-16286-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, Feb 09, 2011, Radoslaw Jablonski wrote:
> Added new parameter to phonebook_cb - lastpart variable.
> If backend want to notify that more parts of current
> request will be delivered later, it should use lastpart=FALSE.
> Because of that, PBAP core will 'know' that should not finalize
> request immediately after receiving data and wait for more
> parts to come.
> If result is returned in one part and no more responses part
> will be sent later, then backend should use lastparam=TRUE.
> Previously results of request from backend was always returned
> in one part to PBAP core.
> ---
>  plugins/irmc.c              |    5 +++--
>  plugins/pbap.c              |   10 +++++++---
>  plugins/phonebook-dummy.c   |    4 ++--
>  plugins/phonebook-ebook.c   |    7 ++++---
>  plugins/phonebook-tracker.c |   13 +++++++------
>  plugins/phonebook.h         |    2 +-
>  6 files changed, 24 insertions(+), 17 deletions(-)

It seems these patches depend on your previous ones which weren't ready
for upstream, so I suppose they'll need to be fixed and resent (once
you've done the necessary changes to the first ones).

Johan
