Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319104011-27747-3-git-send-email-sancane@gmail.com>
References: <1319104011-27747-1-git-send-email-sancane@gmail.com>
	<1319104011-27747-2-git-send-email-sancane@gmail.com>
	<1319104011-27747-3-git-send-email-sancane@gmail.com>
Date: Thu, 20 Oct 2011 08:07:16 -0300
Message-ID: <CAJdJm_OfNxCj9KvchYTtPqW2+KP7f9Xox7Za4+xd3ZtGur3JAA@mail.gmail.com>
Subject: Re: [PATCH 2/8] Get valid range descriptor if it is supported
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Oct 20, 2011 at 6:46 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> +       p = (uint16_t *) value;
> +       min = btohs(bt_get_unaligned(p));
> +       p = (uint16_t *) &value[2];
> +       max = btohs(bt_get_unaligned(p));

Why not use att_get_u16() here? it does exactly what you want (and no
casting is necessary).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
