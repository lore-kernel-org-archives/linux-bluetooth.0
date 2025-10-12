Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6431E7C2E
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Oct 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760266796; cv=none; b=hmwD2mRSC1owYwjFvp0izLRvMJ2HcxHJFU3ew3XURvHEtkETw7VO7eackLmqx7ZKqJV7kW58rQMOCX3oBSsEhNG0xTq6wPcXSRR/pfddtbLSjhk5M9CBEC3+HsAxvl2d7BSThMMNbWgvS+86yPm+dHRvVwSX6jZyairkQZ3xEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760266796; c=relaxed/simple;
	bh=vmhN9IDw+dVwsuzUjWP0A/RV/53VUP5lsDfnw7Fkm3E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ofqh7z6+TvpyERhfMrGfynhoJkHEdmLXBCH/Xvi+B5rA3bsDB6+GObMjr5ZX1QAN3GfqKJLAv/9yBzP6fEi2lzYh1jhbmFWBWNgqtMm8ZNtsNn3fdinSfk+tSb/lvTUIHqy4jg8E05jYhjNYeu5t0m1hAjUf3a2B9iT/vFGVSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NCaCobsD; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NCaCobsD"
Received: from github.com (hubbernetes-node-0478005.va3-iad.github.net [10.48.206.57])
	by smtp.github.com (Postfix) with ESMTPA id A367C4E02A9
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Oct 2025 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760266793;
	bh=APsAwhE7+8pml54Haly2XzKFI3A6B5tC+LDqnO0m0fc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NCaCobsDmz+pqEvU1aYW+oVFzmVWRFdrGvZytHL4h3mJ4abLbZ1DiynVjXGdQmajN
	 u9mbNZVWrLRIvAf2zMOV+nsF2ayvjOUxv/ZFDY58r5osI5JzUdoNrnRu6J7H9Shx8R
	 Rv7B/3xjF4EKVP4RaJXoK1HT3WFjNunI6adrFlmg=
Date: Sun, 12 Oct 2025 03:59:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001717/e9bac1-000000@github.com>
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

  Branch: refs/heads/1001717
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
