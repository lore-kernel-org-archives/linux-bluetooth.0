Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927EC306B1B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626590; cv=none; b=JOhBte37cw5h+40gn69gOrMKhBBaYOn79rkIrHklcKYYdg9xhv+nTa2Q2F0Cdgx72cN226ScmH89Lb2MwU+9K8iXRUHkcLSzrfd1BTYvxgQpIu5PGBR1Ip1Fgkt7RJmKbk/TAcfaRGFHFUtfMlvKca38uOU5q1R8M0Thpq2CVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626590; c=relaxed/simple;
	bh=PeUd4bGPFMDKNEp4BqRgI9U8vO26JEfp7lE1agatD8k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=K5tqqWgeLd7Xhq7EO0t049R2e3pj8B6ilA6kdo2eICWvnZsdzf0p49PqMPpSig25bGJlx3ZqmIbZhXYmj13GbWzxSA5u5P/sBIwqM0GruwRyATVgz7sVlmoz6PcZ43Jnli46TdFLNHfLQHy+gh0+lpQy5CM8vnz8WKuszshSLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Cs8B1+q6; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Cs8B1+q6"
Received: from github.com (hubbernetes-node-1085f9c.ac4-iad.github.net [10.52.173.56])
	by smtp.github.com (Postfix) with ESMTPA id 7F011213DD
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767626586;
	bh=cRkvWdTrza1rIVYPwFhcm2MsyTAVE19gI5zhoR38YbI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Cs8B1+q6rMd7W0Cv9/BnDt46aB1thuE2vmK//xyLBFTKj8MsbA/vEzfimLjYmtieH
	 UGq6Q2ufVkpufS7ALlE8V67nK6L7YVeP0N8DDSteADVBDMJXvuLpp42sjzogS+YlaV
	 EKO6hEhMj5i9FKt8ENwTktWKJKt5Eu0Zb+kFCJeg=
Date: Mon, 05 Jan 2026 07:23:06 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/05813d-f30307@github.com>
Subject: [bluez/bluez] 6358a2: 6lowpan-tester: add test for header compression
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
  Commit: 6358a2a11313e17846d481d59a55a76e2898d6ec
      https://github.com/bluez/bluez/commit/6358a2a11313e17846d481d59a55a76e2898d6ec
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  6lowpan-tester: add test for header compression

Add smoke test for IPV6 header compression. These test the compressed
ipv6 code path in net/bluetooth/6lowpan.c

Client Recv IPHC Dgram - Success
Client Recv IPHC Raw - Success


  Commit: f30307588ea5b7d2dd0cb1040a8452e8ed41c040
      https://github.com/bluez/bluez/commit/f30307588ea5b7d2dd0cb1040a8452e8ed41c040
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  6lowpan-tester: re-enable previously crashing test

Enable test that previously crashed kernel, fixed in v6.18

Client Recv Raw - Success


Compare: https://github.com/bluez/bluez/compare/05813df5e490...f30307588ea5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
