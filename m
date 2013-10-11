Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Oct 2013 13:58:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] audio/AVCTP: Fix crash after disconnecting
Message-ID: <20131011115840.GA7403@x220.p-661hnu-f1>
References: <1381491762-25395-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381491762-25395-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 11, 2013, Luiz Augusto von Dentz wrote:
>   at 0x414C08: finalize_discovery (avdtp.c:1050)
>   by 0x414C5A: process_discover (avdtp.c:3346)
>   by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x40A3B6: main (main.c:595)
> Address 0x5e25de8 is 1,144 bytes inside a block of size 1,176 free'd
> at 0x4A074C4: free (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>   by 0x3D4604D9AE: g_free (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x4152F2: connection_lost (avdtp.c:1206)
>   by 0x4162C4: cancel_request (avdtp.c:2662)
>   by 0x4164BD: request_timeout (avdtp.c:2672)
>   by 0x3D46048962: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
>   by 0x40A3B6: main (main.c:595)
> ---
>  profiles/audio/avdtp.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 622dff8..b938ee7 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -354,6 +354,12 @@ struct avdtp_state_callback {
>  	void *user_data;
>  };
>  
> +struct discover_callback {
> +	unsigned int id;
> +	avdtp_discover_cb_t cb;
> +	void *user_data;
> +};
> +
>  struct avdtp_stream {
>  	GIOChannel *io;
>  	uint16_t imtu;
> @@ -412,9 +418,7 @@ struct avdtp {
>  
>  	char *buf;
>  
> -	avdtp_discover_cb_t discov_cb;
> -	void *user_data;
> -
> +	struct discover_callback *discover;
>  	struct pending_req *req;

It seems to me that this patch is doing two things:

1. Refactor the discov data out to a separate struct
2. Add an idle callback id for some extra tracking

Shouldn't these be done in separate patches? Furthermore, I had to read
through the patch several times to figure out exactly what the fix is -
something I wouldn't have needed to do if there was a proper commit
message explaining what was wrong and how you fix it.

Johan
