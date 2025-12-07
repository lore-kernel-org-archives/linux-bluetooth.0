Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74638DE1
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Dec 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765102176; cv=none; b=NqEKBhFmYbcuCtRUeZNfCq1HbA54vX4TpwGUcV00if4lmRyDnsF6UxJyBwzD4ACAS1r6zgHUqRURnlEYJeNFrtlMqalWTfK7j9g8lnVBRbjC2gQrSXfnbXXyuRL9M3LJ5tDfiAKQEASU6T16hl8nn+QAcQGeKXO7cWlAqnX29Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765102176; c=relaxed/simple;
	bh=2ySJ5fnbjuJinQHGPxTDXIgQ30O+AToCW/EIRHYYr24=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h1qcAUOjVffUuGwIVZ/ra3fwUJGig0ZMsl8UGBNX4cp/iJLvhiTURBVgEE00lOf8dyet4EZJJKwGcj/VL37B17D8d3Cg3HbTinm/bTQgc9JBAMzMpMzbgndxEgVjkLwYEY2bBGhIPFL+2Q4oR75UEfY1VUfNzhVqD+yq6/x121E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ftb3i5z4; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ftb3i5z4"
Received: from github.com (hubbernetes-node-89310bd.ac4-iad.github.net [10.52.164.17])
	by smtp.github.com (Postfix) with ESMTPA id 1D9382089B
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Dec 2025 02:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765102174;
	bh=imk81AcaoSkukXjw+j/P1w/S3hUabDp9TKf9J2Bby+k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ftb3i5z4MQYoK0+Icb0rrMAcia8nAzDDfLYqbld2yQqejOmgAf8bgtra1AE6psyGD
	 Q6LLuOlTD2yNQi052u47nDz1lSrcab6fWTk9irz6cvoMY8hc5tT9xeLADslV2LCPgI
	 KMS90Yd5QKrypiDLC/xaOKBWIw89wALvcJJVonMM=
Date: Sun, 07 Dec 2025 02:09:34 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020791/cb6846-000000@github.com>
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

  Branch: refs/heads/1020791
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
