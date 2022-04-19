Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 08:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350145AbiDSIva convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350132AbiDSIv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 04:51:28 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D84022B1B
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 01:48:45 -0700 (PDT)
Received: from smtpclient.apple (p4fefc32f.dip0.t-ipconnect.de [79.239.195.47])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1B959CECDC;
        Tue, 19 Apr 2022 10:48:44 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH BlueZ] policy: Change AutoEnable default to true
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220413222425.187199-1-luiz.dentz@gmail.com>
Date:   Tue, 19 Apr 2022 10:48:43 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <61417C2F-0009-4123-8F1C-DACC4A46073D@holtmann.org>
References: <20220413222425.187199-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This changes the default of AutoEnable to true so controllers are power
> up by default.
> 
> Fixes: https://github.com/bluez/bluez/issues/328
> ---
> plugins/policy.c | 6 +++++-
> src/main.conf    | 4 ++--
> 2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/policy.c b/plugins/policy.c
> index 48f5db7d3..0bbdbfc88 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -892,7 +892,11 @@ static int policy_init(void)
> 	}
> 
> 	auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
> -									NULL);
> +								&gerr);
> +	if (gerr) {
> +		g_clear_error(&gerr);
> +		auto_enable = true;
> +	}
> 
> 	resume_delay = g_key_file_get_integer(
> 			conf, "Policy", "ResumeDelay", &gerr);
> diff --git a/src/main.conf b/src/main.conf
> index 401796235..91b98b8c4 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -276,8 +276,8 @@
> 
> # AutoEnable defines option to enable all controllers when they are found.
> # This includes adapters present on start as well as adapters that are plugged
> -# in later on. Defaults to 'false'.
> -#AutoEnable=false
> +# in later on. Defaults to 'true'.
> +#AutoEnable=true

so this is problematic since all wireless technology daemon where design to not automatically activate their hardware. It needed a system above like ConnMan, NetworkManager or even the UI to start the operation.

It is especially tricky since bluetoothd doesn’t remember the last state. So if you power off, then restart, it is on again the next time around. Not something you might have wanted. Using false here is the right choice as a default.

If you install systemd-rfkill and want to auto-power once soft-rfkill is released and systemd-rfkill remembers the state persistently, then you need to install your main.conf with AutoEnable=true. That is a distro choice.

Regards

Marcel

