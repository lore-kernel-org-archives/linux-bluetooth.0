Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Oct 2010 09:53:04 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handling nco affiliation fields
Message-ID: <20101029135304.GA2357@jh-x301>
References: <1288344619-18133-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288344619-18133-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Oct 29, 2010, Lukasz Pawlik wrote:
> Previously when contact record was divided into separate replies,
> phonebook-tracker would use first reply and merge only phone numbers,
> addresses and emails from next. Now it's merging all fields dependent on the
> nco:hasAffiliation as well.
> ---
>  plugins/phonebook-tracker.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

You'll need to fix the coding style before this goes upstream:

> +static void add_affiliation(char **field, const char *value)
> +{
> +        if(strlen(*field) != 0 || value == NULL || strlen(value) == 0)

Space between "if" and "(". Also, I'd prefer > 0 instead of != 0 for the
first strlen check. Then, you're also using spaces instead of tabs for
the indentation of all code in this patch. Did you forget to switch your
editor into bluez/kernel mode?

Johan
