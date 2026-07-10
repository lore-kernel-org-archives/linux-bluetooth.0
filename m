Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8632376466
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704344; cv=none; b=gph6KA3s3wMWGXBd7xvvDbt7byU8elXLogof0zhNzHcNfNm2/RktPefkBIlTsYg/jpZYgKQqBwZiVJtdDLnlmS+XJikwTnCoUa12loUY9t1K1GmfXRHfTp3iO6WEjSwVgxEeocPqxsXd4fbhSXy1ryPQ/y6dIcJt29RzdVJgwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704344; c=relaxed/simple;
	bh=YH7X6ElN9X2jkehmYlZIOO+t5qUfFDgLCfS8uwE4vQw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RNhnkp9KJWn0hOUjLIlZ3IJzKe8vS+NbbyZvPvWdmWqjI8qV6t8KntPAHRDGm/sARHm+E2rhS8iwwcjZqBQyfom1u6O8fJQpZyndk938LrfD+QJD/i4n4NwuiifuLwk0ROfDFOPnfr/MD7F37XJHfMJARqKHngmn1eSESUAlico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TPnTKGfk; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TPnTKGfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783704340;
	bh=Iyp62HL7LsBuxTsgcx4EA4J5h4LqJVPjkgj8duKWRFc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TPnTKGfkQYIjctcPlwK6NDj7ao5V9KDPip2k/j/vGVWbhI/UFdW80lykV5YEgY89m
	 NExiSz8mlmdIfz9z7IwV0BPsCRiBzliDRXhUJWqcvOoO3+D9wJfhlLnLt3jpCZMAYv
	 sBfPe2Z+e68E5408aJRyjU7QvDsQKTYrWPubS6Vo=
Received: from github.com (hubbernetes-node-ca05332.va3-iad.github.net [10.48.174.43])
	by smtp.github.com (Postfix) with ESMTPA id ADD4C781268
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 10:25:40 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:25:40 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125495/000000-9e3c1d@github.com>
Subject: [bluez/bluez] 5051e5: lib: add iso_data_* macros to hci.h
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

  Branch: refs/heads/1125495
  Home:   https://github.com/bluez/bluez
  Commit: 5051e5a45f44cceaef0cb1bff87fb52c126571f9
      https://github.com/bluez/bluez/commit/5051e5a45f44cceaef0cb1bff87fb52c126571f9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M lib/bluetooth/hci.h

  Log Message:
  -----------
  lib: add iso_data_* macros to hci.h

Add macros for parsing ISO Data Packet header items.


  Commit: 9e3c1d50e95b0013587f4a8fdbb71ee524beb507
      https://github.com/bluez/bluez/commit/9e3c1d50e95b0013587f4a8fdbb71ee524beb507
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: fix parsing of ISO packet data header and slen check

Check PB flag to see whether timestamp and data headers are present.

Check bounds before accessing data. Bump handle_str length to fit
maximum.

Byteswap length values, and mask Packet_Status_Flag correctly.  Remove
SDU length check, as we are not tracking fragmentation.

Fixes: https://github.com/bluez/bluez/issues/2292
Assisted-by: GLM-5.2


Compare: https://github.com/bluez/bluez/compare/5051e5a45f44%5E...9e3c1d50e95b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
