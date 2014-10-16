Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413382102-4049-1-git-send-email-gowtham.ab@samsung.com>
References: <1413382102-4049-1-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 16 Oct 2014 11:17:41 +0300
Message-ID: <CABBYNZKe1=awjhj2XttF+7gyHaw8f5zWftL=p1wrf+HWMUefMQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools/csr_usb : Fix Resource leak: file
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 15, 2014 at 5:08 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Handles resource leak.
> ---
>  tools/csr_usb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/csr_usb.c b/tools/csr_usb.c
> index 5fb6bdc..a1d7324 100644
> --- a/tools/csr_usb.c
> +++ b/tools/csr_usb.c
> @@ -80,9 +80,12 @@ static int read_value(const char *name, const char *attr, const char *format)
>                 return -1;
>
>         n = fscanf(file, format, &value);
> -       if (n != 1)
> +       if (n != 1) {
> +               fclose(file);
>                 return -1;
> +       }
>
> +       fclose(file);
>         return value;
>  }
>
> --
> 1.9.1

Applied 1-3, but note that I did some changes in the commit message,
please be consistent and don't include things like space before ':'
etc, it is always a good practice got look how previous commit have
been formatted and follow the HACKING document.


-- 
Luiz Augusto von Dentz
