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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C06C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BC4610CE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 18:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhIMSHL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhIMSHK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 14:07:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E3C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 11:05:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v19so4261645pjh.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qT/IZrUW96Fnydm/ue/5Rd4G70pXzwotuwwfXhseTnw=;
        b=QCaFTUi1Ur26CbKwZ0ROSilNFfCQ/xsHfqWv18Bl3CLLc5zydTiym3jdrNBOTigLXG
         kTU8UVwZMGF1nJtH2xf4gnsuJlCH0Ctq4LWsEOxCmg5siHxRkNifwreCt/TkQmyY++b4
         +LlughtlvZTA/qXgw1YZo/AVD1FNkOAOYwewP0heeeJs5jxfqnF9eGlngymZjhDJMhXU
         t5QAqCwAqSQB10ivb47pHM+Gm+dAbtq3/zY815v0H7fa0+3hbiHzurniQwil1mfrWcb8
         e8a9OyNEGePTg5B/nXPTAY7kyRiE5XrNagzWBZHBRdqLdIpeccVU0PyWV/Vh6ECZ2eaT
         o3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qT/IZrUW96Fnydm/ue/5Rd4G70pXzwotuwwfXhseTnw=;
        b=bwVXt9J+OhL9mnHPqiVHKMIojAORKM+Lldg96TAh2Y5pqxxFe1fePUpGKRIoPqC0bM
         5Fq97Nf81I0iBCIqzdsmb9qmieX9+AVdvW2nuzkmxw1VOg60IE7i20SmMDkpK/W/ua4t
         VAtkdRWq6vxiJShZgQPCwH8rrD53JX1DW9E4gCWqFAcBTNkPxCL6qMYd6kfJwxfAXAqm
         23yzK78nETGtCJXHs5qq1ZpLlRcjh69Xg2hWXvgCNz3A/74+ieU8xBbX3RfvcrWiBnop
         n3Yj4Tv4zBSdSJX2uz/5qXVfTK0ovNvUyZBU5BQHwrO5dxC9rmsfgCaRH1E+Rfyd5Xg5
         Dkeg==
X-Gm-Message-State: AOAM532pQM7Uwb0Bz5FTv0QncCcFz5jW8izUAtaDLr2Sf+/V7GbB9QNu
        gayhH9WPXxXv0DaPeHjCqdne1aSHtS0=
X-Google-Smtp-Source: ABdhPJwEBHcxvQ83du1Wy56SExhOh31+xGt19+WYMrIJienA6tPrzDLa0geyyWtmhkwl3P3n4ERbgQ==
X-Received: by 2002:a17:90b:80a:: with SMTP id bk10mr757810pjb.127.1631556353691;
        Mon, 13 Sep 2021 11:05:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u24sm8303812pfm.27.2021.09.13.11.05.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:05:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/util: Update UUID database with LE Audio services
Date:   Mon, 13 Sep 2021 11:05:52 -0700
Message-Id: <20210913180552.3468107-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913180552.3468107-1-luiz.dentz@gmail.com>
References: <20210913180552.3468107-1-luiz.dentz@gmail.com>
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

