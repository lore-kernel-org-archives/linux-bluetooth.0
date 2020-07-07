Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998EEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754A62080D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGGPxh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:53:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51195 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGPxg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 11:53:36 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1B700CECED;
        Tue,  7 Jul 2020 18:03:31 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: create CONFIG_BT_DEBUG_FEATURE_FUNC_NAME
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200707141628.368748-1-alainm@chromium.org>
Date:   Tue, 7 Jul 2020 17:53:33 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <67268C4E-674E-4DE9-B642-E1CAE8748E28@holtmann.org>
References: <20200707141628.368748-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> Creates a CONFIG_BT_DEBUG_FEATURE_FUNC_NAME option to include function names in
> debug statements.
> 
> Unlike other platforms __func__ isn't a string literal so it cannot be
> automatically concatenated by the pre-processor.  As a result, the
> function name is passed as a parameter to the tracing function.  Since
> pr_debug is a function like macro, the normal expansion of BT_PREFIX_PARAM
> does not work as it gets processed within the first parameter as well,
> for this reason, BT_DBG is split into two versions.
> 
> This patch was built tested with all 4 possible combinations of
> CONFIG_BT_DEBUG_FUNC_NAME and CONFIG_BT_FEATURE_DEBUG configurations.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
> 
> Changes in v2:
> - Making CONFIG_BT_DEBUG_FEATURE_FUNC_NAME dependent on
> CONFIG_BT_DEBUG_FEATURE
> 
> include/net/bluetooth/bluetooth.h | 32 +++++++++++++++++++++++--------
> net/bluetooth/Kconfig             | 11 +++++++++++
> 2 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 7ee8041af803..8506dd268d4b 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -162,22 +162,37 @@ void bt_dbg_set(bool enable);
> bool bt_dbg_get(void);
> __printf(1, 2)
> void bt_dbg(const char *fmt, ...);
> +#define BT_DBG_INT	bt_dbg
> +#else
> +#define BT_DBG_INT	pr_debug
> #endif
> __printf(1, 2)
> void bt_warn_ratelimited(const char *fmt, ...);
> __printf(1, 2)
> void bt_err_ratelimited(const char *fmt, ...);
> 
> -#define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
> -#define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
> -#define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
> -
> -#if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
> -#define BT_DBG(fmt, ...)	bt_dbg(fmt "\n", ##__VA_ARGS__)
> +#if IS_ENABLED(BT_FEATURE_DEBUG_FUNC_NAMES)

are you sure you tested this?

And frankly I don’t get the point for the new Kconfig option. It is rather useless in this patch. Tell me one thing, do you prefer that FEATURE_DEBUG prints the function names or not. Because if dynamic debug is used, we don’t need it since that is all configurable via dynamic debug itself and we don’t need it there (and I also don’t want it in the dynamic debug case).

Regards

Marcel

