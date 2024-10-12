Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C234DDA8
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Oct 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698332; cv=none; b=Z28j1znXDX4NMm4XrwiwZjwQ/esbg7ua/uwsRq+HoKfIJmgheMzd4owiM2KhdjfZ/iWF+53Oukuf4A5WT8Nqe5VP9fVETcGYG5u5tp2Iw2rjZgSEJxKCYgWi86rjA9zluDvqLkCkdSQelQGg4nLFXM3bF4OPNZ4M1ISNsQR5Xu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698332; c=relaxed/simple;
	bh=LNXbW1iG5pCzl4yItDTJJgrC19+fKo6th3jMTQnCPD8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=di54UevlAAay6Eq26e8kLUPXGTmeIY0uzbWt0eMHVmzXLXf1kPCENl7TTiB+Jz46Zmx9pb78b9isAD3Yne5sts3Gz5z0aaohbwDL5EzcEzRnHkuR+CEVtxtunk2fLFxAf186RZZav52euIKXtyq5yfNGEfjXFCl9F3EOg8GcPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=gNCaVtFI; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="gNCaVtFI"
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4XQR8C3qDZzDP7
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 21:42:51 -0400 (EDT)
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4XQR836xdFz10B9;
	Fri, 11 Oct 2024 21:42:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1728697364; bh=LNXbW1iG5pCzl4yItDTJJgrC19+fKo6th3jMTQnCPD8=;
	h=Date:To:From:Subject;
	b=gNCaVtFIXzuUtS3zz70BLWKPeLGQZQlUZU+OUSMjCruaW8X3RmPylQirxk+95uZXo
	 A2rZHoI8GEDOQoXFfXuPFaI7WkvveLhFc/u1Hr3+aqaGg0OdPTbJQMrfVrjG0FWnMf
	 lr6aGX7bI6BCBdiq608Vb2ERL6XlP6MdGsQ05SMA=
Message-ID: <6c599d9b-a000-48d8-ae88-ff424bf5ec38@panix.com>
Date: Fri, 11 Oct 2024 18:42:42 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: luiz.von.dentz@intel.com, Me <kenny@panix.com>,
 linux-bluetooth@vger.kernel.org
From: Kenneth Crudup <kenny@panix.com>
Subject: Commit 610712298b11 ("btusb: Don't fail external suspend requests")
 breaks BT upon resume on my laptop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I'm running Linus' master (as of 09f6b0c890); resuming leaves me with a 
somewhat-broken BT, but rmmod/modprobe "btusb" usually fixes it, at 
least once.

Reverting the above commit returns BT suspend/resume back to normal, 
however.

If you need any further info, please let me know.

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

