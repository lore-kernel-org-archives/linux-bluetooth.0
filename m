Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA036E46F
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978053; cv=none; b=YvN2FoNWVoD9vRRfgbgCESqWUn49ZTamU4Xq8OtrmcQuItTLFWClrd1Z3cBNjC4fuOXJ9Kj6eDzQUG2kKe7B+QUFw67IeVPTEN9/tiEkdUSec5ZSFAoroo6+kKvPKmum56onCLTrwc9+sl7CFA25mBR5msXGbID/BFw5BqvrpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978053; c=relaxed/simple;
	bh=Aos5C3I97iBdBMu4V4Mq5O2FmhUbw51SZbbltvcL764=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qq55dO6kAPZVx40g8p9sfYWNOlKpHzoxO2xMGhebZbuRDtbssk48mkFtSzcdxPB8CZ+wG7vYmWyTn37FfGebJySUJD4lTKC3OgMx4aUFXDqdL/aaHa4AjQZ1X7IeTfVQlqW8aT/WzPo7E2sQbEZlh/9krnFtCDGxLi7jMKK7MCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af73b.dynamic.kabel-deutschland.de [95.90.247.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA3A94C2C37D47
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 19:27:27 +0200 (CEST)
Message-ID: <66b33d99-b7ea-4918-b1cf-3043c5cab2eb@molgen.mpg.de>
Date: Tue, 31 Mar 2026 19:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Delivery problems with Google Mail (was: Undelivered Mail Returned to
 Sender)
To: linux-bluetooth@vger.kernel.org
References: <20260331172134.BD0894C2C37D47@mx.molgen.mpg.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260331172134.BD0894C2C37D47@mx.molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Just a note, the Google seems to have tuned there spam filter again, and 
now I got rejections for Google Mail address listed in the MAINTAINERS file.

Am 31.03.26 um 19:21 schrieb Mail Delivery System:
> Diagnostic-Code: smtp; 550-5.7.1 [141.14.17.11      12] Gmail has detected that
>      this message is likely 550-5.7.1 unsolicited mail. To reduce the amount of
>      spam sent to Gmail, this 550-5.7.1 message has been blocked. For more
>      information, go to 550 5.7.1
>      https://support.google.com/mail/?p=UnsolicitedMessageError
>      a640c23a62f3a-b9c1005c08esi37946666b.340 - gsmtp


Kind regards,

Paul
