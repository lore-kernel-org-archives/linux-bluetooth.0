Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465ED2BD591
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431334; cv=none; b=fLcScZJX2MYuEjBspzyGMuni7x8OfLFdnkyvrHIu2xQOhiislYjDV4A7aCUEmTvI2gpAPtJIZjmXLrJBovAZw1LFCE061u2YQOnivbiGkjkS+gXDodsILHf311TijODoHL8KnSU8ZClkDz4buVS2v/yzdJ7UYqSzk6lT10VXUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431334; c=relaxed/simple;
	bh=P1rdOZwtnf5w7vgjCMvO7Dd5HnFZOvJLQE8O64WcQS0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PWmaVS7hmUEa6nU/qiL8mrphnmuD+S48RFcx+jhMaJuqQTJD6GGcZaFB9wliX9EDCh5o8QS0W8ncbY19HDILouwLOJn5vJ/+EiQzrkv1TVy//zUzx303HiUe4ibXHUloqextBfWPfr27uJl2PuhOJX0MvQDY8yad9m/vtXUCm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VHcnMbRv; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VHcnMbRv"
Received: from github.com (hubbernetes-node-44aa45b.ac4-iad.github.net [10.52.175.51])
	by smtp.github.com (Postfix) with ESMTPA id 5AF4A640E01
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750431332;
	bh=nGKauFqkRid0TpgSiMDHKUvj/A/hIq3W63tS2JDLUJY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VHcnMbRvrhnaZoUx57eIyuHUbVIzS7TLHfW64d3HH5B8PtkB6prDDxB2gRXRlmPiS
	 to7wZXomU8IgCs7y2J9BlJ1weLC46AGRC8oiDKtA2ChiMOWy2RSS68I4yDW5QFPjs0
	 Z5IcUuCSTI5B4fx6pee9rjXoWqepG3pWLxBJfFlE=
Date: Fri, 20 Jun 2025 07:55:32 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973896/4f4f7d-000000@github.com>
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

  Branch: refs/heads/973896
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
