Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 11:06:25 -0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix history listing queries in phonebook-tracker
Message-ID: <20101022130625.GA29406@jh-x301>
References: <1287663999-22701-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287663999-22701-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Oct 21, 2010, Radoslaw Jablonski wrote:
> Now we are able to display contact's name in vcard-listing when
> contact has entry in phonebook available.
> ---
>  plugins/phonebook-tracker.c |  140 ++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 118 insertions(+), 22 deletions(-)

Pushed upstream. Thanks.

Johan
