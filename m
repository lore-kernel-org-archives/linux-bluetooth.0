Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2A39C00A
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317734; cv=none; b=tXFo1VI5SC5U3yn6zFyYRTlnGBFeg3gSvEDj+1DIMopWaHKBehJ0UZjFRL8ieLmSFchB/7xPcog5UIuGK1G65rqVI90TovpDaOvBH3wGwKg6VtH5g/eWiZMap9b+PSM3eK7Af6mWtJIQhU0x622Cc05RpSvSJk7N1QAjLQ9gxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317734; c=relaxed/simple;
	bh=vAzZV9gFCSOS8I327wPtqf+e2S+16Geid0MR/C6OE/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=QWF+gLPNv4Xti2ltchzZFXy1PQdq1FxVyWxZAYpMPocYT4N14QC9gj9/jF8tDvHdXgLiUSSj8NH/WcE++Ex1xYj5bD5nVcpwP0JNVr2YWbcPn5mvrMDhHRaRdfwiMRKd5J9SsVLFcVxjDgMZV+GbnLFOgGgYc+rxGMi7OusKsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55329.dip0.t-ipconnect.de [93.197.83.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F16B4C1511A9D;
	Sat, 09 May 2026 11:08:36 +0200 (CEST)
Message-ID: <0e4229cd-5f8e-4096-80b1-f71b64507346@molgen.mpg.de>
Date: Sat, 9 May 2026 11:08:35 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 0/1] btmon/TDS: decode org 0x02 as Wi-Fi Alliance
To: Preston Hunt <me@prestonhunt.com>
References: <20260509002249.2771777-1-me@prestonhunt.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260509002249.2771777-1-me@prestonhunt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Preston,


Thank you for the patch.

Am 09.05.26 um 02:22 schrieb Preston Hunt:
> Adding support to show Wi-Fi Alliance when decoding TDS frames in btmon.
> AFAIK, this code has been assigned to WFA.

I’d add this to the commit message, and maybe even document the test setup.


Kind regards,

Paul
