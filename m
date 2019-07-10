Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCD1C73C7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7042820693
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 07:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="HZNHQNLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGJHwv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:52:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45110 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfGJHwv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 03:52:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so1296366wre.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2019 00:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kxfsIK/azxtf+dkgnH9i+nHGvgqgPlzs2CH//OPWnZ8=;
        b=HZNHQNLhMH5trFthpdaha1PHNG8G5IwEJaNcS3oySGqzUPziJa23k2eaNKxfi7wW2H
         dnGsVyECBwyg744d3IyyI2pV/D+9u4qUqqnDDtXSJkG4JLxLC+HftsCUnNx494P1arG/
         1RbUjT7IiinI4TmaDC0yNkmdlZV0bByYkNpPubcSA8KS6VxCbB0Ru+HFsri9ZyMFmlvX
         FsvAAvXxpBRBMukXOZrI47vo/LMENqiCyz37nMbtq7hudwvl8vQvkWy03sUDOvb6MBFS
         0eeDojvxmvWfYNeZIy9GHGZpT12g5K8ab/Q6BpkiWegjYANHYD5PloW9BuD5/sZGoT+S
         DxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kxfsIK/azxtf+dkgnH9i+nHGvgqgPlzs2CH//OPWnZ8=;
        b=TkoNWMOgAFBWZcPqN2PiTKaSTQr03R8moNDpR6TI3+5dCYZj4mLvhfSHngFUn5tQ4A
         T7+xPNf3TY9GhSNrFTEA19VfVwl+yvI+4cbyoPWGHXMVBo+1NAKPFYqoJfmrEloOfpYY
         GMsli1ZnU4m08rPfl3DyC/RGJ34Ge8Pw0io9lLSzkY8ljY+CvATvUxZ6wOXKccUiuEF/
         hjjf9Mr3ypO5ZkwDRBNEq287p9pGTgQHfpqskBA50t4/bQsSv14hhoPv6OvOQq2fY02m
         8kTSAws6nFsXB7g8gDV5BkhkhQ2OYyvGNv3ixeDNxEKf1xNJBgBGApk168jRo/g6f5Je
         I+gQ==
X-Gm-Message-State: APjAAAX4jdTcwlYKfh1pn5G0piuDpaCX38/UPQKsR232Z64TV7YAmBYA
        e9X8uVdmqUi7gIU9OBv9zZZlIQ==
X-Google-Smtp-Source: APXvYqx7dPbGJjxOL/QcsfJlwRe5oRYFBnlEEo8/0UubeDEhxtKlUuI5SeoYv0ZN3A2mQgesUQ/2SQ==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr30836125wru.147.1562745168762;
        Wed, 10 Jul 2019 00:52:48 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g11sm1442478wrq.92.2019.07.10.00.52.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 00:52:48 -0700 (PDT)
Date:   Wed, 10 Jul 2019 09:52:45 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
Subject: Re: [PATCH BlueZ 6/9] mesh: Define storage format specific
 read/write routines
Message-ID: <20190710075245.2koao3eyj22wbj7s@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        jakub.witowski@silvair.com
References: <20190710050959.7321-1-inga.stotland@intel.com>
 <20190710050959.7321-7-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710050959.7321-7-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07/09, Inga Stotland wrote:
> This adds the following generic APIs to mesh-config.h
>     void *mesh_config_create_config(void);
>     void mesh_config_release_config(void *config);
>     void *mesh_config_get_config(const char *dir);
>     void *mesh_config_get_config_backup(const char *dir);
>     bool mesh_config_restore_backup(const char *dir);
>     bool mesh_config_save_config(const char *dir, void *cfg);
>
> The implementation of these API routines depends on the
> underlying storage directory structure and can be specific to
> a chosen configuration file format.

I don't like the assumption that each node is stored in a separate file,
and there needs to be a backup file.

One of the storage formats I had in mind is a single transactional
database (some flavor of berkeley db, or maybe even sqlite) that would
hold all the nodes.

With this in mind, how about:

    union mesh_config *mesh_config_create_config(const uint8_t uuid[16]);
    bool mesh_config_save(union mesh_config *cfg);

and to iterate over saved nodes:
    typedef struct mesh_node *(*mesh_node_load_cb)(union mesh_config *cfg,
                                                    const uint8_t uuid[16],
                                                    void *user_data);

    void mesh_config_load_nodes(mesh_node_load_cb cb, void *user_data);

and move file/directory handling from storage.c to mesh-config-json.c?


regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
