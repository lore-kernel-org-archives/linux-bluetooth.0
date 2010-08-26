Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Aug 2010 14:28:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handling empty fields in VCARDs
Message-ID: <20100826112802.GA5278@jh-x301>
References: <AANLkTimN_hk1n7rDSBMpDP4-7ECV-4fm0NqHHwz0VBjo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimN_hk1n7rDSBMpDP4-7ECV-4fm0NqHHwz0VBjo@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Aug 26, 2010, Lukasz Pawlik wrote:
> From c9a89b18acf88ac0546ba72d0a169d9c2f18656d Mon Sep 17 00:00:00 2001
> From: Lukasz Pawlik <lucas.pawlik@gmail.com>
> Date: Thu, 26 Aug 2010 11:33:33 +0200
> Subject: [PATCH] Fix handling empty fields in VCARDs
> 
> Previously even mandatory TEL field was not printed in VCARD if it was
> empty. This patch fix this. Now tag TEL will be printed if phone number
> is not set in phonebook. This patch also fix handling category string
> for VCARDs in version 2.1 for url field.
> ---
>  plugins/vcard.c |   54 ++++++++++++++++++++++++++++++++++++------------------
>  1 files changed, 36 insertions(+), 18 deletions(-)

Thanks. The patch is now upstream. Btw, it's written vCard and not VCARD
(I fixed this for you manually).

Johan
