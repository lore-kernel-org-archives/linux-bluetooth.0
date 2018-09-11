Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180904162955.28855-1-tanuk@iki.fi>
References: <20180904162955.28855-1-tanuk@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Sep 2018 11:10:23 +0300
Message-ID: <CABBYNZ+gQ90MOPaOHFsZmKoTjbma-zbDw_bwxskSNnBWa_AGXg@mail.gmail.com>
Subject: Re: [PATCH][sbc] sbc: fix frame_length and codesize documentation
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tanu,

On Tue, Sep 4, 2018 at 7:29 PM, Tanu Kaskinen <tanuk@iki.fi> wrote:
> frame_length is the output block size when encoding and the input block
> size when decoding, with codesize it's vice versa. The documentation was
> inaccurate regarding this. Using the terms "compressed" and
> "uncompressed" instead of "output" and "input" should make the function
> semantics clear.
> ---
>  sbc/sbc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sbc/sbc.h b/sbc/sbc.h
> index d6f123e..835460a 100644
> --- a/sbc/sbc.h
> +++ b/sbc/sbc.h
> @@ -100,13 +100,13 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
>  ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
>                         void *output, size_t output_len, ssize_t *written);
>
> -/* Returns the output block size in bytes */
> +/* Returns the compressed block size in bytes */
>  size_t sbc_get_frame_length(sbc_t *sbc);
>
>  /* Returns the time one input/output block takes to play in msec*/
>  unsigned sbc_get_frame_duration(sbc_t *sbc);
>
> -/* Returns the input block size in bytes */
> +/* Returns the uncompressed block size in bytes */
>  size_t sbc_get_codesize(sbc_t *sbc);
>
>  const char *sbc_get_implementation_info(sbc_t *sbc);
> --
> 2.18.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
