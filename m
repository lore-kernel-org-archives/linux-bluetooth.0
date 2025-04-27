Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF11A55
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745765753; cv=none; b=RzszxPtrsmUg9OHC3BQClb/rzo3UMpaVttUM7yVLKqSXYmiwdmHEojcdo9zp9nk2oAijMmg6wXwKgdoQ3MQP8vz9O7zHzfbhshZRgOQBMU2A1KA8akjgvvl1ui+e7x2qgXd3CaYpOKfD7ecjMZGCbqjzHIUhNXjLz6wXfcDt6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745765753; c=relaxed/simple;
	bh=QoEgWlileFyqKnCio4LGZA9ZzxxCnNoTj9WbfFvc7xo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rqOhuGft5m8dQX5wO9DkN6KVEe6bHKPMTppA9LVrF1r0ovZ/IuVIx4LKpqbGnn6e0Q6dc0Zeg8xxssTiztSTRSYTsCSPOY/+1owp27M4qaKwv1jUgbykUV8E+PaXjvAFKCrcUmeEBnPVpX4MpoDvnQA2ZiOc5uLnWuZq4IT7gAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QYR/ArRh; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QYR/ArRh"
Received: from github.com (hubbernetes-node-979ae9e.ac4-iad.github.net [10.52.162.16])
	by smtp.github.com (Postfix) with ESMTPA id 8E4732029C
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745765751;
	bh=IqGCXkKXWQugAkiyvw4KO44lWUXIsH92fQ6hUXfTxcw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QYR/ArRhfhxxzXMvJ9W2u4ENfeADLtYbP9OA+sm+DecU8sAB1PokjjWpIJJwQ+g4J
	 QMdnGXGzlySu9zhnb/2PVA0YTn1FudQzZTXrs9kHSjy2jJ456moAq3uTm4vWYZ1UHv
	 FWF6POEOeW+01HY5ahAlInJlWhb6/ha15fyU5jFs=
Date: Sun, 27 Apr 2025 07:55:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/955284/6ae7c4-000000@github.com>
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

  Branch: refs/heads/955284
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
