Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCWLxhwuPYV8MOVHGGPLeksJjBGf-n2VTVTF1p_Fg8CTEQ@mail.gmail.com>
References: <1334756834-19770-1-git-send-email-luiz.dentz@gmail.com>
	<CANT-zCWLxhwuPYV8MOVHGGPLeksJjBGf-n2VTVTF1p_Fg8CTEQ@mail.gmail.com>
Date: Thu, 19 Apr 2012 12:50:53 +0300
Message-ID: <CABBYNZKdoNGNDV2gFSWtdFhdL3nAiMfXWQiGrt538XMpL2dqRA@mail.gmail.com>
Subject: Re: [PATCH obexd v3] client: Remove buffer based transfer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Apr 19, 2012 at 12:24 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:

>> +       err = transfer_open(transfer, O_RDONLY, 0);
>> +       if (err < 0)
>> +               return err;
>> +
>> +       if (contents != NULL) {
>> +               ssize_t w = write(transfer->fd, contents, size);
>
> This is not going to work because of O_RDONLY. And you can't use
> WRONLY either because this function is used for put operations.

While this is not logically correct, it works because it normally will
call g_file_open_tmp which does open the file with connect mode, so
the mode is ignored.

> In general, I think is not a good idea to get obc_transfer_set_file()
> involved in this patch. This function should disappear once we open
> the files during creation.
>
> Using obc_transfer_set_contents() would be better, as you initially
> suggested. But first it would be convenient to have the "v1 08/11:
> client: open transfer file during creation" patch, which as was posted
> in the mailing list depends on several other patches in that series,
> but if you agree with this idea I can send the relevant ones again,
> specially to avoid patch 07/11 which now wouldn't make sense.

Im working on integrate your patches on top of this one.

-- 
Luiz Augusto von Dentz
