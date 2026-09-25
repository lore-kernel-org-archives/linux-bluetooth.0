Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23BB50C281
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379653; cv=none; b=CfbeybVLL+AxT9bxkpikXMTROBZgYZa9OG7rUTt18xxnS/jzELGFekcp+WmDs2u4oq/ymDslGNg9NMYOQWqH48yDwMttHOywgPrGO/In5hJLGRpa276yly0oBV+iAtbOfAtdVP7p5bd0FFH42zr2KjKuvpQeBUWstXOkCL/Vp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379653; c=relaxed/simple;
	bh=Wa47zkV/Yv7IwsQoOdlH/3EsP4aAdsYzqIs16PmcFso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt/IAEFxpakvp43zPek5ukapRsK98suSIvoBE/bemRnOSzgA+020PoEkMahtapRzDWmzwn8Jehl4GPEZ4zZL0qAyu1F5+f5pxcxd3bYSrM++WiQpzesTxGeC6EThH4WQEW0o1uKW8MHwgxTvMF8xicX/4tGxCPVp9rXiNEC63kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB5j+HkB; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB5j+HkB"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so372621a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790379651; x=1790984451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5B/rKSH4rLppYVYJZepFLTlK6JeX2CvsKxnHrJSqD3s=;
        b=mB5j+HkBvbpM0uXYbo/S9an3+tuNgFaH95lD66BvrCW0MifD5tyWPUhetuLCq+ikRD
         M0lflA09E9yhqYrrOlQKpvBIkR0JHepBjkbgLzPCrIRkd7K4vnQ+zJr4XO3sJdddLjCJ
         A49gtE0ABo26wLSk8eo26iEPsNZ3EaWnmokL7X5qitrb/rLo/8mG6vFQoKNyxyvE+tE6
         mSSb65KJs6Vag3zNTvAdal9A28cJl4HyoQMntZGOIZjbLKs367Wu6MU1fk7BDbsujUMG
         ii1muiIYPKyZTKWHf3a0kr+tFHaPGR9qhaAj12huu55bYAnFCXtxnCIjd+r0BwYG+UwL
         qAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379651; x=1790984451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5B/rKSH4rLppYVYJZepFLTlK6JeX2CvsKxnHrJSqD3s=;
        b=s+RLG73BJMPI5kHSBPJ9w9xy6sz02JXJFleXlltN4sUtsOFS8ScSHA1g7yCqY9ExQM
         as0ZJxLytnW2+6bvyzaX0iUveLCCUz8/slae4LSXEDeTHUWnbvQz+sl+g1OQtNXi383m
         hOTSyLKSZeMv8tmRdb7M/mIFYHXtVV25cVQoS4mve9TjV/sr3ZADfJVeCPOxRB8U/x07
         hsjpRVle3VUTbTnMup5qjPjnNWhnos1ZJhuBQ6+AIZmgMsSomgawnMcH3jaO+22x+253
         I/5NSqhg3SHOxvp+CE75+7TgmA8zjx495fB2DoXQXMoAGuf//5HrcoFNRg9hU4rdlDYU
         KQqQ==
X-Gm-Message-State: AFuF++kUE9UMRXos/uBqhxp+LaYvd+ILoUV15Q6J91TwcMs/B4t0zw//
	k/F0Zpg0Ibjd8xrhWEH02dvo8Du+H2pyjuQ2kZbNWDGc8OIf5cHEMZF/
X-Gm-Gg: AYBFou32l5reMe7PXasTXy7ZARHPYWQzmSUnTHXgWS7Rl+jjxrYhuWiJsIFAOR2DLE4
	b/Zmfu1cqfxf+wsEacb+UGHlaNuCGQw/+OkCTo0u17vvyprMnufZBBDINBExnjepUPN/R8puh/7
	rdL9PuAdO7updincZ8wEeut7CMLi5retxVQ+cZeJ51FZnbRrG/2YqCkf0+/42RfxM+3oFzFWjgk
	sGtdGe+VAj9GQTNxKJXAamJI8Yq9u3iem97fLP9CEXD3aB6d+sEvvhjTxnpNRziwEvinh5RNjrz
	rp5yon2i0FLKTS7sPru+Pl0F6M1JB7rXDT3Wdrd5HgTxfIRldcqxB2BQODtzkl8GKPCgwI21uS2
	7lEPcF69fKXlCACfxWaK1ETx0ayExxy4rEITjGl3YpRAtLG6tAoRnS7HDrzyqhybbRmLJ+4j+vK
	BDXYPlOtUAgovStsCqdVFxfCUcyTfc8O1niot6ZK6VSat6TtP8/VjCGJVdlrZc+zLpZTyth8qOM
	ftKzurYZyg=
X-Received: by 2002:a17:90b:3808:b0:3a0:e243:28fc with SMTP id 98e67ed59e1d1-3a0e2433538mr34605a91.35.1790379650919;
        Fri, 25 Sep 2026 16:40:50 -0700 (PDT)
Received: from pandar.dancher.net ([2409:8a28:881:a300:decd:fb28:f50d:71a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm6706966a91.7.2026.09.25.16.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:40:50 -0700 (PDT)
From: Cai Yu <caiyu7372@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] Bluetooth: hci_intel: add the CcP controller (hardware variant 0x14)
Date: Sat, 26 Sep 2026 07:40:41 +0800
Message-ID: <20260925234043.707679-3-caiyu7372@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925234043.707679-1-caiyu7372@gmail.com>
References: <20260925234043.707679-1-caiyu7372@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel CcP controller (hardware variant 0x14) is used on the
Lakefield and Jasper Lake platforms.  btintel_get_fw_name() in btintel.c
already knows it and builds the same three-part firmware name as for
ThP/JfP/HcP (intel/ibt-<hw_variant>-<hw_revision>-<fw_revision>), but
hci_intel.c duplicates that lookup and rejects the variant before the
firmware is requested:

  Bluetooth: hci0: Unsupported Intel hardware variant (20)

Add 0x14 to the variant check and to both firmware name switches.

Tested on a Lenovo ThinkPad X1 Fold Gen1 (Lakefield, ACPI INT33E4):
intel/ibt-20-1-3.sfi is requested and the DDC parameters are applied.

Signed-off-by: Cai Yu <caiyu7372@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 28c11dd..d25d029 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -606,6 +606,7 @@ static int intel_setup(struct hci_uart *hu)
 	case 0x0b:	/* LnP */
 	case 0x0c:	/* WsP */
 	case 0x12:	/* ThP */
+	case 0x14:	/* CcP */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
@@ -695,6 +696,7 @@ static int intel_setup(struct hci_uart *hu)
 			 ver.hw_variant, le16_to_cpu(params.dev_revid));
 		break;
 	case 0x12:      /* ThP */
+	case 0x14:      /* CcP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
 			 ver.hw_variant, ver.hw_revision, ver.fw_revision);
 		break;
@@ -721,6 +723,7 @@ static int intel_setup(struct hci_uart *hu)
 			 ver.hw_variant, le16_to_cpu(params.dev_revid));
 		break;
 	case 0x12:      /* ThP */
+	case 0x14:      /* CcP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
 			 ver.hw_variant, ver.hw_revision, ver.fw_revision);
 		break;
