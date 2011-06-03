Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimzQZPSL4tEiyMaBNfF0+zjg3UDUQ@mail.gmail.com>
References: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
	<1307021003-15418-4-git-send-email-lkslawek@gmail.com>
	<BANLkTimzQZPSL4tEiyMaBNfF0+zjg3UDUQ@mail.gmail.com>
Date: Fri, 3 Jun 2011 11:07:50 +0300
Message-ID: <BANLkTikPJRZA6yfnWBCFit6+c-9mGbaxRQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] Simplify counting new missed calls
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawomir,

On Thu, Jun 2, 2011 at 4:23 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>
> This replaces parsing missed calls listing that was used to get the
> number of missed calls that have been unread with a simple SPARQL query.
>
> Previous code was trying to deal with misbehaviour of other tools
> operating on call history entries but still was failing in some
> cases. Those other tools should be fixed instead of doing workarounds in
> obexd code.

[snip]

>
> +#define NEW_MISSED_CALLS_COUNT_QUERY                                   \
> +       "SELECT COUNT(?call) WHERE {"                                   \
> +               "?c a nco:Contact ;"                                    \
> +               "nco:hasPhoneNumber ?h ."                               \
> +               "?call a nmo:Call ;"                                    \
> +               "nmo:isSent false ;"                                    \
> +               "nmo:from ?c ;"                                         \
> +               "nmo:isAnswered false ;"                                \
> +               "nmo:isRead false ."                                    \
> +       "}"

This query look like to return total number of missed calls that have
not been read. Is it?
If it is due to misbehavior of other tools, then wouldn't it be better
to fix firstly that misbehavior?

BR,
Dmitriy
