Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384441915-23966-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1384441915-23966-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 15 Nov 2013 14:29:10 +0200
Message-ID: <CABBYNZLPvDhx2ewJ0FtkzfYmufOQD6tspqx5Hzez6rig0-RnVQ@mail.gmail.com>
Subject: Re: [PATCHv1 04/16] android/hal-sock: Define structures for socket HAL
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 14, 2013 at 5:11 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> This defines structures for socket HAL. We need to emulate Android
> sockets by sending connect/accept signals over file descriptor.
> ---
>  android/socket.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/android/socket.c b/android/socket.c
> index e580036..4699dce 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -37,6 +37,18 @@
>
>  static bdaddr_t adapter_addr;
>
> +/* Simple list of RFCOMM server sockets */
> +GList *rfcomm_srv_list = NULL;
> +
> +/* Simple list of RFCOMM connected sockets */
> +GList *rfcomm_connected_list = NULL;
> +
> +struct rfcomm_slot {
> +       int fd;         /* descriptor for communication with Java framework */
> +       int real_sock;  /* real RFCOMM socket */
> +       int channel;    /* RFCOMM channel */
> +};

Here you don't really need to define channel as int do you? Also if in
future we want to replace this with splice this should use a pipe to
communicate with the HAL.

Btw, introducing lists and struct without any implementation is never
very good to review, because I have no idea in what context they will
be used.



-- 
Luiz Augusto von Dentz
