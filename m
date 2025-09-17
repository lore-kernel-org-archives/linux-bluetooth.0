Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A022222B6
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116588; cv=none; b=l9+s4Ff/8eFn9HMY8BAenXTUlvtTg9lSqPmkmSQU0y+H9SzKmFnJOe2r2QgolBU74TFJP8ngRTu8KPL09k2UhAySCHNwv2M7BhnT3SHZ9UFdGb0s38VNfd95BibsJLNAx97pflFMRU6ZtsFYjAyFycOJQb9eY65dy7KUWG0uuU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116588; c=relaxed/simple;
	bh=r9VhsR6/thExrdfq1Wufp/z0pNT5ZszZN4Gqe8pIk0I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EgjBQwRgIlipxVy0Uhdek5lSuRtZSA+wVshhDxMeuh74C6Aj7uZGwQOCbVRGlgYWVu8VbN/J+OualGzVJbNqYYO8o+GJ4nvpsVZot6ygOmVB9O+8NiZT1GgKCIZqnV8yk7KQpW1APZEmjIgneW8SAqf6YKmTbA5SRsNT64A3MZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gkw9xunT; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gkw9xunT"
Received: from github.com (hubbernetes-node-26d156d.ash1-iad.github.net [10.56.147.41])
	by smtp.github.com (Postfix) with ESMTPA id 1F09D9213EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 06:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758116586;
	bh=HgHi/YTHeHEG7iOaDpNU2rOZ8UlQ6mNVklfmLCimJLE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gkw9xunTIWS9WS+39u5PM9rkMSuy9fq4ioTpzJA3674sdVo0CzqfMb4moRcjsfKIA
	 8aMOTOdFBgCWYa3JUpwXjYJWRqkwT1Y1bxnWxsALh7Jh0QQlP4PTSZ6kGpKrmnqQUl
	 uvk1upsT3Cm7CR2z32MaOM0n7wsxpLt0la1+SkF4=
Date: Wed, 17 Sep 2025 06:43:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1003112/4d37bf-000000@github.com>
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

  Branch: refs/heads/1003112
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
