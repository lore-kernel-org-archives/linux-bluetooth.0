Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435894CC269
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498717; cv=none; b=FO+DDchBs2qUIJZESMI2Tiasb3pZied+Z9aCW1Vj2RJZ/vsNcM2ZKUzZ5AJmS/LBlPtTUG/znhmT09NUTdZN5oIwCWlg3TIajhts0xIyNT5zYJpsKFsTQKNei8bf1JXX3LwVyV6flK8v9JTA9AWlyolk9egRtD1JXdUqHDHF3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498717; c=relaxed/simple;
	bh=akEW0MGlOKaUjX7Cb02buBi+SkvdCiw2Jw7ljOtxk0o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XRi/B12RTaSODOl/fVtSLSDglvLsMwOZqhSAJ4pCf6lalEEvk3B2777QiEEnR7HHi7bXPRFjwJbQhKPHrlN9K0BOBGWOF9GxnO/nnRdkq2IuJBEEpS2NE+Fp2MGSsUKlvXv3mz1u8fXb7afHMl0ad4G8WLVBMtXJi4ZbWJ/7n8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JaZtFzEN; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JaZtFzEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789498715;
	bh=p4LhV89EDf2W7Q88OeUbdQoAcOLYz3z21a2+W2Y/SL4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JaZtFzENr16bAW40AQJDNKZMOGTSQeessOIeriaNgA12AbAP5CWyLVK3dHok4uSYu
	 x2s7xCkizNo1A+k6pgIDKfWRDLx1J7NqfKppLItgNnOqbnXsuCiJJVs2bhRVKULgz0
	 GcwwOq09ctxdGBIwnLIZVLoH53fqXjYE66dDzZRU=
Received: from github.com (hubbernetes-node-e637f89.ac4-iad.github.net [10.52.202.57])
	by smtp.github.com (Postfix) with ESMTPA id 62E2C74143E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 11:58:35 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:58:35 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1164802/fa99a4-000000@github.com>
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

  Branch: refs/heads/1164802
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
