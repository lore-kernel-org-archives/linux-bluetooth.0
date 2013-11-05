Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] android/daemon: Save adapter name on complete event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383646128-8077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 5 Nov 2013 13:28:44 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <A8764F57-113A-4114-B0F6-AA1C711B8A83@holtmann.org>
References: <CABBYNZKJV-h82WQ5_J3z+ArC3=Gy00qTpKHhWSF7v+fFC7KTrA@mail.gmail.com> <1383646128-8077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Saving adapter name was missing from set name complete event.
> Refactor code to function and reuse it in both places where
> name is changed.
> ---
> android/adapter.c |   21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index b6f6096..6b0dc8b 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -88,6 +88,17 @@ static void adapter_name_changed(const uint8_t *name)
> 			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
> }
> 
> +static void adapter_set_name(const uint8_t *name)
> +{
> +	if (!g_strcmp0(adapter->name, (const char *) name))
> +		return;
> +
> +	DBG("Cnage name: %s -> %s", adapter->name, name);
> +
> +	g_free(adapter->name);
> +	adapter->name = g_strdup((const char *) name);
> +}
> +
> static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
> 					const void *param, void *user_data)
> {
> @@ -98,13 +109,7 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
> 		return;
> 	}
> 
> -	if (!g_strcmp0(adapter->name, (const char *) rp->name))
> -		return;
> -
> -	DBG("name: %s", rp->name);
> -
> -	g_free(adapter->name);
> -	adapter->name = g_strdup((const char *) rp->name);
> +	adapter_set_name(rp->name);
> 
> 	adapter_name_changed(rp->name);
> }
> @@ -879,6 +884,8 @@ static void set_adapter_name_complete(uint8_t status, uint16_t length,
> 		return;
> 	}
> 
> +	adapter_set_name(rp->name);
> +
> 	adapter_name_changed(rp->name);

can we feed adapter_set_name and adapter_name_change into a single function. Especially since this is not public API and will never be, please make sure consolidate these things properly. Copies from src/adapter.c are pointless since it does not have to handle any special cases like external hostnamed daemon or plugins.

With most of these function, we need to make to store the value and send out a notification. We never do anything else. So lets keep this simple. No need to spaghetti code.

Regards

Marcel

