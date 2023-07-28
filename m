Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F3C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 04:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjG1EqQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 00:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjG1EqM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 00:46:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBA26BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:46:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9922d6f003cso241757666b.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690519567; x=1691124367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sG8+oB+fQ5vccmXm3z0MhshQ3iTjvVqmi/xkHb/DH7A=;
        b=IWlesWABbuRDf5MLsWwrRoG9q94lLjq1jo97aCsUm2XP9XNQmbcdZC5UfcyNlw8kzm
         9sDFSZVGydz1eIcMMJiN4mllET6JeS6u3i4Agd81MGN67Mqqi7bzUeNiaVR7Xb1GL5Ib
         rp7VOR7WuqKVzZhFRPhz2EfHxx3Tk6J4tGo+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690519567; x=1691124367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG8+oB+fQ5vccmXm3z0MhshQ3iTjvVqmi/xkHb/DH7A=;
        b=YUus0D6UCi3nwzEhE44Ht5g4+zzcp8mL+mAxKn9UZMi7kTQ3Flrwte5qNeoKYTHXDU
         r75I6fk397PHP2ppIG3j/XX7R2bryrhF77dYpL4P/Gq2N61D6d5ISEKSOb84CTp+rEY3
         jEju/aLbiru5mibj2kpA2DMDEhqVYsgFsFCWiQJZ5bcYr4u2/t16R3wZQ2udCtaI3LgB
         qPWOfKdKN+YFjH5qNEqY85uuavs48Qf8XFm+lbRdwUuayfrmSVFNZKm52PmLX0ODG0vk
         PjkuLDmGh6m6EA0PdJtQ/wiT5km+fkSubMotu4pJdE747KasK9wCMLUHgoBmG+axkQMx
         S3kQ==
X-Gm-Message-State: ABy/qLabDz2SybyM2ZB/g8jzIy8dS8i3NFbicKQjR+eU6/1nhxuLu4WE
        8/fd2BR+iKyC8YCNCY9K5OFKVLLqxvlvyDuk5Ac=
X-Google-Smtp-Source: APBJJlGhjlhO3dyxjjUyrYf5Qvf7UBgWIFVhnm0FV5nddTzziNEdrxhuXFgdfIcf68NnpKYWLHVQEQ==
X-Received: by 2002:a17:906:1089:b0:99b:ea8f:9003 with SMTP id u9-20020a170906108900b0099bea8f9003mr1001698eju.50.1690519567211;
        Thu, 27 Jul 2023 21:46:07 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:45e3:52d2:7d93:f842])
        by smtp.gmail.com with ESMTPSA id rn16-20020a170906d93000b009875a6d28b0sm1577276ejb.51.2023.07.27.21.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 21:46:06 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] adapter: Fix generating IRK for adapter with privacy enabled
Date:   Fri, 28 Jul 2023 06:45:56 +0200
Message-Id: <20230728044556.575664-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When root folder for adapter doesn't exist we will get this runtime error:
src/adapter.c:generate_and_write_irk() Unable set contents for /var/lib/bluetooth/00:00:00:00:00:00/identity: (Failed to create file “/var/lib/bluetooth/00:00:00:00:00:00/identity.EKQ581”: No such file or directory)
---
 src/adapter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..fda26fb93 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4148,6 +4148,7 @@ static int generate_and_write_irk(uint8_t *irk, GKeyFile *key_file,
 
 	g_key_file_set_string(key_file, "General", "IdentityResolvingKey",
 								str_irk_out);
+	create_file(filename, S_IRUSR | S_IWUSR);
 	str = g_key_file_to_data(key_file, &length, NULL);
 	if (!g_file_set_contents(filename, str, length, &gerr)) {
 		error("Unable set contents for %s: (%s)", filename,
-- 
2.34.1

