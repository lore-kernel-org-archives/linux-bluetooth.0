Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DF3ED5CF
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814291; cv=none; b=sNr+zX50p3NaI0ohHNlKBTHVJU1jsmXyJ/RWT6jTrV5AoRXBETXd+Ov1gv9MTAHL6ehr24+oFRLJJa4AoaYNVnbT9Y8xnpOI37lRFh3/MWGPOqo1GelonebEBaryx5TgK2QnHeDQQUzyWHg4bWikA9z0BfGRBdAe4Iqj7CDKEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814291; c=relaxed/simple;
	bh=FaTdWPloE/8kC+EFJFtQx8D444LmPjHnVGlX87CQZxQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VRY/UX6dAueF9glI7sYkdrncck6bfnHGuztfIQ9ltLgm4pc/5Y5jtMAp9rl5guWIUZruRz0r5xXE9mkBao+19PhSKGeJ2O/FcyT9cLfQjWB7D3HDHfohR0JDEy/5s9jFV4W3MMkqd74EZdK7n2n+FrSO+bAim9LCOSljJjsb0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EuTcQSaH; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EuTcQSaH"
Received: from github.com (hubbernetes-node-e26c9e1.va3-iad.github.net [10.48.162.15])
	by smtp.github.com (Postfix) with ESMTPA id 115A82C10DA
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772814288;
	bh=kTOgEHtIviiwjAoWMP71O+JVFiXPxtg+r7XdNKu37LU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EuTcQSaHqjl/5v27waxzfQHGeG+M8wr/0Xprr0Y4D0YoQzju/Uf5sqKR8FhOWF4Yk
	 BTnJMqBmEoH6FISDkAY6R6zq4AJFU0wQ3N/GZaoT40u0sfYnUunpebZD+qMUaLE5DS
	 WHpU0bw+qEeJMnyAGcbcaaGXMFXP1XiYyB0plVtw=
Date: Fri, 06 Mar 2026 08:24:48 -0800
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1062730/000000-9cabd8@github.com>
Subject: [bluez/bluez] 0c7646: doc/qualification: gap-pics: fu: add footnote
 for ...
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

  Branch: refs/heads/1062730
  Home:   https://github.com/bluez/bluez
  Commit: 0c76461a699d355a8b1ce3ff156faad4a30c8f69
      https://github.com/bluez/bluez/commit/0c76461a699d355a8b1ce3ff156faad4a30c8f69
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gap-pics.rst

  Log Message:
  -----------
  doc/qualification: gap-pics: fu: add footnote for TSPC_GAP_21_9 feature

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 1b7e682ef4b7 ("doc/qualification:
gap-pics: add footnote for TSPC_GAP_21_9 feature")


  Commit: b4dc69ef69d0c8e226bc6fcc7f54755893c1b942
      https://github.com/bluez/bluez/commit/b4dc69ef69d0c8e226bc6fcc7f54755893c1b942
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: fu: add description for GATT/SR/GAW/BI-39-C

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of db7d1a9c770c ("doc/qualification:
gatt-pts: add description for GATT/SR/GAW/BI-39-C")


  Commit: 9cabd8a0db6360991058de306801c15d1d6f778c
      https://github.com/bluez/bluez/commit/9cabd8a0db6360991058de306801c15d1d6f778c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2026-03-06 (Fri, 06 Mar 2026)

  Changed paths:
    M doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: gatt-pts: fu: add description for GATT/SR/GAN/BV-03-C

Unfortunately, v1 of my patch series has been applied to master. This is
an incremental update to v2 of 268d715b80e0 ("doc/qualification:
gatt-pts: add description for GATT/SR/GAN/BV-03-C")


Compare: https://github.com/bluez/bluez/compare/0c76461a699d%5E...9cabd8a0db63

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
