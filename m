Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339760580-8219-1-git-send-email-ant@antweb.me>
References: <1339760580-8219-1-git-send-email-ant@antweb.me>
Date: Mon, 25 Jun 2012 09:04:07 -0400
Message-ID: <CAJdJm_Ngu1MW3wQ1E19_oC1oRzSa3-2kyT_cm2U5rwK7DB1oZg@mail.gmail.com>
Subject: Re: [PATCH] monitor: Fix optstring to parse -b parameter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anton Weber <ant@antweb.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anton,

On Fri, Jun 15, 2012 at 7:43 AM, Anton Weber <ant@antweb.me> wrote:
> Without the colon getopt ignores the parameter and optarg is always NULL.
> ---
>  monitor/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

I tested your patch and it fixed -b option for me.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
