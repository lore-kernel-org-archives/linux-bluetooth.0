Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278CBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 08:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DCD20C09
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 08:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tjvVoOLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFQIYK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgFQIYK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 04:24:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B403C061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 01:24:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so1828823ljo.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VJ/NRH+QmbQ7xXGqJiL5ePg9uJTpuwFMgQd2vOtCWdw=;
        b=tjvVoOLHuxkT5Aq2HBtFJGoDdbkjzEGmwdXWidfKCb3rMhak1N+7Nu6vaokPv9zzOu
         bdxW/qvBcVYIY1npQc9Z7bVaFHgZ7/sEHAkLd3meNJaA21uJWAz3E4WBfymZDljX0b2k
         sKsYvEiMV8i3Ed52kcCfJTto8R/p9CXlPtxJ+NvMBWAIYLuEkc8xlnmjfx+BVuE5zNUU
         4K2LwKCWcmJZbovAPgcWCU5BBiJ1KPjkKxC551bV7c4/k8HVsAllcYJ5gL1qB00d/bZg
         UIeK9lFzme2b74D8xISFvaBg24GoQY0ptvILD7JHa0VVmXy0Ux7AzGy7tJxf3NxcGknU
         na5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VJ/NRH+QmbQ7xXGqJiL5ePg9uJTpuwFMgQd2vOtCWdw=;
        b=j69I46UXWQcCXecENoCRNe5VEIofb9KUb8EkKYHZTH4PGzthhb6B5DAiMv0SQ2H2fn
         N1gOHTU87xQDPXM7OH1w26+n6I0WqO8VLlM84r5gMft8KHlDKwGtJ3p2cj3olo1Ro0qN
         2we1pAHJpDX9hxtWzH50bYKGnI9WVTes9ReVnrKlOrHsPRE+C9aDihBtJle5EwWKGCe4
         gqT5xyb24IPQXHG8mIdEaWblOgTQpCp+qQHgPcbQS5LvpfcsM0/fhfL0wjCBUrNg37MM
         vibKtr6WqewV4YKo/rHfi/uWyss0DdCEPTPVUe0elRgP8tdszjGmv9hBq1mEexGNcDY5
         uqRg==
X-Gm-Message-State: AOAM531xN+6N1pMb2fbMoSPCZM9uldk2GWt9ipRPgQU3tW74VOsBUaok
        FHQ1r8TTQz+EMMsfCJji9+pH8tJ1PwftnA==
X-Google-Smtp-Source: ABdhPJx/EPJSk/zNiMQgk+9XbetD8kkNyEshhN4AHs6IgiuFlM9ckcGd2i3qCpB8X/eAsbadTm++PA==
X-Received: by 2002:a2e:b5a3:: with SMTP id f3mr3184259ljn.361.1592382246919;
        Wed, 17 Jun 2020 01:24:06 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id p15sm4862640ljn.53.2020.06.17.01.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:24:06 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:24:30 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>
Subject: Re: [RFC BlueZ 0/2] mesh: Deliver mesh packets over datagram socket
Message-ID: <20200617082430.hezshwckqtxq73bc@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>
References: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
 <cf1b99049f6b843affbdc7355038a97331993d14.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf1b99049f6b843affbdc7355038a97331993d14.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 06/16, Gix, Brian wrote:
> This has the feeling of something that has been developed as the
> result of a stress test to see how much data can be pushed through
> the system as fast as possible, which should not be a common mesh use
> case.

Well, not really. We came up with this mechanism because of performance
issues with *real world* networks on embedded platforms. And by "real
world" I mean a single network of 200+ nodes.

We need a way to monitor the nodes in such networks, and potentially
much bigger ones too - mesh addess space is 32k+ nodes, and we already
have runnin installations with ~1k nodes, all of which are publishing
sensor data.

Without this, bluetooth-meshd is *unusable*.

> I also worry about the increase in system socket resorces...
> Currently the daemon consumes 1 socket for App <--> daemon
> communication (the one to the dbus daemon), and each App currently
> being supported uses one more (again, to dbus daemon) And all
> MUXing, marshaling and unmarshaling of messages is handled by
> DBUS...   the very reason for it's existance. While creating a
> new socket between App and daemon would make the messages flow
> faster, it comes at the cost of re-inventing MUXing, marshaling,
> unmarshaling plus all the additional sockets. A larger code
> footprint, and a *much* larger resource footprint.

As you can see in the patch, serialization format is very simple (*much*
simpler than D-Bus marshalling).

As for MUXing, I don't really understand what you mean? A node can have
only one application attached to it, so the daemon knows exactly which
socket to use. Same for the application.

About file descriptors: this patch targets primarily an embedded
platform. While I've seen issues with number of open files on busy
network servers, I don't think an IoT device is going to face such
problems.

As for the "resource footprint", it's a tradeoff between open files vs.
CPU. By using D-Bus calls to deliver network packets, you need to:

 - copy the packet from the mesh daemon to dbus daemon
 - have the daemon look up the application by D-Bus address
 - have the daemon deserialize the message header and check permissions
 - copy the packet from dbus daemon to application

This requires an additional copy and an additional context switch, and a
potentially costly permission check (I've mentioned AppArmor in the
previous mail).

So this delivery method in fact consumes *more* resources.

> This just feels to me like the kind of customization that is fine
> for a vendor to do for a specialized high-flow mesh, but not
> something that we want to impose on everyone who uses Mesh in the
> open source community.

I don't want to "impose" anything... the API is entirely optional and
the "regular" Attach() works as it used to, and might be perfectly fine
for simpler applications.

Note that GATT API does the same thing wrt. AquireNotify() call.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
