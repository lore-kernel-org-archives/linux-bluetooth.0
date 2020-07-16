Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5050C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 09:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BF22065D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 09:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="HRBM3ziZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGPJml (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgGPJmk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 05:42:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB7C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 02:42:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so6360022ljm.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kQ7kXhUoZLozn3MgHnFmBlQD8NJnsw2HeDSPeUP+UxY=;
        b=HRBM3ziZu7PceddomSG//rZdTzIqj9RAer61/nplBCC924TtEedDONC4GgQk/HXkzg
         YYBzkqfGIQsdEuNN7wto94A2uRhw+A/dVNCUO9g+wns71JHYx5ZV6JMxWt6GvabkbPkn
         gwlgu1e5Eqb55fcrwoUEMd19FicLqhLd6g6NNrDzmXEX5ffOH7BaacsUGumLJvDBG3Wn
         FDU/225BuGhP31sPRvq61wa7lP8KRvfw1fK86eFYaWbO2TGlzpsuStbx8cacn8aJn0cT
         3geFQAxSEkml68KD+tWk1gSH0gjSzEmrXA1Isn20Q8HBklBuVncMkPhfcDkx4VFD6YRO
         T5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kQ7kXhUoZLozn3MgHnFmBlQD8NJnsw2HeDSPeUP+UxY=;
        b=E2BZkILts2bjknN19cOPrG24GLjXh3CeXzo3EIQYgif+icFBuA8G/bv/Q34eT++YCo
         RWgFnqdgsY1p1weAnF6I7Ku0k6wLXD1yXEgxgWZcTqoGMmhiWxNC978vtj+vqDGL05Yy
         UI0MS4gY0a3Lgcaa1nwWLdr2y3Wb33xOzmzAlaP26jwzfi0ZOfQDNpV1eLezEogBiJRe
         ZGYtENQycRbK/NAe547c1nbOEm22rH6V6mYE/Ztjsu44eOGdK+ooe2yTwYofTu0QEjt4
         0klYettgJ03T8825TanJq1KRylVh3i0p4LTgZfy1ttNkxfVFmReXCkh5UA68vt4HARpF
         52tA==
X-Gm-Message-State: AOAM530MSpLvSSlZbP1usL5MEO2zZ9Aqq4+MNzM1rmUWQ0VrNa9fl/W2
        H3DtlJwoDysVDAPMDLxWik0f0A==
X-Google-Smtp-Source: ABdhPJzRjXHEMBXC9qnRa04p7Bs3QnjieNBDiJnegZuwyKDfdECh4bkv309gMRAvmxrk20jb0uGknA==
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr1550315ljp.188.1594892558686;
        Thu, 16 Jul 2020 02:42:38 -0700 (PDT)
Received: from [192.168.52.103] ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n7sm929720lji.97.2020.07.16.02.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 02:42:38 -0700 (PDT)
Subject: Re: [PATCH BlueZ] mesh: Fix node composition change detection
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     michal.lowas-rzechonek@silvair.com
References: <20200715153343.2115695-1-brian.gix@intel.com>
From:   =?UTF-8?Q?Przemys=c5=82aw_Fierek?= <przemyslaw.fierek@silvair.com>
Message-ID: <fed43837-fd44-c5ac-6d89-f2d167936a47@silvair.com>
Date:   Thu, 16 Jul 2020 11:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715153343.2115695-1-brian.gix@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

LGTM and solves problem. Please merge it.

/PF

On 15.07.2020 17:33, Brian Gix wrote:
> This fixes a bug that caused disallowed composition changes from being
> detected and rejected. The only fields that are allowed to freely change
> are CID, PID, VID and CRPL.
> ---
>   mesh/node.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mesh/node.c b/mesh/node.c
> index c61167bda..9b97aa927 100644
> --- a/mesh/node.c
> +++ b/mesh/node.c
> @@ -1579,7 +1579,7 @@ static bool check_req_node(struct managed_obj_request *req)
>   		node = req->node;
>   
>   	node_comp = node_get_comp(node, 0, &node_len);
> -	len = node_generate_comp(node, comp, sizeof(comp));
> +	len = node_generate_comp(req->node, comp, sizeof(comp));
>   
>   	/* If no page 0 exists, save it and return */
>   	if (req->type != REQUEST_TYPE_ATTACH || !node_len || !node_comp)
