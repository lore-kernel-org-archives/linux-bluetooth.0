Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C41E53F
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713097455; cv=none; b=m/r1EfPb/hV0/JRYmB44wwpJlbz/nCUwJgqZbIKUCcUkDUuSdJuVsErdQFVdmZxDJHxP5BIqtXaiGP55zGFKP+CWbreAvMsuNmgqPO9TSht4JmPbkASlDqMYb2P6L+jTE60S7yd7TMjz1cAf9BDfTlqOmN3E0KIsQMWI9v5XcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713097455; c=relaxed/simple;
	bh=JYPUCUx1pvi0ZxYfUM1IKunqYWR53KMR5oXwP6mCfYQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Mr7g47ZX2GZceZyLuZFIcpBnCiDfxtNxM2eQXOyJBSiBMEIFRqmQe1E4WywnGHjkgnFj4YtyjKaYlM0H+M0+Bj0LhMpi/dwv2U/UchWNnkb6z0WoOV6D4fVNhF0ObaAIQmmjqtyLKOJTlWjyj/nlQPLbLpI0+X0YLsolUuGuOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=czLsgxcM; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="czLsgxcM"
Received: from github.com (hubbernetes-node-cfa690f.ac4-iad.github.net [10.52.137.24])
	by smtp.github.com (Postfix) with ESMTPA id 36D4364015F
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713097453;
	bh=vmSdqbWkxLFXpFWmFS/Fg7fSqmMh4QNRIfplhJLCEr8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=czLsgxcMCXxq+faCUpiBkk0OYFuWBdRu41hzuTQC1CurHzA65ZRs3886rdFv2vNzL
	 8iTOKB/JCzPB1TelOppcztWWF8aXiXyLGRF1K6z0hMHJNxPKRd6Qfsimeru5aylNQ8
	 RwyvXaqn05uEqMCjh0fx/RdXMIRwWdbJ2P7HMoCw=
Date: Sun, 14 Apr 2024 05:24:13 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6b5447-f1a7ab@github.com>
Subject: [bluez/bluez] 58b6c0: build: Update library version
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
  Commit: 58b6c0b88043321fc0e99742cf999bc76b32c4fb
      https://github.com/bluez/bluez/commit/58b6c0b88043321fc0e99742cf999bc76b32c4fb
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-04-14 (Sun, 14 Apr 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Update library version


  Commit: f1a7ab0ef75b9e11f04a028b50d4172a4b5f8601
      https://github.com/bluez/bluez/commit/f1a7ab0ef75b9e11f04a028b50d4172a4b5f8601
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-04-14 (Sun, 14 Apr 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.74


Compare: https://github.com/bluez/bluez/compare/6b544758375c...f1a7ab0ef75b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
