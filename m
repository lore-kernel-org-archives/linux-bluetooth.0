Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129779;
	b=O3pajXuzS3zx5OFrrMSGcLhjFgjuXA25KY4KQn6aFwiHbe/6NNRpWV7dcMDraYEM2nsi
	 FoYMEl453Vn4EHz9Ht0SPbTECKDiEkyl2blpv0IISMvVamgT4KhjHJBj7shwboYOqiDvP
	 SYSsf9xv5LZfulkQRBgfBXp24jHA1gF+MP7CJcLWqTo30iSi4/4s8BlVy/SElxShAGDuP
	 X6Qzj1VctAD8HgGJoW3olD1Kyf0KBtCPVZJIpJyYAhmfEyP87/X61LF7wz+4xsf89PAk+
	 OyvSrVMVkwo6GMFqfUZAuSvFlL1XSZqW/jFGdw0aN+kXp2D1Hyt2aaYjnif+DYA2lCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VeGAm90AgmXouwn4W32/Qv5tF0RL+dNfBc4p7xQPPeA=;
	b=Ww1QVCPx/lb9iU/2T2AV89eCdD1G6dlL89NGOJ46l3eEUkTVqaiglNjZM9Docsl8VkWx
	 5vL4necfyAdkondnAuxfl3yj1wJVcUNL1mO+1jl2yB9oEAJXiCabbrzp7OJIw5X8iTk2v
	 u+Gp6H9auEv4VUaCcynHkKD6liU6o4+2tgzPRrEwpCGZOmz29rvwOpi1+ka+yJQZz6GQE
	 xNmR4bTlpSs9Z5esddRMIr38JawiYi/sl0d/yb1FBJ9FhKrw2akgigs7JfLyHdOg5sRgU
	 eFs7Gf88zazpN37UBDIe/NG2F9/6iMt/gkLL+BigAl2eN+U8eWSciLkYcYchl4JzFaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xN6SR6ap;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E63606A322
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 19:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E63606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xN6SR6ap
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be42ae8eadso234127e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793129777; x=1793734577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VeGAm90AgmXouwn4W32/Qv5tF0RL+dNfBc4p7xQPPeA=;
        b=xN6SR6ap5IXfeCgA8OXe2bxckrC1vO7HqetaYx/ySe8B3Ppi/qI1AXBkkfczygyHHC
         WjYGcZJaW0VjYK79le4mWgblVX8hVEFuNnKy+rS4iyIqTctNgjYPby59jB8eMUiCEjnw
         qb87EpTATl9CEj1NEHtVvtHIObuv+iFfMAnov6qjNFoQZdp4xswiq/GHrsIE8121qLe1
         Vo99Hp0nSCEBLKvpMECK09JKe0q98zOhzpkjCIY2HBL1x3z4Ysm+TRrkZYhVI4THw+li
         bTKoJGAc2EVHNXf6Cd/SrMs/9ydn1UIKyVx/eFB2DyQYxchlfNVGt8FyKHCLLJL9exmT
         06wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129777; x=1793734577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VeGAm90AgmXouwn4W32/Qv5tF0RL+dNfBc4p7xQPPeA=;
        b=d60lLL/JwskuNIlla+A7vAGt/vHij7jEXfJ1WOwKD/BAiOWQZcyH1EoYxEf1ewqCzP
         62ZWify31HWXgpOjCtkkfJZwrAN8pnLpUQkJN+n9O11W3ofFj7sNX6VYRgdYHi6XseWx
         MFkiUo3S7FX0gUf9LvRHw8NLn9AdyLwFtPZU1qsJstin3diG2bSIEC1KXneN52IQfHaZ
         RYNC/+7et369Z3VPms4CM4JtDMfcVZ+dt7CdcqcxsX86T+WW/4zbHbGoEb9D0zY/m90X
         m+OLFDuSd2bKIxawV0cIs+knxHWcJZUquiJo/gNv3UVcU4MFm7MNAUpF63KGEr2nlwGQ
         DbGA==
X-Gm-Message-State: AFq9FYKZOWrcLMdXaGS7CrXX8FS5+CgwcckTAqTAWgK4VATwBe5OSDdC
	TH0Uxro5pWux3Su76nt6brd52cHdkCcIrwYEb9ApjWniL/1paxcRwGhL
X-Gm-Gg: AYBFou1MMZpyrpnXbuZ2J4op8SFAH3DzD2A2v+tufQMrisDePhRSUGbPXM6qivDYXIT
	Fh7FK90rPznvXTp5kUfhLRzZUtUzijktxXQe8+VwhPc6ljhKMLMRvzLt4rVLxK1s7wXygdS6/xY
	wkIjoeIx79hhV73e84EKTWOKHwBHrwFVN9dPH/ipijOHwYOSVJhZGWtJ3OK6rX+VTTDFDKDr9IO
	6F6u7EanQDQpItPqng08bl2eBVSYEzsufqY1pI15mz85Mhsudkhh04LYn9WywY1QNJZtYfc/9Im
	YoG7SanaiXkbg0RdHAldrtPn/TqY+II7Ef/FC4O/5AHR6PTXk/l95FqMmmALU3bUutqApBTQ67D
	lIR7F2aBbAb2oFLHqPp7Ycv6+jthU/6qOeW/v7hc6YXy2K9gAs1eMzBIusj7uxFE6MGc3rZY5+n
	CSzweQAijxR6DquMKS39A1TbNz2WPTcYI4Wio8J+QXGY1eIOQHYyivEX0ZnVKx25InqNgF9uCMx
	owuMCqMB/1DO4z+cLz49FDYnlc5jxy6Nt7+BECXo/dP7u2KoesCGoSOtehBxjouBPggY4D8FHYJ
	aFVpBYg1l73E1Tf1vXzQH/LqAPrm
X-Received: by 2002:a05:6512:304f:b0:5bf:b963:70fa with SMTP id 2adb3069b0e04-5bfcada2450mr124586e87.48.1793129777315;
        Tue, 27 Oct 2026 12:36:17 -0700 (PDT)
Received: from valor-verifone.verifone.com (balticom-242-238.balticom.lv. [83.99.242.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfca5a2a25sm158477e87.60.2026.10.27.12.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:36:16 -0700 (PDT)
From: Stanislavs Nilovs <valorcool@gmail.com>
To: brgl@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	lumag@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix WCN3950 missing regulator release
Date: Tue, 27 Oct 2026 21:36:15 +0200
Message-ID: <20261027193615.1930624-1-valorcool@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_qca driver is missing release of power regulators when module is
powered off or serial device is removed. This issue is most noticeable
during system shutdown, since the regulator core is firing a warning
backtrace that regulator to be freed still has enable_count.

The issue was found with the help of Claude Opus 5 (Anthropic), which
was asked to review drivers/bluetooth/hci_qca.c for the appearing
regulator warning backtrace during system shutdown. The fix itself was
generated by the tool and reviewed by me by applying it, building the
code and verifying issue is not reproduced anymore.

Tested on real hardware, but not on Linux's master branch. Driver was
backported to Linux 5.15 for internal testing and this is when the issue
was noticed.

Fixes: d5712c511cb3 ("Bluetooth: qca: add WCN3950 support")
Signed-off-by: Stanislavs Nilovs <valorcool@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b639b2..e22e2269efd7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2247,6 +2247,7 @@ static void qca_power_off(struct hci_uart *hu)
 	power = qcadev->bt_power;
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2271,6 +2272,7 @@ static void qca_power_off(struct hci_uart *hu)
         }
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2582,6 +2584,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_power *power = qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
-- 
2.53.0

