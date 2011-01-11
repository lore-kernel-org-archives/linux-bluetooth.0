Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Jan 2011 15:42:19 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix history queries for contacts outside pb
Message-ID: <20110111134219.GA12934@jh-x301>
References: <1294752951-27299-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294752951-27299-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Jan 11, 2011, Radoslaw Jablonski wrote:
> Phone number for contacts outside phonebook need to
> be fetched differently - application which saves call data
> saves this number directly in "nco:Contact" now.
> Without this fix, calls to/from numbers outside phonebook
> won't be listed in call history results
> ---
>  plugins/phonebook-tracker.c |   32 ++++++++++++++++++++++++--------
>  1 files changed, 24 insertions(+), 8 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
