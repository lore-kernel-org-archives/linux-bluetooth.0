Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07231A6192;
	Tue, 30 Jul 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357589; cv=none; b=QdbqsASAzO/RPtHz9aUqsMRt7E5tebGRGG5FyQFNSnq5X2ELe8drOE4WxMP8FXQUWcfZVYqcyBGV35/21OEMTNfdOPm0gPNwJW/dL3jcDBHF/ZsGDMe3NY15joVMZvnKh7+sCrtrZLa1ppCd76MldyCHER2vwT2SMqZ5Jf3rFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357589; c=relaxed/simple;
	bh=MkHZXIVUmjQkbT/V6GhzKiafrDryW7qsZUfuhWIY9Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxrkTPlw/qXWKGxBGzrZei3MI3GFLCbi9bpuBkPNt65KDXgt3304Z20bbX5JCfa2PetwBfkP9YMPJFXT2kUn3U6gDDKUdT2Im//ajzedBNEosYuheN66VVBS2GQF1+aJByyUYN+mZiYIWm0mdQt+9wbNor6IOQsiV+1EBVDYIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af759.dynamic.kabel-deutschland.de [95.90.247.89])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1752E61E5FE01;
	Tue, 30 Jul 2024 18:39:33 +0200 (CEST)
Message-ID: <3cd1fda9-1c3f-4a8a-a35d-74f9d9eba912@molgen.mpg.de>
Date: Tue, 30 Jul 2024 18:39:31 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btusb: Add MediaTek MT7925-B22M support ID
 0x13d3:0x3604
To: Alexander Hall <bearodark@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730154116.25336-4-bearodark@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240730154116.25336-4-bearodark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alexander,


Thank you for the patch. One formal nit.

Am 30.07.24 um 17:41 schrieb ultrabear:

[…]

> Signed-off-by: Alexander Hall <bearodark@gmail.com>

I think the author name, currently ultrabear, and the Signed-off-by line 
should match. Is `git config --global author.name "Alexander Hall"` set?


Kind regards,

Paul
