Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84514155316;
	Sat,  8 Mar 2025 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741462808; cv=none; b=aQufWm3f2d9IKehcN4Jf37YoefIoAK0yhGPj87UmTAnNnv+9eTzIYY/NnKHrhoScPQq04T10y86ZgpKEc8dUd/wo1NrtW++Ej8bJxSRCuZq0S9seL/QuCYNQnY5fdzERIMQo5TTHQH0ox6+I3iZTWoDr5BW6xYQdRuFHTE9Yl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741462808; c=relaxed/simple;
	bh=u95SOK8XrtFcUJcoHMZIV67ybjxm9OqN/sfLe0FBqjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FuHCnophhJAlXS33kGdT4/OfcCY3YUyg8ZqzH6ZQx3ReQcr8EzgHplPdFn2HAk+gAyRpl8zORnhOHD9N2nVfzmzmD1SLDnhXf8kk/d6p8GOe2iy3XKrQQpA/fnrZ4qHvF2FjdQxWS7/wDrg34xypVSkW8ekGCAZ8xsi6l4wFgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=Xh4hI6n/; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="Xh4hI6n/"
Received: by m.b4.vu (Postfix, from userid 1000)
	id 835D66661191; Sun,  9 Mar 2025 06:02:11 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu 835D66661191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1741462331; bh=6nIUT6zNLLVzgjgzFTaOnFCafZ+5lF0wPddW9zDwxB4=;
	h=Date:From:To:Cc:Subject:From;
	b=Xh4hI6n/EbO9m6b8XKoBU3l+uN6BiHRPXfGkxBe8qYi5DGoWlbvkBCStjU25QVBTw
	 pDCneSIelHJtHAe9OgPI7JzwwNFgPGyKKnFq+Cd2kIImE9z2+Kphv/BVD3qgseBeai
	 0VKaS0xNAkxXR3AYpjZ8ZhcOL8cuwTEAnhz7ulU00e4oRmn7xegCNnJU2txPYCGQ/8
	 aYDVI/ktUJK7ZAAHYcwml1RSgIx4D/w/y10ZE+LnPx93zYW1Dg32EzMlG4eWOx/OmF
	 tbf9hafizynbGrQ+2K4Xbk/joq52t7uSysUCR3xpZlLX3SWBt7VglKtqA+ySALciMo
	 E1AIEhg8N4h5w==
Date: Sun, 9 Mar 2025 06:02:11 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>
Subject: [PATCH 0/2] Fix for MediaTek reset affecting Focusrite audio
 interfaces
Message-ID: <Z8ybO7DfeP3Ag9wz@m.b4.vu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series (choose 1 of the 2 patches) addresses an issue where the
MT7922 Bluetooth controller reset added in commit ccfc8948d7e4
("Bluetooth: btusb: mediatek: reset the controller before downloading
the fw") is causing Focusrite USB audio devices to fail to initialise
when connected during boot on kernels 6.11 and newer.

Reported by three users here:
https://github.com/geoffreybennett/linux-fcp/issues/24

Two users confirmed they have an MT7922.

I'm providing two possible solutions as I note there was a similar
change made in commit a7208610761a ("Bluetooth: btmtk: Remove
resetting mt7921 before downloading the fw"), so I'm not sure if the
reset should be reverted for the MT7925 as well as the MT7922.

Option 1: Revert the problematic reset behaviour entirely (MT7922 +
MT7925)

Option 2: Remove the reset only for the MT7922

Geoffrey D. Bennett (2):

  [PATCH 1/2] Revert "Bluetooth: btusb: mediatek: reset the controller
    before downloading the fw"

  [PATCH 2/2] Bluetooth: btmtk: Remove resetting mt7922 before
    downloading the fw

--
2.45.0

