Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341509854-9875-2-git-send-email-jprvita@openbossa.org>
References: <1341509854-9875-1-git-send-email-jprvita@openbossa.org>
	<1341509854-9875-2-git-send-email-jprvita@openbossa.org>
Date: Thu, 5 Jul 2012 14:50:01 -0300
Message-ID: <CAJdJm_Po4UXnVWWEy0cBEtPWHOs3pS_6Rd1uJ6O2xxvO2WVXew@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] time: fix daylight variable description
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Thu, Jul 5, 2012 at 2:37 PM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> -       /* FIXME: POSIX "daylight" variable only indicates whether there is DST
> -        * for the local time or not. The offset is unknown. */
> +       /* FIXME: POSIX "daylight" variable only indicates if DST is used for
> +        * the local time or not. Both the offset and wheter it's currently

small typo: wheter -> whether

> +        * active is unknown. */
>         value[1] = daylight ? 0xff : 0x00;

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
