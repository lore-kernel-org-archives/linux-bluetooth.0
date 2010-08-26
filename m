Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Aug 2010 11:15:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handling empty fields in VCARDs
Message-ID: <20100826081454.GA8970@jh-x301>
References: <AANLkTimB9Tvxt6zZKzfHwhGc_j8MnGTo1DbeH-pYoQpe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimB9Tvxt6zZKzfHwhGc_j8MnGTo1DbeH-pYoQpe@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> From 4bb29cdaf4a9923ab62973c38914ebb67f718d64 Mon Sep 17 00:00:00 2001
> From: Lukasz Pawlik <lucas.pawlik@gmail.com>
> Date: Thu, 26 Aug 2010 09:10:26 +0200
> Subject: [PATCH] Fix handling empty fields in VCARDs
> 
> Previously even mandatory TEL field was not printed in VCARD if it was
> empty. This patch fix this. Now tag TEL will be printed if phone number
> is not set in phonebook. This patch also fix handling category string
> for VCARDs in version 2.1 for url field.
> ---
>  plugins/vcard.c |   51 ++++++++++++++++++++++++++++++++-------------------
>  1 files changed, 32 insertions(+), 19 deletions(-)

In general the patch seems fine, but you need to fix your editor
settings when dealing with BlueZ code. It seems like you're using spaces
for indentation when the coding style is tabs-only:

> -		for (l = contact->numbers; l; l = l->next) {
> +                if (g_slist_length(l) == 0)
> +                        vcard_printf_number(vcards, format, NULL, 1,
> +                                                        TEL_TYPE_OTHER);

All of the above three added lines are indented with spaces.

> +		for (; l; l = l->next) {

This added line is indented with tabs. How did you manage to get your
editor to produce such mixed results?

> +		if (g_slist_length(l) == 0)
> +                        vcard_printf_email(vcards, format, NULL,
> +                                                        EMAIL_TYPE_OTHER);

The first line is tabs but the two others use spaces!?

> -		for (l = contact->emails; l; l = l->next){
> +                for (; l; l = l->next){

Again spaces here.

Please enable whitespace visualization and use proper editor settings to
avoid these issues in the future. Thanks.

Johan
