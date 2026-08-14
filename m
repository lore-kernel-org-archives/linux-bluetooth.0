Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E53367F36
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733725; cv=none; b=UP4OchUA2vMwKZS9YXR/M0G3vNK96mONDzdXP1JHac+4oXcR+ee3fIVaETyUuqOVhNSaa+RcTtkJWiQgf5ggDLYmScW57voKj3OBk+UOv1Hf/l8lZ7gt4idS9ywB2CG7c1H/HmjVLOyPcGyxRCAcXprOLuEdRYcbcezuN5npHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733725; c=relaxed/simple;
	bh=X6lHOZx0XJp6Em4r2QXHTRff45ROdg/6ieRz0Pdp6Rk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Vq3LJKTkswxIpRjCNJg6cU2g0JTQDAEoOsPEknevwq8NO+5tyxMXsNoOOuLkcI2UqW+0vJalVDVxCr/Wb0QBBn5aY9iV0P/xkAVfIocvOKAeCIfgnfpWxv1vSLe3rRyKk3LcmMIGt5TpHy7tyiONfsGWQJbZv4kgVJMZ2RhXdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Swpu0ZN9; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Swpu0ZN9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786733721;
	bh=FWXEVy6jSzr/us3eTB7jfl/n5LgqnPAL37sKZdlhlVQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Swpu0ZN9RuPfNE5bh3ecREbxIJ08xSKpLW25X5xCE9DmdGc93EiVucBvsfQdaYabw
	 kKexR36cu0thIwASDcxoNrZ/XdPLr+zyqDcnJ/MEs+kg6NWqPyumq7TfFANI4iR94e
	 +VL2EFqBDlb4858Mt/1fFsWZTGxuvVSsh+Q4Ul6o=
Received: from github.com (hubbernetes-node-02f02c8.ash1-iad.github.net [10.56.156.38])
	by smtp.github.com (Postfix) with ESMTPA id EB40B520C88
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:55:20 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:55:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146125/61b2d3-000000@github.com>
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

  Branch: refs/heads/1146125
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
