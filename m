Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810121F55F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460938; cv=none; b=fJioRPsC0dPNRPwQwKxk8qmTAgTfqqwCmyZIrAYuAUXPdRuRFp/Z5hgp/r5M2AjoCKhG7nQfOexkipsnBLob3FzmuxZvjmf8O5QpakbSbbSP1bHtSiHwk+/oKy7W2fnflqjr01i0/CKKC2ersTPveyZnVqt6Y8xMsrgb0osS5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460938; c=relaxed/simple;
	bh=Eo8Q5fnTsWfFB0xR+4hlm1sXadIT/74OgwaTVA8jjmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPtUZT9zoFPjswSb9d9LsZpP4UFJ/W+Zxz7EhZneDtAKOW5/uiMV9pH7UisKVvJkNATj6Ir2Otz2mBpacsjB4GYtlv4tKBELLaOpKFyebJt11dhWrBwZcKy7/YQ5im/UQ90RbzYgxwMXAdlqrLBwcD7htCoWVlAgglAHD0MZrdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HsXWJUZp; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HsXWJUZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756460924;
	bh=psKhR7q4wkI7rhPHx1236zi1gtSGNSLrwl5oNGqP1Sc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HsXWJUZpEZfy+fU7deEQTOLlpXkmJvtME5+lNV9fy+t1biCWj9QyqD+t5rGISoTD8
	 h9QJuORG13Vzd6/zky0cAiY6sYZZOOm6+fIAoStGLctpKEEwSXdZz+kFKMriORMpsT
	 l68uecCdjc+mP25XsxMulkp8cEapSbui3lCRNj20=
X-QQ-mid: esmtpsz20t1756460909t73e56edc
X-QQ-Originating-IP: EApUMW9sy/UHPaUnZRVHRzOwN3IsjgtFeStS3BUj7Oo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 17:48:24 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16994612742947666783
EX-QQ-RecipientCnt: 2
From: "xinpeng.wang" <wangxinpeng@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: "xinpeng.wang" <wangxinpeng@uniontech.com>
Subject: [PATCH v2 0/1] device: Fix device recreation after failed restore
Date: Fri, 29 Aug 2025 17:48:07 +0800
Message-Id: <20250829094808.32709-1-wangxinpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d364976e93e23f5defbbf711dcda4787bdad3beb>
References: <d364976e93e23f5defbbf711dcda4787bdad3beb>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MGLtPVEV0N3g1EDzCZSPqsz8X3Umz6IynsjPya3DQheYli1cqrO4kAUH
	/8q094sTylMQT9q6dKc4EQz8IbXquzCvoyX9UB35GSYR77lUMQyyNz+QHGIjbWN+ZCOsuIk
	Sry29FI+7ia3e4lP7xjTHuSzJ9xdt/KsQjT2j/Efco2NfzkFE5XQJakMPHzoGkh2lRdo0xY
	N399EjIjr/gqeoQBGF4ahKY11/9a8cMLcAG+Ivm3BW1MxVbeclAj+iAQWWKdH6WDGoeQc6v
	KjtN8jWMSKhcCUdv7uXYdOlmvc7m898ymOlSi8KCWlfL1cW59NtSE23ZyE5XVfOTcLKefYk
	8Nt8DtPuLP1k2IK+hSp3Xz8Urdb8LZKbMlHKD90yj4pIIsQGGIZ/GeYdPRKtafWip4NaCOB
	4UUqKJFg/cuXQwn/vHbaL1d9bmLLoP58fktL0W1JkXcYbbihLKxQdq1foa1rlufnE4H6/Wa
	PBIjTHXVnYU0+/UNkRc9YLlJqDzya5Km0e02gkLYAuRsri/4DzzIZxDbifCFRRAQrpQwNmJ
	zJ/Ows27RyIdgSBZUqfvhxtn3qvePgrAi1nMFURHqlSse40VrABgTgss73X2aTOIqlv1pDW
	ptZznytCeP5lDdZ9y2acgayjepYHutsZNZyR46Z7RfGjUFhKlyAWSf/NqodNpEZzOB3E7bM
	alkHlEZthlpB3E5CIIjwOW6C6brQNHu5TNRbTmCKe55RuLjWXUfPAc/pWfnn7s4/zoIxxzr
	OxxFeOirO+g2icwYESgjgs2uufYBgllkNsTmKHrisjKvw+pXgpEDV52Bg8LxfaEB1879Cdd
	MJBgAsKS8FKVYu5C8gSGd7juXGAMzmooTNlWcKV2tre+MgD64Xj9kMMDL/4qKYZ1xY58niB
	SWE1x3UvoBTAEAfKs+TWRwyAI9LD7CZ/CKO00WMKnH+mI4xzDN9dTEfNe/kt3JjktlMRa5a
	3IQ3ux9NbULonTen00whOz543UH6CROyv+0XrVspVnLJLAKt+ncm3g7VBGDlYbCfB0gT4TZ
	srcqQAm2WDIHYyJjXYF/7VdmoYtwF9YcROVCS3D+Y9ESGBbA7Ba11VoF3toUwJl32TZQUXH
	TjkPPoSDleG
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

During S4 suspend/resume stress testing, I observed that some paired
devices disappeared after system resume. This happened because
adapter_create_device() skipped restoring from storage, even if the 
initial restore had failed.

My desktop application treats temporary and paired devices differently,
so the disappearance of paired devices led to a poor user experience.
I believe this is a valid issue that should be addressed.

This patch introduces a list of pending restore addresses. When a
device in this list is created, it will be reloaded from storage to
ensure pairing information is properly restored.

Changes since v1:
- Fix code formatting (checkpatch.pl warnings)
- Align logic with BlueZ's existing restore pattern
- Fix a bug in list handling that could cause double-free

Please review ，thanks.

xinpeng.wang (1):
  device: Recreate paired device from storage after failed restore

 src/adapter.c | 113 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 12 deletions(-)

-- 
2.20.1

