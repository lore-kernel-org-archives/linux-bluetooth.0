Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98D245019
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765571141; cv=none; b=fnPpYxnxv2gHolnJ2LrlGFiE1MMIOrIIJJSXRpVZZWgw7xugJdzO+fFKqrgG/3b7VDKr5hVGVfWay2cjg7AQmlrNt/A0zZXMXt08zSpc9JjN+ckBy5dbOtpLZ4+hCGjAdbMi8DUHTMkMnSlVmQkTMWnWtegeDy96THejBjVVTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765571141; c=relaxed/simple;
	bh=tGxgFGHZNK3LH8QEnUvxQvZFN3kYRpv3RtFYrKHg610=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0hDbn7zhj3690p+SIYmuumFjuTHNWP7FqRy1Dqd2KJZmDXDg+SQz8fxcxHATvrDfOcjJEtgk1JsMnHOHen86vfMESdmvij+Rb+kpDpALZaLz68pLdt9Rd8/A70tIV5V93IPIpjOpgMniYUAYhSoExC9tT0YiSUkd40WpnvQNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Dy36DqOl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Dy36DqOl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+tAiMlC2CvY8YsTAY4WgjPwv3rQEWW+6DY/KjBi4nbU=; b=Dy36DqOlj7oE0WC3oRf5hbGhym
	dUjG/gGsgG9OH2bmmn1i0ZhFjZTRY8KMFfRZU/lLm38qT2+lbWJr4/EjqkKcPuL3UV8+185btGSTo
	ELwLpRR2hzST762o0FnL3XYWhKQDQJ20zca81PWss/RRfHYIVmIB7zNGKvTN5o2htac6GVJPhHIcm
	I2Dh/3tIMAeP4/nBx549u4vGFThNCY/g6QPgqrwYpIQu8U7gjNr7bZ4SZ6Sf2YSTZNHJN0/VxVGVa
	rZqbvbUAQn+Le2wFtkmrkL9ry/27R1E7qVISvEx6P6b+TrPqhmfdBgNErPSd6ijWO+lh8FPez/1qR
	LN6khz3g==;
Received: from 241.red-83-35-220.dynamicip.rima-tde.net ([83.35.220.241] helo=[192.168.1.65])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vU9hp-00C9du-9a; Fri, 12 Dec 2025 21:25:37 +0100
Message-ID: <d537fc06-c21b-4579-9c08-68391069a9c1@igalia.com>
Date: Fri, 12 Dec 2025 21:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Support for config fragments (conf.d style
 dirs)
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20251211211356.3842264-1-mafm@igalia.com>
 <20251211211356.3842264-2-mafm@igalia.com>
 <CABBYNZKPn27zfKdRDSD2uChTB7eVaWiCKMdvbvvPGDwfBZmADg@mail.gmail.com>
 <5b33a4b7-378d-42e9-83a4-fe5062a04eff@igalia.com>
 <CABBYNZ+StSv0QpLpRcnf5vt0kWQKb6kd4k5ba38A5yBZkDzVTg@mail.gmail.com>
Content-Language: en-US, en-GB
From: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
In-Reply-To: <CABBYNZ+StSv0QpLpRcnf5vt0kWQKb6kd4k5ba38A5yBZkDzVTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/12/2025 16:27, Luiz Augusto von Dentz wrote:
>> Do you want me to iterate over these two things and provide a version
>> that works on 2_36?
> 
> Yes, if that is not too complicated I'd like to stay with a version
> that works without introducing new dependencies.

OK, sent now v2, hope it's better -- changes to keep using glib 2.36, 
and formatting.


Cheers.
-- 
Manuel A. Fernandez Montecelo <mafm@igalia.com>
