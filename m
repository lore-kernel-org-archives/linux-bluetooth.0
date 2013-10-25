Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382698306-30914-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382698306-30914-1-git-send-email-jerzy.kasenberg@tieto.com>
Date: Fri, 25 Oct 2013 14:56:43 +0300
Message-ID: <CABBYNZJmqpHY=jy1EyqdgCKndAz8KaUDnKsmH_L-7eRktp0Qnw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add basic scripting to haltest
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Fri, Oct 25, 2013 at 1:51 PM, Jerzy Kasenberg
<jerzy.kasenberg@tieto.com> wrote:
> This patcheset adds command 'source' to interpret scripts
> and processing of .haltestrc to execute some commands automatically.
> v2:
>  - small styl changed (fd == -1) changed to (fd < 0)
>
> Jerzy Kasenberg (2):
>   android/client: Add source command to haltest
>   android/client: Add processing of .haltestrc
>
>  android/client/haltest.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>
> --
> 1.7.9.5

Applied, thanks.


-- 
Luiz Augusto von Dentz
