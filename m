Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24151130AC8
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509517; cv=none; b=cR1EVtvOv9k/WLdryY31YWdNN7lFraafEz+W8YRIr3utIDviq58Y3Ce6+lIRLot/gn7wACoErFVefV14DQFCdtRSviPpDMK75bPm6LQ8BPKQyFoHlnUEPszFz5baFsf8uOYs0HzRBsDpNLYzjd2tSX4pvcZbSJUKC2HfGcw0SPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509517; c=relaxed/simple;
	bh=bC+EbO9qfpPS8CkudjKC0qPDkvSbbeS6iazEE0gb9j8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=msHgty4fLfuR7NJ06PxiDHK4JA9OZH04l+/pB8oq+/0BNVTjTwMPIWoDwPwHl/ECm1L2l+IorlRmfkQxJk7rd+tD+JAWW357c40mxwSOFVl3KKRKskzBDx+CUn9lbMCWsHqD0OVsvyChBbEOZTTfWsQIXDS7s+sXYmQb5O2gZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lIYPBkHF; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lIYPBkHF"
Received: from github.com (hubbernetes-node-e98d5fd.va3-iad.github.net [10.48.138.20])
	by smtp.github.com (Postfix) with ESMTPA id 0212F4E0C31
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509515;
	bh=BnzBK0I4uUuHr6XQa5MnDziLZGbcLgh5PWwNAZzpBdU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lIYPBkHFhOMaID4GNYGMne1gCRke6pvoWI5ITkKBqNox6yz2Lbsi6pwfGGvF+7uwT
	 5MrY/JI+KU9YNtUTo9hIvUJVHNbMDo9G1Agimwv12pddF+XnJ2KCgcUBELhO2BFI2T
	 rosXm5V6jcqVaB2oQFqTGRtPKb2l6YXPgJLx8NiQ=
Date: Thu, 24 Apr 2025 08:45:14 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/953925/000000-435783@github.com>
Subject: [bluez/bluez] 435783: bass: remove the device of BIS source when
 modify ...
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

  Branch: refs/heads/953925
  Home:   https://github.com/bluez/bluez
  Commit: 435783cfa07bdd0aef054d7e79de0fe788a8f5c6
      https://github.com/bluez/bluez/commit/435783cfa07bdd0aef054d7e79de0fe788a8f5c6
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: remove the device of BIS source when modify operation.

When the Client sends a modify operation and PA Sync is
"Do not synchronize to PA", the BIS source information
needs to be cleared.

Fixes: https://github.com/bluez/bluez/issues/1145



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
