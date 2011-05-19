Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 16:20:04 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix newmissedcalls handling for large responses
Message-ID: <20110519232003.GA4016@dell.ger.corp.intel.com>
References: <1305790162-14888-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305790162-14888-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, May 19, 2011, Radoslaw Jablonski wrote:
> Previously pull_newmissedcalls was called for every part when
> processing large response (more that one part of results) and
> number of 'newmissedcalls' was wrong in that scenario.
> Now newmissedcalls will be counted only once (during generating
> first part of mch results).
> ---
>  plugins/phonebook-tracker.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
