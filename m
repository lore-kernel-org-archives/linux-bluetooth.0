Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9862329E43
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965836; cv=none; b=HftbKnJOgcrrbUKRTwmnpH4db4L9CDTb1AJreJ73K6a4GyFkUGqBbY8O6QyX3arLq7Pa4/V+ObnETPXdeQFu14g09AbCkZJ70mFnJnDHsZb/EGYOghpg//1zWBnnyrSIUo3PIfY9WSx31JKw8rvS4c+30BI9VXX196DHyRLk6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965836; c=relaxed/simple;
	bh=efdcELqGZNU8OjUQAnNfTiinbpsgSlUg05gPO406S7Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ME19O/BbJU3AOQjB6kMQ69ZmqSXeuXZaGxTvcKTL27yu+PX47/GREEyMM8D9HVHk531h6Z0dmzdKUlflnAbSXDoWfTx0JV90mMlsL4uqP4Shqd4d+XIqj2qUMffb1aOa+x6uissEHIvhRBwosUEVS6YlMcn0hLhxZmnX4B50pkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l3Zh3sgu; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l3Zh3sgu"
Received: from github.com (hubbernetes-node-a43ab28.va3-iad.github.net [10.48.15.38])
	by smtp.github.com (Postfix) with ESMTPA id 1DE044E05F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 19:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768965834;
	bh=Y3rDEWAYG/4hPUxhQnWT6d/ReCMRuvlpx1oIJCQhzMg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l3Zh3sguqjvJ4n7PnupWPGwj2+UPPMtBx25cYDd3L4k6O/BhA1zMM838x/SUjyD+u
	 srIYV2OpQjw80k/5B0YpeDx5jBcL9F2OALJOanUC5R7dEEoalWr/UeQZ5fK8oGGCOX
	 bpZTWxVhBDVYJYyG9I2OdrHr+iVjjEh11AM+06ag=
Date: Tue, 20 Jan 2026 19:23:54 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044931/000000-7e5b9a@github.com>
Subject: [bluez/bluez] 7e5b9a: bap: reduce ISO sync timeout to 3.6 secs
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

  Branch: refs/heads/1044931
  Home:   https://github.com/bluez/bluez
  Commit: 7e5b9a0f6e6e793a356cf50f892a1746d31f510d
      https://github.com/bluez/bluez/commit/7e5b9a0f6e6e793a356cf50f892a1746d31f510d
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-01-21 (Wed, 21 Jan 2026)

  Changed paths:
    M lib/bluetooth/bluetooth.h

  Log Message:
  -----------
  bap: reduce ISO sync timeout to 3.6 secs

The ISO sync timeout was previously set to 20 seconds,
which is too long for PA sync. This could leave the userspace
flow pending for an extended period of time.

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
