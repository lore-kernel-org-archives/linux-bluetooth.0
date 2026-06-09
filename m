Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298A3AA1A9
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023116; cv=none; b=CLzJ6HZY0pL7+hsm2KiOmB0c09eXMxnT97mr5okQzaM6YIhmKHUZ4Rk0L5gACrN3Au1hAInOJmnVltDX0DzzZw5r4WI3aR/P6TsPy5glp90PIKQrC/1u7zLbzsySSaR+Mlnn8h1Y/02o2DN8NN3WtHx7Sq4OA03nn001wXDCBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023116; c=relaxed/simple;
	bh=iqtHPw8+HqGyvUZ4BWJASRLeF6X3sGLoRXekqOc4k7E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LNkrf+JiVfpzLznvR9x1K7SKVPAHUyMvoTeIm/SZvhw0HveRx6wxkdWia66zrRTpd54wINEyff33LozuRuH97nY/5G//APvro043eitfX1WJi4y19Xs92ly8+qONa/LHgzu/eEfyY8LLpOBK1irbrrt3S3ERXIze0DbI8WUKBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=azn0eZ8Y; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="azn0eZ8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781023114;
	bh=txTSMIsHqhEI/hsHZNLFGYq7vZoO3kZ29SdXFFYxA0M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=azn0eZ8Y7Vf6DF5nkDLFohypXbogmdYncM8YaJzv1LhpQ4VJj3n2UAh58UtJiUaWm
	 NEDDf7iwGWK89NKYZr4eRV+EdCMcttuqVuATqIAhdDS7w/HDdZLsilDAJj2eQQ501L
	 SQnd245+gGbkf6uSSn0SMLgGYvjMPvQqtNQLMJDk=
Received: from github.com (hubbernetes-node-5a64955.ac4-iad.github.net [10.55.97.30])
	by smtp.github.com (Postfix) with ESMTPA id 3FB7BA0A50
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:38:34 -0700 (PDT)
Date: Tue, 09 Jun 2026 09:38:34 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108690/000000-8c2ee0@github.com>
Subject: [bluez/bluez] 87d07a: shared: rap: Check role before sending CS Sec
 Enab...
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

  Branch: refs/heads/1108690
  Home:   https://github.com/bluez/bluez
  Commit: 87d07a7981815712c9d8bd855c25b038ec88c2c1
      https://github.com/bluez/bluez/commit/87d07a7981815712c9d8bd855c25b038ec88c2c1
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Check role before sending CS Sec Enable cmd

Add the is_central parameter to verify whether
the local role is central before sending
the HCI CS Security Enable command.


  Commit: 8c2ee0c8aa1082570e31c7a3321b7a304453b86a
      https://github.com/bluez/bluez/commit/8c2ee0c8aa1082570e31c7a3321b7a304453b86a
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add CS Initiator cmd and evt handling

Introduce support for LE Channel Sounding (CS)
ranging procedures in the Initiator role by enabling
required HCI command sequencing and event handling.

Add handling of core HCI LE CS commands and events
This enables cs capability discovery, cs configuration
management and execution of CS ranging procedures
in the Initiator role.


Compare: https://github.com/bluez/bluez/compare/87d07a798181%5E...8c2ee0c8aa10

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
