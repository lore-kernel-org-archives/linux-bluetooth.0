Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADD31E83A
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922198; cv=none; b=kWdaJYQbeFs8dCuTU36jDk5K79GfDMbmnjceq3jf5RF7A1ND8LLYvGkZ7jUVYYAJdpuSusE+OfX4a6xhafmKGETRC+PEc7tg0Xx6/TkM8wUsFVlNtMpW5z1qejwMRME9CK49zFm0GRoyBvViP9Ldxy5g+OJTrTOcepNuiT/VbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922198; c=relaxed/simple;
	bh=plEPJA1D0loLNc66nliJksfVoZKF35dbcICTxfed8jw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f09+zjRjJGeMbV2PomFpVdGM1DUj3G92LJsSnvO6Bheq7zKQ3j4mgjkgUCbVFEWYVjHsRPHH/iUWvZDdQpvbS7aYerH8j/xxTjBDt1nN+e8MW7e9o4VjFnijyndqZ+Zs/NAuM5HKU/liAo9Ar8YlG75RFo2ZX4m3MlHLJDrYPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AFE+qKHo; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AFE+qKHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777922196;
	bh=j86f1WGp9+VvmrQWpU3H3bLZLa1ugwHAZGl1Wt7tF5A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AFE+qKHo+SE0QlrAqGeoZWFNvICUbQo5IrtM0odGcB2OsatiD4ZKnTQOgmYN235y4
	 re1JIivsWUj13mJaHyR0FkIuR85CoEWaO8y4xZUoD+VajaCxtH5W3JGbsLPiQRbuFr
	 JNY5gkoB5ud9p31CFo4oCkd9Jn0YWaf+bFA4Unno=
Received: from github.com (hubbernetes-node-8d64e36.va3-iad.github.net [10.48.14.35])
	by smtp.github.com (Postfix) with ESMTPA id E9E23500B6D
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 12:16:36 -0700 (PDT)
Date: Mon, 04 May 2026 12:16:36 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089467/000000-d11e06@github.com>
Subject: [bluez/bluez] d11e06: sdp: fix overflow in sdp_extract_seqtype()
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

  Branch: refs/heads/1089467
  Home:   https://github.com/bluez/bluez
  Commit: d11e061c25f5e7d5e75e0c03fcf1c819f2220f45
      https://github.com/bluez/bluez/commit/d11e061c25f5e7d5e75e0c03fcf1c819f2220f45
  Author: Martin Brodeur <admin@fluentlogic.org>
  Date:   2026-05-04 (Mon, 04 May 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: fix overflow in sdp_extract_seqtype()

bt_get_be32() returns uint32_t. Assigning directly to the
int *size parameter sign-extends values greater than INT_MAX
to negative, bypassing sequence-length sanity checks in
extract_seq() and sdp_extract_pdu() callers.

Store the result in a uint32_t first and return an error if
the value exceeds INT_MAX. This closes the residual paths not
covered by commit 31e4fb1498f4 ("monitor: Add decoding support
for HIDS 1.1 flags and attributes").

Reported-by: Martin Brodeur <admin@fluentlogic.org>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
