Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD03A5E7C
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757885; cv=none; b=VBqtpa3+kOEewh0RzHaVZEEGjVYRC2xI9cj+PyF61DbUxovICHcbtRYPpTdGjWyAQM88pMaBJ0cFJQ6+0X8zc6+wNVuGF1xZyjeTlAgl/EoOJPzRJaII2b0p9YJ/YjSWaabcLRFoc+Sf5f9zaVOB5n+qiDf9O7jTr2i31LalIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757885; c=relaxed/simple;
	bh=UhnNt6IaWTJGzqx1BrA+ieOQMBdzXgjrVnbRBTf5AF8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fbCdqA3gYWAREmhFF+3Sem4oFSPRQc/Ljjf+QsxoP86UkeQnI8Tts3Z39reordON7BMJwrtyar4ym0Ods5EqmMSX9iFUts8KgPV46Jg6WYgRRJDNaWSbzCt9Cn1Je3z3QIOvrcuUkoSocI3XP61+utq0rko77iC148j0AhDgJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=khQzjfPJ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="khQzjfPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778757883;
	bh=ukO8WKSW4sh9NP9njgov/0smR2KKcqrsOVK/Y72aUyo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=khQzjfPJ1v9tooSCLt6W2qah11Doh2nG79n67e+zM/iiuwlZ1LS9pXk1GeYsANskr
	 QNlJs0fGxXr1J3hXReJn3LFeEW3/ttbMz7VxbTzAib+DrgVDj0Jp1u6Za2ZuXPLACU
	 TLxuZJV5t8gZSkaO87hJUZe4ud2is3e5Ql0SdLy0=
Received: from github.com (hubbernetes-node-076fb8e.va3-iad.github.net [10.48.200.53])
	by smtp.github.com (Postfix) with ESMTPA id 641AB80107A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 04:24:43 -0700 (PDT)
Date: Thu, 14 May 2026 04:24:43 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1094712/000000-f2d501@github.com>
Subject: [bluez/bluez] f2d501: shared/bap: set QoS state when CIS is lost
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

  Branch: refs/heads/1094712
  Home:   https://github.com/bluez/bluez
  Commit: f2d501a965dcdd505bde4903c38fe58acf9cb0cb
      https://github.com/bluez/bluez/commit/f2d501a965dcdd505bde4903c38fe58acf9cb0cb
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: set QoS state when CIS is lost

This is used to pass PTS tests BAP/USR/SCC/BV-167-C
and BAP/USR/SCC/BV-168-C.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
