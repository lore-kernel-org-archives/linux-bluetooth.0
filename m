Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A40379EF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261779; cv=none; b=aYKb8tXxhs1JD6AJW365DC0bMaWcRMVeqOfWqZQpsqWlFHi6X1psvu+9O2MBwd0N/6u7ktAFIpu9MSN+WW7zyCwS5IkaCVeYOQy00Oi3ha8sdxthdGgIhA0S3Jj96DMGVNx4Q+PISkUYI5eZaQq+ou6z9Yl7e/qp9Lrk/yoKMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261779; c=relaxed/simple;
	bh=1P3rpllmwO4Ew00UJeFqPgk7AQYaHP5Pze+cyQS7qac=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=k76/82vcBYKqxWX2GruaNuhtRMVa15YCA7JVWyD7gOYI1ETGu/OMg54uiIsaFqwS1iJjl/4b5QuUCbIeqrfkHNLwKRnAKorHyoqP6qXPTkJDtMsao4i80p9L45NaMNfXQWLHiqDVPz+hHk2doM2FVEohIR4aXYM9Un7qEigeoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lZb103pc; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lZb103pc"
Received: from github.com (hubbernetes-node-1e9196e.ac4-iad.github.net [10.52.136.20])
	by smtp.github.com (Postfix) with ESMTPA id 11D364010AD
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773261777;
	bh=zKvLqQNaC10d825HK1Vbv+YyRL89PxUzm6nZ1+GkzPY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lZb103pcaarXKtmRbPXtfXBn3uk7l/zNSQ9DtRtcmBBKXUuLSynSsxmzShnXA5QZi
	 hEakh1WGlFD65yxArp09cOdc3tASODZyRXsN+M1iyXvXLjE5Zi22v0Fwfbl8acgAgz
	 Y3Ld9C2n7T29mId3jb6YvKFgEHXsyGlCLNm+5s8I=
Date: Wed, 11 Mar 2026 13:42:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1064659/3b918d-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1064659
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
