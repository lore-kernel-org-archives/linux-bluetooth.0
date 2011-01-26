Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 13:29:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Remove unnecessary ordering from single vCard query
Message-ID: <20110126112917.GA2789@jh-x301>
References: <1296039665-3948-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296039665-3948-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jan 26, 2011, Rafal Michalski wrote:
> Previously ordering for query called CONTACTS_QUERY_FROM_URI was applied.
> It is not needed since always only one vCard (with id specified)
> is fetched.
> ---
>  plugins/phonebook-tracker.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)

Doesn't compile:

plugins/phonebook.c: In function 'phonebook_get_entry':
plugins/phonebook.c:1928: error: too many arguments for format
make[1]: *** [plugins/phonebook.o] Error 1

Did you forget to compile with ./bootstrap-configure? Never submit
patches without first checking that they compile cleanly this way.

Johan
