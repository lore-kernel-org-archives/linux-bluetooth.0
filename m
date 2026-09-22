Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F4552930
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092016; cv=none; b=EOhh75HEzvWNsEoXLmppcWeA4tVoRx5b5bR8f8z/SVcyMV/DAxqJNiKTo8IJ2a/sIbjKaJIXXaUkdyfClSRGFZBdpg94fox96JWyDLixIIH/XlGpOSdEemboyH23/czLoUc/efuaYOFZp7JZfFAvR9lNM7xBtWL9fgaFAgr4GGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092016; c=relaxed/simple;
	bh=AZJOZUJRXps6CVu5UiYUK8uZkFjLl69Z1XwNP4vSncY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iMFmtuuuEQUuiObY1M1NH7uSUEDgbABJhE9+GrXOAk99mpPllnC3gjjQI8SVu6GF6D+8Qz7Da/sElo3Q7LWFD4RUsqqMRlp8v6A8kLxg/FFsCmccC2ABy7mAqMoGP/FIpnPyN4SsBf6dLvU3q57LtTBm2aybbFrhzMYsdPOSlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XfOGqZiL; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XfOGqZiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790092011;
	bh=A4CpWpOICtTrCEuozFuZ93+NRyckkJcy0tT5X0is1qM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XfOGqZiLis20xPYpuqenJ8SyUf+C+8HE+ACxreXpfaP4c+K6zea9Ncmw79s0Og0r7
	 DH9Gf01N984qa62hplvLh+17Febn8CfOi6vUDhbkRnbqaLNyT0hxFJdXzcWE8IaHec
	 3ju/mmacIfiLS6DiZpgY/XsIC0qfmlwQI/s1o68Q=
Received: from github.com (hubbernetes-node-5d16d3e.va3-iad.github.net [10.48.74.78])
	by smtp.github.com (Postfix) with ESMTPA id 1D049280636
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 08:46:51 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:46:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1170704/959a7d-000000@github.com>
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

  Branch: refs/heads/1170704
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
