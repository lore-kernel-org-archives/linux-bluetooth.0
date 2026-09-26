Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B733D6ED
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433926; cv=none; b=SGpwOd7jVchyW8EKYrUo++b1aJ6F1Q/NrPGHAu1pn0wmgaARN8zQ/BOyS+LdEvEiKnLiz+MXSyxbDYu+pguNObYLw5NLnWRqKkzB6ym3m7/8hPAXrXzaNVtsHDUh6NGUq3RyP/86Wibl89m419o8BwWbn94IRfsBMpahKv06htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433926; c=relaxed/simple;
	bh=tnnY7hDFDzfOqy9rKWKPRkr85lDbrpx0NzNI8GviEcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gfl12iEG2tVyBLDXxzJmNdkjed7/0sPydu4bKQbIFX8aci0xyLqz2AIPJAMtuPckwhnE1XeS9R4dBhV7EQ51oqOQyeWzDHp/bu0CnL3JNSz1n+CK8bwR5IGNnlCShy7UGguuKMsytHGsnLu6n8jP9MLCaarnEmB91imodE50Wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pp+GCg6R; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pp+GCg6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790433916; x=1790693116;
	bh=tnnY7hDFDzfOqy9rKWKPRkr85lDbrpx0NzNI8GviEcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pp+GCg6RJNn3jtun7/aeLa7bn6UmyY2D+r6jzQx7tgnfqHbxCurcSD6/MYvFv7ZVd
	 Nnsdb9/RZSyUKDy/stBag53NB0KMUkJilGE5UoDOVwc9qC4LlKEBAWHQaPE36imUa/
	 bEWPkMSV5llqyzt2lNmYo/lz4Xmj1N/wySX5GuKJJeiDvcVUcqdJ1dHHUNpQVnjHGE
	 IKWJ55k4n3sqQBOxjvV2GbEg6cUEb+AeVIysuujDmbLtnzSun2rcxEKSxHIiv30T8O
	 JDSDaYDClEfBdCsB0LR9lr1QTAiCOaKLRmnSu6lWK9GGYbulVghkeTOqZrfzydaEQj
	 rXj7PgykdwYPA==
Date: Sat, 26 Sep 2026 14:45:11 +0000
To: Ravindra <ravindra@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: linux-bluetooth@vger.kernel.org, "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Kiran K <kiran.k@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v4 4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
Message-ID: <20260926144507.17217-1-lsa.uz@pm.me>
In-Reply-To: <20260926085302.2879093-4-ravindra@intel.com>
References: <20260926085302.2879093-1-ravindra@intel.com> <20260926085302.2879093-4-ravindra@intel.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 0d63e7eb9cbb23d4264d1f79d90bb64b9d633a72
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On a Surface Pro 11 (BE201 8086:a876) in s2idle, with the rest of v4,
including cycles that take the timeout path and so this write:

Tested-by: Sergey Lebedev <lsa.uz@pm.me>
Reviewed-by: Sergey Lebedev <lsa.uz@pm.me>

