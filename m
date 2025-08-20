Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566523BD17
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722801; cv=none; b=TG950qGhSVncEXPwCFngsBzYRPeMCleVtQf8/bGjazAoXElLjNretr0krIQ2eblHSCR89Y8QPME+1nvbaU3UuPowkRL5H8I1k4JBO0Ck+vxrBOILMDJcjd/5meHkm6HCck2+zfuEauiZVDlSWq8sNadm531SEsxSLK77l0lhSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722801; c=relaxed/simple;
	bh=/zgb80jJQY4qwC+N2XTdmfjspu0lT01JtyzvPYLE8ew=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eMrDicr/w5qvMJEA0EEDCo74zZQ4M7Xos5DJdfTqaFYv3v8ZjabYdJ1jwaBS6q3bskMMMzgzwzmMQJ7pIwbnYg0TqEr8Ddy/JVfQcEKpo57pm3oN+mgYpwf07TxRXtN1A9apJ2BFSk6omXEG6GTVtcQTdRAUgaLjTV8Q8EAu480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hQ2CGS5t; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hQ2CGS5t"
Received: from github.com (hubbernetes-node-602e586.va3-iad.github.net [10.48.169.41])
	by smtp.github.com (Postfix) with ESMTPA id 1B3118C080E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755722799;
	bh=zLCSbGTOPgdrsNK2/mlmt+ipVCrXeRTYcPs0Sp+agwk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hQ2CGS5twgM3TmAdYpKdOa6b44z2bmd9zjKVbIVMYBQjrlbl9DFvjrTDWn1tpYRbU
	 x+8btuVySkDzM1ZA87Bwg+QOKG3hPETq/kwG0Ku05Z7WyJlceBJbRkwNEdANLTgjAa
	 vvc++LT0ixqocnKwMIwba6N4JeJszcrItE49VnZ8=
Date: Wed, 20 Aug 2025 13:46:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993678/000000-47ec10@github.com>
Subject: [bluez/bluez] 47ec10: adapter: Fix setting index in
 MGMT_OP_SET_EXP_FEAT...
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

  Branch: refs/heads/993678
  Home:   https://github.com/bluez/bluez
  Commit: 47ec10d6e88c3269e867abd4753131327daf8b04
      https://github.com/bluez/bluez/commit/47ec10d6e88c3269e867abd4753131327daf8b04
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix setting index in MGMT_OP_SET_EXP_FEATURE with debug_uuid

Experimental debug feature requires use of MGMT_INDEX_NONE since it is
not an adapter specific feature.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
