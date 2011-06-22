Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
References: <1308695065-3784-1-git-send-email-adamek.kuba@gmail.com>
Date: Wed, 22 Jun 2011 10:33:33 +0300
Message-ID: <BANLkTik0xGCny7z3U_7duqjAV5vLn9_GuA@mail.gmail.com>
Subject: Re: [PATCH obexd v2 00/11] Support user defined headers in gwobex
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Adamek <adamek.kuba@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jun 22, 2011 at 1:24 AM, Jakub Adamek <adamek.kuba@gmail.com> wrote:
> Hi,
>
> these patches will enable sending and receiving of user defined headers
> in gwobex.
>
> Two new functions will enable to start an asynchronous get or put
> transfer, taking as an argument a list of structures describing
> the headers to be sent. The headers are sent out in the order
> of appearance on the list.
>
> Likewise all response headers that would have been previously ignored
> by gwobex are now inserted to a list in the current gw_obex_xfer
> object, and so can be retrieved later after the asynchrous transfer
> has finished.
>
> Additionally, the order of sending headers in gwobex is changed
> to the one mandated by BIP, i.e.:
> Connection ID->Type->Name->Application Parameters->User Defined Headers.
>
> This series incorporates Luiz's changes.
>
> Jakub Adamek (11):
>  Add a_header struct for additional header data
>  Add list to store received headers
>  Add function to create fresh a_header
>  Store received headers in gw_obex_xfer object
>  Add functions to get, put w. a_header list
>  Parse headers in a PUT response packet
>  Add functions for async requests w a_header list
>  Reorder headers to conform to BIP's requirements
>  Handle partial content response from server
>  Convenience method to make deep copy of a_header
>  Add func for fetching header by id from list
>
>  gwobex/gw-obex.h   |   39 +++++++++++++++
>  gwobex/obex-priv.c |  135 +++++++++++++++++++++++++++++++++++----------------
>  gwobex/obex-priv.h |   29 +++++++++++
>  gwobex/obex-xfer.c |   97 +++++++++++++++++++++++++++++++++++++
>  gwobex/obex-xfer.h |   18 +++++++
>  5 files changed, 275 insertions(+), 43 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


I didn't spot more problems with code itself, but you should fix the
function parameter alignment, try to make them similar to what have
been used in code e.g.:

gboolean gw_obex_put_buf_with_apparam(GwObex *ctx, const gchar
*remote, const gchar *type,
                                                             const
guint8 *apparam, gint apparam_size,
                                                             const
gchar *buf, gint buf_size, gint time, gint *error);

-- 
Luiz Augusto von Dentz
