Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B7DC388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 20:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF3120BED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 20:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idT9cYTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372049AbgJVU4O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896682AbgJVUzy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 16:55:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194D3C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 13:55:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so3436739ljo.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ovSjaF8+AQYsNiCX+NFwJd5UBFzbmmXOmXUqLw5+IKU=;
        b=idT9cYTEFm1DK1SUOnCS0N+lYwK+G+69GUMe/tjese0xEbSGZB2W9sriYvaUL4TJrd
         oxOR23pZToWQh70Yn0yvSlZRZreM9Q+I+SC8Ap9Ku7BDCx0ZGN441pm0fPvTNvCIscjD
         UPHLXI6AajQPR1giYWRT2M9Pf4MN10nGcBdD+Y57QaKHrbsgqjNHWCNV4imLL3xaa/53
         tCi3Gs0VPiQN8U5qb3szTlKTJnVs1LudeXlIgLYjxRaqEZEjhyBXttoeq5yCeklPMO1+
         tIj7Dfa3lD14xQUzsntieExGi6jwQEIIQOKWF4m/lF43JmU41hZYFYDIaULc0u38X31T
         5a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ovSjaF8+AQYsNiCX+NFwJd5UBFzbmmXOmXUqLw5+IKU=;
        b=nHwKAwj3FNbMi233s5VUMhri1cp1QOCE4X1tj6DFrImXC/9jrIYzQGRu/TVsFRk0nY
         G1jLFz1OQl//xsEqtBOEgNRu3WnJliYGcuAyLGxIyde46TVuPZDQfKqq5b3uAil0nY/1
         8njBNCGOrD3gKLsPm5M/s273xc2wz0CS3dYyMG2JQXIswmV8//oQJWo+oyaMzXw+FNOP
         vxLCizK4dwaKolRpCHogTn2EzgDTdYCdr4AuUbRh6cQ+lTWU4V+aXcxjL8g0o6jSsCcL
         9fZ1OWAj3LnsGrooABc48bvnU6BB7fosDyW+pGfgkoGNLhmu6IfS6e/b9Z1pehJYyWh6
         VUEQ==
X-Gm-Message-State: AOAM530jK5Oum2dcQh67KWwqg+KkrbZ2fySWYLwPuWOd8OL1rU3O5K0X
        RQmLmFQkJOMp36s3ObhOl/0=
X-Google-Smtp-Source: ABdhPJxKPHmiIbiIS1l6tCFCNfBEM9QUY7K7JkA/UbDwSfJ9DFz3aP1rgLluKvQlrHPYTqaxx0EivQ==
X-Received: by 2002:a05:651c:203:: with SMTP id y3mr1582906ljn.457.1603400152381;
        Thu, 22 Oct 2020 13:55:52 -0700 (PDT)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id r5sm432297ljm.77.2020.10.22.13.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:55:51 -0700 (PDT)
Date:   Thu, 22 Oct 2020 23:55:50 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Bluetooth: Fix not checking advertisement
 bondaries
Message-ID: <20201022205550.GA63907@jhedberg-mac01.home>
Mail-Followup-To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20201019172529.1179996-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019172529.1179996-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Oct 19, 2020, Luiz Augusto von Dentz wrote:
> When receiving advertisements check if the length is actually within
> the skb, this also make use of skb_pull to advance on the skb->data
> instead of a custom ptr that way skb->len shall always indicates how
> much data is remaining and can be used to perform checks if there is
> enough data to parse.
> 
> Fixes: a2ec905d1e160a33b2e210e45ad30445ef26ce0e ("Bluetooth: fix kernel oops in store_pending_adv_report")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Fixes rssi parsing.
> 
>  net/bluetooth/hci_event.c | 73 ++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 17 deletions(-)

Could we get the matching HCI logs for these corrupted events? It'd be
good to include that in the commit message. Unless I misunderstood
something, from what I can see from the changes the fields you are
adding checks for are generated by the Bluetooth controller, i.e. only a
buggy or broken Bluetooth controller would generate such events
(meaning, this shouldn't be generally remotely exploitable), so it'd be
good to know exactly which controllers generate such broken events.

Johan
