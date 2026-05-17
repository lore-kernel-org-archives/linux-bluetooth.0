Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BC30566A
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014358; cv=none; b=KyPhoKvjOoGshhPSFyxk3OfnwtesM4TA6rkH9nxlV0BquM7xg5UDRKwZtlS48nw5eGIi8UdPWBa+1P1gucCLO+cg/wqXFCLHmT+i10jbmtXeFWk3FVK/9VpLgOwOETF3kvE5u0PneNGognAXUCZNzOEy2n2nFY87519O/XgJz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014358; c=relaxed/simple;
	bh=V9MKFTgEjNk4EqEutrCTSxUJQXAaJW/hGGu2sSgnOZc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FNTjxg/WnysT1kGgp1PskFLRJVUzgMO2fXcPSaj8SbiCYSgX1sbWqr3cq9/LGCVZj48htw6jeSvdAJ8PkiguYG6M/UIH00WdWSNmgL5o05RrFkEAgiRAc5SnUSP8E8wb/KocMFmBUin3GAtHM4fh+T7lbktY8gMqL1nuMIhtR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IOK93P1N; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IOK93P1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779014356;
	bh=qcDyDXnDjScsBfFWHfWHm9pKluRgg64K9vK3y6uvr5w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IOK93P1N0eVWAt3L1mbAu0+hBei7JLaTPbKs8jtLEay2Kzi31fdgJiXuslHJln9pw
	 CcsiTtr9xMaDK57zPqCMs4Ay2tzNhXoTwiqUSpbYNqvGi9yn8j00AbVli+cLGhNbYH
	 czEzSFGoWmuyjK018/EK1c3dif9fv4dPBR2jNO5w=
Received: from github.com (hubbernetes-node-678d3f8.ac4-iad.github.net [10.52.221.43])
	by smtp.github.com (Postfix) with ESMTPA id 80624321151
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 03:39:16 -0700 (PDT)
Date: Sun, 17 May 2026 03:39:16 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4f4dba-45e66b@github.com>
Subject: [bluez/bluez] 81a4df: build: Fix inclusion of local_node.json and
 prov_d...
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
  Commit: 81a4df3e88d7b347244195d05c478d7119c242e2
      https://github.com/bluez/bluez/commit/81a4df3e88d7b347244195d05c478d7119c242e2
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-05-17 (Sun, 17 May 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  build: Fix inclusion of local_node.json and prov_db.json


  Commit: 45e66b1c4aed688e1959d38dbb9834d248d12c2d
      https://github.com/bluez/bluez/commit/45e66b1c4aed688e1959d38dbb9834d248d12c2d
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-05-17 (Sun, 17 May 2026)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Include test-util binary to ignore list


Compare: https://github.com/bluez/bluez/compare/4f4dba4a7863...45e66b1c4aed

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
