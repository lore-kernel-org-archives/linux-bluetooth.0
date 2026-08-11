Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F8357D18
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462983; cv=none; b=FpdxNZIygJAZvbAVXg1tc7sqpc+wehLCGkEoBJZ28ttqlBu1qdI3AnZL8BmLSbUK7KgCqyAUsdVmYcdN9bn+MBEy7DyyKmSrZMzwtIxo4BrfsT1ZjQMCBBSHb37qXyympAqdnLSrT+Jn8VNk+yeYBtKvo+YMYQpFbkVbVb/YX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462983; c=relaxed/simple;
	bh=WOfZFR3/sKKxKyVEZ6YjwX84tx+OYs8HaYYRndFfVoM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GfOGzUalj61/taueeCloQaeMg5e1vNBr3w4zjN5HEq7FH2sRnd9PwX6VAn/lZx+sQ8X5B9pfWr4uRSmCjcsgZ5QcdlgG89r0w6Tebp7YXEAyNOy8i1OsiFcwmvtnbh5b1lMSNibDITjJF1hv3TuG6pibBhOwBv6UpfvzYzUvNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HmyNgePl; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HmyNgePl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786462980;
	bh=iiHJY43B1CEO21OmD5kXA3REyBMJLo8+Pj/vHUDppbI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HmyNgePluWeMguDBfbqO4Qi54S6QlrfEX9kg+JZkFHCT0udjXpIiBQfPHiVFCwMMj
	 EhQUznq2kP2Q3SMFUVI5UP3GLaVznM9G5wSOCACreKYhhESkp7aR4Yp8QnfcK3Rwfd
	 hWsbh1IZYaZfvkSisWC9q+sZzwcP2sgHW83OPX7A=
Received: from github.com (hubbernetes-node-9a88e96.va3-iad.github.net [10.48.137.44])
	by smtp.github.com (Postfix) with ESMTPA id 62755341372
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:43:00 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:43:00 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1144151/000000-ba6f40@github.com>
Subject: [bluez/bluez] 496623: unit: Add test for sdp_xml_parse_record()
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

  Branch: refs/heads/1144151
  Home:   https://github.com/bluez/bluez
  Commit: 496623162109aa1a97bf1a9c8e6049ea21336be8
      https://github.com/bluez/bluez/commit/496623162109aa1a97bf1a9c8e6049ea21336be8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

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


  Commit: 9f971c42f87398dd8e3b701f718c9c3d26549a11
      https://github.com/bluez/bluez/commit/9f971c42f87398dd8e3b701f718c9c3d26549a11
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

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


  Commit: e033e4bf68f71c4c85a78ef3f4adad058b84b3d1
      https://github.com/bluez/bluez/commit/e033e4bf68f71c4c85a78ef3f4adad058b84b3d1
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

  Changed paths:
    A unit/sdp-xml/compute-seq-size-type-confusion.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp-xml type-confusion bug

See https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34

Co-authored-by: Aisle Research


  Commit: fa35605795af977c269e69e8e5830092d91fcbaa
      https://github.com/bluez/bluez/commit/fa35605795af977c269e69e8e5830092d91fcbaa
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

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


  Commit: a851bde7faa851727369bfa6ce01de635ef17b1a
      https://github.com/bluez/bluez/commit/a851bde7faa851727369bfa6ce01de635ef17b1a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

  Changed paths:
    A unit/sdp-xml/duplicate-attribute.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp-xml duplicate attribute bug

See https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc

Co-authored-by: Aisle Research


  Commit: ef4b6f6d4a7db8575b0de9a335e1662b8bf997d0
      https://github.com/bluez/bluez/commit/ef4b6f6d4a7db8575b0de9a335e1662b8bf997d0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

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


  Commit: f48d1c05d77b726065c55c95159046ee7c96e9b9
      https://github.com/bluez/bluez/commit/f48d1c05d77b726065c55c95159046ee7c96e9b9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

  Changed paths:
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for slow element_end() append

This uses 40k iterations as this takes a visible amount of time on a
pretty fast desktop machine (3-4 secs on an i9 9900k).

See: https://github.com/bluez/bluez/security/advisories/GHSA-4p57-mrcv-r2jc


  Commit: c7d0d90bb243435cf6cd4c21ece05ba655eed25e
      https://github.com/bluez/bluez/commit/c7d0d90bb243435cf6cd4c21ece05ba655eed25e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

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


  Commit: ba6f402e19e742a2e364eb006e6602631b3699c8
      https://github.com/bluez/bluez/commit/ba6f402e19e742a2e364eb006e6602631b3699c8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-11 (Tue, 11 Aug 2026)

  Changed paths:
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add convert_sdp_record_to_xml() to SDP XML testing

This tests SDP binary to XML conversion, including whether a fix for
a stack overflow when dealing with large sequences, like in
sequence_on_squared(), works correctly.


Compare: https://github.com/bluez/bluez/compare/496623162109%5E...ba6f402e19e7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
