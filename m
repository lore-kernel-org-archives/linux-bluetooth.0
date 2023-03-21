Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D1C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 01:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCUBEf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 21:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCUBES (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 21:04:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3537B6A
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 18:03:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so14545799pjp.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 18:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679360616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCpEw1yrd9anE4HOhk7GJqOyKjxAmMFg+sSOWaKZJqc=;
        b=mQWnHEHem4ZlLNQ4iOGc9AgWLVNuO9iB2I5LQfSH8bz6nDseANb0QBeEmSEG8jg/tN
         /3WXZXws5YXfgsH/i5l7VSpNLpJZMJYWZRGI/WW73QhEFtCYp2DQZIzadJp7JCFAVLl4
         jYqMRA0foUCNO/yI9ia8qyNzD72GtMoHrL5B6d41noJiPj1jrOyH/kQTrGxVsi04gpIs
         bAr79dhk3eGuhi43LMaQDYu9OpqofFai+Ru20wR+TuxqR4oUi701FoWTi3gnEhj5kHRh
         xYLWMXm52AZ5i9N9jltRrJYmB2gW46BDTNZEz+M9k7cu+T0AP8hHvGdmxsYTdbu2JuyD
         fNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679360616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCpEw1yrd9anE4HOhk7GJqOyKjxAmMFg+sSOWaKZJqc=;
        b=yCxXkJTdZ0KTzFDDim4AHgsIgMM1uSF4SLlRpwijNwFvBKNYfiena/TpznKjYcwprO
         AzhkNxP7I78dCGMlEAuTYvrbmCj3WkkFlXisL8p5MaGC7jLcL9n9fiHyVaJp4j7uH3UX
         mNdv3YT5E/Xg9POBi95G/my/43WZcU9oCexDRGc5Pi4OnYR6C4/Y6RsHg2vAdRiX4GEp
         61shFYJkQ9FVk58O7Hm4TYvrMq5HnHZcu9Ae7uS5Q5FEvZOHgRVNThA7fVMMeKYRBH+o
         +mAmyXpTFCe76J+RZGyeDbhax+5/0xVaWXh8EsjZqRb5pOuV+cabTwfzAnY/zza6E5HD
         T78w==
X-Gm-Message-State: AO0yUKXl85yCOvSp/unoAwnzX+FH8PR9Z/sS0q34H3rdTCBIHUSQ1BiW
        U40lavmTS3iTzHedTVVT8xIrrQ63qAk=
X-Google-Smtp-Source: AK7set+o5NIs5bpwLWslKGETB/SRENMPBC6/a6XdhGGVcmMIIszubFl5pFSA9eUWd8yXcjmz78uWeQ==
X-Received: by 2002:a17:902:f54c:b0:1a1:b8cc:59da with SMTP id h12-20020a170902f54c00b001a1b8cc59damr489334plf.33.1679360616158;
        Mon, 20 Mar 2023 18:03:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jc7-20020a17090325c700b001a0667822c8sm7323648plb.94.2023.03.20.18.03.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 18:03:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client: Add samples init scripts
Date:   Mon, 20 Mar 2023 18:03:33 -0700
Message-Id: <20230321010333.2361384-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321010333.2361384-1-luiz.dentz@gmail.com>
References: <20230321010333.2361384-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sample init scripts that can be passed to bluetoothctl for
testing.
---
 client/advertise-broadcast.bt  | 2 ++
 client/advertise-on.bt         | 2 ++
 client/advertise-peripheral.bt | 2 ++
 client/power-on-off.bt         | 3 +++
 client/power-on.bt             | 3 +++
 client/scan-bredr.bt           | 2 ++
 client/scan-le.bt              | 2 ++
 client/scan-on-off.bt          | 4 ++++
 client/scan-on.bt              | 2 ++
 9 files changed, 22 insertions(+)
 create mode 100644 client/advertise-broadcast.bt
 create mode 100644 client/advertise-on.bt
 create mode 100644 client/advertise-peripheral.bt
 create mode 100644 client/power-on-off.bt
 create mode 100644 client/power-on.bt
 create mode 100644 client/scan-bredr.bt
 create mode 100644 client/scan-le.bt
 create mode 100644 client/scan-on-off.bt
 create mode 100644 client/scan-on.bt

diff --git a/client/advertise-broadcast.bt b/client/advertise-broadcast.bt
new file mode 100644
index 000000000000..476559d219c2
--- /dev/null
+++ b/client/advertise-broadcast.bt
@@ -0,0 +1,2 @@
+power on
+advertise broadcast
diff --git a/client/advertise-on.bt b/client/advertise-on.bt
new file mode 100644
index 000000000000..4a227e03986d
--- /dev/null
+++ b/client/advertise-on.bt
@@ -0,0 +1,2 @@
+power on
+advertise on
diff --git a/client/advertise-peripheral.bt b/client/advertise-peripheral.bt
new file mode 100644
index 000000000000..5e81c135faad
--- /dev/null
+++ b/client/advertise-peripheral.bt
@@ -0,0 +1,2 @@
+power on
+advertise peripheral
diff --git a/client/power-on-off.bt b/client/power-on-off.bt
new file mode 100644
index 000000000000..c7e150448a35
--- /dev/null
+++ b/client/power-on-off.bt
@@ -0,0 +1,3 @@
+power on
+power off
+quit
diff --git a/client/power-on.bt b/client/power-on.bt
new file mode 100644
index 000000000000..0ba686f4fdda
--- /dev/null
+++ b/client/power-on.bt
@@ -0,0 +1,3 @@
+power on
+show
+quit
diff --git a/client/scan-bredr.bt b/client/scan-bredr.bt
new file mode 100644
index 000000000000..291a3eedbf6c
--- /dev/null
+++ b/client/scan-bredr.bt
@@ -0,0 +1,2 @@
+power on
+scan bredr
diff --git a/client/scan-le.bt b/client/scan-le.bt
new file mode 100644
index 000000000000..4a529b964723
--- /dev/null
+++ b/client/scan-le.bt
@@ -0,0 +1,2 @@
+power on
+scan le
diff --git a/client/scan-on-off.bt b/client/scan-on-off.bt
new file mode 100644
index 000000000000..ffa6c8181533
--- /dev/null
+++ b/client/scan-on-off.bt
@@ -0,0 +1,4 @@
+scan on
+show
+scan off
+quit
diff --git a/client/scan-on.bt b/client/scan-on.bt
new file mode 100644
index 000000000000..767cefc16382
--- /dev/null
+++ b/client/scan-on.bt
@@ -0,0 +1,2 @@
+power on
+scan on
-- 
2.39.2

