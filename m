Return-Path: <cyrus@holtmann.org>
Message-ID: <4D300C9D.7070100@nokia.com>
Date: Fri, 14 Jan 2011 10:43:09 +0200
From: Mika Linnanoja <mika.linnanoja@nokia.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@nokia.com>
CC: ext Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add support for multiple URL in PBAP
References: <1294919592-2978-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1294919592-2978-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 01/13/2011 01:53 PM, ext Radoslaw Jablonski wrote:
> Application which stores contact data changed way that
> URL data is stored. Now it is possible for contact to
> have more than one url defined with different types.
> Place where these url are stored has also changed in db.
> This fix changes handling for url in PBAP to make urls
> visible in pull results again.

Patched version is tested to work.

Please accept.

BR,
Mika

> ---
>   plugins/phonebook-tracker.c |   89 +++++++++++++++++++++++++++++++++++++++----
>   plugins/vcard.c             |   54 ++++++++++++++++++++++++--
>   plugins/vcard.h             |    2 +-
>   3 files changed, 132 insertions(+), 13 deletions(-)
