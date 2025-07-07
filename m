Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093829A30A
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900182; cv=none; b=Irau/g8OCBLNV2HaYq/J1N2jduzjSNBgbuSH6lOiU37zRKO5HMeClDiFOZSVxrmgd4sKF4WcI92vtDICnLjMHLC5uMLq8gzWGcfcTtpJySdtoEaOFVUxDDxtatzIGNRCRSOweUfnXX8BG6yJqJ1IWZ/1tbFo+OvsIOeFkNCv14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900182; c=relaxed/simple;
	bh=A1GVrPHMLCCyt1bLIN9EBYUmxHmrM+xKkcW6gXR6Kpg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TrpiNjqeiy5ObkayR1fkGV7whhnRQ7E+LV1N1fk1ZjYbxbT7z2pnTwkCCEVz4zF+5x6uH48oDbcC7d6aDBmY0C8DYkaKz+SOW3+hnhvt8N1fOc5Bhn/eB842Xq1nxpd+kDP8Dp0PcCcFZ88upTI/LuBrfMB4novGlIrjs5p0tTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l/mOZQsn; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l/mOZQsn"
Received: from github.com (hubbernetes-node-c199cc0.va3-iad.github.net [10.48.135.34])
	by smtp.github.com (Postfix) with ESMTPA id D9EC1E11AC
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751900177;
	bh=AGd0B/18nk4iknoFJxifR0pgLnCU5KMwhP/YqvBeEfA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l/mOZQsnCW7RoINJgyavtJBs/7pUgCUi80rV36gAcQ5opX8IwL2HPrioFNdxDOUxG
	 T2IL24dyjHwyZY4TQpzZ9MwK14noesiflHYTL/Rcx9O8XiL/h+6jdQu9gEkCt59hFZ
	 LhPxGPPCcTT22nHWEKWmYGn9vQ6kZuxTIPAeNhac=
Date: Mon, 07 Jul 2025 07:56:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979547/f7155d-000000@github.com>
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

  Branch: refs/heads/979547
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
