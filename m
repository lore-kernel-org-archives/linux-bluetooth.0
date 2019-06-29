Return-Path: <SRS0=n2JM=U4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D4BC4321A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jun 2019 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A34214AF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jun 2019 08:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="VsffgTf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF2Iej (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:34:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39495 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF2Iej (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jun 2019 04:34:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so8229619ljh.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2019 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1YvU2FIA7Ikg97CRGU4+s26fQbNERK2qByWTZJ+ydKE=;
        b=VsffgTf+RefVgV6acPXSL8V9aA/PdLM/B1XOav0U3MCPYIp+GD/skroA0rojz5buLW
         NdX4/3r0fN328C9fu1CmAuIB9cTqli+OFNhcrNympMAPR7p7N4NE9GUwAckhcvRMlU88
         sm9GcEjwP4/xl0wVGFKau784K6Q0cMbYZrnOTcI0HZQ0hx1VTd1JkzeVxNYBe3eiAqHk
         n1RJT3eS9nud5x7DiOAS/rZ17f8jjVejHe9zno0pvoeHcWuH5PgVIXI9edlijdpomIGY
         9F7OqhGlwH0KmdVY17Q4JZsavCWa4GJc6WwUxk0IxomKGX3U2HjiIBwga6Z7WOSohF2k
         NmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1YvU2FIA7Ikg97CRGU4+s26fQbNERK2qByWTZJ+ydKE=;
        b=S6xrvafECi078NYp2ZS/9PPEvWC4dTCePCzpHpYXL1zO3k4wLmZC5EklGXBvViw23k
         K3P8QsbbWgpMutcJNHD78R6rs38ivGE/VAQTF+7d4gQFkxoWyIDBCyO4aZ/zwP/pUh0j
         YXe4M6jhVcFkf22LtjR2+pg4WP9WV1VNIbiPUl8IOhm+fk5BP1+fW5iVrVLcNenXXUle
         QuQ3mGj5se6POmBWThGXNoWanoEF7ie8HDJO8ZjxDUsXeFTBXW11HZfPqFw/c/oKVfHD
         S7GBHpUgDPkO17kZ/F57TTKI/x9npjpJOMO0pukZmlskAoCYNL+nQFOdElGi9Q5qSSiW
         VjYQ==
X-Gm-Message-State: APjAAAX47jbGiW2odLKdTltxt5QhAFYq+9DuIDkKRU1SoWX/JaH/6mLS
        WD+TpAFkVNXCPcD2gr7WqLEJfQ==
X-Google-Smtp-Source: APXvYqwbM44Jwzmje4X9G3DezYiRsuFXExzPC0UY3EB3/KW9ESYxfFLKMiSX2IQgSHNHGjeFLgMKEA==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr8327424ljg.103.1561797276845;
        Sat, 29 Jun 2019 01:34:36 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id y127sm1171713lff.34.2019.06.29.01.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Jun 2019 01:34:36 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Sat, 29 Jun 2019 10:34:34 +0200
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ 2/4 v3] mesh: Fix virtual address processing
Message-ID: <20190629083434.edok7cdjwsjt4d7i@kynes>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20190628230142.16367-1-inga.stotland@intel.com>
 <20190628230142.16367-3-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628230142.16367-3-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 06/28, Inga Stotland wrote:
> +static struct mesh_virtual *add_virtual(const uint8_t *v)
> +{
> +	struct mesh_virtual *virt = l_queue_find(mesh_virtuals,
> +						find_virt_by_label, v);
> +
> +	if (virt) {
> +		virt->ref_cnt++;
> +		return virt;
> +	}
> +
> +	virt = l_new(struct mesh_virtual, 1);
> +
> +	if (!mesh_crypto_virtual_addr(v, &virt->addr)) {
> +		l_free(virt);
> +		return NULL;
> +	}
> +
> +	memcpy(virt->label, v, 16);
> +	virt->ref_cnt++;

I am aware that l_new zeroes the allocated object, but I think it would
be clearer to say "virt->ref_cnt = 1" here.

Sorry I didn't catch that earlier.

Otherwise, the patchset LGTM.

reagrds
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
