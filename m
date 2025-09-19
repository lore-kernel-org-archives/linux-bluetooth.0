Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428ED2C028E
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271751; cv=none; b=XSKcZNl+s7j9WX7rhTHZOcI/WNnVPb/1lqfzeCvp7ksV39iuh1jAlbQ10SmA6iwhlz/i6WyJzMq3fRNeAivqlDquDUUBXkYrfdjbrIpBMnTALtRQf0mAUA4XlRubM3SVL91nAwDbZCPc7wVUFme3zByzCIO/nGk+oqHxKaJup4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271751; c=relaxed/simple;
	bh=wp/IEyaZ0ZkGKZkzE4Wet4KJjZJf6O/yg3UZuBLXkSI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dm1PlLq6iICPQe89Xps3OKM+r7ocjtBiWGoUW/6pFNxR4RK/CBi+FdDq/P929rExEcw+0x55qi1wTm3QgquxhmZnZPvQE3C2GbULGAlpCeB+C3vxznI6c+t1uR5lszsAUwICDiLWdjjz8fDHSJ34Kvr5Szf3UFZB2FfSMvYq+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Aw1aCYFW; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Aw1aCYFW"
Received: from github.com (hubbernetes-node-026b7a5.ash1-iad.github.net [10.56.178.19])
	by smtp.github.com (Postfix) with ESMTPA id 5AAF0920293
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758271749;
	bh=H9tyu5Qu8IseJqdxXHIQo3YHagR+GKMAEzxiXCLIQ4k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Aw1aCYFWI4sFf9UHuGmpE/UXFvsurer8Gy4HMa/SjZHSsgBl8YbiMHrh7tlPkR+uk
	 +iawhcTTAlbQS2uK4Y0S4hSUA5sWSEhPHcJCxxquYZh3y+3u33/kbOBGazGMRBF7Hi
	 IijYwyPGONtXg6dAf++P4M9p0E7+ijvFoU02zVQA=
Date: Fri, 19 Sep 2025 01:49:09 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1004140/000000-d7a7d9@github.com>
Subject: [bluez/bluez] d7a7d9: doc: Fix typo in PreferredBearer property
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

  Branch: refs/heads/1004140
  Home:   https://github.com/bluez/bluez
  Commit: d7a7d96408562dee2ba8e0bfde53582ca7ad012a
      https://github.com/bluez/bluez/commit/d7a7d96408562dee2ba8e0bfde53582ca7ad012a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-09-19 (Fri, 19 Sep 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc: Fix typo in PreferredBearer property



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
