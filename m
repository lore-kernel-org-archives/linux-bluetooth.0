Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A21D5CC6
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563625; cv=none; b=gg42BVp76bfz5wV0xvuVVBSx6eLDHX56hV8KO1DSRxf1cCyLAGJdLVtqhid8PA/OWY4k6tgxIc4nlofAoO/kU4sDuDmZB/iLTofBG64+/HME2jsF3CNqzXwiaKkGm1h1QwDH78MzWE17d8lzuiPSz5oGkvcBa4hSjX3QDoQ1zrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563625; c=relaxed/simple;
	bh=x5xUUPgoeMlZluL2yDri+69plaTQfapqz6qLclad/nM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ADTkW5RUZSHY8RKf9OQqzRBWQITfpwXkpLXgYGwN6HUePhYThSTxC1DytJZwUkDy4n6Wc9GeQvDiE5O9FyxcX9gN56EgzAlzxO2NS2mwit2/jZ3ArIUBho16cJlqZE2umhwaCrngobI99hitd6V66W4sPoeHS5jsjkBcpdB02H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VGjiT0QW; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VGjiT0QW"
Received: from github.com (hubbernetes-node-3f18dc7.ash1-iad.github.net [10.56.175.30])
	by smtp.github.com (Postfix) with ESMTPA id 070E5860041
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774563624;
	bh=GILdJVplaK4PxuSSXRKwDx/EmT2Ezu3wJacYzV7TsHo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VGjiT0QW9NM3RHer7EujxxCD5aEzLoKsqnCV4LOKoH52nqidT0skf68GCWmRJHYwB
	 X9RJV2xObdLbuLkj+D7UT80x2+AqIksS6DW6IhYGEqGQ4FCzGkuW8uCMbWY8C6cD6F
	 wuqY+1dnSDlglmmcwEuMyf7G7LkDBBZ97mANgrwA=
Date: Thu, 26 Mar 2026 15:20:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1073197/000000-74448c@github.com>
Subject: [bluez/bluez] 74448c: doc: Document bidirectional (Source+Sink) ASE
 flow...
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

  Branch: refs/heads/1073197
  Home:   https://github.com/bluez/bluez
  Commit: 74448ce1024c00f80c9a245a0433c69a5250f832
      https://github.com/bluez/bluez/commit/74448ce1024c00f80c9a245a0433c69a5250f832
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-26 (Thu, 26 Mar 2026)

  Changed paths:
    M doc/btmon-le-audio.rst

  Log Message:
  -----------
  doc: Document bidirectional (Source+Sink) ASE flow in LE Audio

Add a subsection under ASCS explaining that multiple ASEs with
different directions (Source + Sink) on the same connection is the
standard bidirectional/conversational configuration.  Document the
direction indicators (Receiver Start Ready for Source ASEs only),
a typical setup sequence, and a note that this is normal behavior.

This provides LLM context so automated trace analysis does not
misinterpret bidirectional streams as an error.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
