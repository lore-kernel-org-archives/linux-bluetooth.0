Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9044236B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001686; cv=none; b=W/0C3MONL7UwRWsoAyXQ/T9wKY4F+OwcqohSZs3hI4iEdHfFnuYXqG9tjm4zCwLHwzf6H56SzpsU7boA7Mb0fnljz6Cp9dA7MGSHpd7V0+UNr0o7bD1up619KcKDrnYigVvaxVHDRK0tUw3765jBsGua4WjOcxDq6z7Seoh3hlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001686; c=relaxed/simple;
	bh=YcneA1jKCpvRRmH+HIBx4+ffcz8VAo4ugS/8Ckq0gHY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IXfTmJhqShBDUo0cgIMIULknRHnxbWvab6/s6Et9WFpP8Lgi8Y58avtY56oOFqc60hXUbhtIl04mDZcKlJX3SNuooysj8SH1T39jkl8an//dth8XQvQ8G+Guq92GTq6VuaxlmR0Vem6+0Xjfip1K7JilQdMLHeJ9ahmFm3y9XL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E4Uq4Ckr; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E4Uq4Ckr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787001684;
	bh=XM7mtqtItnvxQSSSvyaIEp+0clcvbMqejqWQJQPvTSg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E4Uq4CkrT+sOMn7D9uu0ZiOjkd0ejl2uR6kU9+GDVwf9Cev9HQ5OUqzk5E/k6A1cv
	 cI61Es0YTcMVl/phFHME/Xw1ywrGGznCZUu1KZwgPWB/sCCErYCzY2gFq+baD9oLb9
	 pyoVZDvCAFIYVIbLhUKW1qfAqqZOOtelLtG7aue4=
Received: from github.com (hubbernetes-node-26eef6d.ac4-iad.github.net [10.52.200.86])
	by smtp.github.com (Postfix) with ESMTPA id 77D13A1348
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:21:24 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:21:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147412/000000-1734f8@github.com>
Subject: [bluez/bluez] ce71b6: sdp-xml: Use a queue to collect sequence
 members
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

  Branch: refs/heads/1147412
  Home:   https://github.com/bluez/bluez
  Commit: ce71b6e2e3a02cf1b61f9b5014c9e1d561cf866d
      https://github.com/bluez/bluez/commit/ce71b6e2e3a02cf1b61f9b5014c9e1d561cf866d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-17 (Mon, 17 Aug 2026)

  Changed paths:
    M Makefile.tools
    M src/sdp-xml.c

  Log Message:
  -----------
  sdp-xml: Use a queue to collect sequence members

Appending a member to a sequence with sdp_seq_append() walks the
single-linked list to find its tail, so building a sequence is O(n^2).

This was previously worked around by caching the tail of the sequence in
struct sdp_xml_data, which required the caller to pick between appending
to the cached tail and initialising val.dataseq, and to keep the cache in
sync on every append.

Collect the members in a struct queue instead, which tracks its own tail,
and link them into val.dataseq once the element is closed. Appending is a
plain queue_push_tail(), and the queue is destroyed along with the rest
of the element so members that were never linked, such as on malformed
input, are still freed.

The sequence_on_squared() test stays at less than 0.1 seconds.

Assisted-by: Claude:claude-opus-5


  Commit: fc82acdc01817afeeb49c77eaadbc0183ce80419
      https://github.com/bluez/bluez/commit/fc82acdc01817afeeb49c77eaadbc0183ce80419
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-17 (Mon, 17 Aug 2026)

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


  Commit: 0dff667332abf5cbb8f3acf7cb8ad3d3294375bb
      https://github.com/bluez/bluez/commit/0dff667332abf5cbb8f3acf7cb8ad3d3294375bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-17 (Mon, 17 Aug 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: Fix memory leak when freeing alternates

sdp_data_alloc_with_length() stores the members of SDP_ALT8, SDP_ALT16
and SDP_ALT32 in val.dataseq, exactly like it does for the SDP_SEQ8,
SDP_SEQ16 and SDP_SEQ32 sequences.

sdp_data_free() only calls data_seq_free() for the sequences though, so
freeing an alternate frees the alternate itself and leaks every one of
its members, along with anything they own in turn:

209 (48 direct, 161 indirect) bytes in 1 blocks are definitely lost
   at calloc (vg_replace_malloc.c:1678)
   by sdp_data_alloc_with_length (sdp.c:350)
   by sdp_data_alloc (sdp.c:486)
   by sdp_xml_parse_int (sdp-xml.c:243)
   by sdp_xml_parse_datatype (sdp-xml.c:421)
   by element_start (sdp-xml.c:507)

Free the members of alternates as well.

Assisted-by: Claude:claude-opus-5


  Commit: 1734f8310b83022a02c6aef679905cff3a4b39fb
      https://github.com/bluez/bluez/commit/1734f8310b83022a02c6aef679905cff3a4b39fb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-17 (Mon, 17 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/alternate.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit/test-sdp-xml: Add a test parsing alternates

None of the existing records contain an <alternate>, so nothing covered
the SDP_ALT8, SDP_ALT16 and SDP_ALT32 handling.

Add a record with an alternate holding an integer, a string and a nested
sequence, which leaks its members under valgrind without the previous
sdp_data_free() fix.

Assisted-by: Claude:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/ce71b6e2e3a0%5E...1734f8310b83

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
