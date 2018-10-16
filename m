Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51244C5ACC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A58E20869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxUA0CJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A58E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeJQELw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:11:52 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46735 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQELw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:11:52 -0400
Received: by mail-lf1-f46.google.com with SMTP id p143-v6so6974664lfp.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NQp6a0OtxGqkJQye144uIiwbfkKtHbJxuCprtE7mHUc=;
        b=uxUA0CJB2muFbnxkmQ6FcGdIjR0MAA5GtTenz+35CyUvMLegklOktbwLu2Lt0Y33eT
         hC9SYu8Wz4hugRZk/Xr78wVTqRIE6QhvZTV5lEam4DygJtiROPbPP104SPvtDoV7Oytd
         vFXt6E5Mg8rrXNPlNLEMyGVslF1Z9tSvc62p+BCoYIlZoWjdZfCPSvncv4J/4oZEbdn3
         E+GoZbifo0BA6HKqavvdL3KIB34xk13EMZyAJLTy9fOAYP5cvX6UosAQyCtyon1wpzNH
         Xy/KkHH0ewx4SnUzFVlXrlVAMd14omkZ72eYWtKjuFwxUonUVGwzui+bPVOoFIGcwpan
         Q92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NQp6a0OtxGqkJQye144uIiwbfkKtHbJxuCprtE7mHUc=;
        b=Ff4JdTUwq8m5RjfdOXQeAJd6L8sk30ULdMYyRIL7ju8k//HETIGSIC+cwi1ygpS7UO
         OeA3OZPj+rRGuNRmIo7LvWEqRkHBcHu7LXlcKJnX/QmBy2DBhxyphTbVUotRkP6emVAA
         tN0vix5yPGu5crJiNdWwJ3s4B7DBNO/GQNM+zAX/gqrbslNMea3VJztKHqhwVrAExS0Z
         UXVxrqY28wIewRzJINd6Jft+IJMu3a6MoQFpVrqBaHUUCFwV4isYBValj7SgnMXX2gzB
         PZ8L/5+fp+B/xlznezdL/AcTaVwRk5JZFmjdb10p3XvUa+NNxA1hkFJ2WAJUyZmVUot6
         Xr6Q==
X-Gm-Message-State: ABuFfogVtuY1Vsw21qo79kWVY6j3X51r26SoDjuyPbgTuVfUj5vCRSRa
        S92gz1bqZoRy5uwfHid29IzO8Z/NncI=
X-Google-Smtp-Source: ACcGV60ujACPHXj3OZexRMebr+rUbvT22aCZKmdxqCzevCdFtIc87F8Mbz3FVZKIH3famJPtdFAo+Q==
X-Received: by 2002:a19:2095:: with SMTP id g143-v6mr8011698lfg.62.1539721185215;
        Tue, 16 Oct 2018 13:19:45 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id h2-v6sm3274902lfb.27.2018.10.16.13.19.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:19:44 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:23:12 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12] btmon: fix segfault caused by integer undeflow
Message-ID: <20181016202312.GA85016@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix segfault caused by integer underflow. Fix is to check that
rsp->num_codecs + 3 is not bigger than size before subtracting.

Crash was found by fuzzing btmon with AFL.
---
 monitor/packet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 461f5e84b..1e9f9d9e4 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -5832,6 +5832,11 @@ static void read_local_codecs_rsp(const void *data, uint8_t size)
 	const struct bt_hci_rsp_read_local_codecs *rsp = data;
 	uint8_t i, num_vnd_codecs;
 
+	if (rsp->num_codecs + 3 > size) {
+		print_field("Invalid number of codecs.");
+		return;
+	}
+
 	print_status(rsp->status);
 	print_field("Number of supported codecs: %d", rsp->num_codecs);
 
-- 
2.17.1

