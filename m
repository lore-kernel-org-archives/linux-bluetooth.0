Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFE7E782
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jan 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844180; cv=none; b=uZMaXzVndCZwrrb5rsHh+SpoUWJAPASU/24khwckuGlvhAIU6v0Lgeg37or46YvJNtumS6f17gljEHLudqKiwGFYfMc9E/MuVSyHAXZUVcT6wv573iODBYEUHTbDKuYBhj+lxyT6Fcz7ifgQdMYO9X2pJuzv5KIO1GQG8OCribQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844180; c=relaxed/simple;
	bh=ZhkA/NM+80hBGXSyC35CkDvFt4dvjiCLHDeLs4riEqs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rs1lHzBpnyeweF3xBfYu2IHEb1vthVBfqo8yNjvNikaSqUaaINXKGQmHBguKVPluw57pxffQ/NdAQdIJRCfhigq123idQigNr7t9oSl2rgKXN8v9RplprGBu9zK8Y0j+9l6YxHeaPYduerorxPs2U5GrmSYAAwiudZXgtttZc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=W55uPuBt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="W55uPuBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1735844175; x=1736448975; i=fiona.klute@gmx.de;
	bh=ZhkA/NM+80hBGXSyC35CkDvFt4dvjiCLHDeLs4riEqs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W55uPuBtsfst3c91+71dj28ot/S5rMHHH37Yu59a5XO1hhQ8RigdefWU4a2JwnW8
	 c8HvQxU6nUqa4yo9dmlapd81dqlGo0vardKURKhNmZul76Vo5hyp7GTNV5T4xr3EH
	 ZYfsD9XrApHcyMpQN73GyABedm6lmwoiNCqak7hr/fzpqHCCV1cmfAc4EBL3AU0Ca
	 +VHuLBUE2FhNMSqxxKfDPZzzo+aaSXxXy3/VGHh2HX8GKi8Ctm7d8YCCYrYv2enxG
	 +v9uEtJF236trlcHmk2IqJXNz+Nxzrw/5RG1qPwg8b0Z3OE3+YQI1QfDGdAHES+xJ
	 3bRAWwjEPtXr93fWzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([84.249.220.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1t0kTf08Hw-00YRgy; Thu, 02
 Jan 2025 19:56:15 +0100
Message-ID: <2d83c7e7-80a2-4fa8-b095-c0ac7ad62581@gmx.de>
Date: Thu, 2 Jan 2025 20:56:14 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE-1901, de-DE
To: linux-bluetooth@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
From: Fiona Klute <fiona.klute@gmx.de>
Subject: Bug: BlueZ Build fails with --disable-hid --enable-hog
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:To750VWJZgLECTZuI1Lzkp2TU6uNU1IcQvtdSsa4X2+BsIO3XOs
 tiYIwAnBUVzCdujLw2XT82FaMt5ZQfXsO4H40pjwgpvPxcTiSU9GkypndlKMKcnancwWuMp
 SXG2PAavneCP5zyhXf8EBY69WnoazOyj5HNmrEypxvDqjGRkkcW5aVU0hHIpsxJjSX02/Sj
 cAr/lEyW7ABm0IIY9LqDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rc/35YAf4lQ=;6QfjVwEaZlh38T8jCs5vArwu+Bu
 MU1rdRqa3DegT8WiyESCmDM8+PtUGcTsQkF6moV9/aeO2RYkxIScoIauVdXq5R2U6A48Wy+OU
 laI6IynUtRT4iDnqPU+ftzo+3WCrnnOK5JC5hlSGTz5mU1INuY7TDwKw4duMsWYwY2ZZFm15B
 UV5qbmcpJJ0G+e47G1yb9eEX8uxWHtqQNLEDR3ImK3HDiudnc9PCFm/oKnclGW4MsmtcT5aqX
 bsLoWyFN5b9p8hIBXQI73AgR+g3RMx4T5u7Kzx5bkEDnYZRIaMg59aASTyeGgZrahFjlMyeYa
 8usuhPykMYpUB8eCapY+chDSFpfxcBblAmRvbiXA97q9SFTPAxwj9hZM150RH7BJdK1DF4y9F
 f3shPJZQgdEisTTmM5ywWwETmHO6FCANyamSqsQiptZ/SU05YafvJsIH3CPNcsVIIjMlaeN4Z
 1CRwjGYBpKdHRPKfXc7OYRN6/evjghwJqIWoKP+UU79o4YetBXlKpT4sr/ifH7OOcFjOaiuVS
 U+p0Fbzr8g1If/lg6x3uDTXH6vdOgOnhnTAco2TcGdic5u3NPEmoeKybQ5fl5/8NeC7XKmDgv
 fMIS0wuzVnCwX8/Rin9RVQo5ON+OX1AK6htwl0EtTJwLQGXtFl/ja+WPlfsGA8YIROJAB5Tzn
 yKhxIJglrHKT6wwooNBMGaJlk+yLplh1zcQbKIJfvIZYVEtHgsnaUk5kmkq8j3fqDtSWaF77V
 BDCsn2O1J8AkF7hbGB1bZ+aU4Vs3LvhQSqNtB2ypDiMX9uuZOkl031jFoNu+vNasQE8ZucrPR
 fVebIcfV6shWVDCNlja0tjxRHVa+wiVbGbYkpvpOoxxd9OYtSkcrNH5BTHBNUafAs9xxhq3Nn
 Qp1SphYFK60NUfz6aB3wrumX8uMtpGjBZOXb7tB9UIA+wTJIgFWKFmHe0rMOPyFBQkbSe0jYk
 RI9x7Upwa4LcqsqRjaNp5coytg14Fwr2H1Nq9nB8FSqMveoYwj0P0DD5ZCrvWTXNYh/Jta+Au
 dtg9Ko3c8Xnk+0qb/KsY/FTksm/UqE+tl307BKDuM6xooxkszdAZpUYQXbslPO65O3ps/jkLe
 cL6N+/BLpfdIsYdA/3By6dA7eL/t3s

Hello,

in Buildroot we've seen BlueZ 5.79 builds fail if configured with
=2D-disable-hid and --enable-hog (see [1] for logs, [2] for discussion):

/home/autobuild/autobuild/instance-7/output-1/host/lib/gcc/mips-buildroot-=
linux-musl/13.3.0/../../../../mips-buildroot-linux-musl/bin/ld:
profiles/input/bluetoothd-hog.o: in function `hog_disconnect':
/home/autobuild/autobuild/instance-7/output-1/build/bluez5_utils-5.79/prof=
iles/input/hog.c:211:(.text.hog_disconnect+0x3c):
undefined reference to `input_get_userspace_hid'
/home/autobuild/autobuild/instance-7/output-1/host/lib/gcc/mips-buildroot-=
linux-musl/13.3.0/../../../../mips-buildroot-linux-musl/bin/ld:
/home/autobuild/autobuild/instance-7/output-1/build/bluez5_utils-5.79/prof=
iles/input/hog.c:211:(.text.hog_disconnect+0x44):
undefined reference to `input_get_userspace_hid'
collect2: error: ld returned 1 exit status

Looks like profiles/input/device.c isn't compiled with --disable-hid,
which is why the function is missing during linking. It appears to me
that either the HOG conditional should be fixed so all required files
are compiled if it's enabled, or HOG should require HID. I'm not that
familiar with BT input devices, so I'm not sure which is the correct
approach.

Buildroot has been forbidding building HID without HOG due to a similar
bug for a while [3] due to a similar bug, which makes me wonder what's
the recommended solution. For Buildroot granular configuration is
desirable so embedded systems with limited storage can include only the
required parts.

What are your thoughts on this? I'm happy to look at patching once the
correct approach is clear.

Best regards,
Fiona

[1] http://autobuild.buildroot.net/?reason=3Dbluez5_utils-5.79
[2]
https://lore.kernel.org/buildroot/4abf920a-3da8-457b-a287-cb57fc7fd20d@gmx=
.de/
[3]
https://gitlab.com/buildroot.org/buildroot/-/commit/9850f262fd6546d15ae27f=
84a0e36411abc2b7b5
