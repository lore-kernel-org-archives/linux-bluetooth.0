Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352475687-15070-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352475687-15070-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Mon, 12 Nov 2012 07:41:43 -0400
Message-ID: <CAJdJm_OHoqsec-H=hWqUOD0pHcpAyrR4=TCLaSSx1wORgohBxg@mail.gmail.com>
Subject: Re: [PATCH] gatt: Update characteristic names translation table
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Fri, Nov 9, 2012 at 11:41 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> ---
>  attrib/client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Most characteristics you are adding here come from profiles which have
not been adopted yet, so they are not publicly available.

I would first wait for their adoption before adding here, as AFAIK it
is still possible that their UUIDs might change before final adoption.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
