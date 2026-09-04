Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B035339872
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557834; cv=none; b=N6pW+YyWD5g/7JiuxwGyHh/UlK25qdOaZ1HdWwoCOKYv960y0NDTPYD8kPh7trFgo7+UZBYrfCQIUXV4wx341paH/vrzg3cng/9C24+E3+u/11bOYzmKLhrlCtZddf8l5JXRtyNokfdTIxJTDDMkWzsBJJ8ikVtCeSB/DqgJI0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557834; c=relaxed/simple;
	bh=kmzEgQ0p2Bhop1HB+VswZxiJzyEPeX2m2i5Y6fPhg4Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uPDma+nxRDeNugIof2XXwpv6M4tXQDhUonwLo7zujKTCLWgCoUeqfJ0jBkYThmvhNF4jeeegVkWZhUUT2zp0PeZJwGt2RiZBZfiQRN2tvFV+I2MGc3h4HjiERvi0FGIjb1zEbpEYoQ1bq96iXLEtfX9RlZM6i5vPFFVS10haO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XpluXlNn; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XpluXlNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788557832;
	bh=r/hzzgMlGw8M4ff2QzkDvgYeLwV0TYuEIgB8K2+vI4s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XpluXlNnGNTe1kVyVTlvtkMFVpCwI+xq3CFWzSYMMP7SWm727WSBmqZcr/EjRgWVO
	 iS5dIuIDDl2gxMZt6OVXJFBEn5mAGZLTOme8MNgNQZefhe7nQJXi7nxcAT7OOqozSi
	 MOzolAITj9WoZSH/k1DWggxsCjkO7nqT/DIRvwak=
Received: from github.com (hubbernetes-node-520f5bd.ac4-iad.github.net [10.52.181.53])
	by smtp.github.com (Postfix) with ESMTPA id F2C0A32074E
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:37:11 -0700 (PDT)
Date: Fri, 04 Sep 2026 14:37:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157383/ab6c9f-000000@github.com>
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

  Branch: refs/heads/1157383
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
