Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38033C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022742072C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586795123;
	bh=c/6iTlsY5PP0RqNH0bhnmAvRf7pCQPloSFHgJy+XCY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I6kqTNR63uOFnoaXzT8/yEr7SGnfXvNaqJHnNg5NzYAIwp9bRd1nXV4CRw8PSs/GQ
	 Rt/GqmFms0vEGTWKV1M/PZyC0rGIyyzJrJh5LFqe9Y8ZjGTSPvzlrUxBDZDElOw7zD
	 qx9R1RTtE7Geea5ULEGm0Ig1FRSa6hTSukbWjfN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgDMQZW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgDMQZV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:25:21 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5168F20692;
        Mon, 13 Apr 2020 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586795121;
        bh=c/6iTlsY5PP0RqNH0bhnmAvRf7pCQPloSFHgJy+XCY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEdjMiNyxTOkVv2cPuaYE1mUeviVdic4wRMjmHF02AZQxm6DA05rHWJE4nBseF58V
         IGbBh3yoj+47gJsBq6Vrw3XND2YoYzYh/uPSs3GGf+Bw4vf3N8catVcOOgujXf+B+B
         OlGgEi55WdRog1Gs8qzn6fGf7a9mxpUbziwyykvU=
Received: by pali.im (Postfix)
        id 0282F895; Mon, 13 Apr 2020 18:25:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH 0/3] bluez: Export SDP "Remote audio volume control" item for HSP profile
Date:   Mon, 13 Apr 2020 18:25:10 +0200
Message-Id: <20200413162513.2221-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321195404.fvyku5hmcuqxt7sg@pali>
References: <20200321195404.fvyku5hmcuqxt7sg@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series fixes handling of zero value in feature list and
provides Remote audio volume control support for HSP profile in both HS
and AG roles.

Luiz, you wrote that you do not have time to work on this, so I
implemented it myself in this patch series. Could you please find time
at least for reviewing and merging these patches? Thanks.

Pali Rohár (3):
  src/profile: Distinguish between zero-set HFP AG features and unset
    HFP AG features
  src/profile: Export Remote Audio Volume Control SDP value for HSP HS
    role via first bit in features value
  src/profile: Add default SDP record for Headset role of HSP 1.2
    profile with Erratum 3507

 src/profile.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 8 deletions(-)

-- 
2.20.1

