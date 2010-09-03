Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1283513613-6860-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1283513613-6860-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Date: Fri, 3 Sep 2010 15:13:29 +0300
Message-ID: <AANLkTim8+D6muD0EV+MW5CTTkark0aO4ch=syiOOUKMA@mail.gmail.com>
Subject: Re: [PATCH] Fix clean-local target
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 3, 2010 at 2:33 PM, Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@tieto.com> wrote:
> The fix avoids failure of the second consequent call of 'make clean'.
>
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  Makefile.am |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 5684e99..2fa03e1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -385,5 +385,5 @@ lib/bluetooth/%.h: lib/%.h
>        $(AM_V_at)$(MKDIR_P) lib/bluetooth
>        $(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
>
> -clean-local: lib/bluetooth
> -       @$(RM) -r $<
> +clean-local:
> +       $(RM) -r lib/bluetooth
> \ No newline at end of file
> --
> 1.7.0.4

Could you please remove the Signed-off-by, we don't use it on userspace.

-- 
Luiz Augusto von Dentz
Computer Engineer
