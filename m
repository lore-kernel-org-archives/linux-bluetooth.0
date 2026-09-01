Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032546AEF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293474; cv=none; b=lKsGgJ3z8yxx4EcXaivyoKisEXW6Pl0LjXk8SwpDFe9thdeOvkE4oFqitnLMf0B3XLD1d579DSyxFVXVHnN1u8y5nPGbzMRHlo0MS2uRHD0Hp51UGCwA2/d5xMGcLWNrltltRKFfryvPq+69DUDww5bnpdp8LktrystuAu4WzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293474; c=relaxed/simple;
	bh=MLLd5cIEJMX83JCO3OFN/1B8phX0yNqW/K9q4DLqOoA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=azqXlwxiNWuPBMWcuk90krj2xOV9/fFRGhUCpfmjcj78VgQ3q2SJbdKkSgS5SrX7IKeEtY5hU3qYX0No7Tw5c4LhInLk5pukI+mJOW87WPn1g+c6rX7fdkuDyP798zy0iGIwhjuQo8LObHTF5VqZwph6qkm9tKmRH1j+Z9Y6rHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A39RiJh0; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A39RiJh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788293467;
	bh=lNLy7ETtXj194M0mb4Ue5XP0tBgqFeT0ZlVarHvmS4o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A39RiJh0Ilzjg9wXKt/gu1pOQ47DMMNHqKhAss8KJjB2QlSiyT21wO+m0MKfQjH9Q
	 36km4FQfrjD5xP3dDnZdeddkqrLFpW5Iaej40dgZrLxmFPXJdMGffJ0T7aipkqu/83
	 jRBOso4XJnPLSy627DSoe96I8t8c+qPYeso0T1XI=
Received: from github.com (hubbernetes-node-c2173a7.ac4-iad.github.net [10.52.125.64])
	by smtp.github.com (Postfix) with ESMTPA id 60D193202F1
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 13:11:07 -0700 (PDT)
Date: Tue, 01 Sep 2026 13:11:07 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1155564/000000-162444@github.com>
Subject: [bluez/bluez] b0c9e9: avrcp: Fix out-of-bounds parsing of
 ListPlayerAttr...
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

  Branch: refs/heads/1155564
  Home:   https://github.com/bluez/bluez
  Commit: b0c9e9fe265cb6f1711ae035abbb7e4f5595e2a9
      https://github.com/bluez/bluez/commit/b0c9e9fe265cb6f1711ae035abbb7e4f5595e2a9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-09-01 (Tue, 01 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response

In profiles/audio/avrcp.c, avrcp_list_player_attributes_rsp() parsed the
response using hand-computed offsets into the operands buffer, without
accounting for the fact that operand_count spans the 7 byte AVRCP header
as well as the parameters:

- attrs is a 4 byte array which could be written out-of-bounds if a
  length greater than 4 was declared in the first parameter byte.

- The attribute bytes were read with a bound derived from operand_count,
  so a truncated response could be read past its end. As the receive
  buffer is reused across packets, those stale bytes could be echoed
  back to the peer in the following GetCurrentPlayerValue request.

- params_len was compared against count, which was only ever 0 at that
  point, so the length of the PDU was in practice never validated.

Parse the response through a struct iovec using the util_iov_pull_*
helpers instead, so that the header and each subsequent field are bounds
checked as they are consumed and the remaining length is tracked for us.
This lets params_len be validated against the actual number of parameter
bytes received. The attribute count is still clamped to
AVRCP_ATTRIBUTE_LAST, which is what bounds the write into attrs.

Reported-by: @ax-nnlabs
Closes: https://github.com/bluez/bluez/security/advisories/GHSA-m2vx-pw5f-rc8v


  Commit: 2eaf3e6b25241cbbd83e7b10945d4cbbb41bbe7a
      https://github.com/bluez/bluez/commit/2eaf3e6b25241cbbd83e7b10945d4cbbb41bbe7a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-01 (Tue, 01 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix out-of-bounds read parsing attribute lists

avrcp_parse_attribute_list() received only a pointer and an attribute
count, with no indication of how many bytes were actually available. For
each attribute it read an 8 byte header followed by a 16 bit length and
that many bytes of value, none of which was bounds checked.

The callers only validated the fixed portion of each entry:

    if (be16_to_cpu(pdu->params_len) - 1 < count * 8)

which says nothing about the variable length values that follow, so a
response declaring a single attribute with a value length of 0xFFFF
would read far past the end of the receive buffer and pass the result to
media_player_set_metadata().

These are response callbacks, so they do not go through
handle_vendordep_pdu() and params_len had itself never been checked
against the number of bytes received. avrcp_get_element_attributes_rsp()
also cast the operands to an AVRCP header without checking that a full
header was present.

parse_media_element() had a related off-by-one, reading the attribute
count at operands[13 + namesize] when parse_media_name() only
guaranteed that 13 + namesize bytes were present.

Parse all of this through a struct iovec using the util_iov_pull_*
helpers so the remaining length is tracked as each field is consumed,
and validate params_len against the bytes actually received.


  Commit: 64ff1336995d76fda6baa71560ceddaa7dfdad7e
      https://github.com/bluez/bluez/commit/64ff1336995d76fda6baa71560ceddaa7dfdad7e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-01 (Tue, 01 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Use util_iov helpers to parse responses

Every controller side response callback parsed the PDU with hand
computed offsets into the operands buffer. None of them validated the
declared parameters length against the number of bytes actually
received: unlike commands, responses do not go through
handle_vendordep_pdu(), so nothing did it on their behalf. Several read
past the end of the receive buffer as a result, for example:

- avrcp_get_capabilities_resp() read pdu->params[1 + count] for a count
  taken from the response itself, with no length check at all, and then
  shifted by the resulting event id without bounding it.

- avrcp_player_value_rsp() bounded its loop with

      if (pdu->params_len < count * 2)

  comparing a big endian field without byte swapping it, so on little
  endian the check passes for practically any value.

- avrcp_get_play_status_rsp() only checked params_len, which is supplied
  by the peer, and read nine bytes on the strength of it.

- avrcp_set_browsed_player_rsp() indexed folder names relative to
  pdu->params but bounded them against operand_count, which also spans
  the browsing header.

Add avrcp_pull_header() and avrcp_pull_browsing_header(), which pull the
respective header out of a struct iovec and check that the length it
declares matches what was received, and convert the response callbacks
to pull their fields with the util_iov helpers so the remaining length
is tracked as it is consumed.

Since the receive buffer is reused between packets, the bytes read past
the end of a short response were the contents of an earlier PDU, some of
which were then reported over D-Bus or echoed back to the peer.


  Commit: 2cbe3dd36da8f8de0ffa18afc4ec19302323129c
      https://github.com/bluez/bluez/commit/2cbe3dd36da8f8de0ffa18afc4ec19302323129c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-01 (Tue, 01 Sep 2026)

  Changed paths:
    M Makefile.plugins
    A profiles/audio/avrcp-parse.c
    A profiles/audio/avrcp-parse.h
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h

  Log Message:
  -----------
  avrcp: Move response parsers to avrcp-parse.c

The parsing of controller side responses lives in the middle of
avrcp.c, interleaved with the media_player and D-Bus glue that consumes
its results. That makes it unreachable from the unit tests: none of it
can be called without an adapter, a device, a service and a session.

The three preceding fixes were all in this code, and none of them could
be covered by a regression test as a result.

Move the parsing proper to a new avrcp-parse.c, which depends on
nothing but util_iov and log.h:

- avrcp_pull_header() and avrcp_pull_browsing_header()
- avrcp_parse_player_attributes(), which now takes the bound on the
  attribute array from its caller
- avrcp_parse_attribute_list(), which reports each attribute through a
  callback rather than calling media_player_set_metadata() itself
- avrcp_parse_media_name(), avrcp_parse_media_element() and
  avrcp_parse_media_folder(), which fill a plain struct rather than
  creating media items

struct avrcp_header, struct avrcp_browsing_header, NAME_MAX_LEN and the
player attribute ids move to the new header, which avrcp.h now includes
so that its users are unaffected.

The logic is unchanged; avrcp.c keeps the glue as thin wrappers.

Assisted-by: Claude:claude-opus-5 valgrind


  Commit: 162444ac72084c5841f278c1749ed5e83c88056c
      https://github.com/bluez/bluez/commit/162444ac72084c5841f278c1749ed5e83c88056c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-01 (Tue, 01 Sep 2026)

  Changed paths:
    M Makefile.am
    M unit/test-avrcp.c

  Log Message:
  -----------
  unit/test-avrcp: Add robustness tests for response parsing

The existing tests drive avrcp-lib.c through the AVCTP harness and all
feed it well formed PDUs. Nothing covered what happens when a peer
sends a response that lies about its own length, which is what the
three preceding fixes were about.

Add tests under /robustness that call the parsers in avrcp-parse.c
directly, since a response is entirely peer controlled and the parser
is what has to survive it:

- headers that are short, that declare more parameter bytes than were
  received, and that declare fewer

- a ListPlayerApplicationSettingAttributes response declaring 255
  attributes, which used to be written into a four byte array, and one
  declaring more attributes than it carries

- attribute lists declaring a 0xFFFF byte value with none of it
  present, a truncated value, a truncated attribute header, and more
  attributes than were received

- media elements missing the attribute count that follows the name,
  carrying a name longer than NAME_MAX_LEN, or declaring a name that is
  not there, and the equivalent for media folders

Each PDU is copied into a buffer of exactly its size, so that reading
past the end of it is an out-of-bounds access rather than a read of
whatever the receive buffer happened to hold beforehand, and the
attribute array is surrounded by a guard so that a write past its end
is caught without a sanitizer.

Reverting the three fixes fails ten of these outright and trips
valgrind on six more.

Assisted-by: Claude:claude-opus-5 valgrind


Compare: https://github.com/bluez/bluez/compare/b0c9e9fe265c%5E...162444ac7208

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
