Return-Path: <SRS0=Hv/D=BG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391D2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 17:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180C320719
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 17:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b0rAu1U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbgG0Rh2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgG0Rh0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jul 2020 13:37:26 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A69AC061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 10:37:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id p27so1415683uaa.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqTJWlghm8hbSrvYH/wSR/fzYgdbbuaChV5qjhwMteM=;
        b=b0rAu1U014sI2AO2VeWvQFnUBn6TnTZR3eBNUHZyWLUcznS+S+K7K+3jS0vxB0zM0m
         +5DstfFBT1WJWQ3Fae6TqfmQZyfjyEA4Tx3Rw+LDAgAoqXr6Cn8DAca7WLPxn3TCETDD
         f+jaEmN0isWObVLBp0l4GfrGM43cZMqDYAQEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqTJWlghm8hbSrvYH/wSR/fzYgdbbuaChV5qjhwMteM=;
        b=tu+0PcRD9qTpD/FvszByx55bX4UYZW71QiGpMLC1nePW/ocRHnH3tQ2PvXvCtwAjQR
         TGjfYz3bWzDMXII3jedpjC1mXhyGwbJO9wKetBVJYwyYc/11nXjeu3y0LoUWrUv76hKH
         Z+eY1K7tnKNVjHMdirjp95WR7l1Mnu3smMzpE0S58zbjE0mrmDDWVT9ntGI742c8Xkgk
         6RsUbWU0L2t0bLtSVAf4T8jUz+STMzD9s0+tWBkUrN0GskXb3AWcEr6alFuo0LiwxLju
         iCmEGR84sk0yfK9DrZ0HUDR+HhLNuAMGfBXJKLyr63xTL7uS3rSsf6tc7A7sq5VqVmKP
         qL7Q==
X-Gm-Message-State: AOAM532zHvl9sL9PNGw62FcRFE7cnDoz3DgN692VB4XKfWUGMAJa/IKc
        RcVy9OCbEZPMwJBGdIe3GYgCV/cgmt4=
X-Google-Smtp-Source: ABdhPJwNcP00H7/7LJ6F8gCbYxeN7Xw4B2GCZ9W17fXO7hnMKOXzKgnX/6JNbZep6QdaxLE1nG9/+Q==
X-Received: by 2002:ab0:1846:: with SMTP id j6mr7090989uag.130.1595871444718;
        Mon, 27 Jul 2020 10:37:24 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id s25sm2870871vsj.13.2020.07.27.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:37:23 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [Bluez PATCH] main: adding configurable eir_max_name_len
Date:   Mon, 27 Jul 2020 17:37:20 +0000
Message-Id: <20200727173720.2700327-1-alainm@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds support for a configurable eir_max_name_len for
platforms which requires a larger than 48 bytes complete name in EIR.

From bluetoothctl:
[bluetooth]# system-alias
012345678901234567890123456789012345678901234567890123456789
Changing 012345678901234567890123456789012345678901234567890123456789
succeeded
[CHG] Controller DC:71:96:69:02:89 Alias:
012345678901234567890123456789012345678901234567890123456789

From btmon:
< HCI Command: Write Local Name (0x03|0x0013) plen 248             #109
[hci0] 88.567990
        Name:
012345678901234567890123456789012345678901234567890123456789
> HCI Event: Command Complete (0x0e) plen 4                             
   #110 [hci0] 88.663854
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Local Name Changed (0x0008) plen 260               
{0x0004} [hci0] 88.663948
        Name:
012345678901234567890123456789012345678901234567890123456789
        Short name:
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241 
        FEC: Not required (0x00)
        Name (complete):
012345678901234567890123456789012345678901234567890123456789
        TX power: 12 dBm
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: Google (224)
          Product: 0xc405
          Version: 0.5.6 (0x0056)
        16-bit Service UUIDs (complete): 7 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          Device Information (0x180a)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
          Handsfree Audio Gateway (0x111f)
          Audio Source (0x110a)
> HCI Event: Command Complete (0x0e) plen 4                           
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 doc/mgmt-api.txt |  1 +
 src/adapter.c    | 10 +++++++++-
 src/hcid.h       |  1 +
 src/main.c       |  5 +++++
 src/main.conf    |  5 +++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ca0d38469..1bc0f0c12 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3279,6 +3279,7 @@ Read Default System Configuration Command
 		0x0019	LE Connection Latency
 		0x001a	LE Connection Supervision Timeout
 		0x001b	LE Autoconnect Timeout
+		0x001c	Max EIR Name Length
 
 	This command can be used at any time and will return a list of
 	supported default parameters as well as their current value.
diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..3adc67b63 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2375,7 +2375,7 @@ static bool parse_pathloss(DBusMessageIter *value,
 	return true;
 }
 
-static bool parse_transport(DBusMessageIter *value, 
+static bool parse_transport(DBusMessageIter *value,
 					struct discovery_filter *filter)
 {
 	char *transport_str;
@@ -4435,6 +4435,14 @@ static void load_default_system_params(struct btd_adapter *adapter)
 		len += sizeof(params[i].u16);
 	}
 
+	if (main_opts.default_params.eir_max_name_len) {
+		params[i].entry.type = 0x001c;
+		params[i].entry.length = sizeof(params[i].u16);
+		params[i].u16 = main_opts.default_params.eir_max_name_len;
+		++i;
+		len += sizeof(params[i].u16);
+	}
+
 	err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, len, params, NULL, NULL, NULL);
 	if (!err)
diff --git a/src/hcid.h b/src/hcid.h
index 5f249ebf9..c9b59a374 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -93,6 +93,7 @@ struct main_opts {
 		uint16_t	le_conn_latency;
 		uint16_t	le_conn_lsto;
 		uint16_t	le_autoconnect_timeout;
+		uint16_t	eir_max_name_len;
 	} default_params;
 
 
diff --git a/src/main.c b/src/main.c
index ec7a9fbd7..74876e01d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -123,6 +123,7 @@ static const char *controller_options[] = {
 	"LEConnectionLatency",
 	"LEConnectionSupervisionTimeout",
 	"LEAutoconnecttimeout",
+	"EirMaxNameLength",
 	NULL
 };
 
@@ -433,6 +434,10 @@ static void parse_controller_config(GKeyFile *config)
 		  &main_opts.default_params.le_autoconnect_timeout,
 		  0x0001,
 		  0x4000},
+		{ "EirMaxNameLength",
+		  &main_opts.default_params.eir_max_name_len,
+		  0x0001,
+		  0x00EE},
 	};
 	uint16_t i;
 
diff --git a/src/main.conf b/src/main.conf
index f41203b96..7ecac5930 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -148,6 +148,11 @@
 #LEConnectionSupervisionTimeout=
 #LEAutoconnecttimeout=
 
+# EIR Max Name. This is the maximum length for the COMPLETE_NAME EIR section.
+# If the name length exceeds this size, a SHORT_NAME section is used.
+# Default: 48
+#EirMaxNameLength = 48
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.28.0.rc0.142.g3c755180ce-goog

