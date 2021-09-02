Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2663AC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED1461058
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 09:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343538AbhIBJaK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:30:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44496 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343539AbhIBJaE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 05:30:04 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5DF76CECDE;
        Thu,  2 Sep 2021 11:29:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [Bluez PATCH v2 13/13] adapter: Inclusive language for storing
 LTK
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210902120509.Bluez.v2.13.I90a92f48ae29b2a8d8b18f856ea2a43afba52299@changeid>
Date:   Thu, 2 Sep 2021 11:29:04 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1F544696-4D64-440F-B92E-5A0E05A64EE2@holtmann.org>
References: <20210902040711.665952-1-apusaka@google.com>
 <20210902120509.Bluez.v2.13.I90a92f48ae29b2a8d8b18f856ea2a43afba52299@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> BT core spec 5.3 promotes the usage of inclusive languages.
> This CL replaces some terms with the more appropriate counterparts,
> such as "central" and "peripheral"
> ---
> 
> (no changes since v1)
> 
> doc/settings-storage.txt |  4 ++--
> src/adapter.c            | 10 +++++-----
> 2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> index 1d96cd66d9..3c637c3521 100644
> --- a/doc/settings-storage.txt
> +++ b/doc/settings-storage.txt
> @@ -314,9 +314,9 @@ Long term key) related to a remote device.
>   Rand			Integer		Randomizer
> 
> 
> -[SlaveLongTermKey] group contains:
> +[PeripheralLongTermKey] group contains:
> 
> -  Same as the [LongTermKey] group, except for slave keys.
> +  Same as the [LongTermKey] group, except for peripheral keys.
> 
> 
> [ConnectionParameters] group contains:
> diff --git a/src/adapter.c b/src/adapter.c
> index 4ad53a3a24..8528e2b6e0 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3745,7 +3745,7 @@ static struct smp_ltk_info *get_ltk(GKeyFile *key_file, const char *peer,
> 									NULL);
> 	ltk->ediv = g_key_file_get_integer(key_file, group, "EDiv", NULL);
> 
> -	central = g_key_file_get_boolean(key_file, group, "Master", &gerr);
> +	central = g_key_file_get_boolean(key_file, group, "Central", &gerr);
> 	if (gerr)
> 		g_error_free(gerr);
> 	else
> @@ -3777,7 +3777,7 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
> 
> 	DBG("%s", peer);
> 
> -	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
> +	ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
> 	if (ltk)
> 		ltk->central = false;
> 
> @@ -5780,7 +5780,7 @@ static void convert_ltk_entry(GKeyFile *key_file, void *value)
> 	g_free(str);
> 
> 	g_key_file_set_integer(key_file, "LongTermKey", "Authenticated", auth);
> -	g_key_file_set_integer(key_file, "LongTermKey", "Master", central);
> +	g_key_file_set_integer(key_file, "LongTermKey", "Central", central);
> 	g_key_file_set_integer(key_file, "LongTermKey", "EncSize", enc_size);
> 	g_key_file_set_integer(key_file, "LongTermKey", "EDiv", ediv);

this is just not going to work. You are going to break existing installations that upgrade to a new version. The storage format, D-Bus API and libbluetooth API are something that you can not search+replace.

Regards

Marcel

