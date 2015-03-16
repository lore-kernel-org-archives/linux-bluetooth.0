Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hog: Allow to pass custom fd for uhid
Date: Mon, 16 Mar 2015 16:28:47 +0100
Message-ID: <10891269.ckYh92OItJ@leonov>
In-Reply-To: <1426427072-20085-1-git-send-email-szymon.janc@tieto.com>
References: <1426427072-20085-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sunday 15 of March 2015 14:44:32 Szymon Janc wrote:
> This will be useful for unitests.
> ---
>  android/hidhost.c |  2 +-
>  android/hog.c     | 25 ++++++++++++++++++++-----
>  android/hog.h     |  9 +++++++--
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 2e589f4..729b884 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -817,7 +817,7 @@ static void hog_conn_cb(const bdaddr_t *addr, int err,
> void *attrib)
> 
>  	if (!dev->hog) {
>  		/* TODO: Get device details and primary */
> -		dev->hog = bt_hog_new("bluez-input-device", dev->vendor,
> +		dev->hog = bt_hog_new_default("bluez-input-device", dev->vendor,
>  					dev->product, dev->version, NULL);
>  		if (!dev->hog) {
>  			error("HoG: unable to create session");
> diff --git a/android/hog.c b/android/hog.c
> index 8133303..ff77bb3 100644
> --- a/android/hog.c
> +++ b/android/hog.c
> @@ -87,6 +87,7 @@ struct bt_hog {
>  	GAttrib			*attrib;
>  	GSList			*reports;
>  	struct bt_uhid		*uhid;
> +	int			uhid_fd;
>  	gboolean		has_report_id;
>  	uint16_t		bcdhid;
>  	uint8_t			bcountrycode;
> @@ -1170,8 +1171,16 @@ static void hog_free(void *data)
>  	g_free(hog);
>  }
> 
> -struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t
> product, -					uint16_t version, void *primary)
> +struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
> +					uint16_t product, uint16_t version,
> +					void *primary)
> +{
> +	return bt_hog_new(-1, name, vendor, product, version, primary);
> +}
> +
> +struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
> +					uint16_t product, uint16_t version,
> +					void *primary)
>  {
>  	struct bt_hog *hog;
> 
> @@ -1181,7 +1190,13 @@ struct bt_hog *bt_hog_new(const char *name, uint16_t
> vendor, uint16_t product,
> 
>  	hog->gatt_op = queue_new();
>  	hog->bas = queue_new();
> -	hog->uhid = bt_uhid_new_default();
> +
> +	if (fd < 0)
> +		hog->uhid = bt_uhid_new_default();
> +	else
> +		hog->uhid = bt_uhid_new(fd);
> +
> +	hog->uhid_fd = fd;
> 
>  	if (!hog->gatt_op || !hog->bas || !hog->uhid) {
>  		hog_free(hog);
> @@ -1305,8 +1320,8 @@ static void hog_attach_hog(struct bt_hog *hog, struct
> gatt_primary *primary) return;
>  	}
> 
> -	instance = bt_hog_new(hog->name, hog->vendor, hog->product,
> -							hog->version, primary);
> +	instance = bt_hog_new(hog->uhid_fd, hog->name, hog->vendor,
> +					hog->product, hog->version, primary);
>  	if (!instance)
>  		return;
> 
> diff --git a/android/hog.h b/android/hog.h
> index ddb2cea..2a9b899 100644
> --- a/android/hog.h
> +++ b/android/hog.h
> @@ -23,8 +23,13 @@
> 
>  struct bt_hog;
> 
> -struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t
> product, -					uint16_t version, void *primary);
> +struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
> +					uint16_t product, uint16_t version,
> +					void *primary);
> +
> +struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
> +					uint16_t product, uint16_t version,
> +					void *primary);
> 
>  struct bt_hog *bt_hog_ref(struct bt_hog *hog);
>  void bt_hog_unref(struct bt_hog *hog);

Applied.

-- 
BR
Szymon Janc
