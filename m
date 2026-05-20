Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026C371CEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302533; cv=none; b=gXr/pywwwoot9pf64FB1ffnhSamCZQlLk/CgsKS50PwmqU7S+Xa/X+6EWSheMwqbHkdGxU1f04A+oPZ5355LSvubiW3OCm9auSDsmkq//hYQ05NTO4ZizvVv+CQYePbyhu3c8O7MrCRCzGUC6UADx45wGxTs7qdKOJaaImFMGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302533; c=relaxed/simple;
	bh=ZbV9rXQepgw7Mu3vCbKgeA0Erl32hgpY3I50FNWkXa0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LupeNVgji+42DMwypVKfjwkpRGaVbCdD40/lFCVmHm+NrkwMiMHi5wluwK2Uz5Yf/C1sDdMGqjduSQpxkvrm1hD9u+zmtrakzE7ybxvZTfI3fEDnLbbydzZFl1EzSshnIswFFpMqeg6fDUQC10ba+ZZ6uhSBlmwSe/CAIMvdnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mLoD2bSL; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mLoD2bSL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779302531;
	bh=QpGdRsrGtCQL9+FlCPqkIQnmRim0iAqxk2JYouBvUe4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mLoD2bSLDWyDG2oM1RgfxqOnqwt9w31cnA64N31DUnamtzLQ3u6sfNe7CXYPgnu5E
	 5vlbjJaUnLHOaHTuGnSVUyoqQl4xHg1iwXQE03fYG5JveAN4UOq6yIk7vyUqNMV0XC
	 oG6j1f+C7xzL+jOKZMPh1mavr9DETdTvYnOZSgSA=
Received: from github.com (hubbernetes-node-7ef7b1a.ash1-iad.github.net [10.56.151.45])
	by smtp.github.com (Postfix) with ESMTPA id 35530360FFC
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:42:11 -0700 (PDT)
Date: Wed, 20 May 2026 11:42:11 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098168/000000-ea64b0@github.com>
Subject: [bluez/bluez] ea64b0: shared/rap: Add client real-time ranging
 registrat...
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

  Branch: refs/heads/1098168
  Home:   https://github.com/bluez/bluez
  Commit: ea64b06fc351ced86319a789e5bde3506c3751c6
      https://github.com/bluez/bluez/commit/ea64b06fc351ced86319a789e5bde3506c3751c6
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-20 (Wed, 20 May 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Add client real-time ranging registration and notification parsing

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
