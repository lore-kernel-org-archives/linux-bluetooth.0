Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418716295-13447-1-git-send-email-marcin.kraglak@tieto.com>
References: <1418716295-13447-1-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 3 Feb 2015 08:38:19 +0100
Message-ID: <CABD6X-LNhEvHZgiUBWeuPyLx0c-v=dNtO-m0KD+SDRND_sA3Dg@mail.gmail.com>
Subject: Re: [PATCH] attrib: Fix Read Blob error responses
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16 December 2014 at 08:51, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> Read blob response with offset equal to value length should return
> zero length value intead of Invalid Offset Error.
> Found during qualification test case TC/GAR/SR/BV-08-C Read behind
> Long Characteristic Descriptor.
> ---
>  src/attrib-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 6571577..69e6cdc 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -856,7 +856,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
>
>         a = l->data;
>
> -       if (a->len <= offset)
> +       if (a->len < offset)
>                 return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
>                                         ATT_ECODE_INVALID_OFFSET, pdu, len);
>
> --
> 1.9.3
>

Ping

-- 
BR
Marcin Kraglak
