Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D27837206F
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524794; cv=none; b=m55QcmJ8JrIalmlReKUxjB2kaQn2uZjfxBB7C0AS2VW4OrrwEConGCD653J1h8zqF2Ph5d7mhCGDZGv5dXoRIEk4nCd+JHYg/wZ10IZOt+o54Cmar4r1hTuk0/xBtDepO6mSZ99jYJMFMs/3zGD3Z/V4HyYFcJjCiOcLV2PQGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524794; c=relaxed/simple;
	bh=ve5vcp9BJ2aa6KnM67ZBsnkb2sbX6EEgNUAFPLLP6vI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RmHIH2YHyV6zxpUuCPOOVQDTfuDUGAmxUibivOViZmgDbHBDkkiv96gR35JPkd5oYxIc6dR5dO2QoYF13GcjPOiAJNnqA6sVnqcwQ5ZibOIZf1tIULS7OFDj7O5Jba3oU02tEGVwyUdPKa+8Kd2ly4xY+eVZRENkGePp9pBgjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=StYVJxHZ; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="StYVJxHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786524792;
	bh=JmbxY5lFsR9WIEaoE5/A5wkmm0OYYrEDofh14AGKB84=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=StYVJxHZF+nbr3B4Q6WGD6y2sPvsvsLFwfDi8CK5RNLLBJytQpIvkiKJQHlUK909Q
	 QbI3MNOsbxppsyZVxC8qiQ4wRAgYA3G4KYdYZ2FzVtssZRYtXoeW/moG+obtEpzD2P
	 QjT1HFGifb1HZyEH6QPgnoWs8e6KdtH987jTQePk=
Received: from github.com (hubbernetes-node-895afa7.ash1-iad.github.net [10.59.92.25])
	by smtp.github.com (Postfix) with ESMTPA id 6C17584121F
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 01:53:12 -0700 (PDT)
Date: Wed, 12 Aug 2026 01:53:12 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1144549/000000-7551c6@github.com>
Subject: [bluez/bluez] 9e504d: unit: Add test for sdp_xml_parse_record()
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

  Branch: refs/heads/1144549
  Home:   https://github.com/bluez/bluez
  Commit: 9e504ddc8bdc34b9dcdf10982c69f7dcab5cea70
      https://github.com/bluez/bluez/commit/9e504ddc8bdc34b9dcdf10982c69f7dcab5cea70
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

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


  Commit: 7074b7d01e015769651701d893983121b7425697
      https://github.com/bluez/bluez/commit/7074b7d01e015769651701d893983121b7425697
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

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


  Commit: a94a2ccddc2aae7381a0c405e1e23c22aba1c19c
      https://github.com/bluez/bluez/commit/a94a2ccddc2aae7381a0c405e1e23c22aba1c19c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/compute-seq-size-type-confusion.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp-xml type-confusion bug

See https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34

Co-authored-by: Aisle Research


  Commit: 406953a2229a3a86f07d9c7925f9c0cf88809ef4
      https://github.com/bluez/bluez/commit/406953a2229a3a86f07d9c7925f9c0cf88809ef4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

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


  Commit: 0448df4549fbe82371d4b05ffd5f02b29ee170a6
      https://github.com/bluez/bluez/commit/0448df4549fbe82371d4b05ffd5f02b29ee170a6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/duplicate-attribute.xml
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp-xml duplicate attribute bug

See https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc

Co-authored-by: Aisle Research


  Commit: cd6432449149171235b1fb556a3b7db4cf3f31e2
      https://github.com/bluez/bluez/commit/cd6432449149171235b1fb556a3b7db4cf3f31e2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

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


  Commit: 6f3ce91d1f7a3b79bbd2d25a68b53ea8b2da4fee
      https://github.com/bluez/bluez/commit/6f3ce91d1f7a3b79bbd2d25a68b53ea8b2da4fee
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for slow element_end() append

This uses 40k iterations as this takes a visible amount of time on a
pretty fast desktop machine (3-4 secs on an i9 9900k).

See: https://github.com/bluez/bluez/security/advisories/GHSA-4p57-mrcv-r2jc


  Commit: 0aec92f6bec3ba46abe27e5dab87ba514d0e4555
      https://github.com/bluez/bluez/commit/0aec92f6bec3ba46abe27e5dab87ba514d0e4555
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

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


  Commit: 7551c6e5a358c33f8d8b8665fd0b5a9bd71f4309
      https://github.com/bluez/bluez/commit/7551c6e5a358c33f8d8b8665fd0b5a9bd71f4309
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add convert_sdp_record_to_xml() to SDP XML testing

This tests SDP binary to XML conversion, including whether a fix for
a stack overflow when dealing with large sequences, like in
sequence_on_squared(), works correctly.


Compare: https://github.com/bluez/bluez/compare/9e504ddc8bdc%5E...7551c6e5a358

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
