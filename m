Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C444EB38
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944590; cv=none; b=hXvsEpgo34dC9Nl8Yg4WzytQZmfGwfO1umP/btFazwxFnI3tJoSxq/NOuxqyGZoaHF08AL1OFYVn4WcJk0g6XyBLH0SZjkcBzrUaqlXhjmRQa2vkQXxjs0wlU/UD6G/zTdEgmObjJTb+v2lbDrfHg8Fu9V1V8k88pnyrDXgXnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944590; c=relaxed/simple;
	bh=FrFmmrXCV2MTjYXGQfja1c1b7Lfw8nhc3tEG+q5PAzo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uTeaKeISVxQYzccnW4XW+VXei6bWcKx6PHmSyxbCANBEinaNEcx7kr3AlDaui53FGHIWsSZkmW+xI5yY4XX8wCrHXAYPKxQ9eC62naYM+ap5DtHCDH3s+sYo65DJXSaplmJ+rthxlP3w9pVCj1gFICJc7ouPy9ewVwbh4sESH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RTqisynJ; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RTqisynJ"
Received: from github.com (hubbernetes-node-3294be7.ash1-iad.github.net [10.56.159.37])
	by smtp.github.com (Postfix) with ESMTPA id EDE48600311
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754944587;
	bh=s4kZwxWkwy/MWQdxn7nxaPxdOFS6jSTjJK/bcpBqzi4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RTqisynJ5w1z5ifrmgmv62EamT9ZwUO416LdZkfB3AfSFZmRgiBkZbUtRdb6eHspY
	 DhJsGxuo3cPD5/Yd1z5p9F5srOzetJXqZKpt8LzTb2erYeBRV4nK2jZ2ZuTBuNYCQ+
	 svD1H5GYFqZo1UdM9bSLGNMpRVeQt2ky41/JHsMk=
Date: Mon, 11 Aug 2025 13:36:27 -0700
From: Oliver Chang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5ccbff-013b34@github.com>
Subject: [bluez/bluez] bf5ec1: bap: remove bap_update_cigs callback properly
 whan...
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
  Commit: bf5ec167b66fc40f7c5f3abca58752fee0d4153b
      https://github.com/bluez/bluez/commit/bf5ec167b66fc40f7c5f3abca58752fee0d4153b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: remove bap_update_cigs callback properly whan data is freed

setup_free() may re-enable the CIG update callback. If this occurs in
bap_data_free(), the callback crashes with UAF.

Fix by moving clearing the callback after all setups are freed.


  Commit: 013b3431c58d81e9e01dac7e8a5d088e357326a3
      https://github.com/bluez/bluez/commit/013b3431c58d81e9e01dac7e8a5d088e357326a3
  Author: Oliver Chang <ochang@google.com>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  Fix buffer overflow in sdp_xml_parse_uuid128

This was found by OSS-Fuzz.

This can be reproduced by running this input:
`<uuid value="111111111111111111111111111111111111">`
against the harness in
https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c
which just calls `sdp_xml_parse_record`.

`sdp_xml_parse_uuid` checks that the length of the string is 36 (32
digits + 4 '-' characters) prior to calling `sdp_xml_parse_uuid128`.

There's no check preventing this data from being 36 digits (with no
"-"), which leads to a buffer overflow in sdp_xml_parse_uuid128.

https://issues.oss-fuzz.com/issues/42534847
https://oss-fuzz.com/testcase-detail/5070205940531200


Compare: https://github.com/bluez/bluez/compare/5ccbff0898fa...013b3431c58d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
