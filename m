Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Jan 2011 14:54:51 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] Fix for handling fax and cell phone numbers in
 PBAP
Message-ID: <20110104125451.GA30253@jh-x301>
References: <1294143837-19059-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294143837-19059-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Tue, Jan 04, 2011, Radoslaw Jablonski wrote:
> Application which stores contacts data in database has been
> optimized - fax and cell phones are now stored in "affilation"
> structures for better performance. So queries used in
> phonebook-tracker need to be changed to handle this properly.
> Without that cell and fax phone numbers are not listed in pull
> phonebook results.
> ---
>  plugins/phonebook-tracker.c |   61 ++++++++++++++++++++----------------------
>  1 files changed, 29 insertions(+), 32 deletions(-)

Both patches have been pushed upstream. Thanks.

Johan
