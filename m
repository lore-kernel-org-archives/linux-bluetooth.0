Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10C28F948
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604023; cv=none; b=XkaZhRdTipnz2ecFmR/VoBjYSf9xTUGd6Aj65A+4qq7ttojTBwgk7IqhcJ95ehgICLd/SzKOPw3wtT4YepIgaV3FCqPKU8ubb6I+z/lpK6KuDfzdy3b5Zasm6H3pE94QAfoiN37Z89cBI56aL7vAqXbuPcpdCFX5MUQ5HMU2OzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604023; c=relaxed/simple;
	bh=nSkMc0MFl5Btu15L54QczgZxjWhx8CZZ6uyZVcY4LRw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hplv0NPfUp/7VuhZzg6qKymz1wsLA4zgQzXQmcIeBkF7Wm4N4+Xts2TqMXDzizH3bhnGW2anHjNYIthmLdrRgy9BMdsJYfQIbnA5/G3NRVrC0PlL+Iv9/sB0Y0+6FiJ+BLKogxtcs4EkKn/7hNyIXWwA5hBX/lv/MLsiYnjRtUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eWPmA1Qa; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eWPmA1Qa"
Received: from github.com (hubbernetes-node-003d5bb.va3-iad.github.net [10.48.184.53])
	by smtp.github.com (Postfix) with ESMTPA id E3A898C03DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752604020;
	bh=sAe+W/wI2o94jh5xP6j6W2nDSnzdpbyQKHGQe4VHGdc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eWPmA1QaAz8zE8OgZhi5fOpa9xKzUMv8mB928wg+xeKRqd5jeu6dkuHDwFE7R+hJY
	 b3OOpb3FdatsAKzhvgukpkJzZuYmjgCMkqckNKaeC2EOTMXvPqxEbyFmtRisNtuDhW
	 FYVtm5N62GsrB9FIHPzvW/TQdTxQuITfuduFFydc=
Date: Tue, 15 Jul 2025 11:27:00 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982635/000000-2b4a73@github.com>
Subject: [bluez/bluez] 2b4a73: doc: Add initial ISO(7) documentation
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

  Branch: refs/heads/982635
  Home:   https://github.com/bluez/bluez
  Commit: 2b4a73d64cc7d9e73738c1d76e4bbc3a6f49c028
      https://github.com/bluez/bluez/commit/2b4a73d64cc7d9e73738c1d76e4bbc3a6f49c028
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M Makefile.am
    A doc/iso.rst

  Log Message:
  -----------
  doc: Add initial ISO(7) documentation

This adds initial documentation for ISO sockets.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
