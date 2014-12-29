Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1419636684-7158-1-git-send-email-mariusz.skamra@tieto.com>
References: <1419636684-7158-1-git-send-email-mariusz.skamra@tieto.com>
Date: Mon, 29 Dec 2014 15:49:57 -0200
Message-ID: <CABBYNZKL7oM_7un+-x1ZYHYaMkPDx5+JS3h=csoCL_zeF+sgHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: Fix comparison between signed and unsigned integer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Fri, Dec 26, 2014 at 9:31 PM, Mariusz Skamra
<mariusz.skamra@tieto.com> wrote:
> len is non-negative here, so we can safely cast it to size_t.
> ---
>  tools/bluemoon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bluemoon.c b/tools/bluemoon.c
> index c785472..0f32d63 100644
> --- a/tools/bluemoon.c
> +++ b/tools/bluemoon.c
> @@ -767,7 +767,7 @@ static void analyze_firmware(const char *path)
>         printf("\n");
>
>
> -       if (len != le32_to_cpu(css->size) * 4) {
> +       if ((size_t) len != le32_to_cpu(css->size) * 4) {
>                 fprintf(stderr, "CSS.size does not match file length\n");
>                 goto done;
>         }
> --
> 1.9.1

It seems this has been fixed already.


-- 
Luiz Augusto von Dentz
