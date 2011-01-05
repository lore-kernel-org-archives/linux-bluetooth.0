Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Jan 2011 01:12:56 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix for handling addresses in pull call history queries
Message-ID: <20110105231256.GA31865@jh-x301>
References: <1294220895-2037-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294220895-2037-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Wed, Jan 05, 2011, Radoslaw Jablonski wrote:
> Previously only addresses of one type (by example only
> HOME addresses) were listed. Now every address will for
> contact will be included in call history results.
> ---
>  plugins/phonebook-tracker.c |   84 +++++++++++++++++++++++++++++-------------
>  1 files changed, 58 insertions(+), 26 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
