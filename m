Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB81991CB;
	Mon, 25 May 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717922; cv=none; b=dA79rK5wO2mSd8kYiUhzFmGOKE6rEivlvYJZRSxSEdbW54I1srqa9ywCIgDlz64MACMKS/I3pHRZoOKxfZDb4neUW52okSjMsFRPniAmNxeqBgSn5zG6wj12lYZyGU/lB6aRjaV88SkWDTTrIL6YxAa/KJ4MiUvzmZ3J/smfgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717922; c=relaxed/simple;
	bh=r/TJfs2FjL308K6t4+w4fchQ51JmwkBTb0M9HQq5j5E=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M+YgZZU+NZPnE+Ux/U+nIuCa9oYKv5yuQYtQfj+wQxN74IwZWdl9N6FAMwTMJtDEHc6bPuYqLDMMEYsF6aQ3z6DQItR+ENl5oR3xkKmom8ixiSy2HMnZv3PoxRA4kVd4bxzUOeKktB3qZkesNJKpf9dQlA4F1NAP7cnD+zPxw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=qkmwoldY; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="qkmwoldY"
Received: by chaosmail.tech (Postfix) id 52D991C7F11;
	Mon, 25 May 2026 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1779717918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjnVfgz6zh4SF3gMbSx456mbBro9ABf5bWAoYvwZu+I=;
	b=qkmwoldY0R8w+0rmZMTmWCi+CcadvVw6SdMk05tvUh+mSzuoKZNKjflD1vD3kyAKK4bVSX
	6PPOEqV3T0ZbsgKWxHiIXodhBmSP+qGfbpzj8QH6rlxH2Oq8b+4I9ztkiNyUUijA1W3Dh5
	wkm//BnOjkZZALJNM4Sp91l2ai8I2qU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] Bluetooth: Add Broadcom channel priority commands
From: Sasha Finkelstein <k@chaosmail.tech>
In-Reply-To: <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
Date: Mon, 25 May 2026 16:05:06 +0200
Cc: Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <172D11E7-AF98-43F8-B41B-907738749EA5@chaosmail.tech>
References: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
 <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
To: Joshua Peisach <jpeisach@ubuntu.com>


> On May 25, 2026, at 15:58, Joshua Peisach <jpeisach@ubuntu.com> wrote:
> 
> On Mon May 25, 2026 at 8:11 AM EDT, Sasha Finkelstein wrote:
>> 
>> + cmd.enable = !!enable;
>> +
> 
> Probably a dumb question, but worth asking - what is the purpose of the
> "!!"? Wouldn't just passing "enable" be sufficient?

This is a way to enforce that the value is exactly 0 or 1, not 0 or non-zero.

> 
> Also, currently, cmd.enable seems to just be set and used in the case
> of boolean conditions. Would it make sense for the enable field in
> brcm_prio_cmd to be a bool or does it not really matter?
> 
Opposite, actually, this struct is fed to firmware, and it needs to be
specifically a u8.

