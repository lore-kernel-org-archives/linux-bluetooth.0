Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 11:32:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Fix proper type handling in contacts_query_all
Message-ID: <20101111093212.GB4132@jh-x301>
References: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Wed, Nov 10, 2010, Bartosz Szatkowski wrote:
> Previously all phone numbers, addresses and emails was considered to be "work".
> Now there are three working types for emails and addresses: "work", "home",
> "other" and four for phone numbers - these three as well as "cell".
> ---
>  plugins/phonebook-tracker.c |   61 +++++++++++++++++++++++++++++++------------
>  1 files changed, 44 insertions(+), 17 deletions(-)

All seven patches have been pushed upstream. Thanks.

Johan
