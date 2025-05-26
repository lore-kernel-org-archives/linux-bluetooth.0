Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A619D88F
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242367; cv=none; b=kq/ME17YTLBqHUDCJQf1Qmpcr4kFjhGJxFjWP87zbZ/mtMiyn5WgyoPxL/hZdABTZ4QqtR+3iDjgOlQ3xCKVYG048HylQnIB+H1VH7AsLaFu13GI4tg2Ce8QKqve6XZflOYXnLI2pKT5w5Ha8jwSgXwL5ugCqRxSpH4TISvry00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242367; c=relaxed/simple;
	bh=Z52OzOSTUSrobuO8k+luxsb3Mrrx5lrqfi4q11PaIr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpUvGHg1WUsxybpvxk4FatTa7rDfCsNEb52uewN5+uowC1E7rwkd3o8MF3FGb34vryLTBc9mnE7BKfiqwDgjRXkEeHSD21R1Phgn79t2zULYSszvX1FaKcjTlMRsUFtv7mMmnoTEejeefNjK8JvO1G1iu1Y4FBCnUKMxvREily4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7fB3/Ve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7fB3/Ve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748242364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOw5aT8rZ894OuzRSqfx6nxu1JDQtm13QlR/qfnuRh8=;
	b=Y7fB3/VeQqgQeRBOP2RQ7n4Iflk6VgBYiEUL7S5Jgv7FKd34Flwabofw/iFiU97uBsYUsf
	V1JjFmlfYskwuuIl8Y1abeN3wc7gcQAGhxFPrMVCT0ru8Ue5sxGDg/J2ARsHq0huwX3FhB
	1pwongAq4HioTdBiJtdnsLAbIZ3ufOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-3ZZbJFV3Oy-GmV5HpvmadQ-1; Mon, 26 May 2025 02:52:43 -0400
X-MC-Unique: 3ZZbJFV3Oy-GmV5HpvmadQ-1
X-Mimecast-MFC-AGG-ID: 3ZZbJFV3Oy-GmV5HpvmadQ_1748242362
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4cceb558aso490787f8f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 23:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748242362; x=1748847162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOw5aT8rZ894OuzRSqfx6nxu1JDQtm13QlR/qfnuRh8=;
        b=Dm2J7z86H04cc8mjAb2iJ07phMj/oNFRc2sW8mQ0Jgud1lhSQt9B9PP7RYFpTg2xUG
         2AE/jXPKxFMvZMXYSra+4d8YJjKNvZv735m2Rmio+C6xWwyEb9i63HI+sQe4Jy2TO3cc
         Uk+Yvm9bosPzt885H9X3SAxYoVGNwvBFTodbKn/H1wsH+3lHDj1Fhs5Tzot4wu0uUKdy
         3HddjBONcB6+Wrvh61NMj5bdguzVS6rPT1TwWA7pl0CpIjjrRfeohnVfFAfLbSLEL5NJ
         OJfSnG5u+5112zov2etYWqIX5PTWZxeAz7OQvbpygU6Twz9tbCEyDhHrhUNFqaSb07kN
         z5uw==
X-Gm-Message-State: AOJu0YyXRlU4a0Lr1oocmzBnOEqa33gJnHTiHjeJ7hXj20zyjf/fFGJp
	UTLVgW84vaHQ8FjgezENS6rbKYVnzMjhBj1KQ0RpGHZ9yYXRzczJRly2YOx1jom53T0ACDp0dPF
	IhtOG86HY9802BRXq/YjvlLYvElJbWODzoWS0ThW2D9nQM/PA6Y8cRdI+sYoA6Dgitj0Efw==
X-Gm-Gg: ASbGncup3vBXmfHx2M3sxO9reZCPf3zDWDj+hI74fVJDLT73O3DTntcrAyuep6EE9Ld
	d4KKmj6a3HARwpFv7hpIkYdGVZhPUxDFQKilb5WrACNnFyvfModvPQrM25TsHVV8NZhh7QFzbVj
	DiOiYV9NgK4lx4ztIxXDemyAJjgKC7MccGy94w1tzjUOTbIH4tPG3Il7bEkNuOFBKNzDuImF124
	CHZtk8fI+yay2uCveUaaj+4lIkguPxGRTcw1xefy65S4uJJf95Leh2/SNSZoSyQkGGBhRF6M2K5
	ywXN/i0V1r0VsYFAdAM=
X-Received: by 2002:a05:6000:178d:b0:3a3:671e:3b7c with SMTP id ffacd0b85a97d-3a4cb4996c6mr5768496f8f.48.1748242361778;
        Sun, 25 May 2025 23:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExOfSDAisSVZqhciUw0uFkv3j9cqxJbxN6jdBydc+6Olhc5v5HrwWkXxdBJcJyK9vnJXa8Eg==
X-Received: by 2002:a05:6000:178d:b0:3a3:671e:3b7c with SMTP id ffacd0b85a97d-3a4cb4996c6mr5768480f8f.48.1748242361420;
        Sun, 25 May 2025 23:52:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d652e8b9sm3222690f8f.34.2025.05.25.23.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:52:41 -0700 (PDT)
Message-ID: <1562810b-9217-4da1-ba9e-bc1574047aaa@redhat.com>
Date: Mon, 26 May 2025 08:52:40 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bluetooth-next 2025-05-22
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20250522171048.3307873-1-luiz.dentz@gmail.com>
 <CABBYNZLK00mJ+80XkkS+k9_MC2h2d6wDPqwJqHmR9k_PJYV75Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZLK00mJ+80XkkS+k9_MC2h2d6wDPqwJqHmR9k_PJYV75Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/24/25 3:28 AM, Luiz Augusto von Dentz wrote:
> On Thu, May 22, 2025 at 1:10 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> The following changes since commit e6b3527c3b0a676c710e91798c2709cc0538d312:
>>
>>   Merge branch 'net-airoha-add-per-flow-stats-support-to-hw-flowtable-offloading' (2025-05-20 20:00:55 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-05-22
>>
>> for you to fetch changes up to 3aa1dc3c9060e335e82e9c182bf3d1db29220b1b:
>>
>>   Bluetooth: btintel: Check dsbr size from EFI variable (2025-05-22 13:06:28 -0400)
>>
>> ----------------------------------------------------------------
>> bluetooth-next pull request for net-next:
>>
>> core:
>>
>>  - Add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
>>  - Separate CIS_LINK and BIS_LINK link types
>>  - Introduce HCI Driver protocol
>>
>> drivers:
>>
>>  - btintel_pcie: Do not generate coredump for diagnostic events
>>  - btusb: Add HCI Drv commands for configuring altsetting
>>  - btusb: Add RTL8851BE device 0x0bda:0xb850
>>  - btusb: Add new VID/PID 13d3/3584 for MT7922
>>  - btusb: Add new VID/PID 13d3/3630 and 13d3/3613 for MT7925
>>  - btnxpuart: Implement host-wakeup feature
>>
>> ----------------------------------------------------------------
>> Chandrashekar Devegowda (1):
>>       Bluetooth: btintel_pcie: Dump debug registers on error
>>
>> Chen Ni (1):
>>       Bluetooth: hci_uart: Remove unnecessary NULL check before release_firmware()
>>
>> Dmitry Antipov (1):
>>       Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
>>
>> En-Wei Wu (1):
>>       Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling
>>
>> Hsin-chen Chuang (4):
>>       Bluetooth: Introduce HCI Driver protocol
>>       Bluetooth: btusb: Add HCI Drv commands for configuring altsetting
>>       Revert "Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL"
>>       Revert "Bluetooth: btusb: add sysfs attribute to control USB alt setting"
>>
>> Jiande Lu (1):
>>       Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925
>>
>> Kees Cook (1):
>>       Bluetooth: btintel: Check dsbr size from EFI variable
>>
>> Kiran K (1):
>>       Bluetooth: btintel_pcie: Do not generate coredump for diagnostic events
>>
>> Krzysztof Kozlowski (2):
>>       Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
>>       Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind
>>
>> Liwei Sun (1):
>>       Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
>>
>> Luiz Augusto von Dentz (3):
>>       Bluetooth: ISO: Fix not using SID from adv report
>>       Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
>>       Bluetooth: L2CAP: Fix not checking l2cap_chan security level
>>
>> Neeraj Sanjay Kale (2):
>>       dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
>>       Bluetooth: btnxpuart: Implement host-wakeup feature
>>
>> Pauli Virtanen (2):
>>       Bluetooth: add support for SIOCETHTOOL ETHTOOL_GET_TS_INFO
>>       Bluetooth: separate CIS_LINK and BIS_LINK link types
>>
>> WangYuli (1):
>>       Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
>>
>> Youn MÉLOIS (1):
>>       Bluetooth: btusb: Add new VID/PID 13d3/3613 for MT7925
>>
>>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  17 ++
>>  drivers/bluetooth/Kconfig                          |  12 -
>>  drivers/bluetooth/btintel.c                        |  13 +-
>>  drivers/bluetooth/btintel.h                        |   6 -
>>  drivers/bluetooth/btintel_pcie.c                   | 141 +++++++++-
>>  drivers/bluetooth/btintel_pcie.h                   |  19 ++
>>  drivers/bluetooth/btmrvl_sdio.c                    |   4 +-
>>  drivers/bluetooth/btmtksdio.c                      |   2 +-
>>  drivers/bluetooth/btnxpuart.c                      |  58 +++-
>>  drivers/bluetooth/btusb.c                          | 302 ++++++++++++---------
>>  drivers/bluetooth/hci_aml.c                        |   3 +-
>>  include/net/bluetooth/bluetooth.h                  |   4 +
>>  include/net/bluetooth/hci.h                        |   4 +-
>>  include/net/bluetooth/hci_core.h                   |  51 ++--
>>  include/net/bluetooth/hci_drv.h                    |  76 ++++++
>>  include/net/bluetooth/hci_mon.h                    |   2 +
>>  net/bluetooth/Makefile                             |   3 +-
>>  net/bluetooth/af_bluetooth.c                       |  87 ++++++
>>  net/bluetooth/hci_conn.c                           |  79 ++++--
>>  net/bluetooth/hci_core.c                           |  45 ++-
>>  net/bluetooth/hci_drv.c                            | 105 +++++++
>>  net/bluetooth/hci_event.c                          |  40 ++-
>>  net/bluetooth/hci_sock.c                           |  12 +-
>>  net/bluetooth/hci_sync.c                           |  63 ++++-
>>  net/bluetooth/iso.c                                |  30 +-
>>  net/bluetooth/l2cap_core.c                         |  15 +-
>>  net/bluetooth/mgmt.c                               |   3 +-
>>  net/bluetooth/mgmt_util.c                          |   2 +-
>>  28 files changed, 920 insertions(+), 278 deletions(-)
>>  create mode 100644 include/net/bluetooth/hci_drv.h
>>  create mode 100644 net/bluetooth/hci_drv.c
> 
> Haven't got any update regarding this pull request.

Jakub merged it last week, merge commit
43a1ce8f42cb45d028a8e5f1c2748fb3eff48fb3

The PW bot has been flaky.

/P

