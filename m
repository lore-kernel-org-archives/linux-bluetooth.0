Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EC331200
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974945; cv=none; b=Unk+ZHnZFIetE0ihRdV/WlzKN5mRi3TE2UCk60S7i3xQdTP/A/KpIoqgQKsWD+LCG8FKInW1xEBWTycdPyKGYunpi5vB8ENF5eh0Nt02hjIZkDJ0YUZdkBwgV1dx59DRbfUrXMlWhcZzcb/2vNYMOLt1LhDculqmDk8CW5JHbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974945; c=relaxed/simple;
	bh=Yphq4x7SFp3eG4MsEbNqtHdmkM9kwCaW03QybnZaEjA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E5ng7W3lFHR+mmoBPWaZI3fZ+kbe+dGbaasOn1ebAqr0xh4+cBq3Kl4Jr4YmTP6Bcf6vihUdT8E5Hsc793qcZShJ/yoNgdofQD3IW/6/8soLEVYKvmGRssYkcv7JZz5bYf/h2bQu7QHpiP9o7euQdR9o90uHd71m3WasX59xpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=E7eYM/Ol; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="E7eYM/Ol"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790974943;
	bh=FoorN8f5yR3Ql6YzVhMJyiOCFEYIMYh61XT9xZtwtk0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E7eYM/OlT9COmn9rg6Lwtio3pJxWEeAKTCWlwQAUDax+Vp8zji4YBS711FvW92PI5
	 ah/hgPMs3blM9ZsrBv7Gikeso9J0gwCokCHzUht+QHDmQNvZ5V+0/+hVaiyTDB5kSZ
	 ZyZy3MRMpouyHm3OsKjtA5yp+RaWOCMUhwKHyjwI6SDAAfuyzSaZB9CZ9GB+FlMUag
	 1DjHCnRJR3fUD67kgIXkHUOvQpBR0A6S79K85rQxEPRDXz434L5WXvs7ej/uvVousu
	 uiIdWo2ZhJPjt+vPO5hVv1PG8BvLuwX1Ud+pZ5rr9DLevVe3dcCTSupAKjZ6jkPxUe
	 E+t2aajV7UgdA==
Received: from github.com (hubbernetes-node-c59729d.ash1-iad.github.net [10.56.128.79])
	by smtp.github.com (Postfix) with ESMTPA id 6E1FF84099E
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 14:02:23 -0700 (PDT)
Date: Fri, 02 Oct 2026 14:02:23 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1178588/000000-67d42a@github.com>
Subject: [bluez/bluez] 67d42a: monitor: Fix legacy SCAN_RSP PDU type names
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

  Branch: refs/heads/1178588
  Home:   https://github.com/bluez/bluez
  Commit: 67d42a05a7e8c237e45e958bf5f702a955fe71a6
      https://github.com/bluez/bluez/commit/67d42a05a7e8c237e45e958bf5f702a955fe71a6
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-02 (Fri, 02 Oct 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix legacy SCAN_RSP PDU type names

The names of the two legacy scan response event types are swapped. A
scan response keeps the properties of the advertisement it answers, so
0x1b, which has the connectable bit set, is the response to ADV_IND and
0x1a is the response to ADV_SCAN_IND, as listed in Core Specification
Vol 4, Part E, 7.7.65.13, Table 7.1.

Fixes: e29ef3b85116 ("monitor: Add LE Extended Scan commands decoding")
Assisted-by: Claude:claude-opus-5.5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
