Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B64DD3A1
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227647; cv=none; b=lSe57nVWz82mhURm1pyhny3DeFbcMEtrOB1phxQJNJ/cfF1suTub7VlOEKo4To2ishtiTs5eTDhsNrJeKvv88/+NG9QplPdC2ZQIqIFy+dGdcJrfUZ9g1XJ3d4OJUT2+gJp5i63mzjxX6q5r2/HxXQVFgNA1k98kwTWiQuas29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227647; c=relaxed/simple;
	bh=XhiAk1+4wjLzUEczgmf8vrp8QHDtfig16USnPNWhKY0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IjfP5eKc+M/KqTHhrttT4Wl/mH7k4Nh/SCTdXsjkMyAZciVwKwVYw6om8wS5+VwM3GtttJDjtEzcIfOWgTzTIK7t7n8ZDf8z/CC2ZiDXIvAp2feQOG1veUFbhVTb/Lb9SZGae1WBXb4R9LWGa5Gwq+jkL5qYpWVniWHOUfexAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=FOScWIzP; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="FOScWIzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791227644;
	bh=V8qmPruicsnlm/NAcv3iXJaspMAj9l/dxD4cjHR+qLI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FOScWIzPF3OVtlNqpCZh3IP1iwV9l4SyfpeC7TY4z6ULykmFHWmEgM0u3x386YvE+
	 AfpAqb9iG0Bqz84+SjOY5Y+T7lKomWP35k61+nX55/GckWjlPNpy0SGmF9FpadXAvQ
	 zlHOC0N781mh/JrBPCyTTZ7UA74OBBP7doQCqLV0WXyArD7K1YtXqrIBKKxnDZXC5g
	 I8FezlAXXq2L45x0eom2va8Qec3YA7026KKOUZh4OAAQoeU6Hpz+exwQfmgm+RaN9O
	 q3WC55cOUs+vJWjycdGGA3SJbOeIjnbF9ANyYTjfHb1LUoXdpkARGnreYLK/z/CoGx
	 dnuZmbEm3/lJw==
Received: from github.com (hubbernetes-node-9db071e.ash1-iad.github.net [10.56.195.26])
	by smtp.github.com (Postfix) with ESMTPA id BCAC9360167
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 12:14:04 -0700 (PDT)
Date: Mon, 05 Oct 2026 12:14:04 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1179769/000000-d83398@github.com>
Subject: [bluez/bluez] 5b684c: emulator: Remove unused le_ext_adv_type
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

  Branch: refs/heads/1179769
  Home:   https://github.com/bluez/bluez
  Commit: 5b684c04681ee0ddbfd5d46a38129b5930080a87
      https://github.com/bluez/bluez/commit/5b684c04681ee0ddbfd5d46a38129b5930080a87
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Remove unused le_ext_adv_type

Nothing has read le_ext_adv_type since advertising sets got their own
struct le_ext_adv in commit 5145b1ea2e95 ("emulator/btdev: Add support
multiple instance of extended advertising"). Remove it along with
ext_legacy_adv_type, rather than fix that function's mapping of low
duty cycle directed advertising (0x04) to ADV_SCAN_IND.

Assisted-by: Claude:claude-opus-5.5


  Commit: 140f8097918b6e7e770ae64c3531488074e7ff4d
      https://github.com/bluez/bluez/commit/140f8097918b6e7e770ae64c3531488074e7ff4d
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix extended scan response Event_Type

The scan response to non-legacy scannable advertising was reported with
Event_Type 0x0000, since the scan response bit was masked instead of
set, so hosts saw it as a separate non-connectable advertisement.

Fixes: 32339501a125 ("emulator: Add 5.0 feature support")
Assisted-by: Claude:claude-opus-5.5


  Commit: d83398e628fa2c76cca7cb0db0811e27ab7b963a
      https://github.com/bluez/bluez/commit/d83398e628fa2c76cca7cb0db0811e27ab7b963a
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix report type after a scan response

ext_adv_broadcast stored the scan response type in report_type, which
is also used for the advertising report to the next scanner, so every
active scanner after the first got the advertisement reported as a scan
response.

Fixes: 32339501a125 ("emulator: Add 5.0 feature support")
Assisted-by: Claude:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/5b684c04681e%5E...d83398e628fa

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
