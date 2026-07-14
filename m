Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7734D4FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998016; cv=none; b=C3G1pHJSOnrjNLDJmE9+GsXIhdAGw3yWR1FCHxTuacZpi9+zj2KG7LAVRT5vIVciZpMdQMRXhDRUbyQT/vI7fEUTcI/CJfJsNKzlTr+vnHg7O3Ek3x+JMLccz0yBNaslSScm0S0x5LOo9GntSFyUi3USjbeEzLpBYJRp0bm7ZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998016; c=relaxed/simple;
	bh=ttRt8kVTyY24QC4cVXRavjZuxhkwVLu5Bv6kaeorHic=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Dhqo6WJFgHp5yfWx/DO5vewmfDBEb3mmzJWpbfsRQoCsZLMi2Q8j1J5jwmmf7LOmI2m4JvaehK5vkubMUED7Xa+jAl7HFfQj7i2SSz70lkuOxau6jSKQ6P9xonqgC8HEs+b6pzlIs13TiXucLfBVfIRLY+PGtJ1ta6Y2fzSfZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=B4ZhLFPj; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="B4ZhLFPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783998004; bh=jaHeTN2b3tilUe3vtWw7BcWd9HMPc++S15Dza8276nE=;
	h=From:To:Cc:Subject:Date;
	b=B4ZhLFPjrwtgQEzDKoVegVW2yiGGbx+uY4vOiL+HpcPIEyF8PbKJiULpYRsyiv8p/
	 o7QGpBPUDxM3OIYmXVykD8hswTUZNWmxkQahCl/LmDSABen/4oHkDfDPcFILrDGhwV
	 4dAlTrZQjqMth3C2tEw+EGe8k7VsBYOmPUZdXXDg=
Received: from caitao123456-pc.. ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id D249E299; Tue, 14 Jul 2026 10:52:36 +0800
X-QQ-mid: xmsmtpt1783997556t4vpj910p
Message-ID: <tencent_406D2B6F64B41152DB435F3A88E40205340A@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2z2NAHw958b+C8QJOTN1zYiZnPbEx+g+XWNH/b+FwYjefYhrWqR
	 94VhWNeeTSeki12vg+QJTeBrklB4N+vvTbyqRFDccsp4ZRTtZ42NaRTlbJklXFdkyEePV5CLnqPV
	 ZOkzrs5F5vV1/sxOScMHd6Q4mYw9dRavqpCIOXG50pFPqzgi5K0guUwhzZMGsbOhrudxak0H0LI1
	 Y+sEDGwRA/w2UjsnEnsbr9lCdLeJyihvSqBBoVdOGGkUh9KvtAtjIEv+cDZGuRj32niQMJmbBArr
	 v767Wk2jdJAS9rgCA4rkWdYrrdj+Xo4+YpyOfE9ENwqhjKOuv57bu6zGJDrzCIaJGljHOVSb+kH7
	 Ic1+sbuIqlqsW5v5AgWQk+CntrgE3Q8O/xtVVFEtgCQiV3UWckbHm2ao0jeVL5iUUTAer3f31g7h
	 u7O2O86fwtfYB66rzZ+IOcQ0ZYLqJSvisx+3qQUDHSyZLvbdDKLyzxOf5ylpw4HSuUsvKB0QqQac
	 kn5cTwxEkRHG3wj8H2skasrJ5ARXVcN2pelSBpRkhlmAE9wRuhbDAMR2fU7GRtXlPrrC7j2R2T1d
	 x8YAXj7IwjbWwkH9xV8Bzz25cJlG3TOe6ZvYiIwfVtGlNjOoBgyTt0mgDrQZhYi+XR6X6qKKodm+
	 b8e1Euytiqaa7UCfeLIrPFiZfvEc0ov6NMWBcty5KdmDv7dVFkaPBY1ZlZLeR1amlHJ0m4XPTShS
	 keSMJ8rBgX5MYWKKCpasP9QeGlWz9kUH/C74XjULzA7U8MU6zaOHwbdVvwZ8q35UyDjlUHuXfqM/
	 yy3wgVbCn6Oj4/rReJaFbJYwcH6bV4TMYiBxLK+UqWVvcxzh90BgeJHq9f4oi8vJRq1y+Mu1t47R
	 D6Gvts4jJ6KOgoK2WK/7F1w2CbgFaNBWZ0zmwnq57j1Dxq89PaeG+VyPvf6dH0X+RnwQeIBHtyti
	 1a1MFna3kL4auO49f+mprS4gobO11iSGh9owCHo9IKJtJekGRveupLNoje2iwZr4xyFnpOOxiCvG
	 9X+/kQtfjDYzYLevXnxxYyAkUbpIt8YA1pFlJxavDPvoArzonmI2vGKCiS7mw=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: caitao <294305068@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	caitao <caitao@kylinos.cn>
Subject: [PATCH] Bluetooth: MGMT: Add length check in confirm_name
Date: Tue, 14 Jul 2026 10:52:28 +0800
X-OQ-MSGID: <20260714025228.96568-1-294305068@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: caitao <caitao@kylinos.cn>

The confirm_name function did not validate the length of the incoming
data before accessing the mgmt_cp_confirm_name structure, which could
lead to out-of-bounds reads if a short packet was sent.

Add a length check at the beginning of the function to ensure the data
is at least sizeof(struct mgmt_cp_confirm_name). If the check fails,
return MGMT_STATUS_INVALID_PARAMS without accessing the invalid data.

Signed-off-by: caitao <caitao@kylinos.cn>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a0a491e5311e..aab8e64283aa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6271,6 +6271,10 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
+	if (len < sizeof(*cp))
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+					 MGMT_STATUS_INVALID_PARAMS, NULL, 0);
+
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-- 
2.43.0

