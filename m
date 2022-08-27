Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE0ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbiH0AGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345144AbiH0AGB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:06:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DFE8690
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:58 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso3356709pjr.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=QSMUiJU2mV970rn7ifAB8SnNl65gwzqHfzVq99/Upio=;
        b=bUftI5hEYHLl3HG/p+kK9c4BBchEmjnrjjZSVrNRVl3SK773aLPtxgftoAFk4LEoWJ
         WhRJTOcqA5qVsLqhU2UEt6lAgpgnuNiYbwfjVt6qtEF2L6ajprC3GFD4nLQliz1YA+8R
         qpae+UKs5LlJbVqFMcRq7/rUsTBI1t9Ds562aIxSOVj1NbUYYc4QOk7YPp71U4WOBe8r
         +QGzAvWtdNJQzPNaDb2XLIznWYJkcNPRJtNGD++qdNfLX4LyBYZXaXfDCUu7SlyIRO6h
         xEPzsddfc/9Olckjb8ZgZmltBjTn6rb84SWBQaBw8ygQXwJTy3Pfz56JGDE+ztO33gPo
         ehNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=QSMUiJU2mV970rn7ifAB8SnNl65gwzqHfzVq99/Upio=;
        b=rj/YA+SXpAdOiUmH2cPd+ONhY+TlwBu8KsyElXlHqw2nQTH6X04vF2fhkfcJ29Li9I
         /Z80xv6NBVdsllAzPv2WXGwYrsOmrlkXmteY95LH+CRKRlTaSPGzgCKMKlLEOLMGCIT7
         6J02LlMP4gs5pbWS3Hm6SY24GG425tsvPFKIv98qdnekexBn9+P9PSshM7smHDGzmu7D
         9J8IQtjMTxerSR57ilYSDEcWB8Vtv5LAXhABT1bekyeGjSFM3GrgY4JtsG3GY7qsaBut
         a5bHLPgaMojUPnL+izp1JhA718Zinc+BS/X6LTnEag2wJnHn10yNmH0KtICtd0rgzoCK
         Pr2w==
X-Gm-Message-State: ACgBeo3bHcdQxN2z2Tm26scV2ukNDqy3DSSfSbA5awDmHFgop7++Tiob
        Sx3tsW/ihACb/WdymmWPCNr0FRfDo60=
X-Google-Smtp-Source: AA6agR4M0ob/5HPD+Z8rV1WgtmyLEanE4OtPRDH67R+X5Bos7wY+PSE67uMc/djqYv5CKqvvQIrHTg==
X-Received: by 2002:a17:902:e844:b0:16f:9d2:f4ff with SMTP id t4-20020a170902e84400b0016f09d2f4ffmr5899508plg.27.1661558757509;
        Fri, 26 Aug 2022 17:05:57 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:56 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 11/11] profiles: Update transport Links property on state change to QoS
Date:   Fri, 26 Aug 2022 17:05:40 -0700
Message-Id: <20220827000540.113414-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Frédéric Danis <frederic.danis@collabora.com>

Currently, the Links property is only sent after the first call to the
Acquire method, this cmay result in a rejection if a linked transport tries
to call the Acquire method before receiving the Links update.
---
 profiles/audio/transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f36e609cbd7a..f233643a6a3f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1321,6 +1321,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		/* If a request is pending wait it to complete */
 		if (owner && owner->pending)
 			return;
+		bap_update_links(transport);
 		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
-- 
2.37.2

