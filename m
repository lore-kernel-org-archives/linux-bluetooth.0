Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3AA4F96CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740269; cv=none; b=X388dkk0410k2pYop24b+9QBd6bY/LUjmL3YgdqMNKuTn1HRMAruYy+racCerLI2rtrviPhxn6EgQSu/vjZcuwlcWSNloLsJlhWwtBJkruPxHGval3MFrl6JbQFFyKQ/m/fSY3MkozvdYTfXtY1ZwtCCP2N5p93PasWjUleLeb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740269; c=relaxed/simple;
	bh=EMPelphQj5hx7W/B2D9zgBLmfNEIQJXGX6UWMdbqnN0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pwkcd//t/OJLNusXDjWT2+9I7XZWvyblovYdY0nxHyZuY2SFwh7Y05vz5I1QPXvI8aSol5hRqnEgLUh2cYKlB+gQODSwRXHpqYxd6JWzp6Ta4SwECdkbydLEeUMWdZg0wA2pWqHFgcYr8LW0iPiwmYTCkEohORM2SkwOhci0xW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B3S/cfZ7; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B3S/cfZ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789740267;
	bh=YW7p5iikWyZoAN8n9uetLHLaWlJMp6KSzj2+CC40jJg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B3S/cfZ7tWN9Xvr4JZRHdFpU0x3PNGCQ04ne08lNsOPwRenKq/tZSOz3cFDMTkl48
	 Z9qr3MIJCb1e8jfXOL0uyA8/EWBdwf7r/dRoQEW0nEmtSJBRgqxY9FAUYCFjALdRP0
	 q0E+1XLjfTXOlrFQYKE80LO/nYenphwL6TGDCkvs=
Received: from github.com (hubbernetes-node-1007d3c.ash1-iad.github.net [10.56.211.74])
	by smtp.github.com (Postfix) with ESMTPA id 1380B60104C
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:04:27 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:04:27 -0700
From: MathGrelck <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168672/000000-1a1288@github.com>
Subject: [bluez/bluez] 1a1288: adapter: Set Audio service class bit for A2DP
 sink
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

  Branch: refs/heads/1168672
  Home:   https://github.com/bluez/bluez
  Commit: 1a128855ec2c235da9df6eaf2f99da27fd9ed4c7
      https://github.com/bluez/bluez/commit/1a128855ec2c235da9df6eaf2f99da27fd9ed4c7
  Author: Mathias Johnsen <majo@bang-olufsen.dk>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Set Audio service class bit for A2DP sink

Problem: The Nintendo Switch refuses to connect to a device that does
not advertise the CoD 'Audio' (0x20) service class bit. It completes
pairing, takes the link key, then terminates the ACL with reason 0x13
without ever authenticating, encrypting, or connecting AVDTP on PSM 25.

Cause: get_uuid_mask() currently only grants the Audio service class
bit to HEADSET and HANDSFREE, so a device implementing A2DP sink
without HFP or HSP advertises 'Rendering' with no Audio bit set.

Fix: Report 'Audio' in addition to 'Rendering' (0x04) for
AUDIO_SINK_SVCLASS_ID in get_uuid_mask().

Tested on a Yocto-based speaker running bluez 5.65 with this change
backported and compile-tested on current master. Note get_uuid_mask()
is unchanged between 5.65 and current master. The speaker under test is
purely an A2DP sink; the patch changes the CoD from 0x040414 to
0x240414, after which the Switch connects and streams normally.

Note that A2DP v1.4 section 5.5.1 mandates only the 'Rendering' bit for
a sink, so the current behavior is conformant as it stands. Conversely,
adding the bit is not a violation either: Assigned Numbers section
2.8.1 defines bit 21 as 'Audio (Speaker, Microphone, Headset service,
...)', which a loudspeaker A2DP sink fits.

This is the same kind of device-specific workaround as the
HANDSFREE_AGW telephony bit for Nokia 616 carkit also present in the
get_uuid_mask() switch-statement.

Assisted-by: Claude:claude-opus-5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
