Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EA39F160
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541119; cv=none; b=Sr1rZh8X+gTBYLM/ZbSsKmWyh1WJMGl+it4vV6uyO/x4ErEbN/8b3sCJqFUXVwBqVAI1Q+P14Crwj6QSmDxHWqht7cWpZqQdbik8TPC8D6baMSZiiH4Pz1qkZxEnMaJ45917uGwl57HNPLN3p6qPL5FB5DKO59aoz5yQojXPLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541119; c=relaxed/simple;
	bh=P7rmCP/K5oH+wtXgvgvAfPWnE6g7rD7JeHPZe6sMNUQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LWPq5zLsHZXcmw8L/Hg4LyGon7OvXF541Dmvv6TmguN+uBwgAEWKtumycwJS0LmAuuXNIDYQH05k5qepfTjyJJmxsq0x0T2kodXBCLlXRu3+Y2J2akjT+lN4XT8GAtYg3YdFB49swxXA2zF7anSu8R4PnR5/N3MZDyXF0m57iBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jY1RVtn7; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jY1RVtn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777541117;
	bh=NaB18qi76YtEesTz8RXRMx5OCvlRUTbwVj2IehED6N4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jY1RVtn7yUXu9JHEDK+Tg+exznNSoFsNGky1qeZ5FY8w0sggKv04+YTy1n7ubyKt/
	 Hl1+06/Qud0yJXH7amTZudp+3Pxz7Ee7+7R9L/MaDoKUnsxXtQhd7fpSyXkks7FcQy
	 CERq2DyJFUWywWZk1ZPZIcNIhvLOWCj+BNffPY90=
Received: from github.com (hubbernetes-node-cc0fef9.ash1-iad.github.net [10.56.202.55])
	by smtp.github.com (Postfix) with ESMTPA id 0F424921B1E
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 02:25:17 -0700 (PDT)
Date: Thu, 30 Apr 2026 02:25:17 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087948/000000-293b36@github.com>
Subject: [bluez/bluez] 7e38e0: src/shared: Add RAS packet format and
 notification...
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

  Branch: refs/heads/1087948
  Home:   https://github.com/bluez/bluez
  Commit: 7e38e07ffd061e1b3756bdce628e3b3360f1d551
      https://github.com/bluez/bluez/commit/7e38e07ffd061e1b3756bdce628e3b3360f1d551
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  src/shared: Add RAS packet format and notification support

Implement complete RAS data pipeline:
 - Handle HCI CS subevent result/continuation events
 - Serialize ranging/subevent headers per spec
 - GATT notifications for real-time ranging data


  Commit: 293b360d5847a08fe8386972d5e60e9a3e44265d
      https://github.com/bluez/bluez/commit/293b360d5847a08fe8386972d5e60e9a3e44265d
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Read cs_mode_one_data members

Rearrage reading of cs_mode_one_data struct members as per spec.


Compare: https://github.com/bluez/bluez/compare/7e38e07ffd06%5E...293b360d5847

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
