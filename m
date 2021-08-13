Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05522C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AEB610F7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240362AbhHMMUx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240353AbhHMMUx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1242C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so9013694ybh.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YKZ4eLYwzaOHjplDVKO5bjFgPKbFqtTWrJlcc5epVl8=;
        b=PyUfG8FEytZnHFSQ/LFqXnvhuL0gwJqjGZz05ez9nDIA1pakdTENOfkknEojtijXdh
         7yUIMG6n4zzITgvDGlMUvyc70VKYy+d4WD07GAlDwkQswP6V8p29OPANmh9Mwz4lQOgu
         gZL/jf2284R/3qYIArgTZxmJl7oxQO7biv2aA/l5Rcg94MkNfMXNhKLzifa4D3AqN5uG
         xDjpfxrNiBnqKaAYd7j5vcuaA04hIz6Ps/yEdgx+zAt9i0Wbmwx13sI/oaGpOaoMgYDD
         XTuewk8GmISaGihSYZ0ZnGxZvstzXy41prWqNdgT2OwQpOQ+LGtJcL0CtQrZs+MF1qlv
         zvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YKZ4eLYwzaOHjplDVKO5bjFgPKbFqtTWrJlcc5epVl8=;
        b=oMmmpbM+3TmXuSZyH3zVEzI+7gd3+B8pnwPT5vYETDiqb+BiP3fmxqclsTL34NEzhJ
         GZLQ8pl1Eke9QYYoloCxtNurjyZCu3Rntp3U2DfYjYgU/1KZ7qxydrw2WUvMrgcuxU33
         RcnRfuDX3Rnqrx0SwMMi2dxQq6HI518dgsPaPwq8wRE4I1l/ycvZy2XuXmHhh9RxGc9h
         NWTKdUs0JTwDZZ6dKNsxC5wchiSWfxivDx4BYpKoCdJQM8+R6mH4JOTH4WfX3XZwiDBZ
         ZGB1aqmPNE+bQKPVJzIX31fccjJ2Xdzu5k52M23Bl4DYx1yIKGlb+jWtGQySxkjQWfZd
         gICg==
X-Gm-Message-State: AOAM5339WApo8wfHivQIqk95Cp1Oj7IPQQ0QigNW7g4YEKdpOKYbwdX5
        wDozasUMHsgISTnxmuznK90Jf9W597tbbZtYp+sTT+g8zVgyxX6jW5zOSXgKJwn73mlY2K/3+32
        HX2IbVTaOI2rILjSXfDO4iZkUZiM2y2k3QGt61qyITvPXEC+x8bnQz03JiWAEw3BzQrjJ/lt/YM
        qU
X-Google-Smtp-Source: ABdhPJyCyN+dW7uI59hbS2k8nnlmr5qlniqlu7hGTgtisGBjNgEeqWB7e/7ZQ3OeGaZoAfxXf3X70bZZ7rAc
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6902:134c:: with SMTP id
 g12mr2555981ybu.251.1628857226046; Fri, 13 Aug 2021 05:20:26 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:59 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.14.Iedb876c1f066370a58faad16ab17f846975ea7d9@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 14/62] monitor: Inclusive language in LE states
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are preferred, as reflected in the BT
core spec 5.3.
---

 monitor/packet.c | 110 +++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index b6c7fe7234..3609235d06 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2722,11 +2722,11 @@ void packet_print_features_msft(const uint8_t *features)
 #define LE_STATE_ACTIVE_SCAN		0x0020
 #define LE_STATE_PASSIVE_SCAN		0x0040
 #define LE_STATE_INITIATING		0x0080
-#define LE_STATE_CONN_MASTER		0x0100
-#define LE_STATE_CONN_SLAVE		0x0200
-#define LE_STATE_MASTER_MASTER		0x0400
-#define LE_STATE_SLAVE_SLAVE		0x0800
-#define LE_STATE_MASTER_SLAVE		0x1000
+#define LE_STATE_CONN_CENTRAL		0x0100
+#define LE_STATE_CONN_PERIPHERAL	0x0200
+#define LE_STATE_CENTRAL_CENTRAL	0x0400
+#define LE_STATE_PERIPHERAL_PERIPHERAL	0x0800
+#define LE_STATE_CENTRAL_PERIPHERAL	0x1000
 
 static const struct bitfield_data le_states_desc_table[] = {
 	{  0, "Scannable Advertising State"			},
@@ -2749,59 +2749,59 @@ static const struct {
 	uint8_t bit;
 	uint16_t states;
 } le_states_comb_table[] = {
-	{  0, LE_STATE_NONCONN_ADV				},
-	{  1, LE_STATE_SCAN_ADV					},
-	{  2, LE_STATE_CONN_ADV					},
-	{  3, LE_STATE_HIGH_DIRECT_ADV				},
-	{  4, LE_STATE_PASSIVE_SCAN				},
-	{  5, LE_STATE_ACTIVE_SCAN				},
-	{  6, LE_STATE_INITIATING | LE_STATE_CONN_MASTER	},
-	{  7, LE_STATE_CONN_SLAVE				},
-	{  8, LE_STATE_PASSIVE_SCAN | LE_STATE_NONCONN_ADV	},
-	{  9, LE_STATE_PASSIVE_SCAN | LE_STATE_SCAN_ADV		},
-	{ 10, LE_STATE_PASSIVE_SCAN | LE_STATE_CONN_ADV		},
-	{ 11, LE_STATE_PASSIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV	},
-	{ 12, LE_STATE_ACTIVE_SCAN | LE_STATE_NONCONN_ADV	},
-	{ 13, LE_STATE_ACTIVE_SCAN | LE_STATE_SCAN_ADV		},
-	{ 14, LE_STATE_ACTIVE_SCAN | LE_STATE_CONN_ADV		},
-	{ 15, LE_STATE_ACTIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV	},
-	{ 16, LE_STATE_INITIATING | LE_STATE_NONCONN_ADV	},
-	{ 17, LE_STATE_INITIATING | LE_STATE_SCAN_ADV		},
-	{ 18, LE_STATE_CONN_MASTER | LE_STATE_NONCONN_ADV	},
-	{ 19, LE_STATE_CONN_MASTER | LE_STATE_SCAN_ADV		},
-	{ 20, LE_STATE_CONN_SLAVE | LE_STATE_NONCONN_ADV	},
-	{ 21, LE_STATE_CONN_SLAVE | LE_STATE_SCAN_ADV		},
-	{ 22, LE_STATE_INITIATING | LE_STATE_PASSIVE_SCAN	},
-	{ 23, LE_STATE_INITIATING | LE_STATE_ACTIVE_SCAN	},
-	{ 24, LE_STATE_CONN_MASTER | LE_STATE_PASSIVE_SCAN	},
-	{ 25, LE_STATE_CONN_MASTER | LE_STATE_ACTIVE_SCAN	},
-	{ 26, LE_STATE_CONN_SLAVE | LE_STATE_PASSIVE_SCAN	},
-	{ 27, LE_STATE_CONN_SLAVE | LE_STATE_ACTIVE_SCAN	},
-	{ 28, LE_STATE_INITIATING | LE_STATE_CONN_MASTER |
-					LE_STATE_MASTER_MASTER	},
-	{ 29, LE_STATE_LOW_DIRECT_ADV				},
-	{ 30, LE_STATE_LOW_DIRECT_ADV | LE_STATE_PASSIVE_SCAN	},
-	{ 31, LE_STATE_LOW_DIRECT_ADV | LE_STATE_ACTIVE_SCAN	},
+	{  0, LE_STATE_NONCONN_ADV					},
+	{  1, LE_STATE_SCAN_ADV						},
+	{  2, LE_STATE_CONN_ADV						},
+	{  3, LE_STATE_HIGH_DIRECT_ADV					},
+	{  4, LE_STATE_PASSIVE_SCAN					},
+	{  5, LE_STATE_ACTIVE_SCAN					},
+	{  6, LE_STATE_INITIATING | LE_STATE_CONN_CENTRAL		},
+	{  7, LE_STATE_CONN_PERIPHERAL					},
+	{  8, LE_STATE_PASSIVE_SCAN | LE_STATE_NONCONN_ADV		},
+	{  9, LE_STATE_PASSIVE_SCAN | LE_STATE_SCAN_ADV			},
+	{ 10, LE_STATE_PASSIVE_SCAN | LE_STATE_CONN_ADV			},
+	{ 11, LE_STATE_PASSIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV		},
+	{ 12, LE_STATE_ACTIVE_SCAN | LE_STATE_NONCONN_ADV		},
+	{ 13, LE_STATE_ACTIVE_SCAN | LE_STATE_SCAN_ADV			},
+	{ 14, LE_STATE_ACTIVE_SCAN | LE_STATE_CONN_ADV			},
+	{ 15, LE_STATE_ACTIVE_SCAN | LE_STATE_HIGH_DIRECT_ADV		},
+	{ 16, LE_STATE_INITIATING | LE_STATE_NONCONN_ADV		},
+	{ 17, LE_STATE_INITIATING | LE_STATE_SCAN_ADV			},
+	{ 18, LE_STATE_CONN_CENTRAL | LE_STATE_NONCONN_ADV		},
+	{ 19, LE_STATE_CONN_CENTRAL | LE_STATE_SCAN_ADV			},
+	{ 20, LE_STATE_CONN_PERIPHERAL | LE_STATE_NONCONN_ADV		},
+	{ 21, LE_STATE_CONN_PERIPHERAL | LE_STATE_SCAN_ADV		},
+	{ 22, LE_STATE_INITIATING | LE_STATE_PASSIVE_SCAN		},
+	{ 23, LE_STATE_INITIATING | LE_STATE_ACTIVE_SCAN		},
+	{ 24, LE_STATE_CONN_CENTRAL | LE_STATE_PASSIVE_SCAN		},
+	{ 25, LE_STATE_CONN_CENTRAL | LE_STATE_ACTIVE_SCAN		},
+	{ 26, LE_STATE_CONN_PERIPHERAL | LE_STATE_PASSIVE_SCAN		},
+	{ 27, LE_STATE_CONN_PERIPHERAL | LE_STATE_ACTIVE_SCAN		},
+	{ 28, LE_STATE_INITIATING | LE_STATE_CONN_CENTRAL |
+					LE_STATE_CENTRAL_CENTRAL	},
+	{ 29, LE_STATE_LOW_DIRECT_ADV					},
+	{ 30, LE_STATE_LOW_DIRECT_ADV | LE_STATE_PASSIVE_SCAN		},
+	{ 31, LE_STATE_LOW_DIRECT_ADV | LE_STATE_ACTIVE_SCAN		},
 	{ 32, LE_STATE_INITIATING | LE_STATE_CONN_ADV |
-					LE_STATE_MASTER_SLAVE	},
+					LE_STATE_CENTRAL_PERIPHERAL	},
 	{ 33, LE_STATE_INITIATING | LE_STATE_HIGH_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
+					LE_STATE_CENTRAL_PERIPHERAL	},
 	{ 34, LE_STATE_INITIATING | LE_STATE_LOW_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 35, LE_STATE_CONN_MASTER | LE_STATE_CONN_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 36, LE_STATE_CONN_MASTER | LE_STATE_HIGH_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 37, LE_STATE_CONN_MASTER | LE_STATE_LOW_DIRECT_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 38, LE_STATE_CONN_SLAVE | LE_STATE_CONN_ADV |
-					LE_STATE_MASTER_SLAVE	},
-	{ 39, LE_STATE_CONN_SLAVE | LE_STATE_HIGH_DIRECT_ADV |
-					LE_STATE_SLAVE_SLAVE	},
-	{ 40, LE_STATE_CONN_SLAVE | LE_STATE_LOW_DIRECT_ADV |
-					LE_STATE_SLAVE_SLAVE	},
-	{ 41, LE_STATE_INITIATING | LE_STATE_CONN_SLAVE |
-					LE_STATE_MASTER_SLAVE	},
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 35, LE_STATE_CONN_CENTRAL | LE_STATE_CONN_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 36, LE_STATE_CONN_CENTRAL | LE_STATE_HIGH_DIRECT_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 37, LE_STATE_CONN_CENTRAL | LE_STATE_LOW_DIRECT_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 38, LE_STATE_CONN_PERIPHERAL | LE_STATE_CONN_ADV |
+					LE_STATE_CENTRAL_PERIPHERAL	},
+	{ 39, LE_STATE_CONN_PERIPHERAL | LE_STATE_HIGH_DIRECT_ADV |
+					LE_STATE_PERIPHERAL_PERIPHERAL	},
+	{ 40, LE_STATE_CONN_PERIPHERAL | LE_STATE_LOW_DIRECT_ADV |
+					LE_STATE_PERIPHERAL_PERIPHERAL	},
+	{ 41, LE_STATE_INITIATING | LE_STATE_CONN_PERIPHERAL |
+					LE_STATE_CENTRAL_PERIPHERAL	},
 	{ }
 };
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

