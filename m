Received: from steward.aerusso.net (steward.aerusso.net [208.87.133.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CC1991CB
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.87.133.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824755; cv=none; b=uZ2rS1HrVdZw1wmuuaN55XZ/qJ6oYumUpK017H3M/hSAujD0MAt3rXwpPub8XhBq4sGDV1DE1kdkGyX/bp+clrVaSmc5AAii6IGAX0szx+Neh8HmwF20DmcO5/zZfWzHi7c6wdxud/4lYrzcFPfd+Ag5ZY7MIBaxAIrrhPxZk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824755; c=relaxed/simple;
	bh=O+0YN91HakDHiU0p5mXNULLv+Ms81NC3fh9VS6YebVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoEuOpE4uLHJxy1Yk1v17JxpYhD7jM8Fg1IYbuozxNfCjZuq9FGadXKAU64bgMF0j6pZuAytHQ0aXS9+lCAabqtxggASq3GNI7u5bInb0NprBSH9wRs8iUWtnVlnfbleZn+xCwZG6H9KQb7eecdUMftAnGWbgHFOioQJG0MXhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerusso.net; spf=pass smtp.mailfrom=aerusso.net; dkim=pass (2048-bit key) header.d=aerusso.net header.i=@aerusso.net header.b=bCglrV1o; arc=none smtp.client-ip=208.87.133.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerusso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerusso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aerusso.net header.i=@aerusso.net header.b="bCglrV1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
	t=1748824170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kMhMBT3fyKvzlGtBv8pI08lG7WGebg6TMcKN02JXnbY=;
	b=bCglrV1okC475kJoB2hPdVjXkJV8D+6olDrAeSrvkjTF8Xd+NYzq89nImLpcBxkj1GQBDS
	+Fbslss4RGtYZacY3Myw5j1kCu13cy2QLUrCvN4C+B/DKbmIf0BsvQFXDfnVaC5n44Ryfl
	GlBSloyP5k/2UjLlnwKmkVFKn1Mdv3pmKVHiVCeFhoVOSie7tbvMcELFRxSazNReKvsQpH
	LalMPJZwMTgTIeOoOpCKoc/xHYX4GnmbIPSGY+SP49Y4b7gHZwhHdxRkHpneJnJfK6c3YD
	dGmjrLnCeYzfnhCiLedBm7RU8+PxFs0wtpk+Q7qp+0zMzmD1NMIqCjfL1sxb9Q==
Message-ID: <30a9641a-05fa-4a44-af58-6b155dc7ecfc@aerusso.net>
Date: Sun, 1 Jun 2025 18:29:24 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Do not start mpris-proxy for root user
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Salvatore Bonaccorso <carnil@debian.org>, =?UTF-8?Q?Guido_G=C3=BCnther?=
 <agx@sigxcpu.org>
References: <a15e6919-9000-4628-baec-a2d2cc327903@aerusso.net>
 <aCiLTy-IuqV6V7WA@eldamar.lan> <aCncrfc7qbtLEpta@andrews-2024-laptop.sayers>
 <aDq72xTNkz0kDqpW@eldamar.lan> <aDtHoRCof-iND3Td@quark2.heme.sigxcpu.org>
Content-Language: en-US
From: Antonio Russo <aerusso@aerusso.net>
Autocrypt: addr=aerusso@aerusso.net; keydata=
 xsFNBGZLDNUBEADeuQhOWfMndhaUF+QSABNWP07WLZQHUNFhIiLcVj3ETRLXClWCxrHTz2am
 NbrMBN7Kcaxu1yai8xy9dnPoKKvSTTYsJkK2kE/QhWNRknqQZc5GOF9Ig5tHQECg91sPkA5j
 9lhEIBLXAfcqOvAl5WaYV8eYCbj+CqOFGI8P4NytsWTwucZTk2cQ05vGyi+vsj+inWLyyYYh
 JxVYGub3TTf5QYYtIg/FxKxEpHglW+iRDEiOPRjI/odCkA4bzu6v9wRlOa7vw+rb03vCh+a2
 vsh0noVoX09ACRhpdqgSKxpI2Fr1xQhWrcbIYPz8D2ZX/8kOVovLvbZBCQSc8U+RCaDDM/Gf
 FTDLH8NgT4KHZAFnDfXQXFePckyOTv9ZX6WEhYb5TjuQtmnyWhVo1g/W+X9j7wQM9odV5SFi
 RJZ0kF7whN9tFLL09CaUlSIpdoFNfJw9H1/5wrfC2SJm+oZSgZbaCGxPSJvkxAkSMIP219Lt
 meY7L5a3u47fyCbndvjYpgr/+Ono4rTshYcifvWWzfvWFa1sVBEeZrAYNCf8a2WoIrIZziiM
 x1DifzhZPwT2QCDj3Pk/gmrp1W3zQhEuEfOWMVt8rf/qr6nsWzFpN63rSUBm7bM3QvDo74oi
 tC37WKITYsvRJAm51v0V+kqhZFFWqDd2qyFhtX69E+W40+aomwARAQABzSpBbnRvbmlvIEVu
 cmljbyBSdXNzbyA8YWVydXNzb0BhZXJ1c3NvLm5ldD7CwZQEEwEKAD4CGwMFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4AWIQQMlD2V7ROdzUwmTNNy2wJuBMHHaAUCZksTvAUJC0c75wAKCRBy
 2wJuBMHHaJnvD/92+6Gih0YggXAtFSOEfzDnBKc7krcfhJ6QhjcUAjRe3SExTM2MnRBxvPNU
 3h+r9TOHK8I9c56j2IwQLAkYRF0qyd34gunjA8Ej6abo9Jjic2b4gHA4HmgexvWBOPSfdQ+Q
 uF7bJGU5uCA0umKlpuKq9RY+HbQ01pSrfOfEQ+MyOTtKuywA2Bh5t9rXTyUO6h6pW/330YBC
 ms3WTjlPwgxSfnnYtxLb34WKca7hkWtrp1neSNfB5kYALQ1/mTLLcFEhFMJ4b+4CMOfaHZxg
 9wUnVDGd0xgLUeCeRsusgotfOSfjeZvDf+yUfTQQzkqepyCTtujTQ+9Wiu1/KZ4XmklL7ne7
 byC6gT6yNkLESBP47hBEaKk+OmttByk2dVO3hW3DYckiSb3WZTklA9StjR6CGGwDm50MNbLA
 tVs9+LNx2muTENwycpIBrCwra4ZmFWcoRMfxrvh4tZVBmf5tr/NT/j3zTR/1iqNn/M5MvGJk
 FfqzQGCqTu/qVLKMcs+5TXLGGu5Ty2kAl7c9lt/HirvOANXnKz+o0unsN+bRCBacIRPRDqFS
 c3e2OZJQV+luKJ7tObvkpw6tCND2GHd0ByX0xsaF3HczDs+sexreeaRHGMDiUEeM9TLy2LaI
 DMgNFhI3HjF3YkqDOYK6VdYx/XSk/Hb1tY1o9fRusVu+xvAO1c7BTQRm6ZJkARAAtRIBH4Mz
 FiDfI0/LapgjnT+uHFZFpIF+0GkHP2J6KEfnw8LM438D5GfabkDrPzhogbu9P6/l27u+x1VN
 d4rW6K8H7fn1nLQOi9AujqtHoIft74f1nI8IAVmzkL/w2Ku2dG90A+ipJo80gfJY2ETdaaB4
 Wpxod50mNfaG05c4er9HGxsEInWDdHoK7kfxmR801O/V9oNUWQ4MkVyaaKWJK1pQgMxnV1re
 FGWGT/+mzT7gCArVwTcjn58ooOeHmb5j7nBgdxfXrN8RZrP7R4OYAnEyYpeRjYCNIEEI57EX
 AXcI7FMDVNtZrqEbIVSl/rFRAT1J+EdwgMahbgiOv9nFQgWDYuLKtQIADY8zjJLLPw4g8WIG
 oS6GpnEmNmTWS2wxmFlE0eZvb/4MIGeOvikwhdA50HPcokOvfNSnDyTyZoh1vGaTJ8U2U32l
 GQiDwl2PIVwvjawYXIwOPA18rDO7oZIMeGkt9velWTQRJsJCXchY7ZT+K+77Ii+9Z1wmlK8Y
 7HCQ3SsswtW2I4lAXPE3JUKg5hIYyCkVBW/yDlebbkWty0UGc4EDVPKFo2GsPiulNq1X7JCX
 jLjCpHPwI/8FF/sntx7OkaKHEIhxSRLjNk027cC+aa1IgTrJBOdqyoFZsEvPRrt5Stu9vt2o
 hSY/a2tnrMlutDoiVngNIpWRwJsAEQEAAcLBfAQYAQoAJhYhBAyUPZXtE53NTCZM03LbAm4E
 wcdoBQJm6ZJkAhsMBQkB4TOAAAoJEHLbAm4EwcdoMrAP/RzkUpdL6zPb9G40+vm7FxF5iEs6
 YyKtOo4fxdmeufmOFpcCtHVk7abppJ4qf9wzLZI6nuMtRI/JSD779j8WbpFWswvVqDa/WtG8
 Q/6wdp0v5n14HE1dH0uDgTjgF4BoOh6+9SKRIMMyJoD1gYAkw+QSD49nqDBTvw2XiZBpmnCH
 H30Ufdc+QYCR3woK4IskIEqEryWkSPWzM/9yrbGxzRsNbDUlaTj+a79SiP+tzFT3N3NZJN8v
 vHLoPM4wLoc7F0mQRetmC3XXn2wYqfEnHxsGM2wlTEyxE3oz4w/ogfmjbpJ+hCCRPGsLzlhs
 2I3B4dekY+zwDmIJnzC3xXFdTvxlr70fmuIGedVlW7QoKzJ1AYrP/rfL5FBQM7AMc6bhyM8A
 gUMzgcTfM7s1lA2NH9I3CyUoV2cWHGLnbECbffvyiEWB8uXRTSuZ8buzEzw+PcEbqrn+gZP2
 +kk+wc0zYmgmc4bLxnzXIU4VEZMBuKw7n/ayO0ITplui3s+zIYmeRi9yDu8HPf69zjapCRds
 Gz08XIeMaQfF9U3+yDPzJdplV/DF393HkuXLuz6PsdmJ8ni0sdcOemxBndmjrpSf/J9GqDBz
 IkPjkZUsh8BBAo78waa1Y4ZoXAGGbfuWTR+Fet6Ogfze74A2TtwtQmnfAXz900GDTekE+0i0
 83d/owu8
In-Reply-To: <aDtHoRCof-iND3Td@quark2.heme.sigxcpu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-31 12:17, Guido Günther wrote:
> 
> Sounds good to me. The system users include users running the login
> managers which can have more components on e.g. mobile (for emergency
> calls, etc) but I don't think they'd need the mpris-proxy.
> 
>> wonder how we can best move forward here, to have it then as well
>> resolved downstream.
> 
> I *think* the patch needs a respin by Antonio and once applied we could
> cherry-pick to Debian?

Here's an updated version of the patch with the @system condition.

I do not know how to properly acknowledge Andrew Sayers, so please add
whatever trailer is appropriate for that.

 From eabbcf86ddfff98bf15b32e65c8d385d3e85f14c Mon Sep 17 00:00:00 2001
From: Antonio Enrico Russo <aerusso@aerusso.net>
Date: Sun, 1 Jun 2025 18:10:49 -0600
Subject: [PATCH] Do not start mpris-proxy for system users

A default installation of bluez results in the systemd user unit
mpris-proxy.service being started for all users---including root.
This unnecessarily exposes system users to any security
vulnerabilities in mpris-proxy.

Inhibit this default behavior by using ConditionUser=!@system.

Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>
---
  tools/mpris-proxy.service.in | 1 +
  1 file changed, 1 insertion(+)

diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
index c49d255..6ae56c6 100644
--- a/tools/mpris-proxy.service.in
+++ b/tools/mpris-proxy.service.in
@@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
  
  Wants=dbus.socket
  After=dbus.socket dbus.service
+ConditionUser=!@system
  
  [Service]
  Type=simple
-- 
2.49.0

