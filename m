Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 BlueZ 2/3] doc/gatt-api: Merge RegisterProfile with RegisterApplication
In-Reply-To: <1461926313-5629-2-git-send-email-luiz.dentz@gmail.com>
References: <1461926313-5629-1-git-send-email-luiz.dentz@gmail.com> <1461926313-5629-2-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 29 Apr 2016 11:01:06 -0300
Message-ID: <87fuu4fra5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Since RegisterApplication makes use of ObjectManager it is also possible
> to verify the existance of GattProfile objects unifying the API for both
> services (GATT server) and profiles (GATT client).
> ---
>  doc/gatt-api.txt | 37 +++++++++----------------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 683b1b7..9404986 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -218,8 +218,8 @@ Properties	string UUID [read-only]
>  				"encrypt-authenticated-read"
>  				"encrypt-authenticated-write"
>
> -Profile hierarcy
> -================
> +GATT Profile hierarcy
> +=====================
>
>  Local profile (GATT client) instance. By registering this type of object
>  an application effectively indicates support for a specific GATT profile
> @@ -238,6 +238,10 @@ Methods		void Release()
>  			profile, because when this method gets called it has
>  			already been unregistered.
>
> +Properties	array{string} UUIDs [read-only]
> +
> +			128-bit GATT service UUIDs.
> +
>
>  GATT Manager hierarchy
>  ======================
> @@ -306,11 +310,12 @@ Object path	[variable prefix]/{hci0,hci1,...}
>  Methods		void RegisterApplication(object application, dict options)
>
>  			Registers a local GATT services hierarchy as described
> -			above.
> +			above (GATT Server) and/or GATT profiles (GATT Client).
>
>  			The application object path together with the D-Bus
>  			system bus connection ID define the identification of
> -			the application registering a GATT based service.
> +			the application registering a GATT based
> +			service or profile.

I guess that updating the '/com/example' example above with a profile
case will go a long way making this clearer.


Cheers,
--
Vinicius
