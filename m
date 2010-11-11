Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 11:29:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix pull phonebook reply if filter not set
Message-ID: <20101111092914.GA4132@jh-x301>
References: <1289389387-14308-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289389387-14308-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Nov 10, 2010, Lukasz Pawlik wrote:
> According to the PBAP specification if filter is not set or is set to
> 0x00000000 in the application parameters header all attributes of the vCard
> should be returned. Previously only mandatory attributes were returned in
> phonebook pull reply. This patch fix this and now all currently supported
> vCards attributes will be returned.
> ---
>  plugins/vcard.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)

Pushed upstream. Thanks.

Johan
