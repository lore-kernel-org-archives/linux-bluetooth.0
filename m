Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11136C0AB
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733723; cv=none; b=NEK/FAKs4dJqEIDuErytw5QbhuJGilvGJy770FLFdy5v1q1yKbe2z714ArpvH59RsYFQ+op1rqWRIAJDy0jSUzpAO5SWvVr6NMdUkEJZ6SJR8t5nwak7uuMe8vHsF7301r4XnBm9AVNkTYX2v8lhB6Cy8La+IgCN9l7VtHuv6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733723; c=relaxed/simple;
	bh=CvzhyjBnAwrjoT/iSaSkfWrQBoErSQYI8lFdg9om6zU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aei9y21BPTkW3RA+5DawoyTI5lebtUyQqyrtihxPLdTBMqvDscn1ZKJDAZEGmHGiW3UBcQYg0XpF4FLpwPvXqaERT4rABQMrjmUmv2TRPAYMbs+2MRcKMDCtd0oSNTS5diUByZ/n4hZs2fkSLrJ4Aq5h4IQuvvM3FEHQFEEwJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=csQQO6dD; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="csQQO6dD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786733718;
	bh=j5cm78TKXTOhJ17+ylaCbdniHEEpLlwhR/4X0AXQnS0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=csQQO6dDuvwtx1yvK8ozPHXT5ycSQVsbIkA7uEIXq9Kz/y9EfSdkVGTpTFo5DXtB/
	 NvvSzzeH99DGbUIq/hqSu0S0uYNk2TsidY/0M81tcWOAkJhDEwbz15QBL5BTj1DwYq
	 n54RSwYDhwh3JZwM3iFHe/3YfAZTw4YYUmpUHQp4=
Received: from github.com (hubbernetes-node-7d68445.va3-iad.github.net [10.48.166.45])
	by smtp.github.com (Postfix) with ESMTPA id 145F5780C44
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:55:18 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:55:18 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146225/000000-6ba044@github.com>
Subject: [bluez/bluez] c02b96: sdp-xml: Fix leaking the parse stack on
 malformed ...
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

  Branch: refs/heads/1146225
  Home:   https://github.com/bluez/bluez
  Commit: c02b96cae0449674d4b91b63f7ce08b3847987ff
      https://github.com/bluez/bluez/commit/c02b96cae0449674d4b91b63f7ce08b3847987ff
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  sdp-xml: Fix leaking the parse stack on malformed input

sdp_xml_parse_record() frees its context but never the elements left on
ctx_data->stack_head.

element_end() returns early without popping the stack when it rejects a
document, for instance on a mismatched </sequence> close, so a malformed
record leaves its elements behind and they are never freed.

Free the remaining stack elements before returning. Found with the
compute-seq-size-type-confusion.xml test:

56 (direct) + 1,072 (indirect) bytes in 1 blocks are definitely lost
   at calloc (vg_replace_malloc.c:1678)
   by sdp_xml_data_alloc (sdp-xml.c:73)
   by element_start (sdp-xml.c:473)
   by g_markup_parse_context_parse (gmarkup.c:1369)
   by sdp_xml_parse_record (sdp-xml.c:696)

Assisted-by: Claude:claude-opus-5


  Commit: e176f5bc39751279bbf55d39d198ab3cace18a39
      https://github.com/bluez/bluez/commit/e176f5bc39751279bbf55d39d198ab3cace18a39
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit/test-sdp-xml: Give each test its own test_data

DEFINE_TEST assigned the filename and expected result to a single
test_data and passed its address to tester_add(), so every test shared
one struct and ran with whatever the last registered test left in it.

All the file based tests therefore parsed the same file, and a test
pointing at a file that does not exist still passed.

That in particular meant compute-seq-size-type-confusion.xml, the
regression test for GHSA-7mmr-gwqx-vc34, was never actually parsed, and
passed only because it inherited the expected result of the test
registered after it.

Use an array with one entry per test instead.

Assisted-by: Claude:claude-opus-5


  Commit: 6ba0444e6ae07eeffaff71d4e7c995cff61010a9
      https://github.com/bluez/bluez/commit/6ba0444e6ae07eeffaff71d4e7c995cff61010a9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M Makefile.am
    M lib/bluetooth/sdp.c
    A unit/sdp-xml/alternate.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  sdp: Fix memory leak when freeing alternates

sdp_data_alloc_with_length() stores the members of SDP_ALT8, SDP_ALT16
and SDP_ALT32 in val.dataseq, exactly like it does for the SDP_SEQ8,
SDP_SEQ16 and SDP_SEQ32 sequences.

sdp_data_free() only calls data_seq_free() for the sequences though, so
freeing an alternate frees the alternate itself and leaks every one of
its members, along with anything they own in turn.

Free the members of alternates as well, and add a test parsing a record
containing an alternate, which leaks without this change:

209 (48 direct, 161 indirect) bytes in 1 blocks are definitely lost
   at calloc (vg_replace_malloc.c:1678)
   by sdp_data_alloc_with_length (sdp.c:350)
   by sdp_data_alloc (sdp.c:486)
   by sdp_xml_parse_int (sdp-xml.c:243)
   by sdp_xml_parse_datatype (sdp-xml.c:421)
   by element_start (sdp-xml.c:507)

Assisted-by: Claude:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/c02b96cae044%5E...6ba0444e6ae0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
