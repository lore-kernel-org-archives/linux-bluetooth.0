Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2B72606
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298196; cv=none; b=qaJ+N3F9jVKySCVg/+8l5AxSc1Kek7+V7v/Ww84wNOPx+q8Tvombfi9U4i42pleGghu8DxQxo/EnPx+mxS0ZFLRdlbDq+DbBt6/1ksBuYBq25d3FHsd/krF2Ph7GMExTUNBLdzH4z5Zs2vvhlPocomJUVgWSLEY5qDr8hZUiWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298196; c=relaxed/simple;
	bh=pMaA5f9S80A3NUZ9i6q+7Y9YfB4opJj79xaw4iXognY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=enr+iTxegpobMnzJ3e/MbnPkx1DQGFG3s/grvaVDt+A5KKdx8j1dFvFk5X2q6d6OLyWkCprmO41YKuu9EvrUvV0EWDVNEVpNGQz68TXk8LHwfDltx3sRA75ZGUTUDxy+X6olpKuj5dDcdXFZNrZUn/dcBnsv1gjqFRoNkdGpDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ClZ6wxAa; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ClZ6wxAa"
Received: from github.com (hubbernetes-node-86495f0.ash1-iad.github.net [10.56.184.37])
	by smtp.github.com (Postfix) with ESMTPA id 19AB3920A22
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 18:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764298194;
	bh=0r4y2VeIXK0tp7DrcZdBOPUy4PyZ2dwmYfyO48eOOeQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ClZ6wxAa6+C3Isi20GpnLxZtKYcdx9VpIEvhnhc7AfIaRgvVsg0Ut3+cKkzzDd6qy
	 QkgtTdEZYRDHdwlrSD+MwRVDmCqu8nBXiv56KuLKpTTm3unzqCVhryMSfm0zrX6nOW
	 CAop2mmzsOE7g+tiK9KGFBCBgME7WeIyaOEUGU+Y=
Date: Thu, 27 Nov 2025 18:49:54 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028487/000000-9b4a1c@github.com>
Subject: [bluez/bluez] 9b4a1c: main: Fix wrong option name in LE options array
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

  Branch: refs/heads/1028487
  Home:   https://github.com/bluez/bluez
  Commit: 9b4a1c424bdc55bfed3fe504201d65b8db598cbe
      https://github.com/bluez/bluez/commit/9b4a1c424bdc55bfed3fe504201d65b8db598cbe
  Author: Hermes Zhang <chenhuiz@axis.com>
  Date:   2025-11-28 (Fri, 28 Nov 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix wrong option name in LE options array

Correct the name of "AdvMonitoring" to "AdvMonitor" for consistency
with Bluetooth Low Energy (LE) terminology in the le_options array.

- ScanIntervalAdvMonitoring -> ScanIntervalAdvMonitor
- ScanWindowAdvMonitoring -> ScanWindowAdvMonitor

This will remove the confuse warning message:

bluetoothd[973]: ... /main.c:check_options() Unknown key ScanIntervalAdvMonitor for group LE in /etc/bluetooth/main.conf
bluetoothd[973]: ... /main.c:check_options() Unknown key ScanWindowAdvMonitor for group LE in /etc/bluetooth/main.conf



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
