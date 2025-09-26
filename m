Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F21E7C2D
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903772; cv=none; b=tCJGEy38LO3PTXcPNTGV3FCsV4X//LeRyNbxCAn/F605PKH2zocehbnn17YcKkVGoHT8ymo/W8vi+obWXnV7rRbDCccD65DWf7PUr3NFFIaaaDtMpWz1PkcgG2iRkQF6c11T1uSUrC0eksaYEt42L1nd94ose2zcmAEjNiKBUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903772; c=relaxed/simple;
	bh=bXKAu1cRFEXiSplrhhy+z03g3lWm0ji5sacFZ6mNoig=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V20HUvhlOV/1VpwgwV/F/+tC37md7xv6ZARssobDbf0aumSH+oJBKqdf8ul9Kj6dL4S4WGr0qDAchPgoF8ERtUVSlHtzQ3peWu5JBmMMKn+AHjaAkrWdK/PAV+/3r7RptvxZpqcnNAZspREFc/+aOdLaBYyAKJQAYSM7ezXYPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mEt5XN0n; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mEt5XN0n"
Received: from github.com (hubbernetes-node-08503c4.ac4-iad.github.net [10.52.155.46])
	by smtp.github.com (Postfix) with ESMTPA id EFAC140128F
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758903770;
	bh=jVazgsaZE10RvDA6NsYKaUJ1+hslXKE0SXYl6cOI06g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mEt5XN0nZeTE+bWVI57cey19WIrJhmaX+ahPq0T634X+jP7zVJx4n4kDlpxswOaS9
	 MTG3OocTo3BOMazOp/IwbMwmJbPGyq/TfcEWGq7vJytfTctq39Ug0rzFRt0CpAQzt6
	 30Zba/jDAp+IJGmNhDvWBshlzdaRfbssQutUHSmE=
Date: Fri, 26 Sep 2025 09:22:49 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6b0a08-04a896@github.com>
Subject: [bluez/bluez] 04a896: doc: iso: add BT_PKT_SEQNUM documentation
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 04a8966972d0ff14a14437dad75f67b2f8959f55
      https://github.com/bluez/bluez/commit/04a8966972d0ff14a14437dad75f67b2f8959f55
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-09-22 (Mon, 22 Sep 2025)

  Changed paths:
    M doc/iso.rst

  Log Message:
  -----------
  doc: iso: add BT_PKT_SEQNUM documentation



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
