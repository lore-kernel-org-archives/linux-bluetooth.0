Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Jan 2011 11:05:12 +0000
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Refactoring of vcard content structures
Message-ID: <20110114110512.GA19145@jh-x301>
References: <y>
 <1294904341-16047-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294904341-16047-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Jan 13, 2011, Radoslaw Jablonski wrote:
> Structures for holding data about phone numbers, emails and
> addressess were practically identical and there was no sense
> to handle them differently. Now for saving informations about
> field content and type struct "phonebook_field" is used.
> ---
>  plugins/phonebook-tracker.c |   59 ++++++++++++++++++------------------------
>  plugins/vcard.c             |   57 +++++++++++++++--------------------------
>  plugins/vcard.h             |   28 ++++----------------
>  3 files changed, 52 insertions(+), 92 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
