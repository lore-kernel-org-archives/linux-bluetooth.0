Received: from nx35.node01.secure-mailgate.com (nx35.node01.secure-mailgate.com [89.22.108.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09221279DC0;
	Fri, 14 Nov 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.22.108.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107441; cv=none; b=Zqd5sdbmNyQdTUscAIOOYoamNljI0LwgGbSbqm9A8DRDGxzLblS9wOpWE6xjqFu5Um56wYbAyKAgIYjODy8r5BPTLmG7UpgigTpxgN0BVq9k1HMMNSN8MMGKz8avne5syY6odVOBxbF5XEAuEbTmeDRbwnfk+bsUIFg2Ed1WJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107441; c=relaxed/simple;
	bh=/nvdXeCztr5x7wU02Syex4AbjYAAvVqMMlzKgulCUSY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E25w7rP4L82DkXba1ylU/cUekwhWMX6xuDYeQ9iQeprESFAd7ukBgMwyqxoWyR58HK6MSEZcVawwHZw/tGHXFWeYoqF9v2js6TYCqjrRd5Y7M7xMfxbJUMe/FK/qUajEOgLQ0b9IOswuWy6FnwxZQchYhj0a9YecQEQnuUV6/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neukum.org; spf=pass smtp.mailfrom=neukum.org; dkim=pass (1024-bit key) header.d=neukum.org header.i=@neukum.org header.b=emu3T+mH; arc=none smtp.client-ip=89.22.108.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neukum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neukum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=neukum.org header.i=@neukum.org header.b="emu3T+mH"
Received: from web268.dogado.net ([31.47.255.48])
	by node01.secure-mailgate.com with esmtps  (TLS1.2) tls TLS_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <oliver@neukum.org>)
	id 1vJomZ-00CmoB-S1; Fri, 14 Nov 2025 09:03:51 +0100
X-SecureMailgate-Identity: neukum_org;web268.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neukum.org;
	s=cloudpit; t=1763107426;
	bh=js5De72dNejc963vL2O1fflV3+QBWHSFP9enSUqAojE=;
	h=Date:To:Cc:From:Subject:From;
	b=emu3T+mHkAbxsHb8771NFxWKK791qe59KfEEWoE642RKhbt96UMTDXUV5VxYJw375
	 sZOQcLPBbHNhPyl1PX/Dsk7wT2nA3F0H1JjCD+tVIE9+0R44dEWnWEVYKwb1FTuJeu
	 C0db2M+1xKlBnAjIj1GeVSGuugmBLnsBpT+tE60Y=
Received: from mailproxy6.dogado.net (mailproxy6.dogado.net [31.47.255.222])
	(Authenticated sender: neukum_org)
	by web268.dogado.net (Postfix) with ESMTPSA id 0ECEC28171E;
	Fri, 14 Nov 2025 09:03:46 +0100 (CET)
X-SecureMailgate-Identity: neukum_org;web268.dogado.net
Message-ID: <aee37797-a280-47ea-91ac-487ddc124ac7@neukum.org>
Date: Fri, 14 Nov 2025 09:03:45 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 Sachin Kamat <sachin.kamat@linaro.org>,
 Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>
From: Oliver Neukum <oliver@neukum.org>
Subject: issue with devm_ methods in disconnect and freeing memory in btusb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SecureMailgate-Domain: web268.dogado.net
X-SecureMailgate-Username: 31.47.255.48
Authentication-Results: secure-mailgate.com; auth=pass smtp.auth=31.47.255.48@web268.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.25)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXjNdqzJDxDWLO/UpkdjCiXtcAWE8cl15hb
 OiPsRgpQYCu2SmbhJN1U9FKs8X3+Nt2xp4kjpLhmBfm/1jJBevzt8RFB30Ars0yTQ/BrMn+JnVYm
 9cpWrOMZ7tQFwCmJ4YNwGYjbvhzWX8Co+5c+eruaCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYvhIO3OPuApEENzBIwyefYO48PjF2L3GVxHSajlUCf0ZlwxsU2jMuBNCauY+qeVRqcM2HNV
 91gBZQ/1Pbs8eo64MUJTS2Jsxpkx+IHIsDarm2U3gyy0nlbakKK22WPBaizjKzb+JrnOTbl8FYp7
 CIWjverajYy2yB71RZy29b9HL7yliuqXZvH3i216cQum166kf/ld9xdbddNOGSuUXWv94PtbjLq6
 i876g4nLFuIm206wm4jyRZgLX3JeO1DimxffguuWRCT69XJD0VIf1Sv/utspepH656ibybPLqHoc
 HvpVQ/LHxirsNla37u2pHVFz3YiTLViM/bE4mY1qNrjcLCp1LDNBgpe9gGVcAseQ2CVZSXmdZ20d
 kJlKTM6tEuf8vTtpnDhFVFAXN/ieSgx2ezpFj0BqG/t3fGWq+iiriGm2Olw7NFWD50jbuEX0mdKm
 jhaG/t7hemlhJ+woX3OFSK+6iFsnJVr4u5Itb4fUJJQp+axrkf/Hwt0r5Ay1T6TlgTl6fJxyntEf
 hZCKje4ZOPJmqKySiclosAYjq5HhmyPxWFVH+H26km3T4pig7/wWquhQPjfO5uXT7j9W7u8qTfD6
 cxsdFKDXY5IAQfIM9f4GlAB0wMVfGTDZkKNlJZ7r2RGFJqPDOmAQctmh3zCCQYCC8/tQPot8U0pa
 WNjxsqHbbYrnOB/f8gHK828cLRfg7f7w8jy1FzdiCx53QuIcgpyfZlw7Bq0We+9rBz5aplVUjpsk
 cK4Q8fRu49B7wJHz9p/e5RuxqdsdqZOMXNAdnRq2H0n9jhG+7muBS1X+VskYoN/g2a11WysdYadd
 IKZKTPmNuL7Typo2qFGjUhbtexo0PPTHzQ/IcgTHsStfGbawPRuRtimbueg1dle5Gb6mB1YkM4cW
 R2XQFa6Gjq7FOcH0BPQeQFSwUcz39j/B+9lut0mbmApkjKY46fp6K4xHLjrNjqR2xLJfNZLtGdAq
 lVubB2rCMF6RoS5UV9u3bLZbcIJ0GR+Pe2PV4kBmHm8qxX2+VcRHEBh0q9VNLRGJDNhzVfdYAWUP
 9T27PHqOuBMcaL/3sdQ+aU4L1Br+MEtb1ej7FoCtQ+x7KqtJIKKlUnGMDHzvLQLaIP9xF4j6wA==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com

Hi,

looking at the change to btusb_disconnect() in 23d22f2f7176
and the discussion leading to it I have doubts. Let me quote the change log:

-- quote --

Syzbot opens a usb device with out of order interface descriptors:
Interface 3 (ISOC) in position 0, Interface 2 (DIAG) in position 1,
Interface 1 (INTF) in position 2.
So, ISOC is the first interface to get disconnected by usb_disconnect()
-> usb_disable_device() -> ... -> btusb_disconnect().

I don't think this is a problem on hardware, where the bInterfaceNumber
matches the position in the dev->actconfig->interface list; and in
btusb_disconnect() it would only ever go into the first if
statement: "if (intf == data->intf)" and not into any of the others.

-- quote --

Now, we cannot do this. The order disconnect() is called is arbitrary

1. The order syzbot used is valid according to spec, albeit unusual
2. disconnect() can be triggered from user space via sysfs

We must always be ready to handle any arbitrary order.
The code in the second branch of the if statement used to be perfectly correct.
The actual breaking commit was 98921dbd00c4e by introducing devm_kzalloc()
for memory allocation. That ties the lifetime of memory to the binding
of a driver to an interface. In hindsight in a driver that binds
to multiple interfaces, this is problematic. Hence I would propose
to just revert 98921dbd00c4e. It seems to me that we have discovered
a design limitation in the devm_ methods. What do you think?

	Regards
		Oliver

