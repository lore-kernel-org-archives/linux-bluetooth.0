Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 14:10:19 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] PBAP tracker-query update for addr fields
Message-ID: <20101223121019.GA22183@jh-x301>
References: <1293103208-17664-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293103208-17664-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Dec 23, 2010, Radoslaw Jablonski wrote:
> This is needed to display many addresses of the same type
> (WORK/HOME/OTHER) in different rows in pbap pull response.
> Currently in that case all addresses of the same type
> were displayed in the same row.
> ---
>  plugins/phonebook-tracker.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

Pushed upstream. Thanks.

Johan
