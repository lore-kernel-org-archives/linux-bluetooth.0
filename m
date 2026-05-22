Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC58347C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471921; cv=none; b=mHyuHfzXsNWb10AK0IouaJqY9t88X+02aJIM4snDivzdnYyX0noM8DQfqiER3eCEssyZn/uaS1OCoMNm7LesOpzYQMUpzjcT0JxOT+O9oAVplHADWqg2jZS6P21O2Y4az/9OSNG9dfqWqYiPxSxd7TkJd0k9qu5csrg7Qov+3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471921; c=relaxed/simple;
	bh=7Ew5FAX6fC/CHib1fEQdc6Yg07BbcgFUdHuUvJAHI3g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JV8gt0ByyyGq/1dtlRCpAKowu2BsdFr3Sah750Khu6wGyw0fPaAqZJHhJfYQOzTAI/w19GLpaLv8xMuikEwi8N//9uGqExV3tWa2jhBPcLZpKGvydXri8B9KzD7MNpTnyCwDdZgssGk8UL7/1lzeaGINXBcvLwb0McH3gOi4Zjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gAvpfyUP; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gAvpfyUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779471919;
	bh=buJtTP1USSQ1Z/ICV9DqsQftTD+eA2DlnGeu+1ORkHc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gAvpfyUPEm8JqST/3Q4KKx7ZWOTfZe/Ju71vchIqKwi9adFSZko3fubd12VyaB490
	 imU8ExmEVRpJcSMSCDNXCdXM6fA+Ob93y0AfhLmiN7rczFvpJs/Y1INrVpqeq8qtBm
	 /kR3vjXwOqqAAeWs87bCCzCzspqMUoYUMupJm3Mg=
Received: from github.com (hubbernetes-node-20636c1.ac4-iad.github.net [10.52.220.72])
	by smtp.github.com (Postfix) with ESMTPA id 6D63BA11DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 10:45:19 -0700 (PDT)
Date: Fri, 22 May 2026 10:45:19 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d167d3-f818e9@github.com>
Subject: [bluez/bluez] f818e9: shared/bap: set QoS state when CIS is lost
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f818e9d0c9df2537c3415fe9ff45701084dbe012
      https://github.com/bluez/bluez/commit/f818e9d0c9df2537c3415fe9ff45701084dbe012
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: set QoS state when CIS is lost

This is used to pass PTS tests BAP/USR/SCC/BV-167-C
and BAP/USR/SCC/BV-168-C.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
