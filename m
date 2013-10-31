Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 16:04:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hidhost: Fix not unregistering HID
Message-ID: <20131031140458.GB27325@x220.p-661hnu-f1>
References: <1383227514-22944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383227514-22944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 31, 2013, Andrei Emeltchenko wrote:
> If HID is not unregistered it cannot be registered again and we get
> following error:
> ...
> E/BluetoothHidServiceJni( 2849): Failed to initialize Bluetooth HID, status: 1
> ...
> ---
>  android/hal-hidhost.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
> index a72410b..a81fea5 100644
> --- a/android/hal-hidhost.c
> +++ b/android/hal-hidhost.c
> @@ -301,12 +301,17 @@ static bt_status_t hh_init(bthh_callbacks_t *callbacks)
>  
>  static void hh_cleanup(void)
>  {
> +	struct hal_cmd_unregister_module cmd;
> +
>  	DBG("");
>  
>  	if (!interface_ready())
>  		return;
>  
>  	bt_hh_cbacks = NULL;
> +
> +	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
> +					sizeof(cmd), &cmd, 0, NULL, NULL);
>  }

Did you test this at all? It looks completely broken to me since you
pass an uninitialized variable to hal_ipc_cmd. You should be at least
setting the right service id for HID in the cmd struct.

Johan
