Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4346BC74A2B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C82E2087F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="M9W/6Mub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfGJPB3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:01:29 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33436 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJPB3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 11:01:29 -0400
Received: by mail-lj1-f182.google.com with SMTP id h10so2443157ljg.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2019 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gyHdlxQUuHTKCDEz8RfXTpWvMUdjCx+KDbjik5V/FOU=;
        b=M9W/6MubhCFx6bdbLbZYXe2mTlFO8JgO+N5dfw+RCosfJ6q4u8IkZ/rIzMGLkB0cnW
         /D7HkiB7zMSj4GnRmQhSkfE/8TN3rm4GffzFnwSwUpC51ydT9SaGr0JZP9crhfOU4YSr
         txHWdote5iUt9dAMQO+9dxdUgKBCsLDDW5H68wOVYRBL7oWYVQjQ+sPR85sy8Ime4Obm
         efqf9uHAjCKnBnGRaZxYHUzyWVLeo2VrIQMJESE1425kkwAUTWL125ahX+H59pWmIMYo
         baxyj5YDDCPVXmciHCqAI9xEwriIzyBQ2NkBTHXN8Vh/3Oyy11f5pRjxqUcLlmmmA7lQ
         tUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gyHdlxQUuHTKCDEz8RfXTpWvMUdjCx+KDbjik5V/FOU=;
        b=X7OSep/YHZIYiwS1NUprzqSaTiEeThVaFb7pJsmd3OWMI7eRJPM+nKY1tqB/5tfK9Z
         XyIuG8Cfu3sKDz2OBUcCahL7+ZQGHwTgZGAsZkWdOEo347o7FxLKQAJ1zgcOu7efwe4j
         Px9C1bSlte41VksfFTMeQ1ix6fVKFT0K9CD/tHp90RxSNZxkcHL4LT15Lwa3es0pv5NK
         GDjra6WP62zLV0CkPrOQwPZ85DdWr01z+T2JisbL3dPhsOoAj3+yhhAp12Toh2bl+LHS
         3ac7WQQEeSAh+DH5w80eFoj/L++LriQNLdszrhiWdkEOxj6J7xcLTSkUPpBLcVvQ+hOR
         zjkQ==
X-Gm-Message-State: APjAAAWbrGbmxh2odNieqaMrr/rioY4rxF5gODytimQ/NhEZhz3b4oOQ
        IKqHfI0A2KT2GGo+e+baGtmwWA==
X-Google-Smtp-Source: APXvYqw2OA9AQM4/tebeWN704WX0Nd0gNWrQIYkiqfQ7xeQlJXvhhfTsUFIIYUDOMqVY2/K97PL42Q==
X-Received: by 2002:a2e:3008:: with SMTP id w8mr18342273ljw.13.1562770886793;
        Wed, 10 Jul 2019 08:01:26 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id o24sm506466ljg.6.2019.07.10.08.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 08:01:25 -0700 (PDT)
Date:   Wed, 10 Jul 2019 17:01:23 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
Subject: Re: [PATCH BlueZ 4/9] mesh: Generalize mesh-config APIs
Message-ID: <20190710150123.veutvrmbhx5v7phg@kynes>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
References: <20190710050959.7321-1-inga.stotland@intel.com>
 <20190710050959.7321-5-inga.stotland@intel.com>
 <20190710073827.5ktzlyynztmebiv6@mlowasrzechonek2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710073827.5ktzlyynztmebiv6@mlowasrzechonek2133>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07/10, Michał Lowas-Rzechonek wrote:
> mesh-config.h:
>     union mesh_config;
> 
>     union mesh_config *mesh_config_create_config(void);
>     void mesh_config_release_config(union mesh_config *config);
> 
> mesh-config-json.c:
>     union mesh_config {
>         json_object *json
>     };
> 
>     union mesh_config *mesh_config_create_config(void)
>     {
>         return (union mesh_config*)json_object_new_object();
>     }
> 
>     void mesh_config_release_config(union mesh_config *cfg)
>     {
>         json_object *jnode = (json_object *)cfg;
> 
>         if (!cfg)
>             return;
> 
>         json_object_put(jnode);
>     }

Or even simpler, since we don't even need to define the mesh_config:

mesh-config.h
    struct mesh_config;

    struct mesh_config *mesh_config_create_config(void);
    void mesh_config_release_config(struct mesh_config *config);

    struct mesh_config *mesh_config_create_config(void)
    {
        return (struct mesh_config*)json_object_new_object();
    }

    void mesh_config_release_config(struct mesh_config *cfg)
    {
        json_object *jnode = (json_object *)cfg;
    }

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
