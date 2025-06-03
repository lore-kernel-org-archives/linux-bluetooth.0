Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCA77111
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945120; cv=none; b=kPAiecm17sGk9H/C5M49+kwrdYB/qALQUFimUQxuNeQLAuLX3lK7LvqTvsIVtkZLbnje0uoP6Xd9k4P7WMoQJ0DMjW+0pJIexG0IVB/dCK8jvInjIuCb3AB9hwLrYox9i8hLWKpLG1GR/mJrPZEMgU8qf7ZM3YvBhgzlp9xPKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945120; c=relaxed/simple;
	bh=kSjAh1BkOfbhuyQZKf0OqF5peTSzAkB+3J9stuYr1/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYt0aYuVx0MCzVYWlI8o4YA9cm9s21vIcxagJ9ulqKA0KKuEuGJKyg8YqR5EAvPA59W8w19FeG6Mt1BlPPVIZKZBUWQ13OOqNCFHd06Kp7ciC7nMydJx7rYZXilldbNtyBTBv0KrcDDLS4TPVBgzI7wgdDFJwo9qbzLeEY2X8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=InwoMa43; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="InwoMa43"
Received: from Beast.lan (Beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id C1257103F010DC;
	Tue, 03 Jun 2025 12:56:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1748944581; bh=kSjAh1BkOfbhuyQZKf0OqF5peTSzAkB+3J9stuYr1/c=;
	h=From:To:Cc:Subject:Date;
	b=InwoMa435UmAp5uP3Vr4yqGQJMEiWTpEWp++p53+gGvyhKZ8/M/sbgfkYlSnZoWt9
	 t/tCjfPuFgxNJiz1qAfgakEWGDsz/mBxJFPT19PzC+cfKNptP5w+gQw5hG4+t1qcpY
	 5CySe9Nu6m06z0jQ5Pjv9l3XFwFboAdXe3ZGilPY=
From: Egor Vorontsov <sdoregor@sdore.me>
To: linux-bluetooth@vger.kernel.org
Cc: Egor Vorontsov <sdoregor@sdore.me>
Subject: [PATCH BlueZ 0/2] Cable pairing support for DualSense
Date: Tue,  3 Jun 2025 12:56:15 +0300
Message-ID: <20250603095617.92785-1-sdoregor@sdore.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have figured out the DualSense pairing to be pretty similar to that
of DualShock 4. Successfully tested with a DualSense, from CLI and
via GNOME Control Center.

As a side discussion, don't we also have to add the DS4 constant
at L398 (that's with this patch) for it to be supported as well?
An article at Gentoo Wiki [1] suggests that DS4 pairing cannot
currently be done the cable way. I don't currently have a way to
verify this myself, though.

[1]: https://wiki.gentoo.org/wiki/Sony_DualShock#DualShock_4

Egor Vorontsov (2):
  profiles/input: Add cable pairing constants for DualSense
  plugins/sixaxis: Implement cable pairing for DualSense

 plugins/sixaxis.c        | 107 +++++++++++++++++++++++++++++++++++++--
 profiles/input/server.c  |   3 +-
 profiles/input/sixaxis.h |  25 +++++++++
 3 files changed, 131 insertions(+), 4 deletions(-)

-- 
2.49.0

