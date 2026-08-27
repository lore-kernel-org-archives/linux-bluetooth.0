Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3A40A929
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844472; cv=none; b=edzkm0yUosx0rXlTQguSXitv349Ry413wkjWHSzbvPZpKdQ66Zu98abHlqiE2hNpp8KKIsQDy6z7U4Ko1j+XGOaWqd73A/WQHaacohtNoBezv+d9PlR9CI2I9XY6jjAnaXzaYWkW2hqsL82GGHJ7TSDPu391XBj7cHR5qrkgcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844472; c=relaxed/simple;
	bh=RTMgzL98XkPIxGkleY+0KoK01mKXHK+bd05fgvBlEGE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=M6LhGA5H/BH1o7q/Lv9YKTig7gfb4zC+aRNa0IwZCfCG0XMbb7XKuqBLs8TG9r+v3T5s+W6bgB7bEqdqxc/c5mFTe2p7ZeF+raOq/DsMITy8sDqt2BNBP3rTtA0S52IFgcxXGVobeKS6vTHQ4/qc2wOTSidYjSDrj3aClrythn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CEyh6GPl; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CEyh6GPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787844470;
	bh=y8CxehnwXOy5VN9xwcCJjXGJhVTsMwFU8QSaJ+UranM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CEyh6GPlkzXRAcS46zRGPZFCYV7NklTV7ja+LgYZnN1YdYt1FYKU7Z7VYJs1rxD4C
	 FIM/GTc6fV5eGueDkCIc7nqkXXXiytZ1b709jvC8wIt30+NnnGRMf586+aBF5pZbei
	 +uTOF73r0PMNSKDmR4eeANV9R3wKFVenva7n7PZ0=
Received: from github.com (hubbernetes-node-63e25fe.ac4-iad.github.net [10.52.85.58])
	by smtp.github.com (Postfix) with ESMTPA id 29DBA780980
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:27:50 -0700 (PDT)
Date: Thu, 27 Aug 2026 08:27:50 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152688/000000-e829f2@github.com>
Subject: [bluez/bluez] e829f2: bass: Fix heap buffer overflow allocating
 subgroup...
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

  Branch: refs/heads/1152688
  Home:   https://github.com/bluez/bluez
  Commit: e829f2acc601a8b8ac917957c06c175d38b79c27
      https://github.com/bluez/bluez/commit/e829f2acc601a8b8ac917957c06c175d38b79c27
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  bass: Fix heap buffer overflow allocating subgroup_data array

bass_build_bcast_src() in src/shared/bass.c parses the Broadcast Receive State
characteristic value received from a remote BASS server.

It reads an attacker-controlled num_subgroups byte (range 0-255) but always
allocates a single bt_bass_subgroup_data entry (24 bytes):
subgroup_data = new0(struct bt_bass_subgroup_data, 1);   // line 337: always 1
for (int i = 0; i < num_subgroups; i++) {                // line 343: up to 255
    subgroup_data[i].bis_sync = bis_sync_state;          // line 355: OOB write

Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration
 with Claude and Anthropic Research
Suggested-by: @trace37labs for the Fixes

Fixes: 8980f4f1f7 ("shared/bass: Functions cleanup")

See: https://github.com/bluez/bluez/security/advisories/GHSA-7wjj-8mrm-jhw4



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
