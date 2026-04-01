Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72952620DE
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070050; cv=none; b=AOCN0E/+VISlGOpl+BEh1lKL3m2HN2w8PEun9KngN0T2XaYTeEZvnqTrn2RXQi2Oh/lmG0tLx99tp/ItTSlN/qAlgotFqoI6sLOLhrDN9hhPJTn/sI8HbI368ewWLBDKxYmKqNa3EbeppZaNA/vkR3pS9M2IbZc0FuU74UFV/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070050; c=relaxed/simple;
	bh=0TWUo1ovYbzC0VItGjPNLy1eTDKN8yUr6mr1WmxFCS0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qacuKveDiwkB65/i6kEbJWvJGH8WIQXECsX9r4AV0UxlSEfpAPqPEaE3/2iJP8Vb7Tt7vPaOzMzPlDKMCZRP9OdmCKx0NE6Fqz64ihRAGLlBcx3p8vnLJH7l2FG/k80iRlrDvOcL7H4LRvPazs520kXFaqmpJSXT8WNFhARlPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BQNNko3o; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BQNNko3o"
Received: from github.com (hubbernetes-node-a0eb99c.ac4-iad.github.net [10.52.161.35])
	by smtp.github.com (Postfix) with ESMTPA id E32E4640977
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775070047;
	bh=yiM8VbnBLzscSKEhdQwtoX6KX46Kz1pC7tzfRa4dRak=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BQNNko3oUmf/JBuRT9+g2kjnd7HyrkNNP2K2o/SF73jjoTIANADDfcP5LD06MxWh8
	 +1FnjgKPAz5dTC2IhXVgXChorlnXdbJeBiyvUaBP+8Whgx8TmAjpv3hf9w0THxRNLn
	 TNUq7zWcfaW1IjHexwJHTMmtnlm1qlQMYCZCCD8g=
Date: Wed, 01 Apr 2026 12:00:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075991/000000-15844b@github.com>
Subject: [bluez/bluez] 15844b: doc: add btmon-mgmt.rst
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

  Branch: refs/heads/1075991
  Home:   https://github.com/bluez/bluez
  Commit: 15844bd657e26ac464586ffe6be0527a27f54160
      https://github.com/bluez/bluez/commit/15844bd657e26ac464586ffe6be0527a27f54160
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-mgmt.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc: add btmon-mgmt.rst

Add a new btmon sub-document doc/btmon-mgmt.rst describing Management
(MGMT) protocol flows as seen in btmon output; include it from
doc/btmon.rst and list it in EXTRA_DIST in Makefile.am.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
