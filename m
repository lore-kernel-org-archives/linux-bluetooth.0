Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D033E49C7
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284394; cv=none; b=FaSeAX6GuB4vok6aMDaL5LULq7LCroeMezl3vj2ZMU6JAnjOOdrrqU9dY6Ui2Ozr/REU80m/lVk38VkIVlwMOP3BsDhIxasnsGaUAsGrYa520KxoGrO0RA+nDLXnNzpEGkyXz8SIWjXncscTHLADA2/LbFqYgMoglxaQBHKgoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284394; c=relaxed/simple;
	bh=jKZ7jXy0Y3s2m0Il25OU6sSSAAO13IB/O/bqX1bcBE4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KAd84SJp+iCn1xCMgRAY+DvXdLN14vxPSCD0wvHEVdp/Jc98cDn2h9NR1U2836j6jJf/39PGCK8qHB/+b0cssDf6lsuj4X5EvXXefv2TYU++qzI9fOvesYc6+4MVxl6fKFHwDXrslXxZGnaco1bOrNi2T8zENvBt9O1w1vrqV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Iwu6Gsza; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Iwu6Gsza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791284387; x=1791543587;
	bh=6/LtjHSWFeUXZFWKoIpmiWCnW6HjdOVRUtfhU8lJUxo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Iwu6GszaQj+0JnK1SKr1ZcWNJWm0PJ1k5PBw2NWGiXCAQWv42GDQgrvXlPY4WbCi5
	 S+zzXeGdOP5to0gf/HyhF8AugOkvzbI4OAmKLYgXDQReuv+zscZjjd+b4A3BJ5a0ib
	 jry+UzC3YKho5NnGgVSu7ADpK5ci53GNCixe0t2gQSKKvWLXlD8FobnZ2I/sj5ZPEl
	 eZG5hPB+zjLzd9oOrKFK/MZhHiLf5x9T/eHkOaghh74Md0aDK3N+/MslsLYGniLUf/
	 bsKWfNOPsqOYWuVKGl5M0NoPF9480EeG4Gb/hPBkCK9YoFx1EAdd+OZaH3H9s+Or2M
	 CVlncPRkmXqFw==
Date: Tue, 06 Oct 2026 10:59:41 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: dt <derektern@proton.me>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 0/3] BAP transport Release and reacquire fixes
Message-ID: <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: aa6d4648f1b599d8080124a110cbb462693d2491
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

This v2 rebases the BAP Release/reacquire fixes onto master
7edaa61403390fe1cf2f1fb6d45fdd90fe6e93b3 after the v1 CI PR expired:
https://github.com/bluez/bluez/pull/2550

The first fix prevents a late ready event from replying to Release with
an Acquire payload and losing the pending Disable request. The second
allows deferred IO recreation when a new Enable arrives before the old
CIS has finished disconnecting.

Changes since v1:
- Rebased both fixes and the regression test onto current master.
- Clarified the test's reply barriers in its description and comments.
- Added source-history-verified Fixes and Assisted-by attribution tags.

Regarding the sequencing review: the test waits for both initial Acquire
replies before Release, and for both Release replies before reacquiring.
Every following Acquire also completes before the next Release. Only
calls on different transport paths run concurrently, as in the existing
acquisition test; successive operations on one path are not queued
without waiting for its previous reply.

Fresh validation on this base:
- Current master plus the test: all three pause variants fail with
  malformed Release replies and pending-Disable cleanup crashes.
- Both fixes: all 10 selected BAP functional cases pass.
- ASan/UBSan: coordinated-set creation with SC and legacy pairing, plus
  coordinated-set acquisition, pass including teardown (3 cases).
- make check: all 35 unit-test executables pass, including 697 BAP cases.
- A separate 500 ms userspace-disconnect delay fixture isolates patch 2:
  with only patch 1, both reacquires time out after 26 seconds; with both
  fixes, they complete in about 375 ms and both transports become active.
  This diagnostic instrumentation is excluded from the series.

The v1 functional job failed in coordinated-set cleanup, while its new
resume cases passed. This base includes eb82d81bf26b and 8a1c53517399,
which address the recorded adapter-list and BAP-session lifetime stacks;
the fresh sanitizer checks above cover those previously failing paths.

These are virtual-controller lifecycle tests, not acoustic, full-duplex
range, or physical-earbud validation. The ordinary resume test does not
force the delayed-disconnect ordering exercised by the separate fixture.

Derek

