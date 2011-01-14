Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Jan 2011 11:05:50 +0000
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add support for multiple URL in PBAP
Message-ID: <20110114110550.GB19145@jh-x301>
References: <1294919592-2978-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294919592-2978-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Jan 13, 2011, Radoslaw Jablonski wrote:
> Application which stores contact data changed way that
> URL data is stored. Now it is possible for contact to
> have more than one url defined with different types.
> Place where these url are stored has also changed in db.
> This fix changes handling for url in PBAP to make urls
> visible in pull results again.
> ---
>  plugins/phonebook-tracker.c |   89 +++++++++++++++++++++++++++++++++++++++----
>  plugins/vcard.c             |   54 ++++++++++++++++++++++++--
>  plugins/vcard.h             |    2 +-
>  3 files changed, 132 insertions(+), 13 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
