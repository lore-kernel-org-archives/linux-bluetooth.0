Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498532773E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957100; cv=none; b=AoxtDhsysYkSqx8ImR32TvXOaZGB/DTBtFplQGA8wEg3famw5To1pmnvYeo13x/NxAm20WpYHkKN3i9PqDN8RP8RQcK11Ot5Ygsp8Otom/lviQOx2SE6B+PQ+TjilqUibo7P3SntLCISbpvzKSDddo055NJFRW9RG3y0YIsexSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957100; c=relaxed/simple;
	bh=RmBFSzP8SQ/TwETeoNvmX5kE/iSe22kFXTDSYj5MW/E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i+LsMS3Gsc/M5cE6H8dCIwMLev7fAMHYoYwZgNTy+7J87CjWvzpnEJJH5sHBQCaRIH5iCQG64RYRLxQnKos091bct6NH71DkQnIzAM5sEQ4fccp0ZhNJTVx2eUbMvjy9Y0jBPKcapj+0wWpdIcUMhaBllaMbw5kpbM9SZCPjlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X2YXwmJx; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X2YXwmJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776957098;
	bh=eCna0gseMAcfQ8smdJHlgdwzPxeY47K3xLJ1Yi3wzjY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X2YXwmJxCcEJ9mot7v3QnskdLo9//B0+DGJINQ1fwPxvWYqEpDFo20oC3Li6hnyX9
	 QGbzJFM+9ul+7dLjKIRBq+24plE33e9zZNzEsGurr7C6sFm+ka08kHUxLZH55CYdIj
	 9DiRnsBOiWCncHQ3nk3Pli9A6ZzDpgfON21U1MR4=
Received: from github.com (hubbernetes-node-aa2836c.va3-iad.github.net [10.48.207.115])
	by smtp.github.com (Postfix) with ESMTPA id 62854181153
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 08:11:38 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:11:38 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084770/000000-32ef84@github.com>
Subject: [bluez/bluez] 32ef84: src/shared: implement custom CCC callbacks for
 int...
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

  Branch: refs/heads/1084770
  Home:   https://github.com/bluez/bluez
  Commit: 32ef84ff9a295a75aa862c211be62ee6de640636
      https://github.com/bluez/bluez/commit/32ef84ff9a295a75aa862c211be62ee6de640636
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h

  Log Message:
  -----------
  src/shared: implement custom CCC callbacks for intercepting client notification subscriptions



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
