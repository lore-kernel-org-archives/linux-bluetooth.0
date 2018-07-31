Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180731220225.159741-1-salyzyn@android.com>
References: <20180731220225.159741-1-salyzyn@android.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 31 Jul 2018 16:41:35 -0700
Message-ID: <CAGXu5jKoEB5AOVqkAnqq9SjGRU+qSgxdk2ZBWkwZxZOkK8Fn1A@mail.gmail.com>
Subject: Re: [PATCH] HID: Bluetooth: hidp: buffer overflow in hidp_process_report
To: Mark Salyzyn <salyzyn@android.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-bluetooth@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>, Security Officers <security@kernel.org>,
	Android Kernel Team <kernel-team@android.com>, Jiri Kosina <jkosina@suse.cz>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 31, 2018 at 3:02 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> CVE-2018-9363
>
> The buffer length is unsigned at all layers, but gets cast to int and
> checked in hidp_process_report and can lead to a buffer overflow.
> Switch len parameter to unsigned int to resolve issue.
>
> This affects 3.18 and newer kernels.
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")

nit: normally just first 12 of the sha is used.

> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: security@kernel.org
> Cc: kernel-team@android.com
> ---
>  net/bluetooth/hidp/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 1036e4fa1ea2..3bba8f4b08a9 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -431,8 +431,8 @@ static void hidp_del_timer(struct hidp_session *session)
>                 del_timer(&session->timer);
>  }
>
> -static void hidp_process_report(struct hidp_session *session,
> -                               int type, const u8 *data, int len, int intr)
> +static void hidp_process_report(struct hidp_session *session, int type,
> +                               const u8 *data, unsigned int len, int intr)
>  {
>         if (len > HID_MAX_BUFFER_SIZE)
>                 len = HID_MAX_BUFFER_SIZE;

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
