Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 12:50:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] phonebook-tracker.c: Fix iso8601_utc_to_localtime
Message-ID: <20111208105037.GB30533@x220>
References: <1323337281-5094-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323337281-5094-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Thu, Dec 08, 2011, Slawomir Bochenski wrote:
> Timestamp returned from Tracker can optionally contain fractional
> seconds. Original code treated any character after seconds as flag for
> UTC timestamp. This patch changes it so now only the beginning of string
> is scanned and the end of string is checked for UTC flag ('Z') presence.
> ---
>  plugins/phonebook-tracker.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
