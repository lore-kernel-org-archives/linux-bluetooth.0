Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888028488F
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781384977; cv=none; b=Vnf2pPJfCrGVFJ/an6tXmR3hO48APWPYktHv67pQHxUVrb3KSGCUh4TeVeorzGmPd3yuJnmSy1NYt9SX+Swfzl5OBqIsnUzSgmYaGl4QPXDLvG7FARMQH796f1+TqFLgVhXIDjTQsHkx52n0M3Y1YDHjbThvaZuR6jbKLcNcVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781384977; c=relaxed/simple;
	bh=QQx+fIcaXXi28gh4MJK3I12rSjWSFq6UR8+85O0ta9M=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=n+XXVrZLc+GmboCES9eMiFhaMIhiTFCHmj2r+DRpRQ7wduJsNMnssl57B3wMG3/5SxxTOLFozt14OundyjXFvhAEFAgw6M5c7fUCg1f9hT07EFe83+74lBd+PXEjwMi53cgQgmtM3oP1HsTjhi3KWV4bCOMBg9T2Fz2aXuPTTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=fYXyvWPx; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="fYXyvWPx"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6E415240027
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 23:09:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1781384967; bh=eG6XGtNGe2JTbpLnDWfEzspvwMQBm8jSlJ4LagNZQfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:Autocrypt:Cc:To:
	 Content-Type:Content-Transfer-Encoding:From;
	b=fYXyvWPxC7+nUZcDp9mrP9VaOI2wjFFRAyN+yR1BohwipsHRpMiSU5ugEHJLaooJy
	 nYt4T61HewsndBC/MWNRutcbMgyaflJPstOKCgh2kGT9HTO5U5Re6hKEs+n19c4x67
	 Hc6b15ibc8RuPY2WYFdzVN0JyAJqIg36a2g4PxPst6tNJrCv+iBcBJ71ld+eH/VrWu
	 TsEY6mib5qUXt5Ezx4zSpuFqxwtYDeJjzXF0p8u5RafF40UhmOfzOlwRaJ58KVDJK5
	 4BYw4BCgj+/u7CSmxXGGZ8h2wO6qpRrn80v39oCKSgYzjWr89EbCA1CknNOxliOpdi
	 shY6SQzP1lBiw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gd8CB0qKkz9rxF;
	Sat, 13 Jun 2026 23:09:25 +0200 (CEST)
Message-ID: <635e5e63-dc67-4dac-8590-d613582c94c8@posteo.net>
Date: Sat, 13 Jun 2026 21:09:27 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: =?UTF-8?Q?Bianca_F=C3=BCrstenau?=
 <furstenau+kernelbugWGvWw1PW1l@posteo.net>
Subject: [REGRESSION] Intel Corporation Device a876 (rev 10) firmware crashes
 since ed10eae8
Autocrypt: addr=furstenau@posteo.net; keydata=
 xjMEXvj6QRYJKwYBBAHaRw8BAQdAjPgpP4/OvbMT6+fNQPIrB/vsLvOlYUVllQNYcRQtIvPN
 J1BldGVyIEbDvHJzdGVuYXUgPGZ1cnN0ZW5hdUBwb3N0ZW8ubmV0PsKQBBMWCAA4FiEE/VXO
 o7KKH1JBpL1ts98yAB0tbLEFAmiwGvsCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ
 s98yAB0tbLE2JgEAjtgZcYsddoNaCql6jng1VYdkvmaw0IIPJPeqLuDrSU4BAOSdJE/DImJo
 +L3ctEb1H4j4teTzSqmqHX5neAaHTqsJzjgEXvj6QRIKKwYBBAGXVQEFAQEHQIZKaUZTJ9H5
 f8znaWXd7WkLAnZhOULznKEfFtXyQ1Y2AwEIB8J4BBgWCAAgFiEE/VXOo7KKH1JBpL1ts98y
 AB0tbLEFAmiwGvsCGwwACgkQs98yAB0tbLE5uAD+O755ysLZ3xls9SSKusA1yj1qQJMPDm4L
 uBb+j1goNRMA/joILMHXEZI3C5frHb/KFpy0TAtTkAtlf/IopFtLCUYL
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 Ravindra <ravindra@intel.com>, Sai Teja Aluvala
 <aluvala.sai.teja@intel.com>, Thorsten Leemhuis <regressions@leemhuis.info>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Pierre-Olivier_Vall=C3=A8s?= <nibheis@gmail.com>
To: Dmitry Baryshkov <lumag@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dmitry,

It seems that the linux-firmware commit ed10eae8 introduced a regression 
causing the firmware to fail on Intel Corporation Device a876 (rev 10). 
The next update to the firmware images in 7df47664 did not remedy this.

For dmesg extracts and other details, see:
https://bugzilla.kernel.org/show_bug.cgi?id=221637 (Upstream bug report 
where Thorsten informed us that we were sent to the wrong place)
https://gitlab.archlinux.org/archlinux/packaging/packages/linux-firmware/-/work_items/45 
(Downstream bug report by Pierre-Olivier)
https://github.com/NixOS/nixpkgs/issues/530344 (Downstream bug report by me)

Please let us know if you need any further information. I’m sure both of 
us would be happier to have working Bluetooth with current firmware 
rather than at most one of these.

Kind regards,
Bianca

ed10eae8: linux-firmware: Update firmware file for Intel BlazarI core
  
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/ed10eae8facb3b4bf2da7104cec95afdf0209114
7df47664: linux-firmware: Update firmware file for Intel BlazarI core
  
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/7df47664dd1d94111858b3224c15908517c73e73
Merge Request for ed10eae8: 
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/955
Merge Request for 7df47664: 
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1018

#regzbot introduced: ed10eae8facb3b4bf2da7104cec95afdf0209114
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=221637 
[Bugzilla report]
#regzbot monitor: 
https://lore.kernel.org/linux-bluetooth/bug-221637-62941@https.bugzilla.kernel.org%2F/
#regzbot link: 
https://gitlab.archlinux.org/archlinux/packaging/packages/linux-firmware/-/work_items/45 
[Arch downstream report]
#regzbot link: https://github.com/NixOS/nixpkgs/issues/530344 [NixOS 
downstream report]
#regzbot link: 
https://discussion.fedoraproject.org/t/bluetooth-not-working-on-fedora-cosmic-atomic-intel-core-ultra-7-kernel-7-0-8-200fc44-x86-64/191881 
[Fedora downstream report]
