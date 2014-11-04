Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414770407-11485-1-git-send-email-bharat.panda@samsung.com>
References: <1414770407-11485-1-git-send-email-bharat.panda@samsung.com>
Date: Tue, 4 Nov 2014 11:25:21 +0200
Message-ID: <CABBYNZLYSCO_kPN1b8XJHXXwa2m75gd3+eH1OP2K7w02k-HrUQ@mail.gmail.com>
Subject: Re: [PATCH ] obexd/ftp: Handle transfer reset for FTP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 31, 2014 at 5:46 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Changes made to emit transfer completed to .Transfer1 interface on
> ftp reset.
> ---
>  obexd/plugins/ftp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
> index 4c35467..e255f48 100644
> --- a/obexd/plugins/ftp.c
> +++ b/obexd/plugins/ftp.c
> @@ -494,6 +494,13 @@ static void ftp_progress(struct obex_session *os, void *user_data)
>         manager_emit_transfer_progress(ftp->transfer);
>  }
>
> +static void ftp_reset(struct obex_session *os, void *user_data)
> +{
> +       struct ftp_session *ftp = user_data;
> +
> +       manager_emit_transfer_completed(ftp->transfer);
> +}
> +
>  static struct obex_service_driver ftp = {
>         .name = "File Transfer server",
>         .service = OBEX_FTP,
> @@ -506,7 +513,8 @@ static struct obex_service_driver ftp = {
>         .chkput = ftp_chkput,
>         .setpath = ftp_setpath,
>         .action = ftp_action,
> -       .disconnect = ftp_disconnect
> +       .disconnect = ftp_disconnect,
> +       .reset = ftp_reset
>  };
>
>  static int ftp_init(void)
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
