Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55E3E3C73
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869568; cv=none; b=HioSlv3s30R2RS7smOYYuEafhQ2QKIrQ7DfWzHLN5O+l4y3wPP2kfah5sJw7c89od8flXJrSj9b7aGv+RgysaAS+P0/Ovq1VqrhAcmdSNLQY2rz1WXvK2NcvqgXMDDqvgRZMiE/qlMXNlCky7JSA6bnuxMbYx8KHlxLkiwghUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869568; c=relaxed/simple;
	bh=4UDdSBXh1YUi1T7hukSoQMYkmoF22+T9S+7upYwreVQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZBb9NI1xFiAhI/0Wa/oM5RsvTk1XJlaMWkdhR3Ny23lBji92/BjirFIg+Ab42Cf2UF5HuiSWRHGffZvjV6n3Y1Xo8BmzV7Hh46BjMbmzWUalzxwB/J3uuO+sEJjpoBM6MaUlkvawaTRWqYjjchTVbAlceU8Y6ZvE4o0GF/9F1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=PwR5KqGN; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="PwR5KqGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790869564;
	bh=gUTp2d9qFFvLFy7P++AfW8mKDYdf0ygPMCsyValKu4U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PwR5KqGNXcV0YVl+5mrMqcHunBh3KJdoJcPPqKupxigT0FwVEnHyEwSc3AV4Dnt9a
	 AykSLowcVSvG4qsDyoT+d8bZ+X0ekR9Jc0UU7b00134DqHpMCj9pulDZwN2XqSE0g+
	 j/mGDij3YmJt1kbCnG6D9jSbSsdvJTJtSgd2nVNTgmpeXIIKbCT2KOOf9oMN6MKyqo
	 +yGkuDaCQJWdneWKSgY1xbod6Uwya5n513V44VQZpjeu62PufRsn9oqLZbaApPxeSP
	 N1nZKIBny/OWYugl3Fe1F6UvMOMwV1+J6RlpYE7Hdu8qA2msW8GeXlkNcoEcla98a7
	 Edc/DRd7G2/WA==
Received: from github.com (hubbernetes-node-a9e0422.va3-iad.github.net [10.48.86.31])
	by smtp.github.com (Postfix) with ESMTPA id BF1477813F8
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 08:46:04 -0700 (PDT)
Date: Thu, 01 Oct 2026 08:46:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1177764/000000-c60df5@github.com>
Subject: [bluez/bluez] 39dff6: doc: Add commit message guidelines for AI
 coding a...
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

  Branch: refs/heads/1177764
  Home:   https://github.com/bluez/bluez
  Commit: 39dff637917dbf215666e808711800991917de08
      https://github.com/bluez/bluez/commit/39dff637917dbf215666e808711800991917de08
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M doc/coding-assistants.rst

  Log Message:
  -----------
  doc: Add commit message guidelines for AI coding assistants

Require commit messages to record only the changes and their rationale,
to follow Rule 2 of the maintainer guidelines, and to have their factual
claims checked against the diff.

Inspired by WirePlumber's AGENTS.md:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/AGENTS.md

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 491b715eb1b9625a50124f5a8a0a9834aefc42ba
      https://github.com/bluez/bluez/commit/491b715eb1b9625a50124f5a8a0a9834aefc42ba
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    M doc/coding-assistants.rst

  Log Message:
  -----------
  doc: Add bug fixing procedure for AI coding assistants

Require AI assistants fixing bugs to verify them with a reproducer, test
the fix, state what could not be verified and leave any submission to
the human, with vulnerabilities following SECURITY.md.

Adapted from the Linux kernel's
Documentation/process/coding-assistants.rst.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: c60df518ec4a6c4a6b68e803d9cb978b32624092
      https://github.com/bluez/bluez/commit/c60df518ec4a6c4a6b68e803d9cb978b32624092
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

  Changed paths:
    A AGENTS.md

  Log Message:
  -----------
  Add AGENTS.md symlink to doc/coding-assistants.rst

Let AI coding assistants that look for AGENTS.md load the guidelines
automatically.

Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/39dff637917d%5E...c60df518ec4a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
