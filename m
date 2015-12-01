Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1448289487-2841-1-git-send-email-gowtham.ab@samsung.com>
References: <1448289487-2841-1-git-send-email-gowtham.ab@samsung.com>
Date: Tue, 1 Dec 2015 12:51:28 +0200
Message-ID: <CABBYNZL22BNGyNQR8dWcXadYTTbjJwC8OQpuz77yZtFbQLUMWw@mail.gmail.com>
Subject: Re: [PATCH] HACKING: Add suppression file in valgrind cmd
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Nov 23, 2015 at 4:38 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Without --suppressions=./tools/valgrind.supp in valgrind cmd,
> bluetoothd throws following error:
>
> ==1237== Syscall param socketcall.bind(my_addr.rc_bdaddr) points to uninitialised byte(s)
> ==1237==    at 0x588B227: bind (syscall-template.S:81)
> ==1237==    by 0x451545: logging_open (log.c:76)
> ==1237==    by 0x451545: __btd_log_init (log.c:314)
> ==1237==    by 0x40B035: main (main.c:610)
> ==1237==  Address 0xfff0003b6 is on thread 1's stack
> ==1237==  in frame #1, created by __btd_log_init (log.c:306)
> ==1237==  Uninitialised value was created by a stack allocation
> ==1237==    at 0x451490: __btd_log_init (log.c:306)
> ==1237==
> ==1237== Syscall param socketcall.bind(my_addr.rc_channel) points to uninitialised byte(s)
> ==1237==    at 0x588B227: bind (syscall-template.S:81)
> ==1237==    by 0x451545: logging_open (log.c:76)
> ==1237==    by 0x451545: __btd_log_init (log.c:314)
> ==1237==    by 0x40B035: main (main.c:610)
> ==1237==  Address 0xfff0003b8 is on thread 1's stack
> ==1237==  in frame #1, created by __btd_log_init (log.c:306)
> ==1237==  Uninitialised value was created by a stack allocation
> ==1237==    at 0x451490: __btd_log_init (log.c:306)
> ---
>  HACKING | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/HACKING b/HACKING
> index ffca598..a8fb403 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -89,8 +89,9 @@ automatically includes this option.
>      # sudo ./src/bluetoothd -n -d
>
>    Run daemon with valgrind
> -   # sudo valgrind --trace-children=yes --track-origins=yes --track-fds=yes
> -   --show-possibly-lost=no --leak-check=full ./src/bluetoothd -n -d
> +   # sudo valgrind --trace-children=yes --track-origins=yes --track-fds=yes \
> +   --show-possibly-lost=no --leak-check=full --suppressions=./tools/valgrind.supp \
> +   ./src/bluetoothd -n -d
>
>  For production installations or distribution packaging it is important that
>  the "--enable-maintainer-mode" option is NOT used.
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
