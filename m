Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix valgrind memory warnings
Date: Fri, 20 Dec 2013 10:12:57 +0100
Message-ID: <2739769.kltLLfnETe@uw000953>
In-Reply-To: <1387529782-26462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387529782-26462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Free device structure allocated during open_bluetooth().
> ---
>  android/android-tester.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 7d7ed88..6007797 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -109,6 +109,7 @@ struct test_data {
>  	const void *test_data;
>  	pid_t bluetoothd_pid;
>  
> +	hw_device_t *device;
>  	const bt_interface_t *if_bluetooth;
>  	const btsock_interface_t *if_sock;
>  
> @@ -838,6 +839,8 @@ static void setup(struct test_data *data)
>  		return;
>  	}
>  
> +	data->device = device;
> +
>  	data->if_bluetooth = ((bluetooth_device_t *)
>  					device)->get_bluetooth_interface();
>  	if (!data->if_bluetooth) {
> @@ -882,6 +885,9 @@ static void teardown(const void *test_data)
>  		data->if_bluetooth = NULL;
>  	}
>  
> +	if (data->device)
> +		free(data->device);

There is no need to check pointer before passing it to free().

> +
>  	if (data->bluetoothd_pid)
>  		waitpid(data->bluetoothd_pid, NULL, 0);
>  
> 

-- 
BR
Szymon Janc


