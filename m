Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FE4E77F9
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557456; cv=none; b=c3RNkgDP6naQrXLXPXlHvpsNChX7GmRkqwjFzW89FhLJCtrzgWITzymu3wV6AIFGBraSQz3uSEoWRKgP8B3nPcHOca07le7wSSMsdgxQTyQg2dF1xB94Ig4tUsoeTeY4AhVjj4KVxKj/cCXNQsgAZSfLn0AxvO4RFdyyVha8qBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557456; c=relaxed/simple;
	bh=I8Wt0vMo/AsQ/QfEnVRswzy44NXrVJ53xR4mF/BNMoU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bZciJxANdZFmtAdc15BuOq6TFD3ubpHkJY6sOfEoqhHFCaRobQ0ax6Dg1i9eKLDCxBMXpgqzK8xFAjT4JNkbHZSn7H5cNy8v88FD4nRcmoWo9bHfZnmzwWd5z8oFI6RHHdiYrl9LAdKbxXVCmC1IAdFlzLOtAzynn0xWIKFlzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=nAhRnmDB; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="nAhRnmDB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791557454;
	bh=s5EqTZd7ixdV3vlwEXi8vo4EHQgm1Iw9gIz9Z5PnQt4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nAhRnmDBCNOfBQMO8FYvO60zys8FJqnw2ewH4tTyKbICPN+GBQ94rZOClTdGX9Sne
	 cc7u/vewk1z9gcdu/YvJOkobg/jQNWCR1iQyUWgFylYuwluNRAxTJSJoFFJjdcuPKy
	 xtkzboD9jAL5bSTwrZZUx1pKUdQOdW0jlP3RWvC8BnGRrjzDjE8zPe+Mpx+/z6Wkol
	 WgL6+5HDW94pJT0kEOs+G8oGH6nWHiGzdmtEGsiYQb/+G2SfwCqk+ipP8mUbK71PuN
	 l19yLlrymgbDfV79RdDTgcCzIivZBVe2xyORpfeTyPgEJZxUYcanQUOs50Nkh3yg6D
	 4JKRf6nYzvH5Q==
Received: from github.com (hubbernetes-node-e4d2108.va3-iad.github.net [10.48.66.70])
	by smtp.github.com (Postfix) with ESMTPA id EFC918013C8
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 07:50:54 -0700 (PDT)
Date: Fri, 09 Oct 2026 07:50:54 -0700
From: Jan-Michael Brummer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182479/000000-5a07c6@github.com>
Subject: [bluez/bluez] 5a07c6: Add cover art support
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

  Branch: refs/heads/1182479
  Home:   https://github.com/bluez/bluez
  Commit: 5a07c682d304e7566f3b073733a043ed684945f3
      https://github.com/bluez/bluez/commit/5a07c682d304e7566f3b073733a043ed684945f3
  Author: Jan-Michael Brummer <jan.brummer@tabos.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M Makefile.obexd
    M lib/bluetooth/uuid.h
    A obexd/plugins/bip-avrcp.c
    M obexd/plugins/bluetooth.c
    M obexd/src/obex-priv.h
    M obexd/src/obex.c
    M obexd/src/obex.h
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  Add cover art support

Add bluetooth cover art support based on the existing code.
Tested with VW head unit and Fairphone 5.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
