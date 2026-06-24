Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8103E2AB6
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334755; cv=none; b=bW30sgWyI7RSoX9WUTTjA+raMUrGXSHb0/4CQAsVlf515qwSe2tocu6JFxIUL87CQoDiNmi3cRZcbo9wEQUHFI2tgumg2HmUt4Whfjwsgoj6lAsNnN+B/yFqhCosmsy8tnWr6MdXyWGr/USMby/hWRMWPpCGbtSukSTAiLvzggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334755; c=relaxed/simple;
	bh=Li39nxxi8ULbo0a61RNqHV1AUoRHCqtowJ/pcSUiRg4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i9awttPZxXQWzxiQ6HQHfffN3z5dKap4XED+Ugnyz4AoGl2JAMZ4y083ZuHLZzy02K5AXcGxEAqvrP2U0BdceKJOZX2Kei+3fz4xDKt7rCmEPVMm4kIvWBpK67BdsykFpqFxurvIjJVqpbN+OppDYNBoebpC0NhP5wtToBANZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MkgKFXu+; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MkgKFXu+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782334753;
	bh=slKcyATaAVTf7H4u67LIBlvKKtSDV/7mGnXrspJjuRM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MkgKFXu++2XRzbPEHP+xTywgTgBx5p1gctw2st5GUectucfyoJZh1fpQ+gVIf8bBP
	 gFMJsE41xJT4hzlLTW/CUKtPTzElTp9HV6hkmjdBR0h8WQEFis/bKXJX0O8o+6gGrr
	 toPaXm689N2wEy9gXGDQp77Yp7tlOzlbg/qRjRyI=
Received: from github.com (hubbernetes-node-65e19b2.ac4-iad.github.net [10.52.222.64])
	by smtp.github.com (Postfix) with ESMTPA id 11DE53213E6
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 13:59:13 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:59:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1115319/c62fba-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1115319
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
