Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB08400E18
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079129; cv=none; b=JTH9ty+pfLYf8uZfa0t/JyGi2NdbxOqJs4xmFOvkxq3T61bgu5pV7ue2bvxuIqTVoD3H56fGsSOsaq/8aPiRb5qZtT8bwUgZ8fEgqdnxgbm7hUN7BlHf4sIinBPqiJLoFtF3JSLo/d/UivzweL7uclsKGN69zvfWMlLn3kZWsys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079129; c=relaxed/simple;
	bh=Tjx/wiwC/VccqsO4y6xUU8qXzPPqiXt96ZEflgL/K7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azg3MZFSFvgD2OtNITJMWir0D83L3eXYWIJpZ/qm8J+MVz+5qtfsJDt5ZWYRYKYzndTKZCNtkeHolwY+DfgRMLCszfGMVeNRRgxRKm+uu9hBbpfg1q58wjqiSNb4NhLwiDi2SpDie154eXIbwz/VbXzZosOEstoqaBKfHJVarK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af73d.dynamic.kabel-deutschland.de [95.90.247.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6B2F44C2C37D5A;
	Fri, 29 May 2026 20:25:21 +0200 (CEST)
Message-ID: <c71e7d5d-0e79-4fe9-b1fa-4f6c2f299132@molgen.mpg.de>
Date: Fri, 29 May 2026 20:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
To: Nils Helmig <nils.helmig@web.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com
References: <69ed185e.050a0220.107d78.67fa@mx.google.com>
 <20260529133824.5835-1-nils.helmig@web.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260529133824.5835-1-nils.helmig@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Nils,


Am 29.05.26 um 15:38 schrieb Nils Helmig:

> I saw that the merge request https://github.com/bluez/bluetooth-next/
> pull/127 is closed. Any news on this patch? Is there anything I
> should do?

I think you need to resend, as the state in patchwork in *New, archived* 
[1].


Kind regards,

Paul


[1]: 
https://patchwork.kernel.org/project/bluetooth/patch/20260425185659.13133-1-nils.helmig@web.de/
