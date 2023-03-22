Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28490C6FD20
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 01:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCVBN4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVBNz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 21:13:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E9250718
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:13:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so18228169pjp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679447633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNdqRCa6/jCjaDPT5Tf6jDPAj3GPTeL80rj7C2FFGmo=;
        b=M0dhcWKYdUDQjBK5nmGmRPVgcmcNQ5GgVDC9RMtfBchn1W2ky0BMldYvsWSqmbul07
         7JuzMp+QJdDgd78gZvhkfwHy5oRTHcJjy7dy/qO5FgQmeiRJ6Cvo+LOUkznNsuLvgo0Q
         qzVcIkEGXFVGdwnrQi3ilQeMBp2JYdtCWIEkxh9lPO3WLY8/gssKd6lJIuKFUopfqvtx
         7dozIkSRcy1KDh93dsd9Y30zyMd/rzGotnayelmZ2LdcQDMB6EdX/NnSe68MwIAjBUc9
         QZldfCwAs2QpKEb1GOcU3VfbZS80ABx8aEKk6BO2NW04Ty2oUMJ+p+TbQ3yF3iL340/c
         h4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNdqRCa6/jCjaDPT5Tf6jDPAj3GPTeL80rj7C2FFGmo=;
        b=OMNCp16I6Dg6W1RzH4bsMGhlWRVsuC0Z26pWvgvD51bPolXlXDPkGNzdRv1UAOY6Wh
         GcBh+nn7QrHEiEqRdizekJl3rWe6Ozrazr4LtNkeQK60nBv+LyP1PH180ANZpERE9qrL
         Nuv/eN07DTuMzqxtqGDDnCzWzNUsefg52ksEOK3j8pAhj9ENNtZ4C3EEnw+o2F72/57i
         4a8zCaUh5G4zOP9PND5106R+lSK+jfccs+NK+3GfbUR+y5dnMsJu46hqbpEjLK2kKV4n
         CkVZ/ycoN8oJEkY43378VKiCap/2BD97YXTNwWSnXzpzXBUOMJWWBPC5csz4ZzdTFIhm
         8qog==
X-Gm-Message-State: AO0yUKUTXQjqywaktOjFEJHPHb5AhbGVpOLD+xtWYpDl/ipp/auwLhgq
        flYP5W4oRnJ8RSNR9ySkLPxOthrBVWU=
X-Google-Smtp-Source: AK7set8R2EuGqESDveMCU8jXFBXAJ4EaOlJr4Gr7jPamhyVon/QSQW6XDgEBh1lmENNVRQ9zqTcR8g==
X-Received: by 2002:a17:903:24f:b0:1a1:cd69:d2f4 with SMTP id j15-20020a170903024f00b001a1cd69d2f4mr861298plh.67.1679447632890;
        Tue, 21 Mar 2023 18:13:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b0019ee045a2b3sm9315720pli.308.2023.03.21.18.13.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:13:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] client: Add samples init scripts
Date:   Tue, 21 Mar 2023 18:13:49 -0700
Message-Id: <20230322011349.2763404-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322011349.2763404-1-luiz.dentz@gmail.com>
References: <20230322011349.2763404-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sample init scripts that can be passed to bluetoothctl for
testing.
---
 client/scripts/advertise-broadcast.bt  |  2 ++
 client/scripts/advertise-on.bt         |  2 ++
 client/scripts/advertise-peripheral.bt |  2 ++
 client/scripts/gatt-batt.bt            |  5 +++++
 client/scripts/power-on-off.bt         |  3 +++
 client/scripts/power-on.bt             |  3 +++
 client/scripts/preset-custom.bt        | 26 ++++++++++++++++++++++++++
 client/scripts/scan-bredr.bt           |  2 ++
 client/scripts/scan-le.bt              |  2 ++
 client/scripts/scan-on-off.bt          |  4 ++++
 client/scripts/scan-on.bt              |  2 ++
 11 files changed, 53 insertions(+)
 create mode 100644 client/scripts/advertise-broadcast.bt
 create mode 100644 client/scripts/advertise-on.bt
 create mode 100644 client/scripts/advertise-peripheral.bt
 create mode 100644 client/scripts/gatt-batt.bt
 create mode 100644 client/scripts/power-on-off.bt
 create mode 100644 client/scripts/power-on.bt
 create mode 100644 client/scripts/preset-custom.bt
 create mode 100644 client/scripts/scan-bredr.bt
 create mode 100644 client/scripts/scan-le.bt
 create mode 100644 client/scripts/scan-on-off.bt
 create mode 100644 client/scripts/scan-on.bt

diff --git a/client/scripts/advertise-broadcast.bt b/client/scripts/advertise-broadcast.bt
new file mode 100644
index 000000000000..476559d219c2
--- /dev/null
+++ b/client/scripts/advertise-broadcast.bt
@@ -0,0 +1,2 @@
+power on
+advertise broadcast
diff --git a/client/scripts/advertise-on.bt b/client/scripts/advertise-on.bt
new file mode 100644
index 000000000000..4a227e03986d
--- /dev/null
+++ b/client/scripts/advertise-on.bt
@@ -0,0 +1,2 @@
+power on
+advertise on
diff --git a/client/scripts/advertise-peripheral.bt b/client/scripts/advertise-peripheral.bt
new file mode 100644
index 000000000000..5e81c135faad
--- /dev/null
+++ b/client/scripts/advertise-peripheral.bt
@@ -0,0 +1,2 @@
+power on
+advertise peripheral
diff --git a/client/scripts/gatt-batt.bt b/client/scripts/gatt-batt.bt
new file mode 100644
index 000000000000..902fe48a23cf
--- /dev/null
+++ b/client/scripts/gatt-batt.bt
@@ -0,0 +1,5 @@
+gatt.register-service 0x180f
+yes
+gatt.register-characteristic 0x2a19 read,notify
+64
+gatt.register-application
diff --git a/client/scripts/power-on-off.bt b/client/scripts/power-on-off.bt
new file mode 100644
index 000000000000..c7e150448a35
--- /dev/null
+++ b/client/scripts/power-on-off.bt
@@ -0,0 +1,3 @@
+power on
+power off
+quit
diff --git a/client/scripts/power-on.bt b/client/scripts/power-on.bt
new file mode 100644
index 000000000000..0ba686f4fdda
--- /dev/null
+++ b/client/scripts/power-on.bt
@@ -0,0 +1,3 @@
+power on
+show
+quit
diff --git a/client/scripts/preset-custom.bt b/client/scripts/preset-custom.bt
new file mode 100644
index 000000000000..08bfb57b634c
--- /dev/null
+++ b/client/scripts/preset-custom.bt
@@ -0,0 +1,26 @@
+endpoint.presets 00002bc9-0000-1000-8000-00805f9b34fb custom
+48
+10
+3
+100
+Low
+10000
+Unframed
+2M
+200
+3
+10
+20000
+endpoint.presets 00002bcb-0000-1000-8000-00805f9b34fb custom
+48
+10
+3
+100
+Low
+10000
+Unframed
+2M
+200
+3
+10
+20000
diff --git a/client/scripts/scan-bredr.bt b/client/scripts/scan-bredr.bt
new file mode 100644
index 000000000000..291a3eedbf6c
--- /dev/null
+++ b/client/scripts/scan-bredr.bt
@@ -0,0 +1,2 @@
+power on
+scan bredr
diff --git a/client/scripts/scan-le.bt b/client/scripts/scan-le.bt
new file mode 100644
index 000000000000..4a529b964723
--- /dev/null
+++ b/client/scripts/scan-le.bt
@@ -0,0 +1,2 @@
+power on
+scan le
diff --git a/client/scripts/scan-on-off.bt b/client/scripts/scan-on-off.bt
new file mode 100644
index 000000000000..ffa6c8181533
--- /dev/null
+++ b/client/scripts/scan-on-off.bt
@@ -0,0 +1,4 @@
+scan on
+show
+scan off
+quit
diff --git a/client/scripts/scan-on.bt b/client/scripts/scan-on.bt
new file mode 100644
index 000000000000..767cefc16382
--- /dev/null
+++ b/client/scripts/scan-on.bt
@@ -0,0 +1,2 @@
+power on
+scan on
-- 
2.39.2

