Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345216001-8422-1-git-send-email-sunil.behera@samsung.com>
References: <1345216001-8422-1-git-send-email-sunil.behera@samsung.com>
Date: Mon, 20 Aug 2012 11:43:22 +0300
Message-ID: <CABBYNZLVgoGgMkTVCLAKdLvwWCpScY0DWkY-w0KF9RFNyhbuAw@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] MAP: Add offset parameter decription
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Fri, Aug 17, 2012 at 6:06 PM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> Add offset parameter description for
> messages_get_messages_listing() function header
> ---
>  plugins/messages.h |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/plugins/messages.h b/plugins/messages.h
> index 83e087a..beca3a8 100644
> --- a/plugins/messages.h
> +++ b/plugins/messages.h
> @@ -215,6 +215,7 @@ int messages_get_folder_listing(void *session, const char *name, uint16_t max,
>   * session: Backend session.
>   * name: Optional subdirectory name.
>   * max: Maximum number of entries to retrieve.
> + * offset: Offset of the first entry.
>   * filter: Filter to apply on returned message listing.
>   * size: Total size of listing to be returned.
>   * newmsg: Indicates presence of unread messages.
> --
> 1.7.9.5

These 2 patches are now pushed upstream, thanks.


-- 
Luiz Augusto von Dentz
