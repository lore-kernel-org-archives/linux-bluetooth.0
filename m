Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011BE19DF62
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400455; cv=none; b=f/T4sf6cHcVYZpGP6jjiczkDTmsXtcNsUSen9IsVepzR26K+yfaIfOyBZvvww5ripeTw3j4Q1EOgjTNBOeMPtI1ScbGYad8DKaurbbxCYJ+XQKkpNNU9GDWfq8sVlTGr+nnS8A3a3Eg934dr/F6ykFgcVhpnNrg1Qfh8PmjVtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400455; c=relaxed/simple;
	bh=VtWAeVAUzgijmTEzSZZposnZheGiUCOCmdSelgewc8A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jdD5S+88MlHaSpnJVKQ03dbGtcNRzBcSN1wU6whpIc9jSE0Fns9s2/LqZnap2OlvgkywKeOHI1/97krbnHkBKDlU8e0541kls6/MdemLwhGmGYjsQKA2U5BcO5pV/2+QULZSY7AVacNaDusWymcp/gruzsxe7O5/lWmgLcl9Wv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b/JMfmLZ; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b/JMfmLZ"
Received: from github.com (hubbernetes-node-260f7b0.ac4-iad.github.net [10.52.131.25])
	by smtp.github.com (Postfix) with ESMTPA id 0A3476408B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765400453;
	bh=z019fazzAOtfYu5dQesEPz4q42hDHPJqeVJtTliVbo4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b/JMfmLZ36nUibEX9vGvgfA04zPgMSR54uJe7EDuWuOOmMawkowX4avgGJO40/M1M
	 FAL7ZSkG9NuRLDMhRozpsNNKtDodPJKWN4FNeGf1FaeVIr3x+kOMzMqcMQe9Yi8zXm
	 Zf6eeL+sJ14fDoNl7W4bfnqiLg7ukt3+xXdSkDVw=
Date: Wed, 10 Dec 2025 13:00:53 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032100/000000-654498@github.com>
Subject: [bluez/bluez] 654498: l2cap-test: Add tests for BT_PHY
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1032100
  Home:   https://github.com/bluez/bluez
  Commit: 6544982f500534e192388862951f614e00924754
      https://github.com/bluez/bluez/commit/6544982f500534e192388862951f614e00924754
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-test: Add tests for BT_PHY

This adds the following tests that uses BT_PHY to retrieve the ACL/LE
connection supported PHYs:

L2CAP BR/EDR Client - PHY
L2CAP BR/EDR Server - PHY
L2CAP LE Client - PHY
L2CAP LE Server - PHY
L2CAP Ext-Flowctl Client - PHY
L2CAP Ext-Flowctl Server - PHY



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
