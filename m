Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220ADC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF5061157
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbhI1X4z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243364AbhI1X4c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 19:56:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4FC06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kn18so254817pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PLIIMViIzDU9ElDMtTCtufrKYTS9XWodusKTWEVS080=;
        b=ODaaEMzNCTUt32CrhV6vyD/BuLfCdk+NYXg0uZa5p4genXMWalpYfzhNGuJFTAhVR2
         4yLiV1RoNImiBM/wObsFsJw3G18GP03bpiC2X2F8TJutlFLi8l1yQKwFlq/04rww6Bg2
         JX/iY23flM0nBrsE+BEs/lOYaw/VUm+E8sXX9H3eGdz3P9r8r1tyCBSHS27nj86hYN1a
         CqcHltAZNNoynr9kaJW2CrVUcpNAXp7vSIrAV8/8zQj0zQ+ldVYHetNguWnUi2tEPzFb
         vOC9Dnz4JSyNx7tk5hqmLsLt+Sj9Vj1V/c3arSmih0+hBaia5zObnhIv13UmJc05jf9i
         ovNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLIIMViIzDU9ElDMtTCtufrKYTS9XWodusKTWEVS080=;
        b=gquZROq1LIrJAjuo7q1b0jHzFIEDyAtqfFKL5mjxLKa6RYm0ShsUDHkcTnNFWSfjx1
         S4ZvnnnuEEcMelYmw3kxwD5CL3vj9i+ngAuvpvms+XtjKnbPWdoH6qSYHhqLm5c7W0LM
         qzagglG7b4OGyftBsvkejGmfiv4tg6K8mpyA8ajdQJZ4D2Q9crEF+VyQ8YhLyb+P27Jw
         PvBxWxp5ixati786BKOInNnXdHPSqJr++a8n79XPZT8Tair3NYinPpj5KSA1vnOHsb6o
         sWzcX1HHI5qUQ00IziR9xq4gDUBJIy16+V9abSNRY0wzILtWCCYA47erObUnV1AhEseO
         B2Zg==
X-Gm-Message-State: AOAM531cDrk1X1CfU0q6BvbB8aATW1Mmu0jYn4BzRUeuMKQi/Yd0pVFy
        shxvpFBwKoWztPjlAXyANHYWi0cO7hg=
X-Google-Smtp-Source: ABdhPJy57tKIeenw/4+csighXwijEEEM+8snuILa/DkH9dBjeYp5h77waIxxgRw30ASyaciJsrjyOA==
X-Received: by 2002:a17:902:854c:b0:13a:519c:67ea with SMTP id d12-20020a170902854c00b0013a519c67eamr7606860plo.82.1632873292212;
        Tue, 28 Sep 2021 16:54:52 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm3553139pja.7.2021.09.28.16.54.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:54:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] client: Print MTU on attribute-info
Date:   Tue, 28 Sep 2021 16:54:47 -0700
Message-Id: <20210928235447.3077055-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928235447.3077055-1-luiz.dentz@gmail.com>
References: <20210928235447.3077055-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the MTU of the characteristic when available.
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 229d53262..1746b8c7c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2232,6 +2232,7 @@ static void cmd_attribute_info(int argc, char *argv[])
 		print_property(proxy, "Value");
 		print_property(proxy, "Notifying");
 		print_property(proxy, "Flags");
+		print_property(proxy, "MTU");
 		print_property(proxy, "Descriptors");
 	} else if (!strcmp(iface, "org.bluez.GattDescriptor1")) {
 		bt_shell_printf("Descriptor - %s\n", text);
-- 
2.31.1

