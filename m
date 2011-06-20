Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
Date: Mon, 20 Jun 2011 13:33:20 +0300
Message-ID: <BANLkTiky_NmaU8JWLT0vOvOiS3mZnU=t9Q@mail.gmail.com>
Subject: Re: [PATCH obexd 01/14] Update OPP service record for GOEP v2.0.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, haijun@qca.qualcomm.com,
	yongli@qca.qualcomm.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

On Mon, Jun 20, 2011 at 12:44 PM, Nami <nami.li@atheros.com> wrote:
> Hi,all
>  These patches support opp and ftp over l2cap. Currently I just modified OPP and FTP.
>  Please help review these patches.
>  Thanks.
>
> ---
>  plugins/opp.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/opp.c b/plugins/opp.c
> index 17c4356..7ea7e18 100644
> --- a/plugins/opp.c
> +++ b/plugins/opp.c
> @@ -71,7 +71,7 @@
>     <sequence>                                                 \
>       <sequence>                                               \
>         <uuid value=\"0x1105\"/>                               \
> -        <uint16 value=\"0x0100\" name=\"version\"/>            \
> +        <uint16 value=\"0x0102\" name=\"version\"/>            \
>       </sequence>                                              \
>     </sequence>                                                        \
>   </attribute>                                                 \
> @@ -91,6 +91,10 @@
>       <uint8 value=\"0xff\"/>                                  \
>     </sequence>                                                        \
>   </attribute>                                                 \
> +                                                                        \
> +  <attribute id=\"0x0200\">                                            \
> +       <uint16 value=\"%u\" name=\"psm\"/>                     \
> +  </attribute>                                                 \
>  </record>"
>
>  static void *opp_connect(struct obex_session *os, int *err)
> --
> 1.7.1
>
> --

I review some of the more obvious issues, but you please next send the
obex-client and obexd in different series? It confuses use since the
sometimes are similar but for different purposes (client/server), also
personally I don't suggest sending big series (> 5 patches), split
them into logical sets e.g server, client, gwobex (this is actually
necessary to apply to gwobex repository too) and send them separated
waiting them to get applied before sending the next one.

-- 
Luiz Augusto von Dentz
