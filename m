Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 24 Oct 2013 09:39:07 +0200
Message-ID: <CAHCYCox-C7ApZmPmvQPcgYt-fBfT7mUS7qe4mubfbjv_eaR+Og@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] Enable av interface
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 24 October 2013 09:10, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> For some reason get av interface was missing from hal-bluetooth and from
> hal test tool.
>
> PS: Not sure that haltest is fully implemented, Jerzy please comment here.

I must have missed if-bt in commit.
Thanks Andrei.
Apart from one line in if-bt.c all code to call av interface is there
and should be
functional.

>
> Andrei Emeltchenko (2):
>   android: haltest: Enable av interface in test tool
>   android: Enable AV interface
>
>  android/client/if-bt.c  |    2 +-
>  android/hal-bluetooth.c |    3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jerzy
