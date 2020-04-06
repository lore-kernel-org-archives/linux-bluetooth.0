Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2959BC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021252072A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 19:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="EtuiulYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgDFThl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:37:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35859 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFThl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 15:37:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id b1so1043438ljp.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mi6+ei2itVXen0h2fqPCyaku2buJggpGicP6d9v9Z8A=;
        b=EtuiulYdNipDuouWjtwKppGnCvjh7nYTQv4T0DjeJ3kNaJEj72jttAE0Fig9pNHOEW
         kr+cEoCDCDKpHV2+SednSUZ40c6/WqY1LX+zYB4vB7nUooDoKHC6hR6zCJFPK+xz70l3
         y2p8EaN/nYuFUCo4T4UFAkghtCT1RkiMXSRfD0dtxlyFZDVfhtcWp6itlMzb6ZPQMreR
         dF7YG8Jy9jxVPkr7yz6QLf5tRfkcf6eHaMP7PmueiBRsLe/VAp4WsWu8u/LcleD7IwFA
         29CBo2L2HK5pFfp4ZIK6oKYEh0VCDzV7SQZx5oA3a5kXTXqN4i7D1vIHOpsOV3UpBRM4
         HjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Mi6+ei2itVXen0h2fqPCyaku2buJggpGicP6d9v9Z8A=;
        b=Z3n1rAPQp0X0z0W6t592Py3DC4N570DST1qMIJ7Sg4rBI9weIm45fDcsSThgQO3RGZ
         hPopXuIBwJG2/0QTn9SQHBf8WO788qNHIzf5F7qU3dbny4vsyHgHlRgi6JJrAHMzpoc8
         nvv+wj0VdDa9ajObb2GLp7DdxK+ki4s8RLFFcnmb5FM2Yp5+xQ+kMXMPTfa5dR59Yj4z
         sJ+yINin9sOAGOSPG92BRaOCbPOS8xtnn1d5OSoFpvrnEFWTUSmK+lPcNVGwhMwQNi/z
         9ewkwzByaTWEZoJon9PaeEukzO0/LIqc7/1AnldDSMO+/yTbQYecY6F8JxcMCBi7Y7qO
         uuqw==
X-Gm-Message-State: AGi0PubeNxytdNYmBfo0qoHhqz6u4MMh8b854pKrSTZy77hSWLJIaGdE
        XBUbGKrXEekrHBLB5HlwGF3OPg==
X-Google-Smtp-Source: APiQypKoFb7MfAR95Ham9PGInCSJhPrwWzJoy4D7Xe/Djn8SbITNuKuIeV7+2bv4eNgkMpjsqhhh7A==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr505044ljg.185.1586201856914;
        Mon, 06 Apr 2020 12:37:36 -0700 (PDT)
Received: from kynes (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id g4sm6064454ljn.105.2020.04.06.12.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:37:36 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:37:34 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ RESEND] mesh: Remove redundant code from mesh/crypto
Message-ID: <20200406193734.sf4s22b7uvcm4c7o@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200326211705.18678-1-michal.lowas-rzechonek@silvair.com>
 <27728473092a638d6c97520b14eac61656c56903.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27728473092a638d6c97520b14eac61656c56903.camel@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 04/05, Gix, Brian wrote:
> I think this needs some more work, in that it no longer correctly
> fails the mesh-test-crypto test when running:
> 
> make distcheck
> 
> It *almost* does in that it flags an error in red if a "verify" step
> fails, but it does not exit with a fail code.  This is an important
> step, particularily with the dependance on kernel based crypto
> functions.
> 
> My test methodology was to flip a bit in one of the test payloads
> (i.e., make it "not perfectly match" the specification sample data).
> 
> As best I can tell, it is otherwise functional, but the unit tests are
> important.

Agreed, but as of 14301cf0d42ba3fc4de99c3bdf183045be733e0c running
unit/test-mesh-crypto with modified payloads, e.g.

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 0043b0b10..a832b2000 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -591,7 +591,7 @@ static const struct mesh_crypto_test s8_3_11 = {
 static const struct mesh_crypto_test s8_3_22 = {
        .name           = "8.3.22 Message #22",
 
-       .app_key        = "63964771734fbd76e3b40519d1d94a48",
+       .app_key        = "63964771735fbd76e3b40519d1d94a48",
        .net_key        = "7dd7364cd842ad18c17c2b820c84c3d6",
        .dev_key        = "9d6dd0e96eb25dc19a40ed9914f8f03f",
        .iv_index       = 0x12345677,

also does not cause it to exit non-zero return code, it just prints red
"FAIL"s...

I thought it was done on purpose, as mesh tests don't seem to use the
src/shared/tester.h.

Also, after applying the patch onto the mentioned commit, I'm getting
all green runs. What system are you using? I'd like to try reproducing
your results.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
