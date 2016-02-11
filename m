Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1111476432.738011454943545661.JavaMail.weblogic@epmlwas06a>
References: <1111476432.738011454943545661.JavaMail.weblogic@epmlwas06a>
Date: Thu, 11 Feb 2016 16:13:36 +0200
Message-ID: <CABBYNZKzWDxD--OdOrtH=LPP4DAB73tCvv0e4_L47M7HP++hkQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] obexd: client: Fix memory leaks
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"syamsidhardh@gmail.com" <syamsidhardh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Mon, Feb 8, 2016 at 4:59 PM, SYAM SIDHARDHAN <s.syam@samsung.com> wrote:
>
> Hi,
> ------- Original Message -------
> Sender : SYAM SIDHARDHAN<s.syam@samsung.com> ./Senior Chief Engineer/SRI-Bangalore-System & Connectivity/Samsung Electronics
> Date : Feb 03, 2016 19:52 (GMT+05:30)
> Title : [PATCH 1/1] obexd: client: Fix memory leaks
>
> We have to free the allocated memory for data and its members.
> ---
> obexd/client/session.c |    1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index ef998f9..5f981bf 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -1179,6 +1179,7 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
> if (!data->remaining || !data->remaining[0]) {
> error("obc_session_setpath: invalid path %s", path);
> g_set_error(err, OBEX_IO_ERROR, -EINVAL, "Invalid argument");
> + setpath_data_free(data);
> return 0;
> }

Applied, thanks.


-- 
Luiz Augusto von Dentz
