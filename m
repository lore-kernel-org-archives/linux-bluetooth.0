Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208E28DF46
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357129; cv=none; b=oMxfD3Icax/7ialCftBKCHROkrNlOW08lG2jxrzSkc75sU+Uae/ntT7eUaqOK2cpPSgUF2kvCqaFuD6CUG4JihmsuxNPpp9Ev+WcbHuskyskJcJ/65F9BwZJuMakc3TphOikyCtsbMGVKQgkyVAM7fhYfhTttW6rA3D42yZtarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357129; c=relaxed/simple;
	bh=pBjyE+g4X/SK0tvMdMW7QAjeJTxmMp0pDiWb3ovfKDM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cB/hquN0FuAEUGyUijjUtBTlao4/hBaOB7RanAaC7PYKWYWuu/D2TQofvyug7kW+29dUEnY/BpGPJaY9obuFO3NVGecPOiwWcZQAD5XUSllhmFmBXnS6bQr4Dx+GuAAewRJxXpvs21QNNegMMiPe3Go9nl6ZFP9wPE5hnBZvW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GNZOFOO9; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GNZOFOO9"
Received: from github.com (hubbernetes-node-eb613de.ac4-iad.github.net [10.52.146.37])
	by smtp.github.com (Postfix) with ESMTPA id 74DA920954
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750357127;
	bh=NixOqXSiuJ3GzAB+Se5SyroNDwqr53ygku3FnZeFHns=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GNZOFOO9khVuD2bVB/VoJr/qTZBNZoUG96gVwjKkCSvJr86CWneHFQGrunnW1aK7P
	 XYmYgXtdvivgrseCD9uk/U/QzJpB7mT+40EXIk16EwUTtVcuMgOrmjmlfh2uShN90a
	 HYu+Id/cIXS2zYMwQ7Mee8oU9WbEGJ3D+E9yqoiY=
Date: Thu, 19 Jun 2025 11:18:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973494/223814-000000@github.com>
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

  Branch: refs/heads/973494
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
