Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387204652-14850-2-git-send-email-szymon.janc@tieto.com>
References: <1387204652-14850-1-git-send-email-szymon.janc@tieto.com>
	<1387204652-14850-2-git-send-email-szymon.janc@tieto.com>
Date: Mon, 16 Dec 2013 17:19:48 +0200
Message-ID: <CABBYNZLu11494VB7WKMj-nxaXr1GfzNt_unYezPcU==e_7HweQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] android/hidhost: Simplify handle_uhid_output
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 16, 2013 at 4:37 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Make it use VLA for req buffer. This makes function simpler and also
> fix cutting req to 255 bytes (req_len was uint8_t)
> ---
>  android/hidhost.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 0e0391a..76322af 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -156,29 +156,22 @@ static void hid_device_free(struct hid_device *dev)
>  static void handle_uhid_output(struct hid_device *dev,
>                                                 struct uhid_output_req *output)
>  {
> -       int fd, i;
> -       uint8_t *req = NULL;
> -       uint8_t req_size = 0;
> +       int fd;
> +       unsigned int i;
> +       uint8_t req[1 + (output->size / 2)];

Im not a fan of VLA and Ive seem even some static analyzer that would
warn about its use without first checking > 0 and have a check of
upper bond limit, so perhaps just having it set to UHID_DATA_MAX or
dynamically allocate a buffer to match the output MTU size of the
control channel would better imo.



-- 
Luiz Augusto von Dentz
