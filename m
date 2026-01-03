Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CF381C4
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jan 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767479648; cv=none; b=cPkBJAgCXOiOM+Rk+7wVSEoWT8qIRWTmj+Nxik1cFThwk9w6PnjclShMMnaGOQRDIW3+Bx2skHh/7qOUqxK5u0e8zq+F8rzwrxou8fjGnjYNx4FUSS4s4+uL895tk2WqDCbC+7KcW9N+5arTgq0gaWvuya9ENrGnXzFI0HiQHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767479648; c=relaxed/simple;
	bh=esyub0mlKEWESzkUvMb7if4BELAGa93blEEhudgxBNU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dInsEEQgrWPqB10DjkxnP7sGK8i6+/wwoM4xkgdqBryj8MeY2EHEZfdfVLzwpy0Q2U0J9qYZzCs3iTNHmqNkXK3cTQgX9b5wEZqtps3gsmlTg9lEOfegjogdvsONElqelfc7uNwY3rqtzfhrHWRYGkovutvfbpqYLoEYBdBtp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SmJX19Lk; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SmJX19Lk"
Received: from github.com (hubbernetes-node-c6f4508.ash1-iad.github.net [10.56.207.13])
	by smtp.github.com (Postfix) with ESMTPA id 9AF17600389
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jan 2026 14:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767479646;
	bh=c6dK+T+9iVA89rjdz3feWL9XhU9NWEl+llew3XqNvT4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SmJX19LkNEAxuKTe37rUjm0th8BiSv2oHQW7B/vQlRLEkY4BrKDlnuy9yT45Nf9xb
	 UE3mmdyI++AU772pMXlH65J2uEPmHsC+DhGl9NWKHQI/dczeAw0oK/ygl1JSq+QX+h
	 ahuKi9zshY2Bvn8SEzreCx4F0NdJstN4cTKKQ+fY=
Date: Sat, 03 Jan 2026 14:34:06 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1038129/000000-f9f412@github.com>
Subject: [bluez/bluez] 80b061: 6lowpan-tester: add test for header compression
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

  Branch: refs/heads/1038129
  Home:   https://github.com/bluez/bluez
  Commit: 80b06175fb45ab79ae93556af8b5dc57786fb8a8
      https://github.com/bluez/bluez/commit/80b06175fb45ab79ae93556af8b5dc57786fb8a8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-03 (Sat, 03 Jan 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  6lowpan-tester: add test for header compression

Add smoke test for IPV6 header compression. These test the compressed
ipv6 code path in net/bluetooth/6lowpan.c

Client Recv IPHC Dgram - Success
Client Recv IPHC Raw - Success


  Commit: f9f412c13f0243d21e9b20bbc8914dc6f38502a8
      https://github.com/bluez/bluez/commit/f9f412c13f0243d21e9b20bbc8914dc6f38502a8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-03 (Sat, 03 Jan 2026)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  6lowpan-tester: re-enable previously crashing test

Enable test that previously crashed kernel, fixed in v6.18

Client Recv Raw - Success


Compare: https://github.com/bluez/bluez/compare/80b06175fb45%5E...f9f412c13f02

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
