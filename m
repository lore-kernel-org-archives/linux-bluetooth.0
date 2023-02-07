Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4AC05027
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 01:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBGBNU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 20:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGBNT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 20:13:19 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9C49752
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 17:13:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u27so13931761ljo.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 17:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YaicxGZt8OYGPmJuLhMe6e7TVllgC/jXu0p5E79uHIU=;
        b=T4GG16EyTrXyk4iFyO2eyy5VgH5P/2J4WkFV0u86s6vDX8BJgFD2hhMsvkJ5v8yF5t
         d5ihqk2la2PVe3UiEkh6bmRUxzHNN2LQW/OzAjY7cr0zbWFw/LOWiNPFhJRyxJfu9hKR
         Ilx9BAB2MbjIYbydFslJACizLlLYw39qtFqO0zQci2JwuG3mntMDmSN1qN1RzamY6ej9
         QwXBa6JK7igvIJn3GTbUn8/VW3qpuVr0ZCcFxvLV2k1HliUfOirJYRlZB5gFIHlyJIN0
         kXv80HG39lEDPr6fJhSoM3sluENXStQuxtdkDTVDVsXeXQN+2O7XUhPMOXEnktXiNWQL
         qvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaicxGZt8OYGPmJuLhMe6e7TVllgC/jXu0p5E79uHIU=;
        b=mfmSs7N9NHlzQtjUL2wIbRIdUXbmL1564XKSxXLEbOPQTkJLxNcau9v/aCTl21evYW
         9T4fFd4xSAHn6OHu+z1zo8+yIWh51s0+QSj6w1mZz9agEpKkHrpjMNRoYohEN8ZSa1rC
         s1/BIO8eazN7ZtEe+FO/BfLA0AeWcVqp6vYDU6zNPibJ4SKvlpZUA/sZWXPG3ceVoCo9
         2/9tuiDIIs6eMVer2sXv08dBVxSqcWEgEFebPXSGIPGI4M+s8wpXIMZE+QF8LrMqCWqk
         YezDLfTY0knn5Bn1Q07zHFZKWdulXvXOKDP3KUUnplTE7zkbqJmqMiAUBeukhL9rAXpW
         r2rg==
X-Gm-Message-State: AO0yUKXvECxLBbbx9on9nKzexMuMhnla1orKqZo0dri9TCyAROiEoV2K
        FaBpjIy9kkJpQZJUbOL731ZwEpKi+roY+FxOcKk+dvlG
X-Google-Smtp-Source: AK7set8zO0bB+sMpYNLcayceErjhEp4csqoClNGorjbvUZuZiFEzhEK+SE2AQqpmpuI4ZKCZDOAy5kARzOQvZdxTdk4=
X-Received: by 2002:a2e:a4d7:0:b0:28b:78f0:e658 with SMTP id
 p23-20020a2ea4d7000000b0028b78f0e658mr170341ljm.9.1675732396722; Mon, 06 Feb
 2023 17:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20230127205205.20235-1-pav@iki.fi> <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
 <7e42fb8018045ac29c3e7a6784dd1a43a755e977.1675103676.git.pav@iki.fi>
In-Reply-To: <7e42fb8018045ac29c3e7a6784dd1a43a755e977.1675103676.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Feb 2023 17:13:05 -0800
Message-ID: <CABBYNZJCoZZ5Exwj8JniSDJ633e0E7_GBgSoyOHOySw73V56hw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/8] lib: Add defines for MGMT setting bits for CIS
 feature support
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Jan 30, 2023 at 10:56 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> ---
>  lib/mgmt.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 796190cd9..efbdfb4b1 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -96,6 +96,8 @@ struct mgmt_rp_read_index_list {
>  #define MGMT_SETTING_STATIC_ADDRESS    0x00008000
>  #define MGMT_SETTING_PHY_CONFIGURATION 0x00010000
>  #define MGMT_SETTING_WIDEBAND_SPEECH   0x00020000
> +#define MGMT_SETTING_CIS_CENTRAL       0x00040000
> +#define MGMT_SETTING_CIS_PERIPHERAL    0x00080000

Perhaps now it would be a good time to convert these to use BIT macro.

>  #define MGMT_OP_READ_INFO              0x0004
>  struct mgmt_rp_read_info {
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
