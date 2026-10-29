Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274444;
	b=CeEu7oerk7OnIIEpqtm1tzdzRMwalWF2t4lIvWNb0BbhTkAMfUilQitOnYPL4w26d7RJ
	 mrdGg6GJy1Sk759QddyzUtP28eafw88rDRSbqlsXaCHfArZ6bJVpkon0axDFEFmbXfKPZ
	 gwfIWElQHEoh1I8FdRk/PVzpe8e4gpPc7rzIaw4YSiKiHjnwY+QLsoYDp/gVHXWcTF5Us
	 WOAsKOxAOg5G9m9YZRwV0O7+VOFX+y4wtM+4kbDfL0BGumXOhzb3qS+bjuvFViWD2XLWw
	 LFacw8Ne7Wfr+xFIHpAuIzE/aVWTur4SrQoS7otUu+7KtlqkATpQS7/D3g5V9RsmNTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gQdeRMxfMEAWttNNf5wmjahx8+W0rP2B/qswRbAKyVA=;
	b=CdwPtSUaIXD1xDfZT77TCI4y7Que7Sxp6qno671Vj2InubsiElY8D5QHgRB/lLuQCLHk
	 uQti4DIq94YZdAGv100Djn/AoT3Ci9gL4CtdBh/wMUrKVMPm2wliChPcpD24TxAix7vAv
	 QhXoPo0lXQcsQvjDtEUTe1hBdQc96ZrQGcteqyawyqE/Wdyk3wEge3BY5SrUGHTYifV60
	 uWO7aNviVPtW2rAcSpgRcnPqqSu27GRyB+wOwj7k0XQJawnoPQMGpvmEgJfevUPL0F0SX
	 wfgFzcOMxQ4+teOIrvbdT4FrbwbkpGN47z5pVZvXU77IkvE29iS9VDCc+wkpK5syO1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cvH51fUG;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B026606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 11:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B026606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cvH51fUG
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6f74f6b46abso1119592eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793274443; x=1793879243; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gQdeRMxfMEAWttNNf5wmjahx8+W0rP2B/qswRbAKyVA=;
        b=cvH51fUGPScQP29bbD4p/JKfmOm8BFSdpgMrOAVsO+KL9QzwMS5zaJQherGFhVifjd
         hDwi50q51pEV+QYdmw0fu/E9+OZ58gRVlYQiAxmMs8TAxc/IO1l6J+QwsURVXKwIUfm5
         1pFTH0UXkP0FUXZMWfeUjAHl1OZeCix+u5M9JkKylA4q+Ufi1/RjBOsiB2uqJ/WGBPQ9
         id0FU/zTfwk1YJ1KtkolimT1cS6AsjuXmvcAorMfLr2G7rbDcs7UXDkR6pKo8+jJ8AYm
         nYxvtBVff9Yc3fMDV10BpVVz2YrcnXNlNsAlxs1VFbiDTA5Hdbdb1Rg/rZAYY3j486Yd
         GYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274443; x=1793879243;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gQdeRMxfMEAWttNNf5wmjahx8+W0rP2B/qswRbAKyVA=;
        b=1MKEtZUElJC99uTfy5ATgDqwA/qMFS+B0eXIlOg8zHkF/t/yIx3g4AFn3bHtJIaWIW
         bszkYACso1yD5HZdNF1n2Cct/upOV7tG75N2y6XK6L4t28B13CjjUyEqLC9u6xVWe7Le
         /8CO/6+uPcicIikMM4EFfvkCmhrPsXR7c4NqSTMEJny23WjtrXbVjMvlEB+FlrBnrXtE
         QHqonJyROl/VjTnIba8fxsMfrW0X0RfBcbYbAfaTUaSzCyAQLH7G/fmEsw9fvpfdL3Ir
         3ndn8eHQgpZo66fljKmHM7o4S8Pi1PJiPqTpFRk1Sf0ahcVR5x0RXg/yymQ67T/s9GPl
         23MA==
X-Gm-Message-State: AFq9FYJgtkO4L84TFrkETI+zY42gsGWyL+bCXIz21DsTfk9mq45BJhvf
	e9ReCn7P8bxGGT32SRY3eUj8/S689azKbMorE8TJcaUBCF/qS2MorUfEwHT26Q==
X-Gm-Gg: AYBFou1jx/SRSos40h1nwAASrV7jhSZ44hZudMestn5BGUk2sJaB8UTQ7fFoRJBnpXa
	V6oE3PuIdx+q8Pz88H09ZUeAoy9eXqRlS/WECl9UGdirGdRcXV8cFtvD4IOhbYIu8BvGPWH/B/U
	eP+oYCjfUTIGd/tculJj51ZXTLvrs6ZIGkX5nJ7x37udlLLNFxfsJB669KV+0tUh3w2q8XBWhyk
	NH/n4VqcdYBKTclHKvgJI/Jg2dl0jFenjTxApBU6U/u6DpXCGvffqiQhWdteBNKhclJ0xqBxj6F
	DJHeslPsdpHhRaP7ekH45dlu7D9+Of/HBMZ4tvBt0ems2z4VMuCZXg7fJIO09WSjqsBveFiuC3B
	MvjH5lpLWn8WKh1HWe9N9XEB8VSuJ5ZoRGSBVcIfYa62+XFjrJPcJbccxsGoFUOBcssjJbenIWe
	BzJXfa27Gcqj0Ox2RZygE1hpiYxdeKXYvFZIP2YvHsUpAxyMuHL5UW2/ITqbSI8DhaLoOBxwE8y
	rZf9KmcI1fhVsPg3tjNwQgGy2Xu+Uyu4yx3BXOUefltaSLFUw0CwpIJ1CXGlJzxtnlEzdjxIE8r
	g4JMut4iyQ==
X-Received: by 2002:a05:6820:a512:10b0:6dd:ddb6:b242 with SMTP id 006d021491bc7-713f1f4d907mr1807698eaf.72.1793274442978;
        Thu, 29 Oct 2026 04:47:22 -0700 (PDT)
Received: from [172.17.0.2] ([135.233.180.58])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb7942fsm4153026eaf.5.2026.10.29.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:47:22 -0700 (PDT)
Message-ID: <6ae3324a.963fedab.2a0d42.3e9c@mx.google.com>
Date: Thu, 29 Oct 2026 04:47:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6401958945045258870=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] mgmt-tester: Add host-resolved RPA scan checks
In-Reply-To: <20261014052008.413209-1-cochcoder@proton.me>
References: <20261014052008.413209-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6401958945045258870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC] mgmt-tester: Add host-resolved RPA scan checks
   Pull Request: https://github.com/bluez/bluez/pull/2676
   Created:      2026-10-14 06:48:53+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6401958945045258870==--
