Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A171FECBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075320; cv=none; b=fMXxVVVw6ERt7gILbM47Do87pRA40sNQpJsXx11bAZ5moADzkNXBsnhINWvdC4AFEfcMHcuEDmhK92cgii2GRTG7evm6zUTKPRNSNnjk/MdwHMfdTVbzIl7Tvbm73saRz2lq6ZSRnSJngv0yRN87F4dnhRwMl5x+cNI+6mocPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075320; c=relaxed/simple;
	bh=JE3SmwTkYSiXZiAfUiOVdaPaWE6EM4/aK4tgXbOlYKM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MmQobSYBMVFySptzW65HjR4C0aXwEurloRCVCqs1YS5Gea+Dm9+0ER6aMrR82iDuAwEEjtBxirO4wU9e3A4fU+EnyRCAE8aD23SQDu8svoW090el0w4V9QsGSNLw9aHFmeAmXY0g1y/9y6Xn42B4YXK1ZdyE9mY8cGcGCtZB0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=keckC80o; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="keckC80o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787075318;
	bh=6okbuqmHb/82EmHuFGvWD1R7HaRF5cv5H95Q74JafYo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=keckC80og3a8cKWiVPD+JQUETfkYEUlXsrmfmYaX+kdZmGEZfGDh5W9eQcC4I1kuQ
	 Et+M0W2MpC2rYrSIABbzfSYbTVmM/qimis8HalnghaTAoZLJ6jfZvsURYDB8Y1yHPr
	 KzZxDK368V5oEu03z6MmA8Zygoi7V4u2iE5CIZKU=
Received: from github.com (hubbernetes-node-d36bec0.ac4-iad.github.net [10.52.157.25])
	by smtp.github.com (Postfix) with ESMTPA id 309C9324376
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 10:48:38 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:48:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bd8989-5abc00@github.com>
Subject: [bluez/bluez] b21edc: sdp-xml: Use a queue to collect sequence
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: b21edc49b2c3675c7aea19286fdb2b887f29c0ff
      https://github.com/bluez/bluez/commit/b21edc49b2c3675c7aea19286fdb2b887f29c0ff
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


  Commit: 97521ab4dd79a38b2c30d8d664b4e11f86680e88
      https://github.com/bluez/bluez/commit/97521ab4dd79a38b2c30d8d664b4e11f86680e88
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


  Commit: 078ef10a4531e3fddbac332cf65077f317092555
      https://github.com/bluez/bluez/commit/078ef10a4531e3fddbac332cf65077f317092555
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


  Commit: 5abc0045b84adcb47af26f88f699f33c0037a00c
      https://github.com/bluez/bluez/commit/5abc0045b84adcb47af26f88f699f33c0037a00c
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


Compare: https://github.com/bluez/bluez/compare/bd8989620ed6...5abc0045b84a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
