Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C77CC636D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbjA3SjF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjA3Sit (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:38:49 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0D9DBEC
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:38:03 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 968CC1B00284
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:38:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGr63m2nawIlWmW54r7Y7bbf5H8d62yr4LMtjIapxLE=;
        b=SupBJFo2nokol5N585npdxHG/KIHYMeN+e/LqYQfBYcxU17/cGNNQ/WaRCifxYnroMa+2n
        +y0E1NVdhDQELX/6rj3iJqlcyqQzY1c1a7tQ+MhDKJpF+/iG1pPqmxOeegGsqWeifhOlEI
        yD6lkHXrXJ95ZZAu2lozRqsa7mbn0lEwfsHzY+2CVEiQqE/ZaNTJXd7aqoZNCpDjj20YyV
        7zBKajfdNt3ibMPCAoDsh3a0naumIhT87vX/qpyp/pnAsHiwTv+H1DVaP4z7R6CzCGI+Rz
        pQw+GwHqkUI07SzKZzgjY5y5p4lAdnvPZ0HARmj2o1K26zCIcw+EK3Z+p0Z+mg==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id E97EF203AF;
        Mon, 30 Jan 2023 20:37:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGr63m2nawIlWmW54r7Y7bbf5H8d62yr4LMtjIapxLE=;
        b=Nz45eKaQnASPHKZgbDPtricnlJ24Rd7FJcGIz8HLByoksW4DcfvxmQwA1BoWmkCNnFhhPh
        wpReRhqMOTbbDleFb5AM3R6ruIBfHKtH2YoS5TRrSNz4oJQp5U4DRIiqG2UXTl6YTNbUPn
        r0MNyPsix+H2BW5l5gL/hTgFocoJIw8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGr63m2nawIlWmW54r7Y7bbf5H8d62yr4LMtjIapxLE=;
        b=w/bggFRU2C4xSyCRL9NOjQD9wLEiHESM/P/UxeP0ZHx2aPNCk/+Kvx6FjnQnyG3l9rBfDo
        rK5phz9eoiJtGV/qRvXMHxmuAdFAHzlTjjuRztU/RpTOt+MeuD5FSfvbTCfmLpRQ59LJ/V
        RLcW0SaSmDNO5NH/baXmr20s9kj8OnI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103875; a=rsa-sha256; cv=none;
        b=e+RyE7fasXLu0rBFfJrd/5+76AEcdCycEdfZc/KUJLkFz++FFl/Psa80EPiDjlH4cMfkAy
        9c3nPIXA13oTqUavGXgDgK+CAiDF2QzgRQ3ajcvwR5AlqQCvk0sQ8LX/2RYyY3r1QjVSjw
        GveUIwyQiDVmSmXTQfphbGOnFHSKOqA=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/8] tools/btmgmt: add names for MGMT setting bits for CIS feature support
Date:   Mon, 30 Jan 2023 20:37:35 +0200
Message-Id: <b98624eb045141f941c3855631e266c93203bf91.1675103676.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btmgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 29f86091f..323c26712 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -353,6 +353,8 @@ static const char *settings_str[] = {
 				"static-addr",
 				"phy-configuration",
 				"wide-band-speech",
+				"cis-central",
+				"cis-peripheral",
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.39.1

