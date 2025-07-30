Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB52D8DA9
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883721; cv=none; b=adGp2hiOEsdMfM0BS8VpJgzmEggJyK7I36QCCF/RmdTQM+1lBZkYvmXpn6/piuCiTqTgTQuJr57f6VkKZSd3cpUO1mighRf6tTZ2BfnsUZsp9FlwMUcyAxiWYpyTLPsGPN6gTwgVQkyen4zXtnc8OqsGmDlV/qq+LTh3pDZM6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883721; c=relaxed/simple;
	bh=jJAGnZidVooHii3shAjXk5SHFRph6b04SpB9tr62bhk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BVPCo2zJ1K+TfM9pwfGCeh5p3YMy/5oaj2ahyY+c2xQuO0RV81kDEOt7OSJHC5TLXey9uEH3W3ErPLI2kIzSXhg2Y/SadeDcfyPUtZ3ye4fI5QbA2bOw82OtUPcdYkFi02IfrlTAuuke68HbP64BnRKUEopSVbIOL9IDBoF6UWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=adfwBSJT; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="adfwBSJT"
Received: from github.com (hubbernetes-node-22889b5.ac4-iad.github.net [10.52.135.25])
	by smtp.github.com (Postfix) with ESMTPA id 031A321383
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753883718;
	bh=Z89A5GvQt66JhyrpKF69wFURAgXuq1wX1wipkYOmIEg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=adfwBSJTlhCdQtRCndSAsPvrapD/KWask4PVywTbz6Y4L+eUdEKAIC5OlCAGLpXbY
	 +VQDw0S1tpuXBegpbwU0F5XHkincp4W7/CPFNh8SB4JMBW+TioZNDW7eap+2fpncjz
	 R7sM39olMBqw6fX7W8t1IY1wu71hx3Vlskwg962I=
Date: Wed, 30 Jul 2025 06:55:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/986817/6f89e9-000000@github.com>
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

  Branch: refs/heads/986817
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
