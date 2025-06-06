Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183F289343
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228933; cv=pass; b=oUrFz7zV9VP2G+WSQpV5XqoNGYCOEQOgpLk3DnVlwkiarq1EQxXRX3Xq9qAzh9jUggLbROErFByoo7TOjNIo0pks686WqLJKAbuYhB9pFT8m3NeTvulDwxbprv7Og7MrAp5WX2xURjO80A/Jp55ZJ1GmrjfFEnUHFrDNwyKkDww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228933; c=relaxed/simple;
	bh=e0SH2gUmaO8ENjma+nAUWAUyL9x6Xz9RVI3DxZrdE8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQhvfTh6+dvqM5Wj2uj/XFacTTcAsLt8G5p6iiFlDDL0Mmcdzptx6Wwf0KEfXCbRuFRDOeEJ98MTX+8XZnkGX+pYTjEtLukjWs7lKgXZFXaC625VxiLAFJsjLmnO5nFrKnRlKSWmzm967qM4FSqUCIuzKaaWaKt6YOWUNSt8XlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=g1rSrl2V; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="g1rSrl2V"
ARC-Seal: i=1; a=rsa-sha256; t=1749228911; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J9hCFmHmAy1HZ9zOF5cwdvc7vlOUo7oeyiJ7mUHyrZqpY0GNO0uZ09huej95jnKAsF+XZ6wYHgygDJGi1Ak7QMCL8jME7/BLC3U6cxAxs/P7hXIUQ8n6ipSoMpI8lyW752aBABFnIJ74PGWSU/K2d1JIFNNXIh25/C1EusX4MXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749228911; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KCHFwXpu5SXcH92uuzCNsX1gBSjSy4zGar3rIxI6fYQ=; 
	b=i2QItARNDRYpCBm06PFRTsdF/Kx1FKAreEnPJf3zXnajqiWcrQ4p3gFBIbYP6Ouh4qeer9UKOOvQuYfJNAzKt6N+AhdLuupN2gYaav7D2F9ahsSjs28GX+fW5oXgogEe8i8YiDSqxE9O/NilePob6T3Ys5YztAWv1zenDvlLwds=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749228911;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KCHFwXpu5SXcH92uuzCNsX1gBSjSy4zGar3rIxI6fYQ=;
	b=g1rSrl2VDSjvkx6XymUwCYcDHK3YHwXW2m94tdLbsi18EHhJFS1HfpKwQ/dTfURr
	HxKMfR4NdeaM3G4ZlW7qTjcwd0bxuj1mgX6J9AXLV7assyFT6rUuVRtO8HrjWfHMAyd
	2gjuaWWxRCJx1OsvVfrsIYFnp7lQA3gh6ydDlsL4=
Received: by mx.zohomail.com with SMTPS id 1749228909808304.29277809568146;
	Fri, 6 Jun 2025 09:55:09 -0700 (PDT)
Message-ID: <dbe336b6-4500-45ec-99d3-2d442ab8d7f1@collabora.com>
Date: Fri, 6 Jun 2025 18:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/3] obexd: Pass at_(un)register value to logind
 callbacks
To: Andrew Sayers <kernel.org@pileofstuff.org>,
 linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, pav@iki.fi
References: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
 <20250603151651.1080923-2-kernel.org@pileofstuff.org>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20250603151651.1080923-2-kernel.org@pileofstuff.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Andrew,

On 03/06/2025 17:13, Andrew Sayers wrote:
> Logind (un)registers callbacks that it calls when the user's state changes.
> Callbacks may also be called during (un)registration.
> Clients may need to handle those initial/final calls specially.
>
> Pass an argument indicating whether this is being called during
> (un)registration, and modify existing callbacks to ignore that argument.
>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>   obexd/client/pbap.c       |  6 ++++--
>   obexd/plugins/bluetooth.c |  6 ++++--
>   obexd/src/logind.c        | 14 +++++++-------
>   obexd/src/logind.h        |  8 ++++----
>   4 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 51b523592..64bb8ff72 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -1455,8 +1455,9 @@ static struct obc_driver pbap = {
>   	.remove = pbap_remove
>   };
>   
> -static int pbap_init_cb(void)
> +static int pbap_init_cb(gboolean at_register)
>   {
> +	(void)at_register;
>   	int err;
Building on Ubuntu 24.04 I got the following error:

obexd/client/pbap.c:1461:9: error: ISO C90 forbids mixed declarations 
and code [-Werror=declaration-after-statement]
  1461 |         int err;
       |         ^~~

>   
>   	DBG("");
> @@ -1482,8 +1483,9 @@ static int pbap_init_cb(void)
>   	return 0;
>   }
>   
> -static void pbap_exit_cb(void)
> +static void pbap_exit_cb(gboolean at_unregister)
>   {
> +	(void)at_unregister;
>   	DBG("");
>   
>   	g_dbus_remove_watch(system_conn, listener_id);
> diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> index 7ff27a8a8..ad37e636d 100644
> --- a/obexd/plugins/bluetooth.c
> +++ b/obexd/plugins/bluetooth.c
> @@ -427,8 +427,9 @@ static const struct obex_transport_driver driver = {
>   
>   static unsigned int listener_id = 0;
>   
> -static int bluetooth_init_cb(void)
> +static int bluetooth_init_cb(gboolean at_register)
>   {
> +	(void)at_register;
>   	connection = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
>   	if (connection == NULL)
>   		return -EPERM;
> @@ -439,8 +440,9 @@ static int bluetooth_init_cb(void)
>   	return obex_transport_driver_register(&driver);
>   }
>   
> -static void bluetooth_exit_cb(void)
> +static void bluetooth_exit_cb(gboolean at_unregister)
>   {
> +	(void)at_unregister;
>   	GSList *l;
And:

obexd/plugins/bluetooth.c: In function ‘bluetooth_exit_cb’:
obexd/plugins/bluetooth.c:446:9: error: ISO C90 forbids mixed 
declarations and code [-Werror=declaration-after-statement]
   446 |         GSList *l;
       |         ^~~~~~

>   
>   	g_dbus_remove_watch(connection, listener_id);
> diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> index a0eb62b1e..b4279b209 100644
> --- a/obexd/src/logind.c
> +++ b/obexd/src/logind.c
> @@ -43,13 +43,13 @@ static void call_init_cb(gpointer data, gpointer user_data)
>   {
>   	int res;
>   
> -	res = ((struct callback_pair *)data)->init_cb();
> +	res = ((struct callback_pair *)data)->init_cb(FALSE);
>   	if (res)
>   		*(int *)user_data = res;
>   }
>   static void call_exit_cb(gpointer data, gpointer user_data)
>   {
> -	((struct callback_pair *)data)->exit_cb();
> +	((struct callback_pair *)data)->exit_cb(FALSE);
>   }
>   
>   static int update(void)
> @@ -229,7 +229,7 @@ int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
>   	struct callback_pair *cbs;
>   
>   	if (!monitoring_enabled)
> -		return init_cb();
> +		return init_cb(TRUE);
>   	if (callbacks == NULL) {
>   		int res;
>   
> @@ -237,23 +237,23 @@ int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
>   		if (res) {
>   			error("logind_init(): %s - login detection disabled",
>   				strerror(-res));
> -			return init_cb();
> +			return init_cb(TRUE);
>   		}
>   	}
>   	cbs = g_new(struct callback_pair, 1);
>   	cbs->init_cb = init_cb;
>   	cbs->exit_cb = exit_cb;
>   	callbacks = g_slist_prepend(callbacks, cbs);
> -	return active ? init_cb() : 0;
> +	return active ? init_cb(TRUE) : 0;
>   }
>   void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
>   {
>   	GSList *cb_node;
>   
>   	if (!monitoring_enabled)
> -		return exit_cb();
> +		return exit_cb(TRUE);
>   	if (active)
> -		exit_cb();
> +		exit_cb(TRUE);
>   	cb_node = g_slist_find_custom(callbacks, init_cb, find_cb);
>   	if (cb_node != NULL)
>   		callbacks = g_slist_delete_link(callbacks, cb_node);
> diff --git a/obexd/src/logind.h b/obexd/src/logind.h
> index eb3ff8d7b..3cdb03338 100644
> --- a/obexd/src/logind.h
> +++ b/obexd/src/logind.h
> @@ -8,8 +8,8 @@
>    *
>    */
>   
> -typedef int (*logind_init_cb)(void);
> -typedef void (*logind_exit_cb)(void);
> +typedef int (*logind_init_cb)(gboolean at_register);
> +typedef void (*logind_exit_cb)(gboolean at_unregister);
>   
>   #ifdef SYSTEMD
>   
> @@ -22,12 +22,12 @@ int logind_set(gboolean enabled);
>   static inline int logind_register(logind_init_cb init_cb,
>   					logind_exit_cb exit_cb)
>   {
> -	return init_cb();
> +	return init_cb(TRUE);
>   }
>   static inline void logind_unregister(logind_init_cb init_cb,
>   					logind_exit_cb exit_cb)
>   {
> -	return exit_cb();
> +	return exit_cb(TRUE);
>   }
>   static inline int logind_set(gboolean enabled)
>   {

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

