Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A0C76195
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 08:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF1221783
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 08:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="f2JhplnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfGRI71 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:59:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37969 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRI71 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 04:59:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so26509624ljg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2019 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cvQUMNFfESzuGoMGJZ57MR9rk/uOD5rYwl2mMw1RDJU=;
        b=f2JhplnXkAF5eWC5yQtTZ4cT+yi2Ra5gljW7fAWqcYOW0HLfXK0P6AFOJnABPhFZ18
         wHfZufEv1l1JVora/PATaZFBidblq6Dg6vjGMckb45xCpBlVJVgacIfYYSmfwGEBFKPg
         Qo0/hZ/VMABR8n9+FLP/tL8JjS0LXioDGSDc6pozkLA3qfQkcaHsMt2XTF1CexahV3ic
         RStjrQvfvo6qvlCe3a4q8U82QDVy18RKQF/vbkPI/gHCtat18I7jo2au0qGNJx+AEZam
         HjBA+nNB/Uzu4HK38xuBOBwtX9iHwVbXXMujWy7QYkLA39nYmYxpIuPMXZq1xRSveLpp
         7Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cvQUMNFfESzuGoMGJZ57MR9rk/uOD5rYwl2mMw1RDJU=;
        b=LRFcnUhaSc6WTXfBEj+UFO+apVqMQPaMcLA59AJF/LWICqUKdXkPB9iAOwHb2CZh34
         63F60QiyDV4jTHyq2XI2LBTPmwLCEBI2EG3W/7rXkYBzL/dXyP0Vd7V7nUkjiGN/YWuX
         RPWD/ILqUG2r8iK1697F+88LZnse/PlUSIUADLVS5Lt98Ly9GStAzq+eI73gN6+qdeOJ
         2EYp57bljmObNYE+tYml8ecQvSYSYBwj06Ty1g3EUvsUECHaMqRAdRAbLFiD6HdiZmyJ
         k+G8l3RT34HT0vqytajyIVuhaxRh8SZfp3ph6aLIoXV9aEHxNUJoogAwY8rTZAtz//An
         Y+3g==
X-Gm-Message-State: APjAAAVA63/tvnsIuPlbv5R8iMAVDtZtCZTbf0xkzagJUb5zzfKy4O42
        i4OnJ+p4VUxA1Zb2KdiH6nZCUJH5jLI=
X-Google-Smtp-Source: APXvYqxwjNC6O67yQqxJ7ZlEekKfWiV/1XH4R2o1ciKk7vkXe5BqBMpnAMkJNgN/PoVKFp9iSXHO6A==
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr22756309lja.238.1563440365438;
        Thu, 18 Jul 2019 01:59:25 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z22sm5009595ljz.20.2019.07.18.01.59.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 01:59:24 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Thu, 18 Jul 2019 10:59:23 +0200
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ] mesh: Init keyring storage directory on node
 Attach()
Message-ID: <20190718085923.4ljvk3t3avqdh24d@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20190718040126.5152-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718040126.5152-1-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07/17, Inga Stotland wrote:
>This adds initialization of keyring storage directory when
>a mesh node is attached successfully.
>---
> mesh/node.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/mesh/node.c b/mesh/node.c
>index 652551756..6b784bf8d 100644
>--- a/mesh/node.c
>+++ b/mesh/node.c
>@@ -1656,6 +1656,14 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
> 		} else
> 			goto fail;
>
>+		/*
>+		 * TODO: For now always initialize directory for storing
>+		 * keyring info. Need to figure out what checks need
>+		 * to be performed to do this conditionally, i.e., presence of
>+		 * Provisioner interface, etc.
>+		 */
>+		init_storage_dir(node);

I think the keyring should be initialized as soon ad the node is 
created. The keyring should always exist, and should contain at least 
the local device key - otherwise DevKeySend can't be used to talk to 
local Config Server.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
