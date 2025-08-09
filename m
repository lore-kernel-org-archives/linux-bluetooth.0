Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894B239E62
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754734935; cv=none; b=an2Iatp8Kz8H/VrSsH10j3chzLdZM8KH4WaHhYp/PYBaLH+YsAIFsHXRvZp9M5G4U0jEET/F2ACzByIYsISDY6p9L/XSo88lzEUJBHxkCnIipRTHBWNz0Khq4L3VEjYoXkFRZsQfPiGLq1jmJihTXXPzf5fFFBAUwyRz/Nq1hNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754734935; c=relaxed/simple;
	bh=ckkfzaaeiMv5tyAbutz847XAnAuAMvt0zlJY2V7mus0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=T98jThi6kEehovZwrB84HADavjEpmSpE9DegX2E6rK+GTUx6IiQOWueypdY0bxqwnXIUcngtVMvwIjxliyuzmFomevKl8991S5PqhWF4VbRvkUuqMFZHk/wy+jznQyHTJ4VEd/hUUNojZIOUBEGrTgKaDGj8Nz8jiWhZJ1NeMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7a9.dynamic.kabel-deutschland.de [95.90.247.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D0BB661E647B7
	for <linux-bluetooth@vger.kernel.org>; Sat, 09 Aug 2025 12:22:07 +0200 (CEST)
Message-ID: <97a26f46-4153-4b1a-859e-2cbed1b92b6d@molgen.mpg.de>
Date: Sat, 9 Aug 2025 12:22:07 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Two volume related issue with Sony Audio/Video receiver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Pairing the Sony A/V receiver STR-DH190 [1] with the Dell XPS 13 9360 
(Linux 6.17+, *btusb*; 0cf3:e300 Qualcomm Atheros Communications QCA61x4 
Bluetooth 4.0), the volume control does work, and changing the volume in 
GNOME also updates the displayed volume on the receiver, and changing 
the volume on the receiver, the volume meter in GNOME Shell changes too.

There are two issues:

1.  The volume level bar(?) in GNOME Shell already reaches the maximum, 
when the level is at around 50 on the Sony receiver, whose maximum 
volume is 100.

2.  Changing the volume by turning the knob on the receiver, the volume 
bar in GNOME Shell does not change smoothly.

I uploaded the output of `btmon -w ….cap` [2] and a screen recording [3].

Where would I report these issues to?


Kind regards,

Paul


[1]: https://www.sony.de/electronics/av-receiver/str-dh190
[2]: https://owww.molgen.mpg.de/~pmenzel/20250807--sony-str-dh190.cap
[3]: 
https://owww.molgen.mpg.de/~pmenzel/20250807--sony-str-dh190--gnome-shell-volume-meter.mp4
