Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073C2BD59C
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510357; cv=none; b=MuYazkfzXazJyxzo2iYwesbOJTA3r8XYNtQslQm1S2td3UaDJvDpmWKQ+UCestvDV5QyQ2m0A2wHdyxa08nbb6KLxIysBZuEXYDz7Kl5eTZYSfFC8hqOUahfGIQxkfe8YxnbwVuM+mVrwfbpuftc8FSfn/ZLr8w5eDpRlSchOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510357; c=relaxed/simple;
	bh=nmbPCGkq7TcwIyDXPetFisu5OsFx7fRZqt/RDg9HLNw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NmpZIfUfc5C0JZdAJgv4HepgleRnXEhC01+PrOBE506gMxvZo41vLomDqyY4yHrTSqcd2Xx1Tu44sA6TRySGk2b7reLiL1d808sVU1mvvmPDGLFtPWnkENRMXZwDBYqvry1mpEgJVbcStzPvQc4kKRSx2iFGbk7a6OPm/RNoE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hdUjgorN; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hdUjgorN"
Received: from github.com (hubbernetes-node-e7db897.ash1-iad.github.net [10.56.157.37])
	by smtp.github.com (Postfix) with ESMTPA id B8C499205CF
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754510354;
	bh=g1ifJdal5jUWRTI7eCqzBnknO0YHD0x5XNwWIszkr0o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hdUjgorNJyqF//GV0vpBPj4rChscKhqO3EGaUigfwVt46r7vj7Pc2DywTelAJ/S/Y
	 s3+9FSaPL1Jkqw1WjTmkPI4K1zAve+4VKgcn+vZMa4yehoOaojxT27Ija7hecXRuLU
	 jTYqSSqg4y4Pz9KACu+DbiDoNiJ6wqNJnaDM+HFo=
Date: Wed, 06 Aug 2025 12:59:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979806/de485c-000000@github.com>
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

  Branch: refs/heads/979806
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
