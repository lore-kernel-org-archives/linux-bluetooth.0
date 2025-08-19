Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC21DF75D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614093; cv=none; b=ONysELCuVTLiDgtWDdwBypK3XgqZ5SZ+7YFU/Np3g0RbHNPG5PMtkH0oibUtMP6nqrV1QY0PWG2IJCaH9pnxzEGYRkfM8IuuFwZPb3ihvH3kpJCcb1tFyfeYbKLEdqGoWgvdmO29XUIPdZ19GqOnprjS1ZVbPmlpVZkcPqV3/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614093; c=relaxed/simple;
	bh=MaVz3jVUcRMzUaF5NC4K5rpuoxagYP71a9570dJkkVY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SgShSGRTaseiGVM7K26BceakRgLE2tGaCoLLEnBrVGIxfUczT+ryFRmXdo6rgXYlQDOQf63LfoSWqPnVvxU9GmqCMX0/K8SuqVcG0S8CAhZrXHohpLGBbCo3/WvZaM4aQtUamh07iBzZmBys0zzsN4ZqaBMFF3xCTyxc/PgtKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LqE/3X9U; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LqE/3X9U"
Received: from github.com (hubbernetes-node-e042978.ac4-iad.github.net [10.52.167.38])
	by smtp.github.com (Postfix) with ESMTPA id 4945C641462
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755614091;
	bh=Q20xyfTMDaA6pPQ8WILxYTNXz8dw/u5VHqr8cPTtlao=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LqE/3X9Ut/bWu7ZY3KR9Z2u5RWj7pV0R0gqYnN6REWLctEA/EFqasrjBkFMFgn3l8
	 Td7ltODTdgAygiKKbbAo0c0XD272z0Uu1eKagEuu0dlvzdHbmuuH2gLDXO0h1b/cjp
	 Zikx1tmr94NhgY6pYlX0K8+5xsHwthuwmNOJGkVQ=
Date: Tue, 19 Aug 2025 07:34:51 -0700
From: Oliver Chang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0bb66d-00eea3@github.com>
Subject: [bluez/bluez] 00eea3: Fix heap-buffer-overflow in
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 00eea35722b73d922472c7fba006f711690ce195
      https://github.com/bluez/bluez/commit/00eea35722b73d922472c7fba006f711690ce195
  Author: Oliver Chang <ochang@google.com>
  Date:   2025-08-19 (Tue, 19 Aug 2025)

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
