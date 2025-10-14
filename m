Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2671307AEF
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475516; cv=none; b=U5dfCXkD8GYdkddpjA96ayoXh3fLA/R+aQLO724Ioyf1cTgI5EPdzJEhM/x1lNxj52MgbTni/fv54CXSxY3F1jSH1yD59xNFsSPw3DXYGh9SGRWtcP+LeoOgagkzzVHXMZg9cc4UwdZNwIAnOCYHmKNo3I4/ILsZYtoKHCe+a3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475516; c=relaxed/simple;
	bh=DK/RJA+RaoW/FXLxyqT57a112d16pzhl/LNYP0g8EBI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qId1P2w7rpstHorxkhL6tA44IhO1MOOwC1FHqGHA3YIlMm9i6paJiMhBgc4poXoUPIJoWuxOFUybgdA8AuTDTIixi0x02O92u1TbkhX1KzsmOxrBcX+XTzLDSlqtxuWHdW4PDCwW277hmxF3ZMWDQPlIHE8yJZmQzm7gsfNkV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MOEwy+ag; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MOEwy+ag"
Received: from github.com (hubbernetes-node-7243035.ac4-iad.github.net [10.52.133.29])
	by smtp.github.com (Postfix) with ESMTPA id B37326406EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760475513;
	bh=7pULMyAUavs4eS5h2xFHczOjXm5ZOWNoSpvVq2vP2xQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MOEwy+agNGhivUwxjI9qhWEkmgzYdXrsB8wKZOJ5cS/P1txtc5bo2qTKZiE/V21MU
	 QipDSDjy4MQRb6G5sTbZH6cKDhpWzfnFEWpOd2GGQ6JUyNw5nBZNmA3Ozrjz2KOtkk
	 veW2EFEgehCvXm0v69PlRhzS7rLP5qIn4pAET0Ns=
Date: Tue, 14 Oct 2025 13:58:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009899/77f8a3-000000@github.com>
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

  Branch: refs/heads/1009899
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
