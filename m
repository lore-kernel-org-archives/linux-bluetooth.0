Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCB14292
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Dec 2023 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af728.dynamic.kabel-deutschland.de [95.90.247.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3FE3161E5FE03;
	Sat, 16 Dec 2023 12:15:42 +0100 (CET)
Message-ID: <12c4c516-28d4-4f09-86de-5e424cf714f3@molgen.mpg.de>
Date: Sat, 16 Dec 2023 12:15:40 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Linux warns `HCI Enhanced Setup Synchronous Connection command is
 advertised, but not supported.`
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On a Dell XPS 13 9360 with

     ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4 Bluetooth 4.0

Linux 6.6 warns:

     $ dmesg
     [    0.000000] microcode: updated early: 0xf0 -> 0xf4, date = 
2023-02-22
     [    0.000000] Linux version 6.6-amd64 
(debian-kernel@lists.debian.org) (gcc-13 (Debian 13.2.0-8) 13.2.0, GNU 
ld (GNU Binutils for Debian) 2.41.50.20231202) #1 SMP PREEMPT_DYNAMIC 
Debian 6.6.4-1~exp1 (2023-12-03)
     […]
     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 
06/02/2022
     […]
     [    0.456973] microcode: Microcode Update Driver: v2.2.
     […]
     [   27.179867] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
Connection command is advertised, but not supported.
     […]

As a user, I do not know what to do about the warning. How can I adress 
it? Is that a firmware issue of the USB Bluetooth device, and should I 
contact them? It’d be great if the warning could contain that information.


Kind regards,

Paul
