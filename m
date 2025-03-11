Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38638136A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741671932; cv=none; b=lVTc0PeBzrqxv14Rtd1PTg80oO041f9hTk+KQiX0Hh7FoavXA5EoxjvXL6ENJ7UANJ+j0H9GkP3jOns4R9FtXyRznk2m3LdMD9cFQK+p/iYu5darUJVpR2/bzrIApwGyZlct+RRWPBo20G2+dq1nTPwyD11N4hCrGDR0VBMuM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741671932; c=relaxed/simple;
	bh=im6yan4noykuufVkoLUUlvj5/vtKXRQatVudXyENhd0=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=FYbDiChkK1ea4Cf4VyBAySZxx3l0aaBgBq8+280arHl7omo/uCoDkG9qD/X0DDpNdmqDasAdfdpFGAGZSJsRuFxigbBnq9FNBUcXsRtQWqF9VmqRymwj2mvHohaS+AtWHrG0qq9O2GkBHLsljmkavt/FXEWkJyt+rx4PoE2RGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=FkOaJE8C reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="FkOaJE8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=vcgeW9I/wd9JtSp9Ne+P4275hnZub9VoA/vHe5nVjpQ=; b=F
	kOaJE8CvhMlWk/F+nBa715Fr1f10uJMTHxUvx8Yor5aOWi0pYoGun+sInn79stU6
	wUOowx3zrqiFwWjNQNScHpsW9c9VyqTvlDdICnt3r/suF1QEBBJCs1hePzLurNvH
	7WdlWvSnS/b4HTrswDJqQMOrj1UCAXA7mUr93YutJk=
Received: from kx960506$163.com ( [121.227.245.102] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Tue, 11 Mar 2025 13:45:21 +0800
 (CST)
Date: Tue, 11 Mar 2025 13:45:21 +0800 (CST)
From: "Michael Kong" <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix data type in bt_hci_send_data
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2fA/qcvkEp5yaYYOkfmU4Vge85UMS3v/og3o5SOJ5+jArp/R4AZEJSBXnJ7OO0OiyImgmGcBZzz9l7RZlFYawxbe2HO42Fi7fjomnq6+b4dw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <72fe471.4f65.19583bc77c9.Coremail.kx960506@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eSgvCgB3H8bxzc9nL2F7AA--.16238W
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/1tbiuhMNumfPw7fg5wADsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClRoZSBkYXRhIHR5cGUgaW4gYnRfaGNpX3NlbmRfZGF0YSBzaGFsbCBiZSBBQ0wsIFNDTyBvciBJ
U08uIFRoaXMgZml4ZXMgY2Fubm90IHNlbmQgSVNPIGRhdGEgaW4gY2xpZW50L2hjaSBtZW51LgoK
Ci0tLQrCoHNyYy9zaGFyZWQvaGNpLmMgfCAyICstCsKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgoKZGlmZiAtLWdpdCBhL3NyYy9zaGFyZWQvaGNpLmMgYi9z
cmMvc2hhcmVkL2hjaS5jCmluZGV4IDA3ZmRmZmM4Mi4uNTc1MjU0YzA5IDEwMDY0NAotLS0gYS9z
cmMvc2hhcmVkL2hjaS5jCisrKyBiL3NyYy9zaGFyZWQvaGNpLmMKQEAgLTYyMCw3ICs2MjAsNyBA
QCBib29sIGJ0X2hjaV9zZW5kX2RhdGEoc3RydWN0IGJ0X2hjaSAqaGNpLCB1aW50OF90IHR5cGUs
IHVpbnQxNl90IGhhbmRsZSwKwqAJc3dpdGNoICh0eXBlKSB7CsKgCWNhc2UgQlRfSDRfQUNMX1BL
VDoKwqAJY2FzZSBCVF9INF9TQ09fUEtUOgotCWNhc2UgQlRfSDRfRVZUX1BLVDoKKwljYXNlIEJU
X0g0X0lTT19QS1Q6CsKgCQlicmVhazsKwqAJZGVmYXVsdDoKwqAJCXJldHVybiBmYWxzZTsKLS3C
oAoyLjI1LjEKCgoK
