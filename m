Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729312CDA5
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168858; cv=none; b=LVNnIqy8/af6LWtOKVRUQ8rPDx1YmmhkbyszOKaKckizE748kzQkbb285EsivIGWdrEF4L8e5U7mn60VTX9QNMrajWRB1q5ON+Y+edRhL2KTMi72isqM6sPGsqzfFFGDgIjsIQQnKDOu9y9ak37qe8VGLCe2rC2QFxcCQ2++8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168858; c=relaxed/simple;
	bh=Khte3oIIlUi28Q58s6+fz99U2mStqYYLlqMx93pq6i4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D//7X+yGDVIw+mkKOEds2V1BxjR/8a0SERFWcGGwONdPHiH268VOfhEijU4JWDFgWKttAr3tG8QbwMzY9zVeZm41ua3NGgpn7JewYwdueUajPTBMpPNO75h9fP2R/82+WyH99w0lymgyWla3Y2UFm0bcQiqUBv+LlXs7/kEjvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kuO5mRK2; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kuO5mRK2"
Received: from github.com (hubbernetes-node-0397efb.ash1-iad.github.net [10.56.194.48])
	by smtp.github.com (Postfix) with ESMTPA id 94FD214079B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761168856;
	bh=jYYvWQeSYyE+Oa10W9K+nl+GtTaMSXkthmM7H08dTj4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kuO5mRK2BTIwgjmjSHi8kLWEuLxhYetoe/Hl19xFEjk49OCOii82pV8qj8FeIcNlA
	 0uzkz8sDHHLzKXMyqhDs+9NbNdxVNEaqq/M2l7R7AxQATAB2IHa21ZnXrF8b0UGS/q
	 Wn1ItEeFBNNbH8eTzQfC4XqT0SWunqk0kGPoe7Mo=
Date: Wed, 22 Oct 2025 14:34:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014533/106401-000000@github.com>
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

  Branch: refs/heads/1014533
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
