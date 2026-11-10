Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349405;
	b=IISqkYIkVl+tpnEXFCRqTbhqmehFUIBS1RI+ckcShRHMONEWKVsjsGZa6abPYgH6J5CB
	 Qfha6p94LX2bNyqJbK8b1v4yS8ZUt176yMyNYkOJ4XY6kpq7p2FPlrch+rTgMSn/lgpD6
	 5cebOiBpPGsqWrpBOsbVhP21PTV3SjiAGbatBTeY8B/Zne4N2JegjbNq/eoTVJImU5qud
	 TJZTyh7XhymyH7Bfi6NfpsEOLjPLoUQLVQ/HhiYTKCjMEmup+BpN0IL2W8e7jj0ZoXYfy
	 0t9KgfN2s2YPK9Eu/WNPmObji24NEenxfWZbFjXHYOJA/gGxJYPFn/uDqgy7DaMCenw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=otRyMeb75+VLZ1qPaOWUchAC2U7XAkcMMqGgLecGB9I=;
	b=mA5uLKK+RkrfUOFkKnCoYYsER5/ANh/8n4BeMP3Det8dbwb34CBVius6IAL1BTv4KxiH
	 agDuhd1VpSvcBQm3pOq0YDilrEb95BHEe5pC3WeA5bKbN6+p1C5eTc43nc8TWLKiyfgK2
	 YlN6PL4KY8SK5D1e9l2XgGy4CxYOhHUTXP/Wp2AUyd6kia19piH9Q/SzqsTSsn1DbIzVC
	 JSVrd94uF6hE7BocdvJt/MNTL6Q1h5kvojKT0zmwhMT5dWl++/DPpsq1cSKobbbnEN4u4
	 nChSwpceTq5pk/nSHzrznzhdczziStVhPKbtPTsLqtfVbIlKsZll8MevvglVAGmsEXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPq7O3Wk;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593D606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5593D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPq7O3Wk
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3acec6677so3968548c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349404; x=1794954204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=otRyMeb75+VLZ1qPaOWUchAC2U7XAkcMMqGgLecGB9I=;
        b=lPq7O3Wkj/vM9r3JNDdcLozDsq3fAdAlDjXIzdHKc8R4VLWraDlUVNMFGf4MnP5gIH
         QDgj/BCupkFkv/4PTDaAkiwxxLYF43/GxA/7Z7cRo00yhngqIfiiqtWjzD7+c/kg9Twm
         BotE7kiX/vYjzMykrFH89ewEElErt+gEsRuANUeih0aSi8tG82tpNSPS/9+jH7SMzLRm
         jAtkudGVXM/tA2CJZNtQ1OLIKKowgfIDNSZv6EdOOlJJBaYBIFb8qAwDipQJ9CrAZYEZ
         YeaN2gfAfbDQKCe6p488tiJov3ZwzwCjAUiA2+oMLuI2L/y1U5/TzsTfRBK4A5SpsfxV
         0cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349404; x=1794954204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otRyMeb75+VLZ1qPaOWUchAC2U7XAkcMMqGgLecGB9I=;
        b=i3DRW+O4ZSb86T6rnRM0iVpEirstcZ4wv7BHvDpoQRxUr0SgWPoJFmS7PG2jEfgB62
         nFeusu1+cwMXy7mT8kxZuCifcmUhNxZCFtErhrN+PzzRzNSIFXZBkM2T6cAixQRIaECG
         7athntdvYEl2rtK4V5GtLh+fLmy2qDWH6vTZeQ/kyjfnv6DrF0tfz74N6QfbZh5yIHiG
         8LU4QHLr474GddiO6dGT7L2DptnNzAPEqSOG5As9TMl9i5W1id751gZdUFKwiflBm983
         9KBnW22Q0yweC3Dm4WS2ilMko7CGb+g0pxxBTPmB+Rp2wytPNeX5C/59pQGmiZwr0UuN
         wE1A==
X-Gm-Message-State: APuU4Z91rCj1kHm8OyRwUQ8y/8S4YlXlj2ikucgKymELX7jNiG0TiDuN
	W860oLg+Vm1lm2S9KpIlHEXxs8YosCWt0LMXS5kr7oqlB8ktJvTKiN89
X-Gm-Gg: AYBFou2Wf5AW+N+NolVrCYhKOh1hvhLvgJvdTCZ5IyXPAFYTPr5z5vB94FhaGtr+71Q
	3yqkTNxJdfgIqIOrhAGc5EAj14rJtzjpirC6q2gR/o1+r4ZV6JRnYDFuexnxM25PiO17LCpnWRR
	TMU63l11vB9ZpZyhDhuZKXXDqNs2RbsFxveoS/v02ROCGYXc2dg5TH/9Y9WLpl2eL/JQNcXr1SG
	L9TQ2tl3Rh/Z5YYkkmiL/BpAQBmIR7GfndE++Qwb3j0zhaIRX5/It3uOPTJBNFXRFTbcWUBsacR
	6MMGzd9mNiRVrr9ENvCrr5b3o/WKdAwbQmiBskJwCLT2qK/v1ai4vYiVRcXW/U3VDksNF0m7w5b
	xN9Iul2Ubf71RjKfP5nMDJrJRwEBICt1O1ViQaxujdhG5AwLeMB7c5Rsug5EHVgIcnJrMqfLTfE
	pvOvov4cL38QnrfKhaxCj9s/MyVRtEBTdyeK1lMqClzJXxdHUiTM2dMovJNSDXCv1EmbXEkyOCE
	uf1SL9IOOxymmYxyejsPfNeYKEwVyVFzPkpbiJRKvdvsJqR6VGUb6YyY9f0jwgAX9o/XVuMKbg9
	itk861THY0ZlVkrBld2srWXEk4F5adWXd11cxItkPHi1avOdDg9dDr6Dnqk=
X-Received: by 2002:a05:701b:2903:b0:136:c443:80e5 with SMTP id a92af1059eb24-1b3c023c9aamr353445c88.6.1794349404165;
        Tue, 10 Nov 2026 14:23:24 -0800 (PST)
Received: from localhost.localdomain (wood.seclab.cs.ucsb.edu. [128.111.49.37])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm9882751c88.9.2026.11.10.14.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:23:23 -0800 (PST)
From: Praneeth Balasubramanian <praneethb2002@gmail.com>
X-Google-Original-From: Praneeth Balasubramanian <praneeth@ucsb.edu>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manish Mandlik <mmandlik@google.com>,
	Miao-chen Chou <mcchou@google.com>,
	Praneeth Balasubramanian <praneeth@ucsb.edu>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Hold hdev->lock when freeing an adv monitor
Date: Tue, 10 Nov 2026 14:21:44 -0800
Message-Id: <20261110222144.204736-1-praneeth@ucsb.edu>
X-Mailer: git-send-email 2.25.1
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

hci_free_adv_monitor() removes a monitor from hdev->adv_monitors_idr and
frees it, and its comment says the caller must hold hdev->lock. Readers
such as read_adv_mon_features() walk adv_monitors_idr and dereference
each monitor under hdev->lock.

Since commit 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv
Monitor"), MGMT_OP_REMOVE_ADV_MONITOR runs from the cmd_sync work, which
holds only hci_req_sync_lock. On the HCI_ADV_MONITOR_EXT_NONE path, which
is also taken while the controller is powered off,
hci_remove_adv_monitor() then calls hci_free_adv_monitor() without
hdev->lock. A concurrent MGMT_OP_READ_ADV_MONITOR_FEATURES can load a
monitor pointer from the IDR and read monitor->handle after the monitor
has been freed.

The MSFT path already frees the monitor under hdev->lock, in
msft_le_cancel_monitor_advertisement_cb(). Take hdev->lock around
hci_free_adv_monitor() in hci_remove_adv_monitor() too. None of its
callers hold hdev->lock.

The missing lock was found with an LLM-based tool that checks callers
against the locking rules stated in kernel comments.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Praneeth Balasubramanian <praneeth@ucsb.edu>
---

Notes:
    This was found by an LLM-based static analysis (GPT-5.6) that checks
    kernel code against the rules stated in its comments, as part of research
    at UCSB SecLab. The patch and changelog were drafted with Claude Opus 5.5.
    I reviewed the patch and take responsibility for it.
    
    MGMT commands need CAP_NET_ADMIN in the initial user namespace, so I am
    sending this as a regular fix rather than a security report.
    
    Testing: builds without new warnings with W=1 (x86_64, KASAN and lockdep
    config). Not runtime-tested.
    
    The patch applies to mainline 9ba46df34488 and to next-20261109.

 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 74d9865e08c2..b66d3c295e5e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1966,7 +1966,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	if (status == -ENOENT)
 		bt_dev_warn(hdev, "Removing monitor with no matching handle %d",
 			    monitor->handle);
+
+	hci_dev_lock(hdev);
 	hci_free_adv_monitor(hdev, monitor);
+	hci_dev_unlock(hdev);
 
 	return status;
 }
-- 
2.25.1

