Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F8379EC6
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682344; cv=none; b=JXhFDmjGtabNTR7Bi1FheupAyBJnhhJ++228Vlz0LRswikYTtIHdfVXgZ+ALetrHCA9c7nNXjKwXRscwR+NqcN0Op794qf3Pgg7B9VZSwWMahPl+Nh8gFKcpvSa5EbHSzcFD2fbNEgWwMnmRegkyufkwqftdDlQVXpsz8Mt3al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682344; c=relaxed/simple;
	bh=O82m5RgtjCQNZCzNnkUsmw+GT1lL3/wGgkG8peYyYw0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=loe1LrUmKdkPwdFU77VXZ26xZ7CPhCUwrVOxXL2kjjbakW4zYT4OLMVnyTz/lOjK0r8c6hfTdxz0C6W9J2LkjtMkjFLQsv5LZrMrOgVOWaSoUyCFEjmHDhNtqDByJhhjSaCQJJsldtIIu8VlxzuSr/1mNewxW4LNPmzccNK5wpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iauCY8Mf; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iauCY8Mf"
Received: from github.com (hubbernetes-node-2e1587f.va3-iad.github.net [10.48.210.64])
	by smtp.github.com (Postfix) with ESMTPA id D9E89E06E4
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775682342;
	bh=ATj1B0PEx8E1jmQ4e70stW4jrjPNDN02tR6c+6U5L/s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iauCY8MfYWV7/Hd9UvYQZQy64mOf2HqzopPoeRqbR9LaWX9vMmqQN5H2Iypq51+do
	 V7IovxstZwyPBKVF+ldOyKZxBz2XbJelVSMdBN/gSqnbJckD4VxKGEP0jebFio9Qbq
	 mymVi3QPsRXMz4aq/sOdJ8HkXWwzw2XbO2vTSLZo=
Date: Wed, 08 Apr 2026 14:05:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078903/d51fcb-000000@github.com>
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

  Branch: refs/heads/1078903
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
