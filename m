Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64F2E11C1
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749879510; cv=none; b=N+e7HJrCKBpMUkUYaWTBsMPRWqkvphO4qmrQM5qoipcWW9Rizhl/FbJ35P46wrOGHWY7NUibcgZNSInz5gKPi7VHi5m4wUUmQsGTQBCMYk/wEaA4rVhy2zOTtaz1NU49eDqrsjgc15WpGEYOudZ1/z1IX8bpbBfc+Z5nfmsBL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749879510; c=relaxed/simple;
	bh=wd23SgxYuNlDX4ToZ7OW6xcEw2BCnwusobE0rUgxtu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qt0BM0o1dRxfe5yYBGa4HzUOOnEXUTtbPez28xUu4NXYPMt0idXLZ3X8TkMnVDqOU0xE3tA7Gx25H7PhFdltw5xivqfL6/cpVm7sK67unTU2ZJDZSvvQcAFi9TTT14lw+Qpo7VkFfiIFLVzLxR+xL+3glACSh6Lw2em5zzYTn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.111] (p57bd96ac.dip0.t-ipconnect.de [87.189.150.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AF8BF61E647A7;
	Sat, 14 Jun 2025 07:38:12 +0200 (CEST)
Message-ID: <2e2edd54-4bd4-4c60-bc99-d7c183077cb5@molgen.mpg.de>
Date: Sat, 14 Jun 2025 07:38:11 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] bluetooth: hci_core: Fix use-after-free in
 vhci_flush().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: Marcel Holtmann ' <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 David Rheinsberg <david@readahead.eu>, Kuniyuki Iwashima
 <kuniyu@google.com>, linux-bluetooth@vger.kernel.org,
 syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
References: <20250613230228.1243343-1-kuni1840@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250613230228.1243343-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kuniyuki,


Thank you for your patch with a well written commit message. Just a 
minor request to remove the dot/period from the end of the commit 
message summary.

Am 14.06.25 um 01:02 schrieb Kuniyuki Iwashima:
> From: Kuniyuki Iwashima <kuniyu@google.com>

[…]

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
