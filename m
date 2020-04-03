Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83001C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A045208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 07:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gJLk7XPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbgDCHkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:40:00 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38286 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389685AbgDCHj7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 03:39:59 -0400
Received: by mail-wr1-f52.google.com with SMTP id c7so7278498wrx.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 00:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T+ny2xt7oV0AF7kZU9x7GRzFG4bH2jJvWpxk4ZHCmBc=;
        b=gJLk7XPWY6xROrEcrWsx5zmc/q+5BiPHx2xVeJ7eQcCjtmv+iGIdRB3LpFQMJbcjQr
         //bBA7Lh5y70ACUNiBKR/hbgO8DexswQvCNdHUlb2dSy9tm05nbFv4p5Prb4TuKXbkKN
         ErVNV5QWIc/rmMuluzuV31gyMv3BmVjQOo5AGg11aAlRawZM1xovkVNCcLmVEGC5Q/zz
         icEb1b/nYUB7LWOjsXUXHRwb9MZxFLpw/FgZiosnD9h+fFjJvl3v5m7HQoQ+VQ5AE08j
         3aiBrthWJsLAPsvgXnWQs3YFkm0CoQNoR+ioY+vtgDtAK7P+qXAeobE5fif6NnXslFR5
         LZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T+ny2xt7oV0AF7kZU9x7GRzFG4bH2jJvWpxk4ZHCmBc=;
        b=Pcw1E4Il8I8/wRgnsSNOHP1twJYmRdAXK+ZOghBY9TFlyCCf36NAU7gw/CyH/1AgVp
         N2hhBR2heUxXaEZH62S8bWKs5QjXgIRVUrs6Dm3Zrgg3PT6ON+RQIMVuczZHMqoSOmbC
         UY/WoorMxurL2pTTv0RQeLzaxHDjoaISg5PJSEQgeA5fS291O5TaBUDF6gx0I9N1diby
         UmGk/+/hRDTWWZpN8kxCy1FbQ+CbnMue+9Z25Qf/WlMNjdTYXlYS0pfpEpjG0t7pQxw3
         4vXXVHNFR7+3xiD4lOBHb0RkjBP1kUz0df/++RrJQnupbu5Sfgv93/DjRO54KFnhPtXS
         VIJg==
X-Gm-Message-State: AGi0PuZTFLr01ZkyA04RXHbz27HR1B6cF/u720PKBbfQjyCWoK0zF8+L
        fsq/v88s5sxLxPwkZ7wRo2Kmen8p
X-Google-Smtp-Source: APiQypIIhpeBqVhRtb7bll9LOh9Y0dXPtO+cFJqgTHVpgHF1W8zZ6NfLEg5tCWRWH7jmX5hm4uAVXg==
X-Received: by 2002:a5d:5707:: with SMTP id a7mr3620693wrv.108.1585899597679;
        Fri, 03 Apr 2020 00:39:57 -0700 (PDT)
Received: from RBGWVBL000659.fritz.box (p5B26793F.dip0.t-ipconnect.de. [91.38.121.63])
        by smtp.gmail.com with ESMTPSA id 98sm11283261wrk.52.2020.04.03.00.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:39:57 -0700 (PDT)
From:   "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
X-Google-Original-From: "Klein, Thorsten (BSH)" <thorsten.klein@bshg.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Klein, Thorsten (BSH)" <thorsten.klein@bshg.com>
Subject: [PATCH BlueZ] Added Manufacturer Data for Scan Response
Date:   Fri,  3 Apr 2020 09:39:50 +0200
Message-Id: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A ManufacturerData field is added to the ScanResponse. Keys are the Manufacturer ID to associate with the data.

Schachschal, Maximilian (BSH) (1):
  ManufacturerData field added to ScanResponse

 doc/advertising-api.txt |  6 ++++++
 src/advertising.c       | 25 +++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.7.4

