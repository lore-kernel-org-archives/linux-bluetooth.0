Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 15:46:53 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handling owner data in phonebook pull
Message-ID: <20110304184653.GD21452@jh-x301>
References: <1299072355-24766-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299072355-24766-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Mar 02, 2011, Lukasz Pawlik wrote:
> This patch fix handling "empty" phone owner data in phonebook pull via
> PBAP. Previously owner vCard was always present as a first on list in
> phonebook pull results even if it was empty. This patch fix this and
> owner vCard will not be present in pulled phonebook.
> ---
>  plugins/phonebook-tracker.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
