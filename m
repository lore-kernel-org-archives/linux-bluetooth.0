Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328284418-4989-1-git-send-email-arik@wizery.com>
References: <1328284418-4989-1-git-send-email-arik@wizery.com>
Date: Fri, 3 Feb 2012 13:25:42 -0400
Message-ID: <CAJdJm_M6kc_ZLsTMsxvZAs1H5DB8Zmyby51cN4cipe9BfYeSmQ@mail.gmail.com>
Subject: Re: [PATCH v2] proximity: make reporter work per-adapter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Fri, Feb 3, 2012 at 11:53 AM, Arik Nemtsov <arik@wizery.com> wrote:
> Register an adapter driver for reporter and add the adapter argument in
> appropriate places.

Looks ok.

>
> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> ---
> v1->2: minor rename of reporter driver, squashed a bug where
> the D-Bus connection was referenced only after the monitor driver
> was registered (Thanks Anderson)
>
>  proximity/manager.c  |   28 +++++++++++++++++++-----
>  proximity/reporter.c |   57 +++++++++++++++++++------------------------------
>  proximity/reporter.h |    4 +-
>  3 files changed, 46 insertions(+), 43 deletions(-)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
