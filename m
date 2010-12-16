Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 17:06:35 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Further optimalization of PBAP tracker queries
Message-ID: <20101216150635.GA8997@jh-x301>
References: <1292511423-3140-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292511423-3140-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Thu, Dec 16, 2010, Radoslaw Jablonski wrote:
> Now emails, addresses and telephone numbers of the same type
> (work/home/other) are concatenated into sigle strings - this
> gains huge difference in speed of queries when there are a lot
> of contacts in database. Also changed functions for splitting
> these fields on our backend side.
> ---
>  plugins/phonebook-tracker.c | 1241 +++++++++++++++++++++++++------------------
>  1 files changed, 711 insertions(+), 530 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
