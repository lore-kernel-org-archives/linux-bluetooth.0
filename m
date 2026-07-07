Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE668372EFF
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440113; cv=none; b=B3JzrsxUn3f4QvleSwizek2tzYk/G8+eKAN0xegqrRfLruk79MdK1yXshHDVsdAUBsGCdcOO0lrquDEi+aVMJ3QHNNt2AdbcCoJG3oQnSSa2fCnVdXfvHGh5Zakwgdwa3aHGM240gNv3cC/UvgfjMclTsitRDvmO5ULEmPGnZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440113; c=relaxed/simple;
	bh=UUUbTw9doTt6pE5r4eqVfX08WJOPMmmgZF6AMH0eBec=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g3knl5OpumJxEWBMvEOhC3qEiS5xdiPyBpw/5DfLLxnC73T6xXbdn7tGFSOc6swCB51gzAXFMmeVVXGEpWg6LdeAgIEJ0MMSpiyd5eRC6MPARKFRSHdL2s/n3Nj8R49CRkBk5P8kaGJY9984MQyyiw/NOtw8n9b8+9toirk4huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XGbIl59O; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XGbIl59O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783440111;
	bh=hFiLo9JuEdShGga/Aq0EsVxcFDfGMKxW80aUMTjAkWk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XGbIl59OlzLhLgoXbNyz0QAilYr1I+ycRLdoAOK+sq1wxXZwfxB++WNg/RvKtWy+V
	 3eXnQhFeF2zvIRumbB6xIW24xkccFc3orNZyO1dvZ4xCwqS4ynazus8BUQzU6ytdlJ
	 CaPGiinugkOwsFCG8vXIm1w2zl0I2zHzG1xBtJ1Q=
Received: from github.com (hubbernetes-node-b368a33.ac4-iad.github.net [10.52.174.55])
	by smtp.github.com (Postfix) with ESMTPA id D5B61749143
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 09:01:51 -0700 (PDT)
Date: Tue, 07 Jul 2026 09:01:51 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1123158/000000-b98029@github.com>
Subject: [bluez/bluez] b98029: l2test: Fix calling getsockopt(BT_PHY)
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

  Branch: refs/heads/1123158
  Home:   https://github.com/bluez/bluez
  Commit: b980298bb454155032eb278cd0a1426040c659a4
      https://github.com/bluez/bluez/commit/b980298bb454155032eb278cd0a1426040c659a4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: Fix calling getsockopt(BT_PHY)

getsockopt(BT_PHY) expectes a 32 bits argument not a
sizeof(struct sockaddr_l2).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
