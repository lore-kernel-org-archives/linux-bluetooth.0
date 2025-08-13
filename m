Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E374420
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081811; cv=none; b=PBz+GrLCMA9LBO8bGC/Rl1Bj7SmTH0ci90oDnsgd3tznI7RXytFksKZuwEqTMl8dP4kph/DgcRFjrxLt5EABsdq7MFB2HN5nB7lte20bzLVIpep56wO4ZQ0LYDvjpkV7xZRCH0PtcaJfUIhNDZ8eLdd8NVU4DflqqhCyAZamT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081811; c=relaxed/simple;
	bh=6ZOve0ZvaCxwnPjRnidYumitpRVIfeOWtDPjuQ2ye5E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BS1Pby8saGDONbF2ym5nc7YwREueJiEaXnho1HbQVhAAb6gyy69F1TuP8qBTKfMavmyrbWqR74LcZO9zAD5FMN6cBVTBE+0uJiJOZkAUjqHnoSMwMnCAI7gxp2fWxDHnAGZe/+pyU7MA5AVZjLo49zJ/TTnZyLJv5Qgzqrkg1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lRGNYM3N; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lRGNYM3N"
Received: from github.com (hubbernetes-node-ceae02c.ac4-iad.github.net [10.52.222.72])
	by smtp.github.com (Postfix) with ESMTPA id 77676204DE
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755081809;
	bh=5Y38DaYa4W45JqtXH0YG5mn4LRl6OHNmZkZVk8QGrI8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lRGNYM3NM96NN8AbZdw2fe2ESbquVOMtP6+lsF8SvdzPpggElIu+78m+izcqlZXEh
	 OC/f7f+ZNhmDaTJi9ULRxraXaHh4va00jbQQKhf6qjA2U3LnqViHJiCGW2gasurLE/
	 KouJ2dwzJE54k3A1zkFfNdcILwqbbtbaWmyS17Lg=
Date: Wed, 13 Aug 2025 03:43:29 -0700
From: Oliver Chang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990970/000000-1663ae@github.com>
Subject: [bluez/bluez] 1663ae: Fix heap-buffer-overflow in
 sdp_xml.c:compute_seq_...
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

  Branch: refs/heads/990970
  Home:   https://github.com/bluez/bluez
  Commit: 1663ae444fa2a670d2e7cc2fdfc3eb3e057621e6
      https://github.com/bluez/bluez/commit/1663ae444fa2a670d2e7cc2fdfc3eb3e057621e6
  Author: Oliver Chang <ochang@google.com>
  Date:   2025-08-13 (Wed, 13 Aug 2025)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size

https://issues.oss-fuzz.com/issues/42516062
https://oss-fuzz.com/testcase-detail/5896441415729152

This can be triggered by using an input of
`<sequence><foo/><text/></sequence>` against the harness in
https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c

The root cause of the heap-buffer-overflow was incorrect stack
management in the SDP XML parser (element_end function) that led to type
confusion.

When an XML element failed to parse (e.g., an unrecognized tag like
<foo/>), its corresponding entry was left on the parser stack because
the we returned early if data was NULL.

With the input <sequence><foo/><text/></sequence>, <foo/> failed parsing
and remained on the stack with a NULL data. Then <text/> was parsed and
also remained on the stack because it's only popped if
ctx_data->stack_head->next->data != NULL.

When </sequence> was encountered, the parser then mistakenly used the
data from <text/> (which was now at the top of the stack) as the
sequence data.  This led to a type confusion: the TEXT data's string
pointer (val.str) was interpreted as a sequence pointer (val.dataseq).
This pointer pointed to a 1-byte allocation (for the empty string). The
code then tried to dereference this pointer as an sdp_data_t struct to
calculate the sequence size, leading to the out-of-bounds read.

To fix this, in element_end, ensure that the stack is popped even if the
element's data failed to parse. This prevents the stack
desynchronization.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
