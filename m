Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1373033022-11180-1-git-send-email-luiz.dentz@gmail.com>
References: <1373033022-11180-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 8 Jul 2013 13:46:08 +0200
Message-ID: <CANT-zCUN8L_iVyPmXchmunoKwxt72KR7ZYhbQYtCBwUpxSWbJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/service: Make sure service is disconnected
 before shutdown
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jul 5, 2013 at 4:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This ensures that the service is disconnected before setting the state
> to unavailable.
> ---
>  src/service.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/service.c b/src/service.c
> index 83e1c1a..dce5c05 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -170,6 +170,7 @@ int service_probe(struct btd_service *service)
>
>  void service_shutdown(struct btd_service *service)
>  {
> +       btd_service_disconnect(service);
>         change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
>         service->profile->device_remove(service);
>         service->device = NULL;
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm not a big fan of this approach. The service should already be
disconnected by the time it's shut down, so this additional transition
should not be needed.

Having a look at the current code paths leading to service_shutdown(),
one tricky case I can think of is the call to
device_remove_profiles(), specially from search_cb(). I have my doubts
whether a service shutdown makes sense if it's connected, but in case
yes, I'd add the disconnection code to device_remove_profiles().

Or do you have some other examples where the disconnection is not triggered?

Adding one more side effect to service_shutdown() is IMO undesirable,
where the transitional DISCONNECTED state would be artificially
introduced. Think about an external profile being unregistered while
connected devices exist: not only calling
Profile.RequestDisconnection() doesn't make any sense, but a
transition such as STATE_CONNECTED->STATE_UNAVAILABLE is probably what
you want to observe. This can be different from a graceful
disconnection, and a policy module could use this distinction to
reconnect the service once the external profile gets registered.

Cheers,
Mikel
