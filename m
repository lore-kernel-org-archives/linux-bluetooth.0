Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D4170A19
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379428; cv=none; b=fiIoCTCbXpRBd14PzH/XuO+bcFzdNqnoaeAyY8T87bwSWkdfMSm819tVI3TOdCsAbdjKMGBgJuRMwhk2ZPrFoZnWYzoqWMAU4+Goxy4CPaeNOpiur4AQzuEsTlpKV85IN1NHJtc4kpciBX7HtFuQbddrN8gvUkWRe+Tv3rG5GL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379428; c=relaxed/simple;
	bh=7LVgAEZO0NBfylLDxALb9YNO2rFzaACh41pSzKKZtUk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FwTHdC9wWbZNsoI3TrAH0f0wiee+ugTlBe7pJLSUaV97KJdG3VkwmT9n0zlIBL4fR3AbKXANi1DVxEQR/joZKLZC1RuMk7kOqCuAe0rDe/riT2FSfrdd6IQgDRV6pasMYvuK45wt2KCX57HPaZPkeC+4Vhgklr+sh8AN0UIDals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Cf0BWcO1; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Cf0BWcO1"
Received: from github.com (hubbernetes-node-8735374.ac4-iad.github.net [10.52.132.29])
	by smtp.github.com (Postfix) with ESMTPA id A2814640A64
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1727379425;
	bh=xo8xMe2MmYINHB9/CjNO0fg7ARSH46fADAO9BNySjiA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Cf0BWcO1kfqjbIp81aYeEwYWVDzMwmAG7/sKZyWjAwr6g2chWYiCuVvpDNM2AYwRo
	 1WgKuOcptW647tpSaiBuRoagUv1UO0GUy0Gi7+D00bOcDzWXxsy/5Ur6vvsA0okRu9
	 Y40iBPtfys5gYC+nk8APxmLe+5hC5tX42S/k1uE0=
Date: Thu, 26 Sep 2024 12:37:05 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5b6ffe-9a9dc3@github.com>
Subject: [bluez/bluez] 9a9dc3: shared/shell: Allow script command to be used
 with...
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
  Commit: 9a9dc3d456c04cb7f364ade1271113af7e2f6b03
      https://github.com/bluez/bluez/commit/9a9dc3d456c04cb7f364ade1271113af7e2f6b03
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-25 (Wed, 25 Sep 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Allow script command to be used within scripts

This makes script command to allow the usage of script within the
script file by saving existing execute queue and then replacing the
line with script command with the lines of the input file.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
