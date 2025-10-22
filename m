Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC97342C95
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157671; cv=none; b=S8mqblvScb6StPXx9cSSkZIRf2vdSZUjoKTzXqpKWzLbx3zCFwi9dG/R7S3WNa2o2AQ/FteLtiOfBr4jPErb5Xo3R9cJL98QABXJRwpDG91A8UDy8w8VN7NXhUgw6/qY6ttIgnbWiqx6VgWU3UWkwspo5l4CHYfOlBp5Wn7NRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157671; c=relaxed/simple;
	bh=ITRMuJ0r6S1FgRG3tbdBDAdrkAQEHCMhhGDh8n54zYA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=diJe+FhwDP9+jdu0eipgwnvXarmA9vdB8E2qIJDfd1ylR7cKOxAJ/tAbgtQohPNGDU3k/LPx2OWufjd/OWt5fayk4hzYxsVa/TTeu1OpFUwpHWtbaoorCbFoKL6r6xTnRTiGcWoFhBAopT7Bbo423lNkDqXIsxcMWBn5Dvs6NAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fP1hzX9Q; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fP1hzX9Q"
Received: from github.com (hubbernetes-node-33a737e.ac4-iad.github.net [10.52.223.73])
	by smtp.github.com (Postfix) with ESMTPA id A252364083A
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761157668;
	bh=gSDhzG6lBbLLojZ2vO0SoDbg0hEyg0+fhSavUhQZyNM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fP1hzX9QtlO07egqztl6zR6ZTsh6EECFZrPxSBJUAgr1DIn2LJMOBLZcgveSk8Imn
	 cp1rISNhOf+mSQ1v//jnPD/Ivh5/SuJoKWHjPO4zdfjh46z0q4nM81B+qd+Cj9zNSO
	 jJjq42xUTPNLWJ+0oLuEVE45nuhWlbZXndFkEiqs=
Date: Wed, 22 Oct 2025 11:27:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014654/000000-fd9000@github.com>
Subject: [bluez/bluez] fd9000: monitor: Print data if LTV and data length
 don't m...
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

  Branch: refs/heads/1014654
  Home:   https://github.com/bluez/bluez
  Commit: fd9000c2076e3184caed19e4e147b8f5140cfaa9
      https://github.com/bluez/bluez/commit/fd9000c2076e3184caed19e4e147b8f5140cfaa9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-22 (Wed, 22 Oct 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print data if LTV and data length don't match

If data length and LTV don't match this should be made visible so
issues like the data coming as all zeros as bellow can be detected:

> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 64
        TX power: 127 dbm (0x7f)
        RSSI: -55 dBm (0xc9)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a

Versus:

> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 64
        TX power: 127 dbm (0x7f)
        RSSI: -55 dBm (0xc9)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00                    ..........



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
