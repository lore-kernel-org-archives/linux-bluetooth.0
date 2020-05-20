Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B47C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 07:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749E7207ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 07:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="MaZjFWMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgETHmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETHmG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 03:42:06 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25040C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 00:42:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h16so1877012eds.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 00:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZlWsLift7Slk2DCqV8ajYnOSTCF+lyAKnz4F/6ZwjE4=;
        b=MaZjFWMDuxmy8qr/CwuW3KSKTj8LI3qMrZfGdQE05pT3JCVUnVl7O46YzgaEjqqPaw
         LgyXBaXHADRE0Vk+6kJSxh+j9yk5SCau07jz+WM3EvFRNQFq7AYQKe1J+/yXerCu7ad6
         nCe5zxlgxSsb6T0tFDa194jnEPcOXu3sWfjaVW/KQiFh7qvcV/kAWOzGYqDwT8Jf0hvQ
         yEgVuS+9uth4uFrcAobBKieor7XjWFXPcDNf9O5JgY7SJ/xgsn90b18CssVOHSRf7j+1
         WcDBQWw+9lLRhBeG22jsjKfx6iHO3RD2q9R+XuoSh4m0wMQaAsoIGJae+WwQ3xmQhqIo
         VzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZlWsLift7Slk2DCqV8ajYnOSTCF+lyAKnz4F/6ZwjE4=;
        b=Jv38fYeUHOgYQBZ9jG2hV1Ru+s6MpaH0vZ+Yub5KwNwtwu71O3qgIgFv0CYgxGN1bU
         InL723Gqybk21jcdChcmH6gSDEubsQN5Sgz7Qiz/BHiLIwJRgiyTA0udlGgHGMiHc2nH
         yKyf0P0gqMdkFuU+ciTZYpVZp1WVZtoEofa3HFQsc5aPRkzkGHAziokl1A+91tIUY6db
         tsnqFkBvZWKKLraSUYn11tIfDsbp7/kw8lmLSkMQO6HYeJGYC4CJr88Z1PJ9GeSHi1hl
         LmFJG/DzmjvNk100m4D1pTqlzcwgkoiz6HVTdDC+QjZpPrtO/eXHO+LoDh2qvoBCbD+F
         uoAg==
X-Gm-Message-State: AOAM532NT6rxI6DQoP9dAyowpgEqCCN0F1Mp+2P8ey0P33kNu7yCppZx
        en81UOewtAZA0paPmdRbhIi085TGGXXVpw==
X-Google-Smtp-Source: ABdhPJz24sqydBOvqTxWTrNT7Z+sqhHSAx/tkSlWZMAruz4WqslrMoAT4eRb7/vMH7vL6mED3oBWSg==
X-Received: by 2002:a05:6402:3cd:: with SMTP id t13mr2273945edw.285.1589960523675;
        Wed, 20 May 2020 00:42:03 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id dr19sm1267016ejc.122.2020.05.20.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 00:42:02 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Wed, 20 May 2020 09:42:26 +0200
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v2 1/2] mesh: Fix valgrind memory leaks
Message-ID: <20200520074226.7xrgnhr343nhmqs5@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20200516012742.573151-1-brian.gix@intel.com>
 <20200516012742.573151-2-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200516012742.573151-2-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Sorry for the late response.

On 05/15, Brian Gix wrote:
> These memory leaks are ones that will compound over time with node
> creation and deletion.
> ---
>  mesh/mesh-config-json.c | 16 ++++++++--------
>  mesh/mesh.c             |  5 ++++-
>  mesh/node.c             |  1 +
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
> index 9ac3979f8..6567d761c 100644
> --- a/mesh/mesh-config-json.c
> +++ b/mesh/mesh-config-json.c
> @@ -447,8 +447,6 @@ static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
>  	if (!len)
>  		return true;
>  
> -	node->appkeys = l_queue_new();
> -
>  	for (i = 0; i < len; ++i) {
>  		json_object *jtemp, *jvalue;
>  		char *str;
> @@ -505,8 +503,6 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
>  	if (!len)
>  		return false;
>  
> -	node->netkeys = l_queue_new();
> -
>  	for (i = 0; i < len; ++i) {
>  		json_object *jtemp, *jvalue;
>  		char *str;
> @@ -1133,8 +1129,6 @@ static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
>  		/* Allow "empty" nodes */
>  		return true;
>  
> -	node->elements = l_queue_new();
> -
>  	for (i = 0; i < num_ele; ++i) {
>  		json_object *jelement;
>  		json_object *jmodels;
> @@ -1154,6 +1148,7 @@ static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
>  		ele = l_new(struct mesh_config_element, 1);
>  		ele->index = index;
>  		ele->models = l_queue_new();
> +		l_queue_push_tail(node->elements, ele);
>  
>  		if (!json_object_object_get_ex(jelement, "location", &jvalue))
>  			goto fail;
> @@ -1167,8 +1162,6 @@ static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
>  						!parse_models(jmodels, ele))
>  				goto fail;
>  		}
> -
> -		l_queue_push_tail(node->elements, ele);
>  	}
>  
>  	return true;
> @@ -2133,6 +2126,11 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
>  		goto done;
>  
>  	memset(&node, 0, sizeof(node));
> +
> +	node.elements = l_queue_new();
> +	node.netkeys = l_queue_new();
> +	node.appkeys = l_queue_new();
> +
>  	result = read_node(jnode, &node);
>  
>  	if (result) {
> @@ -2148,6 +2146,7 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
>  		result = cb(&node, uuid, cfg, user_data);
>  
>  		if (!result) {
> +			l_free(cfg->idles);
>  			l_free(cfg->node_dir_path);
>  			l_free(cfg);
>  		}
> @@ -2157,6 +2156,7 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
>  	l_free(node.net_transmit);
>  	l_queue_destroy(node.netkeys, l_free);
>  	l_queue_destroy(node.appkeys, l_free);
> +	l_queue_destroy(node.elements, free_element);
>  
>  	if (!result)
>  		json_object_put(jnode);
> diff --git a/mesh/mesh.c b/mesh/mesh.c
> index 890a3aa8f..23ff9c2a8 100644
> --- a/mesh/mesh.c
> +++ b/mesh/mesh.c
> @@ -209,7 +209,7 @@ static void parse_settings(const char *mesh_conf_fname)
>  
>  	settings = l_settings_new();
>  	if (!l_settings_load_from_file(settings, mesh_conf_fname))
> -		return;
> +		goto done;
>  
>  	str = l_settings_get_string(settings, "General", "Beacon");
>  	if (str) {
> @@ -242,6 +242,9 @@ static void parse_settings(const char *mesh_conf_fname)
>  
>  	if (l_settings_get_uint(settings, "General", "ProvTimeout", &value))
>  		mesh.prov_timeout = value;
> +
> +done:
> +	l_settings_free(settings);
>  }
>  
>  bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
> diff --git a/mesh/node.c b/mesh/node.c
> index 8914b639d..2b4b3a563 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -335,6 +335,7 @@ static void free_node_resources(void *data)
>  
>  	free_node_dbus_resources(node);
>  
> +	mesh_config_release(node->cfg);

This introduces a double-free when application cancels a Join() call:

09:35:54.082 DBUS.in              DEBUG / org.freedesktop.DBus.ObjectManager::GetManagedObjects()
09:35:54.082 MESHD.stderr          INFO 2020-05-20 09:35:54.080       mesh.c:547  join_network_call          mesh/mesh.c:join_network_call() Join network request
09:35:54.082 MESHD.stderr          INFO 2020-05-20 09:35:54.080       node.c:1699 node_join                  mesh/node.c:node_join()
09:35:54.083 MESHD.stderr          INFO 2020-05-20 09:35:54.082       node.c:1280 get_app_properties         mesh/node.c:get_app_properties() path /com/silvair/application
09:35:54.083 MESHD.stderr          INFO 2020-05-20 09:35:54.082       node.c:1127 get_element_properties     mesh/node.c:get_element_properties() path /com/silvair/application/element0
09:35:54.083 MESHD.stderr          INFO 2020-05-20 09:35:54.082       node.c:1127 get_element_properties     mesh/node.c:get_element_properties() path /com/silvair/application/element1
09:35:54.084 MESHD.stderr          INFO 2020-05-20 09:35:54.083 mesh-config-json.c:1706 mesh_config_create         mesh/mesh-config-json.c:mesh_config_create() New node config /tmp/pytest-of-khorne/pytest-66/test_join_cancel0/config/83bf3b46810345a28bcce70d8d0b46d3/node.json
09:35:54.084 MESHD.stderr          INFO 2020-05-20 09:35:54.083 mesh-io-tcpserver.c:773  tcpserver_io_reg           tcpserver_io_reg 29
09:35:54.084 RADIO.out             INFO LEAdvertisingDataTag.MESH_BEACON: 0083bf3b46810345a28bcce70d8d0b46d30000
09:35:54.085 DBUS.out             DEBUG /org/bluez/mesh org.bluez.mesh.Network1::Join('/', b'\x83\xbf;F\x81\x03E\xa2\x8b\xcc\xe7\r\x8d\x0bF\xd3') = ()
09:35:54.085 APPLICATION           INFO Cancel
09:35:54.086 MESHD.stderr          INFO 2020-05-20 09:35:54.085       mesh.c:592  cancel_join_call           mesh/mesh.c:cancel_join_call() Cancel Join
09:35:54.086 MESHD.stderr          INFO 2020-05-20 09:35:54.085 mesh-config-json.c:2327 mesh_config_destroy        mesh/mesh-config-json.c:mesh_config_destroy() Delete node config /tmp/pytest-of-khorne/pytest-66/test_join_cancel0/config/83bf3b46810345a28bcce70d8d0b46d3
09:35:54.086 MESHD.stderr          INFO 2020-05-20 09:35:54.086       util.c:146  del_fobject                mesh/util.c:del_fobject() RM /tmp/pytest-of-khorne/pytest-66/test_join_cancel0/config/83bf3b46810345a28bcce70d8d0b46d3/node.json
09:35:54.086 MESHD.stderr          INFO 2020-05-20 09:35:54.086       util.c:140  del_fobject                mesh/util.c:del_fobject() RMDIR /tmp/pytest-of-khorne/pytest-66/test_join_cancel0/config/83bf3b46810345a28bcce70d8d0b46d3
09:35:54.086 MESHD.stderr          INFO free(): double free detected in tcache 2
09:35:54.086 MESHD.segfault        INFO *** Aborted
09:35:54.086 MESHD.registers      DEBUG Register dump:
09:35:54.086 MESHD.registers      DEBUG 
09:35:54.090 MESHD.registers      DEBUG  RAX: 0000000000000000   RBX: 00007f6bc6ebf740   RCX: 00007f6bc6f333eb
09:35:54.090 MESHD.registers      DEBUG  RDX: 0000000000000000   RSI: 00007fffc10c1ef0   RDI: 0000000000000002
09:35:54.090 MESHD.registers      DEBUG  RBP: 00007fffc10c2240   R8 : 0000000000000000   R9 : 00007fffc10c1ef0
09:35:54.090 MESHD.registers      DEBUG  R10: 0000000000000008   R11: 0000000000000246   R12: 00007fffc10c2160
09:35:54.090 MESHD.registers      DEBUG  R13: 0000000000000010   R14: 00007f6bc74b0000   R15: 0000000000000002
09:35:54.090 MESHD.registers      DEBUG  RSP: 00007fffc10c1ef0
09:35:54.091 MESHD.registers      DEBUG 
09:35:54.091 MESHD.registers      DEBUG  RIP: 00007f6bc6f333eb   EFLAGS: 00000246
09:35:54.091 MESHD.registers      DEBUG 
09:35:54.091 MESHD.registers      DEBUG  CS: 0033   FS: 0000   GS: 0000
09:35:54.091 MESHD.registers      DEBUG 
09:35:54.091 MESHD.registers      DEBUG  Trap: 00000000   Error: 00000000   OldMask: 00004002   CR2: 00000000
09:35:54.091 MESHD.registers      DEBUG 
09:35:54.091 MESHD.registers      DEBUG  FPUCW: 0000037f   FPUSW: 00000000   TAG: 00000000
09:35:54.091 MESHD.registers      DEBUG  RIP: 00000000   RDP: 00000000
09:35:54.091 MESHD.registers      DEBUG 
09:35:54.091 MESHD.registers      DEBUG  ST(0) 0000 0000000000000000   ST(1) 0000 0000000000000000
09:35:54.092 MESHD.registers      DEBUG  ST(2) 0000 0000000000000000   ST(3) 0000 0000000000000000
09:35:54.092 MESHD.registers      DEBUG  ST(4) 0000 0000000000000000   ST(5) 0000 0000000000000000
09:35:54.092 MESHD.registers      DEBUG  ST(6) 0000 0000000000000000   ST(7) 0000 0000000000000000
09:35:54.092 MESHD.registers      DEBUG  mxcsr: 1f80
09:35:54.092 MESHD.registers      DEBUG  XMM0:  000000000000000000000000ffffffff XMM1:  000000000000000000000000ffffffff
09:35:54.092 MESHD.registers      DEBUG  XMM2:  000000000000000000000000ffffffff XMM3:  000000000000000000000000ffffffff
09:35:54.092 MESHD.registers      DEBUG  XMM4:  000000000000000000000000ffffffff XMM5:  000000000000000000000000ffffffff
09:35:54.092 MESHD.registers      DEBUG  XMM6:  000000000000000000000000ffffffff XMM7:  000000000000000000000000ffffffff
09:35:54.092 MESHD.registers      DEBUG  XMM8:  000000000000000000000000ffffffff XMM9:  000000000000000000000000ffffffff
09:35:54.092 MESHD.registers      DEBUG  XMM10: 000000000000000000000000ffffffff XMM11: 000000000000000000000000ffffffff
09:35:54.092 MESHD.registers      DEBUG  XMM12: 000000000000000000000000ffffffff XMM13: 000000000000000000000000ffffffff
09:35:54.093 MESHD.registers      DEBUG  XMM14: 000000000000000000000000ffffffff XMM15: 000000000000000000000000ffffffff
09:35:54.093 MESHD.registers      DEBUG 
09:35:54.093 MESHD.backtrace       INFO Backtrace:
09:35:54.098 MESHD.backtrace       INFO /lib/x86_64-linux-gnu/libc.so.6(gsignal+0xcb)[0x7f6bc6f333eb]
09:35:54.102 MESHD.backtrace       INFO /lib/x86_64-linux-gnu/libc.so.6(abort+0x12b)[0x7f6bc6f12899]
09:35:54.175 MESHD.backtrace       INFO __libc_message /build/glibc-t7JzpG/glibc-2.30/libio/../sysdeps/posix/libc_fatal.c:181
09:35:54.185 RADIO                 INFO Disconnected
09:35:54.186 APPLICATION          ERROR Disconnected from org.bluez.mesh (:1.6564)
09:35:54.187 DBUS.out             DEBUG /org/bluez/mesh org.bluez.mesh.Network1::Cancel() = ('Message recipient disconnected from message bus without replying',)
------------------------------------------------------------------------------------------------------------ Captured log teardown ------------------------------------------------------------------------------------------------------------
09:35:54.294 MESHD               WARNING Terminated with code: -6
09:35:54.297 MESHD.backtrace       INFO thrd_yield /build/glibc-t7JzpG/glibc-2.30/malloc/malloc.c:5333
09:35:54.369 MESHD.backtrace       INFO _int_free /build/glibc-t7JzpG/glibc-2.30/malloc/malloc.c:4201
09:35:54.375 MESHD.backtrace       INFO l_queue_clear /home/khorne/Programming/silvair/bluez-tests/bluez/ell/queue.c:103
09:35:54.376 MESHD.backtrace      DEBUG  101: 	entry = queue->head;
09:35:54.376 MESHD.backtrace      DEBUG  102: 
09:35:54.376 MESHD.backtrace      DEBUG  103: 	while (entry) { 👈 😡
09:35:54.376 MESHD.backtrace      DEBUG  104: 		struct l_queue_entry *tmp = entry;
09:35:54.376 MESHD.backtrace      DEBUG  105: 
09:35:54.376 MESHD.backtrace      DEBUG  106: 		if (destroy)
09:35:54.376 MESHD.backtrace      DEBUG 
09:35:54.382 MESHD.backtrace       INFO l_queue_destroy /home/khorne/Programming/silvair/bluez-tests/bluez/ell/queue.c:83
09:35:54.383 MESHD.backtrace      DEBUG   81: {
09:35:54.383 MESHD.backtrace      DEBUG   82: 	l_queue_clear(queue, destroy);
09:35:54.383 MESHD.backtrace      DEBUG   83: 	l_free(queue); 👈 😡
09:35:54.383 MESHD.backtrace      DEBUG   84: }
09:35:54.383 MESHD.backtrace      DEBUG   85: 
09:35:54.383 MESHD.backtrace      DEBUG   86: /**
09:35:54.383 MESHD.backtrace      DEBUG 
09:35:54.390 MESHD.backtrace       INFO mesh_config_release /home/khorne/Programming/silvair/bluez-tests/bluez/mesh/mesh-config-json.c:2192
09:35:54.391 MESHD.backtrace      DEBUG 2190: 	l_queue_destroy(cfg->idles, release_idle);
09:35:54.391 MESHD.backtrace      DEBUG 2191: 
09:35:54.391 MESHD.backtrace      DEBUG 2192: 	l_free(cfg->node_dir_path); 👈 😡
09:35:54.391 MESHD.backtrace      DEBUG 2193: 	json_object_put(cfg->jnode);
09:35:54.391 MESHD.backtrace      DEBUG 2194: 	l_free(cfg);
09:35:54.391 MESHD.backtrace      DEBUG 2195: }
09:35:54.391 MESHD.backtrace      DEBUG 
09:35:54.400 MESHD.backtrace       INFO free_node_resources /home/khorne/Programming/silvair/bluez-tests/bluez/mesh/node.c:339
09:35:54.401 MESHD.backtrace      DEBUG  337: 
09:35:54.401 MESHD.backtrace      DEBUG  338: 	mesh_config_release(node->cfg);
09:35:54.401 MESHD.backtrace      DEBUG  339: 	mesh_net_free(node->net); 👈 😡
09:35:54.401 MESHD.backtrace      DEBUG  340: 	l_free(node->storage_dir);
09:35:54.401 MESHD.backtrace      DEBUG  341: 	l_free(node);
09:35:54.401 MESHD.backtrace      DEBUG  342: }
09:35:54.401 MESHD.backtrace      DEBUG 
09:35:54.414 MESHD.backtrace       INFO node_remove /home/khorne/Programming/silvair/bluez-tests/bluez/mesh/node.c:358
09:35:54.415 MESHD.backtrace      DEBUG  356: 		mesh_config_destroy(node->cfg);
09:35:54.415 MESHD.backtrace      DEBUG  357: 
09:35:54.415 MESHD.backtrace      DEBUG  358: 	free_node_resources(node); 👈 😡
09:35:54.415 MESHD.backtrace      DEBUG  359: }
09:35:54.415 MESHD.backtrace      DEBUG  360: 
09:35:54.415 MESHD.backtrace      DEBUG  361: static bool add_models_from_storage(struct mesh_node *node,
09:35:54.415 MESHD.backtrace      DEBUG 
09:35:54.421 MESHD.backtrace       INFO free_pending_join_call /home/khorne/Programming/silvair/bluez-tests/bluez/mesh/mesh.c:325
09:35:54.421 MESHD.backtrace      DEBUG  323: 
09:35:54.421 MESHD.backtrace      DEBUG  324: 	if (failed)
09:35:54.421 MESHD.backtrace      DEBUG  325: 		node_remove(join_pending->node); 👈 😡
09:35:54.422 MESHD.backtrace      DEBUG  326: 
09:35:54.422 MESHD.backtrace      DEBUG  327: 	l_free(join_pending->sender);
09:35:54.422 MESHD.backtrace      DEBUG  328: 	l_free(join_pending);
09:35:54.422 MESHD.backtrace      DEBUG 
09:35:54.427 MESHD.backtrace       INFO cancel_join_call /home/khorne/Programming/silvair/bluez-tests/bluez/mesh/mesh.c:613
09:35:54.427 MESHD.backtrace      DEBUG  611: 	free_pending_join_call(true);
09:35:54.428 MESHD.backtrace      DEBUG  612: done:
09:35:54.428 MESHD.backtrace      DEBUG  613: 	return reply; 👈 😡
09:35:54.428 MESHD.backtrace      DEBUG  614: }
09:35:54.428 MESHD.backtrace      DEBUG  615: 
09:35:54.428 MESHD.backtrace      DEBUG  616: static void attach_ready_cb(void *user_data, int status, struct mesh_node *node)
09:35:54.428 MESHD.backtrace      DEBUG 
09:35:54.440 MESHD.backtrace       INFO _dbus_object_tree_dispatch /home/khorne/Programming/silvair/bluez-tests/bluez/ell/dbus-service.c:1793
09:35:54.441 MESHD.backtrace      DEBUG 1791: 		return false;
09:35:54.441 MESHD.backtrace      DEBUG 1792: 
09:35:54.441 MESHD.backtrace      DEBUG 1793: 	reply = method->cb(dbus, message, instance->user_data); 👈 😡
09:35:54.441 MESHD.backtrace      DEBUG 1794: 	if (reply)
09:35:54.441 MESHD.backtrace      DEBUG 1795: 		l_dbus_send(dbus, reply);
09:35:54.441 MESHD.backtrace      DEBUG 1796: 
09:35:54.441 MESHD.backtrace      DEBUG 
09:35:54.449 MESHD.backtrace       INFO message_read_handler /home/khorne/Programming/silvair/bluez-tests/bluez/ell/dbus.c:285
09:35:54.449 MESHD.backtrace      DEBUG  283: 		break;
09:35:54.449 MESHD.backtrace      DEBUG  284: 	case DBUS_MESSAGE_TYPE_METHOD_CALL:
09:35:54.449 MESHD.backtrace      DEBUG  285: 		if (!_dbus_object_tree_dispatch(dbus->tree, dbus, message)) { 👈 😡
09:35:54.449 MESHD.backtrace      DEBUG  286: 			struct l_dbus_message *error;
09:35:54.449 MESHD.backtrace      DEBUG  287: 
09:35:54.450 MESHD.backtrace      DEBUG  288: 			error = l_dbus_message_new_error(message,
09:35:54.450 MESHD.backtrace      DEBUG 
09:35:54.457 MESHD.backtrace       INFO io_callback /home/khorne/Programming/silvair/bluez-tests/bluez/ell/io.c:126
09:35:54.457 MESHD.backtrace      DEBUG  124: 						"read event <%p>", io);
09:35:54.457 MESHD.backtrace      DEBUG  125: 
09:35:54.457 MESHD.backtrace      DEBUG  126: 		if (!io->read_handler(io, io->read_data)) { 👈 😡
09:35:54.458 MESHD.backtrace      DEBUG  127: 			if (io->read_destroy)
09:35:54.458 MESHD.backtrace      DEBUG  128: 				io->read_destroy(io->read_data);
09:35:54.458 MESHD.backtrace      DEBUG  129: 
09:35:54.458 MESHD.backtrace      DEBUG 
09:35:54.466 MESHD.backtrace       INFO l_main_iterate /home/khorne/Programming/silvair/bluez-tests/bluez/ell/main.c:467
09:35:54.467 MESHD.backtrace      DEBUG  465: 	}
09:35:54.467 MESHD.backtrace      DEBUG  466: 
09:35:54.467 MESHD.backtrace      DEBUG  467: 	for (n = 0; n < nfds; n++) { 👈 😡
09:35:54.467 MESHD.backtrace      DEBUG  468: 		data = events[n].data.ptr;
09:35:54.467 MESHD.backtrace      DEBUG  469: 
09:35:54.467 MESHD.backtrace      DEBUG  470: 		if (data->flags & WATCH_FLAG_DESTROYED)
09:35:54.468 MESHD.backtrace      DEBUG 
09:35:54.478 MESHD.backtrace       INFO l_main_run /home/khorne/Programming/silvair/bluez-tests/bluez/ell/main.c:516
09:35:54.479 MESHD.backtrace      DEBUG  514: 
09:35:54.479 MESHD.backtrace      DEBUG  515: 	for (;;) {
09:35:54.479 MESHD.backtrace      DEBUG  516: 		if (epoll_terminate) 👈 😡
09:35:54.479 MESHD.backtrace      DEBUG  517: 			break;
09:35:54.479 MESHD.backtrace      DEBUG  518: 
09:35:54.479 MESHD.backtrace      DEBUG  519: 		timeout = l_main_prepare();
09:35:54.480 MESHD.backtrace      DEBUG 
09:35:54.486 MESHD.backtrace       INFO l_main_run_with_signal /home/khorne/Programming/silvair/bluez-tests/bluez/ell/main.c:644
09:35:54.487 MESHD.backtrace      DEBUG  642: 	result = l_main_run();
09:35:54.487 MESHD.backtrace      DEBUG  643: 
09:35:54.487 MESHD.backtrace      DEBUG  644: 	l_signal_remove(sigint); 👈 😡
09:35:54.487 MESHD.backtrace      DEBUG  645: 	l_signal_remove(sigterm);
09:35:54.487 MESHD.backtrace      DEBUG  646: 
09:35:54.487 MESHD.backtrace      DEBUG  647: 	l_free(data);
09:35:54.487 MESHD.backtrace      DEBUG 
09:35:54.495 MESHD.backtrace       INFO main /home/khorne/Programming/silvair/bluez-tests/bluez/mesh/main.c:302
09:35:54.495 MESHD.backtrace      DEBUG  300: 	}
09:35:54.495 MESHD.backtrace      DEBUG  301: 
09:35:54.496 MESHD.backtrace      DEBUG  302: 	status = l_main_run_with_signal(signal_handler, NULL); 👈 😡
09:35:54.496 MESHD.backtrace      DEBUG  303: 
09:35:54.496 MESHD.backtrace      DEBUG  304: done:
09:35:54.496 MESHD.backtrace      DEBUG  305: 	if (io)
09:35:54.496 MESHD.backtrace      DEBUG 
09:35:54.505 MESHD.backtrace       INFO /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f6bc6f141e3]
09:35:54.513 MESHD.backtrace       INFO _start /home/khorne/Programming/silvair/bluez-tests/bluez/mesh/bluetooth-meshd(+0x2b68e)[0x56487c72d68e]
09:35:54.513 MESHD.backtrace       INFO 

>  	mesh_net_free(node->net);
>  	l_free(node->storage_dir);
>  	l_free(node);
> -- 
> 2.25.4
> 

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
