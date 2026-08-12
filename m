Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D413624AE
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528177; cv=none; b=JdeZAHZ2m2qWQwk//wUpnVU3ukgIjuCpTFLAba4QZvgxzc/hFzz19Tb0v4RQers4D9izJYhM1D11CGpM96Ej4RQgYFiD3wkhycyNJpTMob4rPV2KMzCPmJfe2s2IHuzz/2XbVLcVaNF54vwwrK/RN62JZXR2YxQQijMRybeZe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528177; c=relaxed/simple;
	bh=FPKasyCouYakKdIbUsUAa7LGMM7gcSXoM45q6aNf7VU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OvH9pxXie5nrtrzYqxbVayIGNU7AYgJTA2fVoAfqCyuxRZj222fw9CFDndAc73kd1c0jdx/rXaYyDtxdsXf+kRI831U7RRbksIGYOYRIhykNEGjAfDh1L1ZhhK5NTNWwXZWeDwa3aJPkr24CKkzrbv5YjTsK1ji62J5RjeLIOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mdsFzCqY; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mdsFzCqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786528175;
	bh=WcKfHHLWV7/egoTpEqCZm4tM8QgWp/vi+1IE4qCtbuQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mdsFzCqYcS7tJJmICH3fN/Qv79UDgRdNcCFTEQlB69zzubzPKfVLIodqaDOOAWSVu
	 n8nCStwY2vCJoaOtT2Fu6f699vGgIEPJ7v11Dw9a3gl0DJ/m6G2ZdYAZI2d3905UbJ
	 zysocwUSrbivTXjubmPuh0+8LKkYSFBb+yzuXWfo=
Received: from github.com (hubbernetes-node-f924d0f.va3-iad.github.net [10.48.94.60])
	by smtp.github.com (Postfix) with ESMTPA id CF07928088D
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 02:49:35 -0700 (PDT)
Date: Wed, 12 Aug 2026 02:49:35 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1144151/ba6f40-000000@github.com>
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

  Branch: refs/heads/1144151
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
