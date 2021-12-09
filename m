Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26656C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 20:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhLIUEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhLIUEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 15:04:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47556C061746
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 12:00:49 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id l18so1355085pgj.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9rc/A0GVC7Gr5qk7HFBZtNF/+JwbT91bxOFZ7zLHKg=;
        b=EU5UN2CnPJ+ttmLganHHFxnU/8yWD4BQ3hAid5CenZSur+UjNewxahis4T0PCfrY+B
         omN7DaQkvt4GApiqTonnVx9mF4VjOqQUXhEMOE5bsLdJDBTAPkOa7q62MW40Pp1YhaO9
         ht6EgyKcHG8Kp2WqkCzb1jGv8As5cKftt40cRjFBJM171ap1IFW8U6wJoC11F0EIGWST
         viSOtPF78xsi31IF8NERQSthr/KLwx3XRxtfhi2CFC5ctKQgUat+LQ+pthgxAwZzVSRu
         yFLDN7CoagGhHUMf5cEMxnbtgAccXlH1O+VqKOz4nTOtaKE1h4MbiSTpBI3eYHz+84VQ
         K1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9rc/A0GVC7Gr5qk7HFBZtNF/+JwbT91bxOFZ7zLHKg=;
        b=fZg6thFQiWPXOknOntHelndU1EAcr/U1rrolTHiwGqKNX99jfpbzZesEvyz2YHL/Rn
         vLAlaV2K+/VTZ8DZP7WAHminHgje/CXorAhhF2rqiifduTuHol4NYqaNakvZXSpoch8d
         Iz16GBdk4FMkbvtq9HuihvwIUIuNvnes9Emajww5sBnTwQQvD5imSTj2OHyp9VCsvJPS
         860idfharS5BnDiGMZmwTiUdl205glUA/N9ilXDaAYAhgjYaayT56GitD/R2enWAdnBq
         ggSafIteHzOdYZn+hjcDplB1VNz4PE6bJK6FkTSMR7z36XhPPo+Fvcf0juaW4n7gco/z
         4V/Q==
X-Gm-Message-State: AOAM530zgyYpnzLaJPHECTs20Z/+oCbUEcegVSRetg9sHPIyWO7TwbTh
        Uq+oy5/T4GBfpV7i+jzcOYZxwPHClQc=
X-Google-Smtp-Source: ABdhPJySSi0VSZNXksCD42eSAdPpxhX6NCJxkXj+i6fQ814qHGeTepvlnL4iV/pK+ic2Izq75oVpKQ==
X-Received: by 2002:aa7:8219:0:b0:4a4:bec7:ef10 with SMTP id k25-20020aa78219000000b004a4bec7ef10mr13644338pfi.37.1639080048149;
        Thu, 09 Dec 2021 12:00:48 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:d0d6:ba5:fd1c:15de])
        by smtp.gmail.com with ESMTPSA id b2sm531440pfv.198.2021.12.09.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:00:47 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH DNM 2/3] Bluetooth: DO NOT MERGE: The Second Test Patch
Date:   Thu,  9 Dec 2021 12:00:41 -0800
Message-Id: <20211209200042.737140-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209200042.737140-1-hj.tedd.an@gmail.com>
References: <20211209200042.737140-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Test patch 2

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8f9109b40961..f35cdd382aa4 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -300,7 +300,8 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		variant = "Firmware";
 		break;
 	default:
-		bt_dev_err(hdev, "Unsupported firmware variant(%02x)", ver->fw_variant);
+		bt_dev_err(hdev, "Unsupported firmware variant(%02x)",
+							ver->fw_variant);
 		return -EINVAL;
 	}
 
-- 
2.25.1

