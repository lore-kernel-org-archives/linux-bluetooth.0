Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 10:42:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix not returning in failure
Message-ID: <20131218084207.GA17745@x220.p-661hnu-f1>
References: <1387289853-8942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387289853-8942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Dec 17, 2013, Andrei Emeltchenko wrote:
> ---
>  android/android-tester.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 2a8c8d0..c193921 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -851,8 +851,10 @@ static void setup_socket_interface(const void *test_data)
>  	setup(data);
>  
>  	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
> -	if (!sock)
> +	if (!sock) {
>  		tester_setup_failed();
> +		return;
> +	}
>  
>  	data->if_sock = sock;

Applied. Thanks.

Johan
