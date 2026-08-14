Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1B477E31
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730462; cv=none; b=B5JnGr0QkxVS08xAU49YvPv20DgkrRo+KyXXRjX3093feMvLuLBGaf4au7bLoTDTJF47I2fbgRetrYbh0YiGMJgIKTXjCxmkNInzS3J43EubkYrBFlT5P91gSt5xmlJSLbfXmahImxkDJJWOpynoesFMRWP3gQ6A/XqbeXXuOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730462; c=relaxed/simple;
	bh=OPy5BiKD7j1Wxvb2pVFhK1ytjZCrgNMfKNAcGC5HHI4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RNxZf//muFu36GBfqpW0+6Ukp1OOuhiEyBZK/UJQYfrUlXTwMW474AKrIAbWmNMTtluw8aEHRblsZ+RWTF3HF0efPOObyScD1BkNusIn6WANlirlUFBEc725OpZxuvkXERWOj+Pj47OEmcvshDNQcZzbzWdhbiOqTVFiQeFv12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R9Wq/MvG; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R9Wq/MvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786730460;
	bh=oUAaQ9ZlAu6rfUPW/BY299Pr8mcn4RQ5B1RuoJEjZHQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R9Wq/MvGnSX0j5xLG9woCBF9s4GzWabYvxq98mx14aZlWoekGaCMimEF7fc3MeC/F
	 Sycn9CkW/S4MjakAamFbyLA3I6sJ84Dwz1Pb7bTGM1aJW0XJxVx4CwywJ2cL7KE6m/
	 My7YJVumILCXVI/Fn77RXVnpyv4D0sU8/iKqMNcU=
Received: from github.com (hubbernetes-node-6044380.ash1-iad.github.net [10.56.196.46])
	by smtp.github.com (Postfix) with ESMTPA id 34A9E6006B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:01:00 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:01:00 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/10df0b-bd8989@github.com>
Subject: [bluez/bluez] e55ff8: unit: Add test for sdp_xml_parse_record()
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
  Commit: e55ff8818f722dfbefc62b9646f69bad19014fdd
      https://github.com/bluez/bluez/commit/e55ff8818f722dfbefc62b9646f69bad19014fdd
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/Bluetooth_HID-sdp_record.xml
    A unit/sdp-xml/qt-SerialPortSDPRecord.xml
    A unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp_xml_parse_record()

This adds 2 example XML files from other repositories, under a fair use
license exception.
Reported-by: Aisle Research
Reported-by: Aisle Research


  Commit: 985e643d78b09afc81d606bc0a08581fc05b1b15
      https://github.com/bluez/bluez/commit/985e643d78b09afc81d606bc0a08581fc05b1b15
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML

When element_end() processes </attribute>, it frees ctx_data->stack_head
and clears the stack even if parsing is still nested inside a parent
container.

If a crafted ServiceRecord places a nested <attribute> inside <sequence>,
a later sibling scalar element such as <uint64> can become the new stack
head. When the closing </sequence> is then processed, compute_seq_size()
is reached without first validating that the current node is actually
a sequence.

sdp_data_t.val stores both scalar members such as uint64 and the
dataseq pointer in the same union. As a result, attacker-controlled
scalar data can be reinterpreted as a linked-list pointer and traversed
until bluetoothd crashes.

See https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34

Reported-by: Aisle Research
Co-authored-by: Aisle Research


  Commit: a92683ce81ab92cd7dffd3350284579fbe0d4c30
      https://github.com/bluez/bluez/commit/a92683ce81ab92cd7dffd3350284579fbe0d4c30
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/compute-seq-size-type-confusion.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp-xml type-confusion bug

See https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34

Co-authored-by: Aisle Research


  Commit: ae6c543e892f1fc55d16584ce1ef02e1969352af
      https://github.com/bluez/bluez/commit/ae6c543e892f1fc55d16584ce1ef02e1969352af
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  sdp-xml: Fix memory leak when adding duplicate attributes

When sdp_attr_add() fails because an attribute is duplicated, don't
unset its pointer in the parsing context data. As the attribute wasn't
added to the record, the ownership of the attribute didn't get passed
to the record either.

Don't set the pointer to NULL so it gets freed when cleaning up the
context.

Fixes those 2 ASan warnings:
Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #1 0x562042b747f2 in sdp_data_alloc_with_length lib/bluetooth/sdp.c:350

Indirect leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #1 0x562042b74bd7 in sdp_data_alloc_with_length lib/bluetooth/sdp.c:425

See https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc

Reported-by: Aisle Research
Co-authored-by: Aisle Research


  Commit: ab91b45282297e052b2e3be22c198265d19ac097
      https://github.com/bluez/bluez/commit/ab91b45282297e052b2e3be22c198265d19ac097
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/duplicate-attribute.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp-xml duplicate attribute bug

See https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc

Co-authored-by: Aisle Research


  Commit: 308e3536688c0011e11b2d9bfdc94cb38e52c060
      https://github.com/bluez/bluez/commit/308e3536688c0011e11b2d9bfdc94cb38e52c060
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  sdp-xml: Optimise parsing large sequences

SDP sequences are stored as single-linked lists, so appending members
to a sequence requires finding the tail of the list before the
insertion.

Finding the tail of the list always starts at the beginning of the list,
so takes longer and longer as the list grows bigger.

Keep track of the tail to avoid that problem. This cuts down the
sequence_on_squared() test from around 3 to 4 seconds to less than
0.1 seconds.


  Commit: 95fa5735562e9f020c174199f19016cbb1c09ff2
      https://github.com/bluez/bluez/commit/95fa5735562e9f020c174199f19016cbb1c09ff2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for slow element_end() append

This uses 40k iterations as this takes a visible amount of time on a
pretty fast desktop machine (3-4 secs on an i9 9900k).

See: https://github.com/bluez/bluez/security/advisories/GHSA-4p57-mrcv-r2jc


  Commit: e9caa7d3e2bf746203348e50654e7758fc84285d
      https://github.com/bluez/bluez/commit/e9caa7d3e2bf746203348e50654e7758fc84285d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  sdp-xml: Fix stack overflow when converting large sequences to XML

Don't make convert_raw_data_to_xml() call itself recursively X times
if there are X elements in a sequence.

AddressSanitizer:DEADLYSIGNAL
=================================================================
==1684518==ERROR: AddressSanitizer: stack-overflow on address 0x7fff7fb40d98 (pc 0x7fbe1ee95c2b bp 0x7fff7fb41610 sp 0x7fff7fb40d70 T0)
    #0 0x7fbe1ee95c2b in printf_common(void*, char const*, __va_list_tag*) (/lib64/libasan.so.8+0x95c2b) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #1 0x7fbe1eeb72d6 in vsnprintf (/lib64/libasan.so.8+0xb72d6) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #2 0x7fbe1eeb94f4 in snprintf (/lib64/libasan.so.8+0xb94f4) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #3 0x000000401fc2 in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709
    #4 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994
[...]
    #246 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994

SUMMARY: AddressSanitizer: stack-overflow ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709 in convert_raw_data_to_xml


  Commit: d01ba78b1d8a3294f82ae003479c922e1499ed49
      https://github.com/bluez/bluez/commit/d01ba78b1d8a3294f82ae003479c922e1499ed49
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add convert_sdp_record_to_xml() to SDP XML testing

This tests SDP binary to XML conversion, including whether a fix for
a stack overflow when dealing with large sequences, like in
sequence_on_squared(), works correctly.


  Commit: 5cf94acaea718d1955d4bcc16dea57f31fae14ad
      https://github.com/bluez/bluez/commit/5cf94acaea718d1955d4bcc16dea57f31fae14ad
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/adv_monitor.c

  Log Message:
  -----------
  adv_monitor: Fix buffer overflow caused by integer overflow

In src/adv_monitor.c, merged_pattern_send_add_pattern(), and with a
large merged_pattern->patterns list, it's possible to overflow cp_len,
an 8-bit integer:
pattern_count = queue_length(merged_pattern->patterns);
cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);

Eight patterns require 273 bytes of command storage, but assigning
that result to uint8_t cp_len wraps it to 17 before allocation.

The loop that follows does not use the truncated size; it still copies
all eight 34-byte struct mgmt_adv_pattern records into the heap object.
The mismatch between the wrapped allocation size and the full copy
volume produces a large, deterministic heap overwrite.

Fix this in 2 ways in the function itself:
1) increase the size of cp_len, as 8 patterns would overflow it, and some
   typical Bluetooth devices can support 16 patterns
2) Store the result of the multiplication in a 64-bit integer before
   checking whether it's bigger than our 16-bit cp_len

A similar bug exists in merged_pattern_send_add_pattern_rssi().

Reported-by: @ax-nnlabs (for merged_pattern_send_add_pattern())
Reported-by: Aisle Research (for merged_pattern_send_add_pattern_rssi())
Reported-by: @ax-nnlabs (for merged_pattern_send_add_pattern())
Reported-by: Aisle Research (for merged_pattern_send_add_pattern_rssi())


  Commit: 14347c86fb999416959720fd844427d02e241ba8
      https://github.com/bluez/bluez/commit/14347c86fb999416959720fd844427d02e241ba8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/adv_monitor.c

  Log Message:
  -----------
  adv_monitor: Ignore additional patterns past what's supported

Ignore patterns beyond what the adapter supports.

Suggested-by: Aisle Research


  Commit: a01be7144cd89e3c76618409fce40c2a9b5785db
      https://github.com/bluez/bluez/commit/a01be7144cd89e3c76618409fce40c2a9b5785db
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M attrib/interactive.c

  Log Message:
  -----------
  attrib: Fix smatch "non-ANSI function declaration" warning

attrib/interactive.c:175:27: warning: non-ANSI function declaration of function 'disconnect_io'


  Commit: bd8989620ed6e80755f06cfdb18f5b4a3913493c
      https://github.com/bluez/bluez/commit/bd8989620ed6e80755f06cfdb18f5b4a3913493c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

If the "Displayable Name Length" is much longer than the size of the PDU
packet we receive, then we might try to memcpy() past the end of the PDU
packet.

Be careful about clamping the name copying to the smallest of:
- length specified in the PDU
- left-over packet after the length field
- size of the string we'll copy it into

Reported-by: Elman Shahbazov <shahbazovelman97@gmail.com>


Compare: https://github.com/bluez/bluez/compare/10df0bb74844...bd8989620ed6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
