Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4D363C56
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932815; cv=none; b=FqaKfYnuygwFRgTZdO3o6g7hzbJ/Yi8fsE6quLSNAEfIHNe4wxRI4in8p2gR8RoGfeonHXBqnwPLreF+ZzbH/OUU1AstGJlbIy17IU8NR0O6quzRKEizhZdCY9txvsTAMDLVprIY9XBLftv2IWEkMDObswl7duhf8XQPOrJtfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932815; c=relaxed/simple;
	bh=X3FeaJWRal384XC44FVkK0B3n83ySIw6OW6Bybn6Wj0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eVvka3sdaswdyqNzocVB5nS3ylw3Ec3EJsGqo7jsSk9XHBt1aaHfzthWEigjewePn69bWkL7NW8I8FdDaEy7GL03pLFMV1BYb/DCNh1ZZJ3ah+b7UoflmbJUTpvGDDlGskRb4y2FvSm+pTG+gEaZecRmpdQsoAuA/Vosi7iPabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WlicFaOK; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WlicFaOK"
Received: from github.com (hubbernetes-node-5b80fdc.ash1-iad.github.net [10.56.158.23])
	by smtp.github.com (Postfix) with ESMTPA id 5E2BE2E12AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773932813;
	bh=CGvepgKz37dXONJEpSYR3Hb101EjWIUFqt12shXWA90=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WlicFaOKG+qIcbWSNT/BtImSYnGCd/faQgsEdOU0QHi+ekCGhVVZFwfy011ZTWda3
	 EdC0wdmABFINB97mfAC5RxcYIqQga+JQMX5xY5X2XzLj1YE8J7kjPDOOL28vimjvV+
	 p37+BfiWVXWkIpPBVQ8cEtjT5q5mWx2O9RReyh5U=
Date: Thu, 19 Mar 2026 08:06:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1068955/bb6234-000000@github.com>
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

  Branch: refs/heads/1068955
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
