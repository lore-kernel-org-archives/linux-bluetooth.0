Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461D27C879
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509516; cv=none; b=uDoTBQOinzL7Z6kSR2ThT0I0R6oETNfCOlXaeKTXglYDV9cuAZZNoeqxTm5J6urJiGpNzasORJ5na6tuaVbSNlBoNeBF+uGRHfiJqsqwmHHcvQ5gQITTkZq7rADyACSV6/Gx2GTcVOfosDGy8A/+4ePSQdEtwp/sJw9yjuKYeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509516; c=relaxed/simple;
	bh=bST2R8Yxs85ARMrv12yg96TfG0uyeimFNu/cyk0F8+Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VWSeyzUkfquPVx7EyTpYqd9D7oMtIYX3NaJLcWBDdMbNdZ9ypTsgQhs1M6NgiWMD/JjxZqCusDC1/MzjSsG0Kp+h+qixAnryBGBBNISJGnZjNmN97fA2TEPft0g2ITMz6GqnrSg/McR3mxf8V33eh+F9JlU0ClSNNx2WVdLPokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ROun4wqD; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ROun4wqD"
Received: from github.com (hubbernetes-node-c191d69.ac4-iad.github.net [10.52.205.75])
	by smtp.github.com (Postfix) with ESMTPA id 49FA12091F
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509513;
	bh=/BJ8Z2scKME6PVF0qzZ/r7xFPsJNeKPo3FPSakSQE4Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ROun4wqDkksHwSCDQGIJoo0jrFYrswWVFhECXDM+qVEpPoIO9XvADl3PUbRHRPzXd
	 oXzdrXvM0Pv4uATfVm/QpdQxULdTMfC5OQi1ep1rYm6gg1NvUaIiSZHZU6nVlxZBuK
	 8GXK2sqLOm5PGchKwSMmzVNiXHXaZmiR37v+kmeQ=
Date: Thu, 24 Apr 2025 08:45:13 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/953043/000000-992b2c@github.com>
Subject: [bluez/bluez] 992b2c: device: Fix rare ERR_BREDR_CONN_BUSY during
 connect
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

  Branch: refs/heads/953043
  Home:   https://github.com/bluez/bluez
  Commit: 992b2c9ab9b8d08f5892eea80928dcecc97fa300
      https://github.com/bluez/bluez/commit/992b2c9ab9b8d08f5892eea80928dcecc97fa300
  Author: Oleg Lyovin <ovlevin@salutedevices.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix rare ERR_BREDR_CONN_BUSY during connect

Disconnect may happen while the connection to the device is not
finished, leading to device->pending list is not being freed. As a
result, subsequent connection attempts leads to ERR_BREDR_CONN_BUSY
error, making it impossible to establish a connection.

This patch frees device->pending list in such case.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
