Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EAEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4A16108B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbhIMUPE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbhIMUO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 16:14:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5776C061760
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 13:13:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso321094pji.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qT/IZrUW96Fnydm/ue/5Rd4G70pXzwotuwwfXhseTnw=;
        b=dxtg2hWVvbWwU1xJdH88W0dBnOuvBc0zBHhqXMfoizSNZujRQFlRyxhw7YwZw+FWX9
         IpEARTV7ofKlr73Ygij+RYVAJMvDpqwRiBjk8oonnjbkFgzZ3t/SpdNKEdoSddnxSuWt
         2lTPU/OFEEuQ+tATjhAzb0CKpBXBxVCB/71JVLZA4pm5nq83gKl3hZNopSc9r/l0l9Af
         iXWFdAkCPqxGoDXjuAS8oYAyD0/ctE1mJxahi4iRGtAB5KCnQUP9HUey4ifJvZ+oysol
         UsrmloK0KpgGvWvE9j0xwqvlnYFyXzWP0Bdiu2XEdq1ei+7TY5xwzEpYzEHwCFVPsNav
         oZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qT/IZrUW96Fnydm/ue/5Rd4G70pXzwotuwwfXhseTnw=;
        b=U7RNjTtBSSty5EeD5zEreaZard06jfjyT3L3loeDA+mnIQbRcjZhz3/rcvhqedW7BE
         orf6JouGJ0Jn9p8f/Mw8lQgbch/lly9Ohy1hNcOAT91j/nUF0F4O+qpD1Jms+n1iwyoH
         fpnplVRakic6qU7yfx6pr/iZQtR9DDlbL6RAC0VOsgoAQ7SlYLGP1rqeGXmfangbj3Ic
         loAAOP79FriNhsIpjIeaG17uSN8xSlkrwklSQ12NGCucWmjlFmX5j51rMieFnnUmgcbM
         IcWPH/5JS0EGBsQX+DiOo7SkZ9lbiHEZVwnIMekM73yyXc0PZT09TH+xbZeIK6Szo9LF
         jZnA==
X-Gm-Message-State: AOAM531B9UTKmXesDgyJC9pRc8m27wcQ9I2ouQd182GUdZDVJ510qylS
        tEB6z6XZX7D/XypaETMAA6xn+HP7VHQ=
X-Google-Smtp-Source: ABdhPJxounLEDaG4vOaGSpRBk3uBFn8ywHm/JiIpZb09fJuTuewRbvaDD4SOJBSH8k1kvpNXqyoSaw==
X-Received: by 2002:a17:902:ab4f:b0:13b:9cae:5dd7 with SMTP id ij15-20020a170902ab4f00b0013b9cae5dd7mr3550624plb.53.1631564022982;
        Mon, 13 Sep 2021 13:13:42 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u15sm8289651pfl.14.2021.09.13.13.13.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:13:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] shared/util: Update UUID database with LE Audio services
Date:   Mon, 13 Sep 2021 13:13:41 -0700
Message-Id: <20210913201341.3515285-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913201341.3515285-1-luiz.dentz@gmail.com>
References: <20210913201341.3515285-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates UUID database with the values from assigned numbers for LE
Audio services.
---
 src/shared/util.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 2887a3efa..81b20d86f 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -289,7 +289,21 @@ static const struct {
 	{ 0x1826, "Fitness Machine"				},
 	{ 0x1827, "Mesh Provisioning"				},
 	{ 0x1828, "Mesh Proxy"					},
-	/* 0x1829 to 0x27ff undefined */
+	{ 0x1843, "Audio Input Control"				},
+	{ 0x1844, "Volume Control"				},
+	{ 0x1845, "Volume Offset Control"			},
+	{ 0x1846, "Coordinated Set Identification"		},
+	{ 0x1848, "Media Control"				},
+	{ 0x1849, "Generic Media Control"			},
+	{ 0x184b, "Telephony Bearer"				},
+	{ 0x184c, "Generic Telephony Bearer"			},
+	{ 0x184c, "Microphone Control"				},
+	{ 0x184e, "Audio Stream Control"			},
+	{ 0x184f, "Broadcast Audio Scan"			},
+	{ 0x1850, "Published Audio Capabilities"		},
+	{ 0x1851, "Basic Audio Announcement"			},
+	{ 0x1852, "Broadcast Audio Announcement"		},
+	/* 0x1853 to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
 	{ 0x2802, "Include"					},
@@ -522,6 +536,74 @@ static const struct {
 	{ 0x2ade, "Mesh Proxy Data Out"				},
 	{ 0x2b29, "Client Supported Features"			},
 	{ 0x2b2A, "Database Hash"				},
+	{ 0x2b3a, "Server Supported Features"			},
+	{ 0x2b77, "Audio Input State"				},
+	{ 0x2b78, "Gain Settings Attribute"			},
+	{ 0x2b79, "Audio Input Type"				},
+	{ 0x2b7a, "Audio Input Status"				},
+	{ 0x2b7b, "Audio Input Control Point"			},
+	{ 0x2b7c, "Audio Input Description"			},
+	{ 0x2b7d, "Volume State"				},
+	{ 0x2b7e, "Volume Control Point"			},
+	{ 0x2b7f, "Volume Flags"				},
+	{ 0x2b80, "Offset State"				},
+	{ 0x2b81, "Audio Location"				},
+	{ 0x2b82, "Volume Offset Control Point"			},
+	{ 0x2b83, "Audio Output Description"			},
+	{ 0x2b84, "Set Identity Resolving Key"			},
+	{ 0x2b93, "Media Player Name"				},
+	{ 0x2b94, "Media Player Icon Object ID"			},
+	{ 0x2b95, "Media Player Icon URL"			},
+	{ 0x2b96, "Track Changed"				},
+	{ 0x2b97, "Track Title"					},
+	{ 0x2b98, "Track Duration"				},
+	{ 0x2b99, "Track Position"				},
+	{ 0x2b9a, "Playback Speed"				},
+	{ 0x2b9b, "Seeking Speed"				},
+	{ 0x2b9c, "Current Track Segments Object ID"		},
+	{ 0x2b9d, "Current Track Object ID"			},
+	{ 0x2b9e, "Next Track Object ID"			},
+	{ 0x2b9f, "Parent Group Object ID"			},
+	{ 0x2ba0, "Current Group Object ID"			},
+	{ 0x2ba1, "Playing Order"				},
+	{ 0x2ba2, "Playing Orders Supported"			},
+	{ 0x2ba3, "Media State"					},
+	{ 0x2ba4, "Media Control Point"				},
+	{ 0x2ba5, "Media Control Point Opcodes Supported"	},
+	{ 0x2ba6, "Search Results Object ID"			},
+	{ 0x2ba7, "Search Control Point"			},
+	{ 0x2ba9, "Media Player Icon Object Type"		},
+	{ 0x2baa, "Track Segments Object Type"			},
+	{ 0x2bab, "Track Object Type"				},
+	{ 0x2bac, "Group Object Type"				},
+	{ 0x2bb3, "Bearer Provider Name"			},
+	{ 0x2bb4, "Bearer UCI"					},
+	{ 0x2bb5, "Bearer Technology"				},
+	{ 0x2bb6, "Bearer URI Schemes Supported List"		},
+	{ 0x2bb7, "Bearer Signal Strength"			},
+	{ 0x2bb8, "Bearer Signal Strength Reporting Interval"	},
+	{ 0x2bb9, "Bearer List Current Calls"			},
+	{ 0x2bba, "Content Control ID"				},
+	{ 0x2bbb, "Status Flags"				},
+	{ 0x2bbc, "Incoming Call Target Bearer URI"		},
+	{ 0x2bbd, "Call State"					},
+	{ 0x2bbe, "Call Control Point"				},
+	{ 0x2bbf, "Call Control Point Optional Opcodes"		},
+	{ 0x2bc0, "Termination Reason"				},
+	{ 0x2bc1, "Incoming Call"				},
+	{ 0x2bc2, "Call Friendly Name"				},
+	{ 0x2bc3, "Mute"					},
+	{ 0x2bc4, "Sink ASE"					},
+	{ 0x2bc5, "Source ASE"					},
+	{ 0x2bc6, "ASE Control Point"				},
+	{ 0x2bc7, "Broadcast Audio Scan Control Point"		},
+	{ 0x2bc8, "Broadcast Receive State"			},
+	{ 0x2bc9, "Sink PAC"					},
+	{ 0x2bca, "Sink Audio Locations"			},
+	{ 0x2bcb, "Source PAC"					},
+	{ 0x2bcc, "Source Audio Locations"			},
+	{ 0x2bcd, "Available Audio Contexts"			},
+	{ 0x2bce, "Supported Audio Contexts"			},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.31.1

