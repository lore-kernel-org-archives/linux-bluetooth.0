Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76B3F1059
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787952651; cv=none; b=PrgJ28tZYeYCqzUt35o4bZ4f/2G6fcTlx+AEIfU90jD4w4NO9ez8Lgk8SQwQMi6YentOJIZtrSRqxvXgILj6cth+iQH2IpIgEZ4Bj4lY+LF8tNUOwQnI0+uUW79LcpcaIPROmdRmPPuLqu58/zTXxDFBnwJBYqTDnKOO9lBFMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787952651; c=relaxed/simple;
	bh=Xkj9iQQiZUfgRjmWLJhNuZpesDFj1wHtz6GgR9+rg0Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lnVa0oec/9EoWKjfT3dcpTRXljRmihFkV/BRMPMAVWQqTgIcYVxbwXUSBJFY6SSUFjuDkst59t7ii7FmRLloqfvQ0ct2/5fYux2Yr1N1IR+HT2x8MZd4F3UgIm6rABHIqCjMrvfoa3QOR0Wg5Tn6RaIl2GW8MBF7mzq6TePf1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aNryI2u6; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aNryI2u6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787952649;
	bh=e+z8ZnU2aEuxGnNMIbeTeVu05wXIpc1r8e36LRfXbew=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aNryI2u6V+QbZp8o5Kkvu8Fu9mVfrNBeF5TCOlSzzhq7Hpbasy/jIL5fZ/p0zz1z4
	 tzPRKyd8kyGwr11R5jSw2Qiwm+pmwm/flUAOyo0ClXq2lF/S3Wke3NZT0U02f4BIgL
	 nbyfxMnt4eviMKANTY3skCXHeRLgtCJydmmvdIxU=
Received: from github.com (hubbernetes-node-1812d54.va3-iad.github.net [10.48.67.49])
	by smtp.github.com (Postfix) with ESMTPA id 1684928038A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 14:30:49 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:30:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153367/000000-772bf5@github.com>
Subject: [bluez/bluez] c070a1: avrcp: Fix out-of-bounds parsing of
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

  Branch: refs/heads/1153367
  Home:   https://github.com/bluez/bluez
  Commit: c070a1646ae7433456c27781d7f46070f38634e9
      https://github.com/bluez/bluez/commit/c070a1646ae7433456c27781d7f46070f38634e9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-28 (Fri, 28 Aug 2026)

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


  Commit: 617e4424880ac8a4342424dbb75d071970ef6d50
      https://github.com/bluez/bluez/commit/617e4424880ac8a4342424dbb75d071970ef6d50
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-28 (Fri, 28 Aug 2026)

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


  Commit: 772bf5e33c8017cbfdb4df6372f72843836f6c37
      https://github.com/bluez/bluez/commit/772bf5e33c8017cbfdb4df6372f72843836f6c37
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-28 (Fri, 28 Aug 2026)

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


Compare: https://github.com/bluez/bluez/compare/c070a1646ae7%5E...772bf5e33c80

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
