Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F83644C1
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353414; cv=none; b=iZPhVwE37FWge2b0DfYkdG8pZI9J8kI1brl38YVtF058tSrx+fT0axv90Nnz0Kj7Ch15dYFFVsTUXIhtBiqHTlLma7PgZkSENjz1u71pJXKyzs1Ixgh/T4UDHGylVoXHJg52G9Mhy5wLmWTcD4xMdr5hbwU7lf0WcYiAQr5qWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353414; c=relaxed/simple;
	bh=pAIsiCeK6yj//dz5uMePuO5V8arW06Qg/v84Dak9C0A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aRI66kcTnlirLOZpdsDHISe/CWORoThu2h4q2+08NxEKFfsk/VZJvT/tI6wfu5H4X3e7v9Cja+zwPdIrK3SEHV70f2K9Z3oDcUePOrmrKunxwKVrCq7En3EGIAK8rIR+2q8y6ly/MG1wViCmaU/YKkRhgXam770yONlMK7SCH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MxEqPjUu; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MxEqPjUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779353412;
	bh=wV7Mf5EJyI/kZjeAPM2OtTzfwKxqJKeMT5PfXCQpMbI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MxEqPjUuXRVOcfWS0/X+vtM+U2cPePpdUT8mvSMipLBWDaRO+07BY7rnFeokVX0h/
	 2U2+4qFo1iubEDrDCJhYOjvJNzuj8K9RrtphgkpaGCFf2vULIr7TsMZzb0CgrjWjUE
	 9aphEPjtqCPQ6D4cWGExSsXlvUc7aaKCmnU1A+Dk=
Received: from github.com (hubbernetes-node-5b80fdc.ash1-iad.github.net [10.56.158.23])
	by smtp.github.com (Postfix) with ESMTPA id 88FDB360FF7
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 01:50:12 -0700 (PDT)
Date: Thu, 21 May 2026 01:50:12 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098497/000000-75a3ce@github.com>
Subject: [bluez/bluez] 75a3ce: shared/rap: Add client ranging registration and
 no...
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

  Branch: refs/heads/1098497
  Home:   https://github.com/bluez/bluez
  Commit: 75a3ce5f2ea1ce327efd2c7506a0644f3923469c
      https://github.com/bluez/bluez/commit/75a3ce5f2ea1ce327efd2c7506a0644f3923469c
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Add client ranging registration and notification parsing

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.

Changes in v2:
Removed unneccsary DBG logs and unused variables.
Use helper fuctions for readablitiy and code indentation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
