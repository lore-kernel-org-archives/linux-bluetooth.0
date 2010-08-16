Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Aug 2010 16:23:23 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix empty contact in missed calls problem
Message-ID: <20100816132323.GA17617@jh-x301>
References: <1281963827-20375-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281963827-20375-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Mon, Aug 16, 2010, Radoslaw Jablonski wrote:
> Fixed problem with tracker queries for calls history - previously call
> without contact in phonebook was missing in some scenario for pull
> requests.
> ---
>  plugins/phonebook-tracker.c |   28 ++++------------------------
>  1 files changed, 4 insertions(+), 24 deletions(-)

Thanks. The patch is now upstream.

Johan
