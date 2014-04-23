Return-Path: <cyrus@holtmann.org>
From: Martin Kampas <martin.kampas@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] obex-client-tool: Set the length header
Date: Wed, 23 Apr 2014 12:20:06 +0200
Message-ID: <5012684.PXV09D887U@5th>
In-Reply-To: <CABBYNZJjB6D4Bekqu+wK9EeRrzg=26GFhB-KW-Spzq7X-tt4cg@mail.gmail.com>
References: <1398143280-21017-1-git-send-email-martin.kampas@tieto.com> <CABBYNZ+6aXGkqnHcoaYCU+2DQ95i_W-+g2H4dM8uAV0rob1_CA@mail.gmail.com> <CABBYNZJjB6D4Bekqu+wK9EeRrzg=26GFhB-KW-Spzq7X-tt4cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday, April 23, 2014 11:28:55 AM Luiz Augusto von Dentz wrote:
> Try the with the following patch:
> 
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index bd4770d..7b4634e 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -873,6 +873,10 @@ static void cmd_put(GObex *obex, GObexPacket
> *req, gpointer user_data)
> 
>         os->cmd = G_OBEX_OP_PUT;
> 
> +       /* Set size to unknown if a body header exists */
> +       if (g_obex_packet_get_body(req))
> +               os->size = OBJECT_SIZE_UNKNOWN;
> +
>         parse_name(os, req);
>         parse_length(os, req);
>         parse_time(os, req);

I tried your patch with the old obexd v0.48 and it worked (I am sorry I could not easily try with the newest obexd from bluez tree).

Both patches seems worth to apply - mine to make the obex-client-tool work with old buggy devices.

Here is your patch aligned for v0.48:

diff --git a/src/obex.c b/src/obex.c
index 9044961..5ae4ff1 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -961,6 +961,10 @@ static void cmd_put(GObex *obex, GObexPacket *req, gpointer user_data)
 
        os->cmd = G_OBEX_OP_PUT;
 
+       /* Set size to unknown if a body header exists */
+       if (g_obex_packet_get_body(req))
+               os->size = OBJECT_SIZE_UNKNOWN;
+
        parse_name(os, req);
        parse_length(os, req);
        parse_time(os, req);
--

BR,
Martin



