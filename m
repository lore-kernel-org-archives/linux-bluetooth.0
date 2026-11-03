Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707784;
	b=viHeyzgEByVjDHuoL6HEj5NVIqpU+/P+xtEK6dsntyQIKytGj7gxJPNC62lCpwRum8xd
	 9Df+ZAnheGLVCruAsOX5ZZ7kVUVJ7KVr9p5UPgz6reNpFowiIb+L1ik8T/8ecc6q7n+fJ
	 XC4uBfhvSQYQDJSBKmcgwzH5wi5AV4pW7qTRFlROQTyoVmSJlS4+jJ6N5KBstWhiyIWls
	 mSUioJsj2kx1O8olWKPz/X8QV/e6NzCGAhiL7PC0H+SvVSVjONqUNVyMoznrzp2MJWvdP
	 VwL3+mPwqv+t/eznqDU0WpYuGvCJYwrUyp3KVV1vCLDth7lGZ7GlYtpIlufmUacEf0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707784;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
	b=IUVj5JfWQvCqBqcO4WBeQ5wQMvI+yQl2dIii4CJVMis/z0ad2WXFKTPnnMHa+45m6Vcy
	 5CN0oIi5HYDMHPuJC6MoceVtRhSUzLEgwM3b3YnX3Cp+A7YLf/pHnFECJhp/HYRv2QtsE
	 lV+b1GvbdygkeeiHXkBMPXvv4T4vOskcBGakM8b6wDE1umb5ttQxXFtJRaWF9PRVdy+/L
	 vCJ7CufnjMKIRlmtucilHGf5FebCHljRBd9DAHzuaIApv7ZDblcqg46s9K/GK/Rp+dD4y
	 JLesVKOg927xBMxPibMY3oT027ZQVEv4RnJKGMTftvQNxK1nK+Tib/wLtRcstxl0dKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Taz1ZifE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D51P0HAF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6B606A335
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 12:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A6B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Taz1ZifE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D51P0HAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793707782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
	b=Taz1ZifERdpvvFThdSNTWJpv0aLGUJKPYp7aywYk8MonYwzk/cNyXzoNYPSESRPbViB6bg
	B+UYJLsj0tFnzjf2QvX6kEZ9aRYCCCkM+PyTXbR/IDsLTsPda0ARG5YfXyYCCgToNvpvcu
	eyDP9IVdSD21S9LgKkYvAF2/oRtlzlM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-2WJH99IgNw2eqhgDfvhNLQ-1; Tue, 03 Nov 2026 07:09:41 -0500
X-MC-Unique: 2WJH99IgNw2eqhgDfvhNLQ-1
X-Mimecast-MFC-AGG-ID: 2WJH99IgNw2eqhgDfvhNLQ_1793707780
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so39498685e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 04:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793707780; x=1794312580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
        b=D51P0HAFtd+AeKw9q11SHwQCaSJPkeZ3lB3Avgf0fnrBCRwRRXGKWv5+vymobR1A3J
         +TudcI9dW2ZiqKM2GuuULw4aFL5nWAygMZayTCfnqcK5hGtxol5X2JesKcyKq8WgLz6M
         Gy+ODljho7EIzbceGwOPOzeDaV5SBHmOm1p0Jrulxyc+RvuA3gBlh7OnUaR9EjOHe4Ij
         wRm1AgbbI7A+02kqMsrfltRWfM4PYbCoGRlrHc9wjaTeBvLL270fRp/zdw2FN0EOV0oi
         kNwpFj5KwS79Zq1rjOteR79Y+zfdDUf4r5XWQIWgdIIxqU7PkIAYGzfB8q0YzQVRMAX4
         BFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793707780; x=1794312580;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjBl+xQjckO71yWChgagu6bNi+s2XZn6aD6ayTH9C6w=;
        b=jDJPL5qiNgSSFPOBO1BvkEIIjUm54dV3tvAATWoCVxGPb/fy2MmLe/Z2ro/177NlG3
         amdYqr7xpl6elVYZ+5qv4fM80zEK2wJZLGRAJarTPM+vSaxtl8dYXNEtvuhQv2Ez6wnZ
         GalR0s7m2p3h1OxhOQ67oTvehyMABtqUpoHkaMQhEQP7CnlX3idiWJMaSl/BN7lex3Fo
         rlImQcnr6GbOjqi8zQOZxNtaVb6CDhfN/cPYkAyWMhIKReaWETsOetDoFEA00ZWMbxl9
         2riLTvWUoAHHZvKg+hiozOKRvvZmge0XLn3H/cRZ6yJ7H75jWibjFWndcKD1wBmC2iNz
         JKmg==
X-Gm-Message-State: APuU4Z9VxwbYPGTi0NKu1pSsoVFMsAhrEjO+0PlMpMFp5te+salVT/7H
	0pghqBFIjA0idg0WIFIYWWF6Fm+N+dF1o1hWA5g0oEjvCmXcthIIuZxCKFmF+/KDQo6yLCjOm2L
	3FeqMvHbom/MkQcHlKtJZL6itFEW4KZEGzbwjbSjqiHVKVCqbI7Cbe1dfuQR/mwF81tOYBg==
X-Gm-Gg: AYBFou1ouwa2cLBbX5++8v0pSolyeAXqhp9wh/yAvq79KLuk9IDcfTVc36nCjoEHjET
	bBKMzXRq32LODWrWMjnUKqefuZO0ZuhJFhLrkIkl7tSjnRW03MYXM3xBIw5uspqhl3yB5o6Y9u0
	UV8+pFygta4tTeHI8iQtz/dSJOWB/FfYhSfyx108oAaN8aITEb0KZzpX5wGIyqrWh5g+fisgcuI
	MGo+hQAf/Cyqr3h/2QsDmnwFmi7cIFQbzKqGQb29wzxidJuBr8SWwh62spi9cSB5KT3UGdN/Qj2
	aRzzF7RnAkiaVxxVst/ein1Kfvc62gU/KOyd9RErVUrMOScdeO1RXxTXoq5lpqsIg0KFYUfDiWw
	aIuWq4NXXREV/UYWrFizjSqhMdFtZfrYmuDKhRvoXJvRNGAKq2vOKU4NV7m5Nc+0fAVomToHkdv
	7OV8nVne0icU+HO14wDds/4CxZno1qfesxVGriE/ALJLk=
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr293047435e9.27.1793707778539;
        Tue, 03 Nov 2026 04:09:38 -0800 (PST)
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr293046905e9.27.1793707778109;
        Tue, 03 Nov 2026 04:09:38 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm58867935e9.0.2026.11.03.04.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:09:37 -0800 (PST)
Message-ID: <997ed703-e1f8-4b6e-aede-b1a8a5ac6140@redhat.com>
Date: Tue, 3 Nov 2026 13:09:36 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-11-02
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20261102222018.2610820-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102222018.2610820-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 23:20, Luiz Augusto von Dentz wrote:
> The following changes since commit c3e67bd82b9b9b1a5118f09a429ccefe2aab0741:
> 
>    ipv6: reject wrapped temporary address preferred lifetimes (2026-11-02 22:31:32 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-02
> 
> for you to fetch changes up to 60b10121db602a43ada3dbc39792bbf93d25991b:
> 
>    Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
> Core:
> 
>   - hci_core: Initialize IRK before publication
>   - hci_core: Initialize link key before publication
>   - hci_core: Initialize LTK before publication
>   - hci_core: Fix queuing rx_work while workqueue is drained
>   - hci_core: Keep link-key filtering inside RCU
>   - hci_core: Initialize advertising RPA work only once
>   - hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
>   - hci_sync: re-enable legacy advertising on resume
>   - hci_sync: pause advertising for the scan address update
>   - hci_sync: Update the CIS host feature when enabling LE
>   - hci_sync: Copy the LE accept list under hdev->lock
>   - hci_sync: Protect resolving-list lookups
>   - hci_sync: Copy the resolving-list IRK under RCU
>   - hci_event: Clear explicit connect state on LE connection
>   - L2CAP: Hold incoming data until encryption key size is known
>   - L2CAP: Ignore connection responses with wrong ident
>   - SMP: Protect link keys during LTK derivation
>   - SMP: Protect LTK encryption with RCU
>   - MGMT: Return RFKILLED for Set Powered on a blocked controller
>   - MGMT: Clear disabled connection parameters when loading none
>   - MGMT: Fix discovery stuck after a failed Stop Discovery
>   - validate retained LE Create CIS command length
>   - validate retained LE Set CIG Parameters command length
> 
> Drivers:
> 
>   - btintel: fix buffer over-read in fw payload
>   - btmtk: drop zero-length ISO packets from endpoint padding
>   - btmtk: bound the ISO payload length by the controller's MTU
>   - btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
>   - btmtk: fix error handling in btmtk_usb_isointf_init()
>   - qca: Fix the WCN3950 NVM baud rate offset
> 
> ----------------------------------------------------------------
> Akhil Arul (1):
>        Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained
> 
> Binbin Deng (3):
>        Bluetooth: hci_core: Initialize IRK before publication
>        Bluetooth: hci_core: Initialize link key before publication
>        Bluetooth: hci_core: Initialize LTK before publication
> 
> Catherine L (1):
>        Bluetooth: btintel: fix buffer over-read in fw payload
> 
> Cen Zhang (7):
>        Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
>        Bluetooth: hci_sync: Protect resolving-list lookups
>        Bluetooth: hci_core: Keep link-key filtering inside RCU
>        Bluetooth: SMP: Protect link keys during LTK derivation
>        Bluetooth: SMP: Protect LTK encryption with RCU
>        Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
>        Bluetooth: hci_core: Initialize advertising RPA work only once
> 
> Chris Lu (3):
>        Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
>        Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
>        Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
> 
> Ismail Tarim (1):
>        Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()
> 
> Jinwang Li (1):
>        Bluetooth: L2CAP: Ignore connection responses with wrong ident
> 
> Kevin Dewald (3):
>        Bluetooth: hci_event: Clear explicit connect state on LE connection
>        Bluetooth: MGMT: Clear disabled connection parameters when loading none
>        Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
> 
> Luiz Augusto von Dentz (4):
>        Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
>        Bluetooth: hci_core: Convert hci_conn flags to a bitmap
>        Bluetooth: L2CAP: Hold incoming data until encryption key size is known
>        Bluetooth: hci_sync: Update the CIS host feature when enabling LE
> 
> Michael McAllister (1):
>        Bluetooth: qca: Fix the WCN3950 NVM baud rate offset
> 
> Tobias Wilken (1):
>        Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller
> 
> Valentin Kindschi (2):
>        Bluetooth: hci_sync: re-enable legacy advertising on resume
>        Bluetooth: hci_sync: pause advertising for the scan address update
> 
> Yifan Zhang (2):
>        Bluetooth: validate retained LE Create CIS command length
>        Bluetooth: validate retained LE Set CIG Parameters command length
Not intended to block this PR, but it feels quite large.
My understanding is that Linus is still actively pushing for smaller/
not ever increasing RC releases, and we should keep trying to redirect
to next non urgent fixes (i.e. the coccinelle ones fell like candidates
for postponing).

Please try to keep 'net' PR as slim as possible.

Also I guess you are already aware, but the `Assisted-by: LLM` tag is
now actively discouraged/should not be included anymore.

Thanks,

Paolo

