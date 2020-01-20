Return-Path: <SRS0=TohX=3J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F08C32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 22:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28378217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 22:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="m70WP5/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgATWcd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:32:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34222 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWcd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jan 2020 17:32:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so717569ljg.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2020 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qen2oaV6NSJ+DPu/aA+AjsLPX6S4e0YSD1L4RkCs10o=;
        b=m70WP5/0NaV+TgztVsKDzvPM/e0cAhyjeYS44CPXSBGF4Gbl9bsapo5v6iPZX5akPj
         EOjgplzLJe/yeq3xOz4IBYDo5D4V9ZnLDN/8c8+LXDZh8O/SQMIxIZA0Py24m7V35oDv
         wy7y/+qaYhvQhCWa1/ED2LuhLGb3YqIimT/3TmbF0mILh8w8HQUDGtxbKGDrTsRa1NYy
         Wm7RI/N2V6HyTUfJCitVDKVxdbCTIaQuy6fnoNcfgkgyuzEnhWjaOdqZs0uDW3zfmFdX
         Np9IcQ9aoHy0ds3+yxNHexkZC1bVYbc/YCkFxWlxGpKN5hLGf70JRx1E8PtzMDU82YA7
         ZBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Qen2oaV6NSJ+DPu/aA+AjsLPX6S4e0YSD1L4RkCs10o=;
        b=ptm8qCAkGyo9ble6mIet9IMGnAZLblSvz+IyxpIkbpMnbiA7uMHkcP0HbKsbugRrde
         rNgsxtonY/i5f0KOKHr8M/FNbh2rhfL1pVkRFyG58HWK62pnWAjVycTM7/Uh82r3fRsi
         AELXAkdKvjvdMeZNMnC3k8VWbVoWGrzGPuFPhjAqgmEkP0/7k8uMWBwV43SGab4Dw2C3
         K3QCE0EpP+GPn1sqPUHautO6nrPCZSRuKJsZD0p0FKaEVmjg6K82JFr0Uz0aJ+IF8u7u
         J4uF2znn1E0HNz2a1xb9e4XZJca4x2Zil0oa3uKy7jcsCM7nAmlcOkhhBs0v2hmvDFJ/
         IiNg==
X-Gm-Message-State: APjAAAVljp+PeCV14Hi1lroiDt0VRDaphtBsTEEkMU8zh2mr+8WmgHWn
        M2OPOz02D8BOsQl+0cLgtQYupw==
X-Google-Smtp-Source: APXvYqyaOGzEEWGqxJXpKHbV3jHTTUTHQhd6USNTkbqHZrO3cU6ta2qXLT1C7Yjm+AO04iGlQQX1Fw==
X-Received: by 2002:a2e:9687:: with SMTP id q7mr14261049lji.232.1579559551254;
        Mon, 20 Jan 2020 14:32:31 -0800 (PST)
Received: from kynes ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x29sm20466848lfg.45.2020.01.20.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:32:30 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Mon, 20 Jan 2020 23:32:28 +0100
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Subject: Re: [BlueZ PATCH] shared: shell: Only omit consecutive duplicate
 history lines.
Message-ID: <20200120223228.onfe3orcusf3vhsb@kynes>
Mail-Followup-To: Marijn Suijten <marijns95@gmail.com>,
        linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
References: <20200118204423.494209-1-marijns95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200118204423.494209-1-marijns95@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/18, Marijn Suijten wrote:
> Change rl_handler to append duplicate history, as long as it isn't
> identical to the last line. It prevents consecutive duplicates while
> still having an accurate overview of the most recent commands used,
> mimicking most modern shells.
> 
> This addresses my only major gripe with bluetoothctl: pressing UP does
> not retrieve the last typed command when it is a duplicate of something
> else written (much) earlier in the history. It is especially noticeable
> when needing the same command repeatedly.

Works like a charm, thank you!

I was wondering why btshell utils are so weird and never thought it was
that obvious...

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
