Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414420542-15336-4-git-send-email-armansito@chromium.org>
References: <1414420542-15336-1-git-send-email-armansito@chromium.org>
	<1414420542-15336-4-git-send-email-armansito@chromium.org>
Date: Tue, 28 Oct 2014 11:26:19 +0200
Message-ID: <CABBYNZLK2iZ+NhPPU_3=Tw17Zr9484gy_Q8Rm8XbWQMytR=idQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 3/7] tools/btgatt-client: Fix read-long-value
 offset parsing.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Oct 27, 2014 at 4:35 PM, Arman Uguray <armansito@chromium.org> wrote:
> This patch fixes the way read-long-value command parses the "offset"
> argument by interpreting it as base 10 instead of 16, which is more
> intuitive.
> ---
>  tools/btgatt-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index b7bfa24..e7cd31c 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -486,8 +486,8 @@ static void cmd_read_long_value(struct client *cli, char *cmd_str)
>         }
>
>         endptr = NULL;
> -       offset = strtol(argv[1], &endptr, 16);
> -       if (!endptr || *endptr != '\0' || !handle) {
> +       offset = strtol(argv[1], &endptr, 10);
> +       if (!endptr || *endptr != '\0') {
>                 printf("Invalid offset: %s\n", argv[1]);
>                 return;
>         }
> --
> 2.1.0.rc2.206.gedb03e5

Perhaps we should use base 0 here and let strtol figure what base it is:

'If base is zero or 16, the string may then include a "0x" prefix, and
the number will be read in base 16; otherwise, a zero base is taken as
10 (decimal) unless the next character is '0', in which case it is
taken as 8 (octal).'


-- 
Luiz Augusto von Dentz
