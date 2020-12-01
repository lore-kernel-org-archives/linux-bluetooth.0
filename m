Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4546BC64E90
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 16:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8408206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 16:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgLAQ2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 11:28:35 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:47019 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLAQ2f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 11:28:35 -0500
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D6839200002;
        Tue,  1 Dec 2020 16:27:52 +0000 (UTC)
Message-ID: <f92e2c6b4b9981405a035f957a04290133453c9a.camel@hadess.net>
Subject: Re: [PATCH BlueZ v5 6/7] adapter: Add a public function to find a
 device by path
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>,
        linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 01 Dec 2020 17:27:52 +0100
In-Reply-To: <20201130215602.386545-6-sonnysasaka@chromium.org>
References: <20201130215602.386545-1-sonnysasaka@chromium.org>
         <20201130215602.386545-6-sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2020-11-30 at 13:56 -0800, Sonny Sasaka wrote:
> The public function is motivated by the Battery Provider API code
> which
> needs to probe whether a device exists.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> 
> ---
>  src/adapter.c | 33 ++++++++++++++++++++++++---------
>  src/adapter.h |  2 ++
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 56d0c6eaa..03d9d29e9 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -872,6 +872,30 @@ struct btd_device
> *btd_adapter_find_device(struct btd_adapter *adapter,
>         return device;
>  }
>  
> +static int device_path_cmp(gconstpointer a, gconstpointer b)
> +{
> +       const struct btd_device *device = a;
> +       const char *path = b;
> +       const char *dev_path = device_get_path(device);
> +
> +       return strcasecmp(dev_path, path);
> +}
> +
> +struct btd_device *btd_adapter_find_device_by_path(struct
> btd_adapter *adapter,
> +                                                  const char *path)
> +{
> +       GSList *list;
> +
> +       if (!adapter)
> +               return NULL;
> +
> +       list = g_slist_find_custom(adapter->devices, path,
> device_path_cmp);
> +       if (!list)
> +               return NULL;
> +
> +       return list->data;
> +}
> +
>  static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
>  {
>         if (uuid->type == SDP_UUID16)
> @@ -3192,15 +3216,6 @@ static gboolean property_get_roles(const
> GDBusPropertyTable *property,
>         return TRUE;
>  }
>  
> -static int device_path_cmp(gconstpointer a, gconstpointer b)
> -{
> -       const struct btd_device *device = a;
> -       const char *path = b;
> -       const char *dev_path = device_get_path(device);
> -
> -       return strcasecmp(dev_path, path);
> -}

You should move the function in a separate patch, ideally. This is
helpful to show that the function was not modified in any way.

>  static DBusMessage *remove_device(DBusConnection *conn,
>                                         DBusMessage *msg, void
> *user_data)
>  {
> diff --git a/src/adapter.h b/src/adapter.h
> index e5750a37b..60b5e3bcc 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -83,6 +83,8 @@ sdp_list_t *btd_adapter_get_services(struct
> btd_adapter *adapter);
>  struct btd_device *btd_adapter_find_device(struct btd_adapter
> *adapter,
>                                                         const
> bdaddr_t *dst,
>                                                         uint8_t
> dst_type);
> +struct btd_device *btd_adapter_find_device_by_path(struct
> btd_adapter *adapter,
> +                                                  const char *path);
>  
>  const char *adapter_get_path(struct btd_adapter *adapter);
>  const bdaddr_t *btd_adapter_get_address(struct btd_adapter
> *adapter);


