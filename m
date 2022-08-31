Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B294ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 19:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiHaTgb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiHaTga (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 15:36:30 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 12:36:29 PDT
Received: from b224-5.smtp-out.eu-central-1.amazonses.com (b224-5.smtp-out.eu-central-1.amazonses.com [69.169.224.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F37C696D
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=b4y2oqd7fm2lugxzudc3kdvc4wctgrpv; d=ubports.com; t=1661974202;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding;
        bh=cifvqcH7BcoZVGwLULg8y64waz6Us5umAW2IlK01rVY=;
        b=WIIPTtotDGbjKf1b5Fxl/1utOY9UYVUt3vCZiTuJU8CFfHoED5k05kIQk6tiAzUS
        yNWxh+ciiEfv7Nwx+/lUA8JyR0s3ZQf5mJIqSRHTL7QwBTZV4B7MBtFrxXcfMfrRY6I
        oPgD0H3SAlKv+3nKl6EurNGiAQuy/Ql8pmwWospb1+eFFwX6j1jLcLCzwZhwgzseuLM
        JTPcsD7/L1b8i8pLm0ultAGnUyCBjGIlyl26NzT0kFZXGBsuYGdvW3zZJ2i/YIO+dnG
        d1HPKC2QAjwO5inenAWaMSAZZrp2mwHQjEJcpis3a6/56oRSg+XBvNECnnGfNxeYSD4
        srdKbb9ZTw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1661974202;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=cifvqcH7BcoZVGwLULg8y64waz6Us5umAW2IlK01rVY=;
        b=oKuAjufXykYBDTFIhbt1BhRK4vXiWvlSLV04+k0ePLWsSjMomaGwvuP/rD7xQiLh
        FKSUFp5ZYJsUQqSmHOQ/fcCmc6QDwKsYXBPm/zK2IQEuG9zAwFnlFFfTy7A1L+sbPQ3
        JcBtLinslv4KUMZvUckX/+EIOaYeEJqcXapwJd4g=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ubports.com; s=mail;
        t=1661974201; bh=cifvqcH7BcoZVGwLULg8y64waz6Us5umAW2IlK01rVY=;
        h=Date:To:From:Subject:From;
        b=OHQ944Ulj3ol484Lc1Nn2Dw9FTnobQg5Mo8CJYt2w8U9nuDOd7WFU/VJFnWK8vUr/
         BG0Py1/231E/lysLXUpWpq2W/G3dSBUHvKSKBJj3Y2ecOPgNtBJbJwliM4v38mZ2vk
         1PONxoDmUsQ8kSj5y77QAO3YCDLYG1yWYIEQfokio0bT5iEusxIl5/sccePAkvEqA6
         ozi18MuPVKaRYMX9UV8aKhxNePsrrtwos9QuXjgL6VC333w4kTNejLPhH1Hc33RXV4
         /w97pXAFm+OYIpjfV+cn0t3tuAYqpeLyL48h1HiiSDyHNneTt+7/TG6CH1BekfWhP0
         SuTZ7LhM2Pppw==
Message-ID: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Date:   Wed, 31 Aug 2022 19:30:01 +0000
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org
Content-Language: de-DE
From:   Florian Leeber <florian@ubports.com>
Subject: [PATCH] plugins: Do not try to autopair with Nissan Connect devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-central-1.U71sxic/3tmi0U3T+Ze2hDyqoN46zyPgdCO+zEPT6YQ=:AmazonSES
X-SES-Outgoing: 2022.08.31-69.169.224.5
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It seems that Nissan Connect carkits a) do not use 0000 but 1234 as 
default code
but also b) the autopair plugin is not allowed to make a second attempt 
to pair.
Let´s try to not use the autopairing at all for those devices.
---
  plugins/autopair.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 0b09e89..6bf07e3 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -66,6 +66,9 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
         /* The iCade shouldn't use random PINs like normal keyboards */
         if (strstr(name, "iCade") != NULL)
                 return 0;
+       /* Nissan Connect carkits use PIN 1234 but refuse a retry */
+       if (strstr(name, "NISSAN CONNECT") != NULL)
+               return 0;

         /* This is a class-based pincode guesser. Ignore devices with an
          * unknown class.
--
2.17.1

