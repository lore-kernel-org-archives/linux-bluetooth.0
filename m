Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB495342523;
	Fri,  3 Jul 2026 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068915; cv=none; b=LimNRRBrnLNNnEjjXcpVEOT/z3ml78T0XCJx+EtwD5xmhRv9HaOoeFQxJkt62qeZZA+eHrRbLDPa7TAFvdNOlr9sJ31MinfDRuIKNzrOaeIWb4pzk+K4l3iRKLKNxrZ5hMD1q7AHz05mxifJg1BqIaVBYwAYE/R+8f+Ixls3CP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068915; c=relaxed/simple;
	bh=eKI7OrRx+ws5BlmMIWzhn+c130GYvd1H5bURxsobRfc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bF9iXCqXH+D69BxBPUJOQxRnRSSVHkTF31tIOqWtcFqWEzsz+dDtp6UZrBPDuU5flua9cAOu/9DNEMxwZ9AA0tP/+yIRcjfrzBFTFoVjnqpuZPo+X9lZUBIG5cqSuLG8SIG5ITRqQYQNeZwgqt1l5eQ5m21n8k6qbo9WsdYZhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=usYiVT09; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="usYiVT09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783068900;
	bh=2WchnoND6ZC1YwTNCHecshM3Pc20MGGj5Wsynwy65MQ=;
	h=From:To:Cc:Subject:Date;
	b=usYiVT090sSCtVH9kIe/h4I5xmOX3RczL0SqgyMUZhLs/91lT64XylogdO6kekkI0
	 7avKiXOibOgpnmYkDDolZPfpkU8Vn9otQS+OUAL09Pk2Q0EvWU+Lz1h3hiY5TumFV9
	 upPiDlqrzSVX5uU1H04dg8tdUe1Zn4ZsnhwPRSt0=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id DBB0E4DF; Fri, 03 Jul 2026 16:54:59 +0800
X-QQ-mid: xmsmtpt1783068899tj8mnhzdw
Message-ID: <tencent_A0AEA018EC865AB4DC9D2A43D1E5B71DE905@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahOvhCmaNs6GQdEXblxuUuh1DoSiC2/JGnCnxOpAgHVpdaW8GPuP
	 ExE51I1hy0NJVF+LzV0jNTPLOY6ynESgXMrZ8B9Mo1ZpXznzhUHDi8K9Vg1KYY8KdMLTdtmGBgwW
	 MuMCzPAcL+AjirB8PP+TYLFOL/1Ss/87Bijo2jw0S0lCQIFL/ld69DRWU0Ay12a+/Kn9Hbuc9ElE
	 dXViQeU3+BmGVlIc08OJIJu01mLSmU6KQxtFlc9YKC3hXItURsVCSRNdC/xfWF3/Q9PZf53DBcI6
	 0tw9AindTJtZ7W4402FI/KPfmgHIU78EtnHU0AbiwLp2AJCR4a3eMeFbYiJnbNWxwyRDNCtwI/IY
	 YvC85Xbd2cmlnYZwLNdH2gsrrj0tezTpE3Dcv7LAH0pmAxlGB9Qjb9JBkBl8pBZF8IWNGCM6zYHA
	 pE7fhTVFeAs2OaBDWGVEPkj2slJ4uVtzjPvInVXj4soT9SPcBA3HUt9+ktz8t1GCp8VoA7j6Rxqb
	 OM6q7dzMfo8QbEy3o1wYo2hgAnx+OVFjwPrhVrR4fUmtDujJzIdOSI+kb7/P6I1CqeW0Ae9bzd91
	 wm049vR7+GcyomUBrz3G9EMbar61+9KxDoAADCXbFSjWWcWAVGVy1yzvdmVrQF+A/jfQLu3gq+Xt
	 zIFWB/SqO5A26zy5FjAMijlLvlZ68bILKDE9feMVKLvYGxDh0zcgTsUPuAPUTidkZNh6P66f5bRa
	 9nCkf2ZmipEz1daHdpKsSw9gz6Kca9TluFtpuIjimUbAauVrk4ZVuqTIS+MnoAlddInRXXXeKb++
	 Zb6CCjlkEf9Abb6cHcG/eXIR2KkqVSln4jkXQ9hnO4HzEIWwzs+c4MPLJocsxGAtzaP+V0fd1iEc
	 NNdpRP7nbdOmB0Jl1fgbMavSVppcx9A4MVkhUXR4y/Zb87vts2MVlIpEJSP7rxuEGBBdJKBz1FuS
	 uVCsuol+JbCNLPLcMINNJYplyFpSo6x6e+xErh+vW4stvFnb0lyDI2oBxoM97kPqkWVQS4DI7nRv
	 4CdtbGF0od94KOYwzh7lzy60h9g4w=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Zhao Dongdong <winter91@foxmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: [PATCH] Bluetooth: btusb: fix USB interface release on probe error path
Date: Fri,  3 Jul 2026 16:54:56 +0800
X-OQ-MSGID: <20260703085456.421662-1-winter91@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

When hci_register_dev() fails in btusb_probe(), the isochronous and
diag USB interfaces previously claimed via
usb_driver_claim_interface() are not released. This causes USB
interface reference count leakage, preventing subsequent re-probe of
the same device and leaving stale entries in /sys/kernel/debug/usb.

Add a new out_release_iface error label that releases any claimed
interfaces before falling through to out_free_dev for the remaining
cleanup. This follows the kernel's standard reverse-order cleanup
chain pattern and avoids releasing interfaces on earlier error paths
where they may not have been claimed yet.

Fixes: 9bfa35fe422c ("[Bluetooth] Add SCO support to btusb driver")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 830fefb342c6..829d7dbcd84d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4407,7 +4407,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-		goto out_free_dev;
+		goto out_release_iface;
 
 	usb_set_intfdata(intf, data);
 
@@ -4416,6 +4416,12 @@ static int btusb_probe(struct usb_interface *intf,
 
 	return 0;
 
+out_release_iface:
+	if (data->diag)
+		usb_driver_release_interface(&btusb_driver, data->diag);
+	if (data->isoc)
+		usb_driver_release_interface(&btusb_driver, data->isoc);
+
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.25.1

