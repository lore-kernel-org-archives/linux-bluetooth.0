Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494E2C21FD
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777790100; cv=none; b=DD5lfLM/QXuB1SO/KGsSvoTjM37KvzCd4cemggNbgj+HYHZavKBLPrgw/JMGV7tchiQzQRocA4xoObP+GVzv+ARb5/KeF+bGiSekOKMu9rRSd+GnMR2W4yThWq9jtcUrYn9/D+fij36jM7xRbM0oKyWHVMg8a0B8fwcJopCKq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777790100; c=relaxed/simple;
	bh=+tXBDwADE0vpFRm881qFHaHeTvICq4dB9A1H3wve28w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AICso9Q8MTdhgLR955yglLlplzFyM0L1o9R0GJy+JbVOgCQzu/QxmpTXu8ld9ET/1mPQOAZeB8KlKIiJ6Z0n1dZL3+oIpSy0QXlHjoXdO9cziDJ4s5AxArDOjw1ki7EyuaoeklaW9xIh1FErf1gIg2FCeaFtHTe4bOmYs0k6nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GW3CaV3u; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GW3CaV3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777790098;
	bh=hjCzsN5taws+fk4EFp9L3/lIiPNNWCAKqkjMgdw8/d8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GW3CaV3u716g2UfdHRBRS7sLGKDoVPH+d0q6v7kHbaB0CX7tTzBMA9Rb6LK2Thqju
	 bi0lgRmpgbYE99jeMrS34oNwAd9PcVmKHaqXLpzdVFjnesEHho80SCm8Tb9QUyP7vv
	 DkNnSsKJIwrKqQ/+++yHqd8P5THt0wFzOBp8sV5U=
Received: from github.com (hubbernetes-node-e12b829.ac4-iad.github.net [10.52.207.58])
	by smtp.github.com (Postfix) with ESMTPA id 7B5882000C
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 May 2026 23:34:58 -0700 (PDT)
Date: Sat, 02 May 2026 23:34:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076781/3632c1-000000@github.com>
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

  Branch: refs/heads/1076781
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
