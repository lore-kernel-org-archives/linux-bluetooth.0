Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335367519-16361-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1335367519-16361-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 25 Apr 2012 15:35:47 -0400
Message-ID: <CAJdJm_Pbndzgs6OKkkyQiXNYhTFwpwhHkf+V_WDkFWV-Q=xkNw@mail.gmail.com>
Subject: Re: [PATCH] gatttool: Fix handle parsing in cmd_char_write()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, Apr 25, 2012 at 11:25 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> errno is not set to 0 before call to strtoll() so cmd_char_write() can fail
> even with proper data. Use strtohandle() helper function instead.
> ---
>  attrib/interactive.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
