Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170331135823.21883-1-luiz.dentz@gmail.com>
References: <20170331135823.21883-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Apr 2017 14:08:57 +0300
Message-ID: <CABBYNZLQRsCWxn7b+VUmp_N4+75v28Vj2WC6NEvFRpx51fqsdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Make btmgmt tools installable
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 31, 2017 at 4:58 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  Makefile.tools | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 55d392e..73b2eef 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -348,7 +348,9 @@ EXTRA_DIST += tools/hid2hci.1
>  endif
>
>  if READLINE
> -noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
> +bin_PROGRAMS += tools/btmgmt
> +
> +noinst_PROGRAMS += tools/obex-client-tool tools/obex-server-tool \
>                         tools/bluetooth-player tools/obexctl
>
>  tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
> --
> 2.9.3

Applied.


-- 
Luiz Augusto von Dentz
