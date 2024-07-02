Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CF4CB23
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906148; cv=none; b=LUboj67WRgxC82ELuYPwMwchoAmBdsB1ckilAd/Lvs7yN3e63S9pDNEbRQ+aRnpCYnEZGgWHDJCj+CG9ZQHF+2jkJ9mKr77yJ/iHXH6im+Viz8nEnNPilp/1abjAo4oKaflnrifVZQY8WhIGL6ElBPtlPyrtixhUiwGbzSikSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906148; c=relaxed/simple;
	bh=LwAc0begORpyx05/PdMxKoJr+Fwy2QaBFUTnWx1JlfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHva1EqcA2bd2SMW80OF34zHPIurYVNgMAR6nZB982bPigK/m2/ctUrkLD6yDZzSPAjMpjLpqZBgbW8IGQgNuBHBqE0Rf00QC3WZiQRIgtKFYP05shtLvKaoOffiJRZlfFS+wYjkziYlzOgo1RPigeRgMH2u+NrwR/VZlUtXs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.50] (g305.RadioFreeInternet.molgen.mpg.de [141.14.13.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 04D5C61E5FE05;
	Tue,  2 Jul 2024 09:42:15 +0200 (CEST)
Message-ID: <456f2746-908a-431b-93f1-a820a01e3372@molgen.mpg.de>
Date: Tue, 2 Jul 2024 09:42:14 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: No need to update the mas plugin
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20240702071103.24986-1-quic_amisjain@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240702071103.24986-1-quic_amisjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Amisha,


Thank you for your patch. As this is for BlueZ, please follow [1]. Also 
I’d make the subject/title a statement about the action:

Do not update the mas plugin


Kind regards,

Paul


[1]: 
https://github.com/bluez/bluez/blob/be0b08770e9214592e89589b2dc069426c0d9b91/HACKING#L98
