Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180402023435.30430-1-inga.stotland@intel.com>
References: <20180402023435.30430-1-inga.stotland@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Apr 2018 10:12:07 +0300
Message-ID: <CABBYNZJXM0j0JSymhkGkDqhi2ooQtdNj_w+PShhjQ_PTE=Lm9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/1] Usage of bt_shell with ell
To: Inga Stotland <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Mon, Apr 2, 2018 at 5:34 AM, Inga Stotland <inga.stotland@intel.com> wrote:
> For test code that relies on underlying ell-based implementation, I would
> like to use the menues and navigation features provided by bt_shell
> without starting glib's mainloop.
> The attached patch allows to do just that. Perhaps, this is not most elegant
> solution, but it seems to be less invasive.


It should be possible to create ell backend for mainloop/io, etc, that
the shell uses, in fact btmgmt already do use a different mainloop
than glib.

> Inga Stotland (1):
>   shared/shell: Add commands to allow shell usage with external mainloop
>
>  src/shared/shell.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  src/shared/shell.h |  3 +++
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> --
> 2.14.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
