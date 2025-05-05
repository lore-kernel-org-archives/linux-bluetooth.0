Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D03192D6B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450033; cv=none; b=uRY9ZYsQ3qqhobfPvhp9W9ahBM30RXM9bwv10ARUzdXs2dQCWl0dx8o+jdSA1arXTxaLzTuAzvijY32JwI2hdIgW77XPi4PCV5gANda2B6p5P92LWMi9f5mteWtIVAuZdds20gPJR/UlCcarl9bi9XuofL8nmCsM7MS9JMyTidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450033; c=relaxed/simple;
	bh=9NOWX9RA7ihPuh0jFsK3Vwy133eS+pNg4aUWM12AQqU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XyOkuNQBG7lUqTA/vAtI/7ZfVPTOU6T+bc5fURqTnTAwVx+8FiD1vcxlSjkKmdRAaP+eoMaTNhxKmj+SzIaz6ae9IBQxA9NGahFOYKm6Wj+oIv6o1UNrp0m6qWvRP64tdy2wLqxbxBg8fotV3W/ZbeyEy+t0z1C5IeX9oFOMWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X3STIa4W; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X3STIa4W"
Received: from github.com (hubbernetes-node-cd72301.va3-iad.github.net [10.48.148.31])
	by smtp.github.com (Postfix) with ESMTPA id 2DAEF4E134D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746450031;
	bh=s5/upUgzrLscjGpIBUW3NqcOCbkvEt5eUO+MuKSiwuc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X3STIa4WNjDe1nJn8OBxSyI7cY5T9QAVVAQJ8rljiaS0sok0W91UiEb3DCTIQXHrj
	 Co8xZKgHR1ijezChswVj0zfZ8lImf9nHOm3XymBOnpFEej+TOflWALyl9FZVeBQgQu
	 tB4jANxqaA4u3r1oemx3gBgbZo08eoJPBGcx+s+g=
Date: Mon, 05 May 2025 06:00:31 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959621/000000-edb889@github.com>
Subject: [bluez/bluez] edb889: monitor: remove redundant hexdumps in Mesh
 Provisi...
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

  Branch: refs/heads/959621
  Home:   https://github.com/bluez/bluez
  Commit: edb889e4f580c421d5333bc68eec615872e7a9b6
      https://github.com/bluez/bluez/commit/edb889e4f580c421d5333bc68eec615872e7a9b6
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: remove redundant hexdumps in Mesh Provisioning

Paket data is already dumped in the statement above.

Fixes: ad0cdbc1e943 ("monitor: Add basic decoding for Mesh Provisioning")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
