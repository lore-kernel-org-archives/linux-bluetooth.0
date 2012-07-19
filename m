Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1342694975-9184-1-git-send-email-luiz.dentz@gmail.com>
References: <1342694975-9184-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 19 Jul 2012 08:36:15 -0300
Message-ID: <CAMOw1v7Z1VTw2Q=y15O+iB7pCWip_HvNWQe7sM3YKtVReM4V=A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] AVCTP: Make use of sendmsg to avoid copying data
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jul 19, 2012 at 7:49 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This use sendmsg to send headers and operands in separated buffers
> avoiding memcpy.
> ---

Nice...  only a small issue

>  audio/avctp.c |   21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index e3e5275..9ef6161 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -929,23 +929,20 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
>                                 uint8_t code, uint8_t subunit, uint8_t opcode,
>                                 uint8_t *operands, size_t operand_count)
>  {
> -       uint8_t *buf;
> +       uint8_t buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];

you need to zero-out this, or set all the fields below.



Lucas De Marchi
