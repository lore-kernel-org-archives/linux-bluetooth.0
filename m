Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCD2D0606
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436648; cv=none; b=F1SzmOHTJxM8hrTMPECj5ENp8zJYPM7gM3emSzqHh83b4EQOjQ0GUK6oxb2M42DX8QqhA1AOQ7P1MopTUkiAzXAGeS1ROngwz89cUgLpBvnx04WZ2Zm3Esc0PQ6OUI04tlUBpUFGH2IKD9hr11S2x1UhMr/uzfy/pcXmXcxgScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436648; c=relaxed/simple;
	bh=bnynu/jMay94Hj0DwlbbL0LnP76XQSdLVABiCJCFXoI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RFtd/AOfx2Gux7l5fICE9LhBx0AxQh6CMyuK5pu+rpvIcNdGnhhuKjGRHNB5nV7DNOGi6r+WkPt+/iDVRi43CPimkHF6FpmU39KZE2ScFciARlkaJnrpjPGGxJzj3m3RvNoaLxPQ/8ai8ZBkyOq6oSxQgjt/FYW9HfIdAhuaqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Vqt4Fjjg; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Vqt4Fjjg"
Received: from github.com (hubbernetes-node-f28788c.ac4-iad.github.net [10.52.211.86])
	by smtp.github.com (Postfix) with ESMTPA id 635F54010DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766436646;
	bh=zGm18gFy+2ud03AJi09n4HV37gGU9sTR3JUu1PeTAyI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Vqt4FjjgcVTN35FkOG4KB2gSpPNgcV4jPMsvxDggm5i9isCe++P7n4Ys57IymvRCN
	 UePePv42HOJUKUJOWqetTCVg1Vo59jthWOGOYvkgKP6crP/BketiuxFqkrO7X/JB3x
	 /Pd29SFOr7tqW/enN+K0moE9GjyAkwYcqBtRnYXU=
Date: Mon, 22 Dec 2025 12:50:46 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1035059/ad7749-000000@github.com>
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

  Branch: refs/heads/1035059
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
