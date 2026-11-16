Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865130;
	b=fgq/9Df0mXZRYE2KmHLJwz008cOHX60jDg216qs4/7qwxw/TUm4B8wl35Ilt8qmMsP/G
	 vTXG3tMz6Op/IZU5FZK5BCCRDFSQYFmIJsYrP7+6vyGKvxZQ4u82wY9sEYwP8EK1+Qcl6
	 z5TEplLYN3qYFt4bOBOuJ1XguYinm8hFqoLpCC472NigW8CPNcb2BQoVF1asemOe0OsDw
	 CzUEMER5yAxc+wgjgtdD0JGnuNYt9ynTXpYRbbqp0HgcWz48Du/2GakzF4Y6M12bDo00e
	 qWJUNfGbkrBK2xRvbQKGQBFiPGD8TmSjDokDyNTM/ntbtlAmN25RUyN5TT0kx6QnwKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=N/IRCZAR2uINU2Yz+quelX7uIQDJ1pWTDySOsZRw7Ps=;
	b=J3P1ZVOqPCMJbD5AdpXEVxZfy6yNFRWDZ+w8gc8rH7P/vXCdl+ioufpt4ArldQrffYZ4
	 CxbeuD59ma4fdJ+HbePuxRx0l84hWOJEdWF40Cq9C3FDfZ5oVCtGl9AA0N7h7kcZ/8kPd
	 zkejSY40d40Fyr7ANffcp2LkKtVK0nLIeboEQyaKBzCgYu9hXVx6JH3InXCwI8IE9M6jw
	 ROmpU2rL+i+fb9plUp+3y4vxp5ARSM3/CTKRmR8CDCimzyCoBCRv6sWSirKBAOOX3CIJY
	 Ek+N0McMv81NSdsjzRYNlZ0T89xvf/kyBc3fB8LT8WviT1tEpXItWZSbeLw2kKOIBqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tI8DQZF1;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D7606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 21:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 180D7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tI8DQZF1
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67db89857abso1853412d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 13:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865128; x=1795469928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N/IRCZAR2uINU2Yz+quelX7uIQDJ1pWTDySOsZRw7Ps=;
        b=tI8DQZF1ueCSROoR1hS0wRY3UbfDhvHo6IbY5ani6kaucOW3vTxsx6DC6jqr5dWNvk
         Z+y+ZOEWCBdj3QsPRmYG2xWh9s1TOfDIQ65xYveQknHqaABiBzrW3q6w1O3aFx4rvZ4h
         +cU/wL6VnCTNUfZEbeR4LZCQK9SBiwopG9RmM2NJ4hwfsmYjhFvAOHNfoC5LJ0f7YE87
         h9aRQKhwLjVrsatU2452PoWvbI7iKB/T+/O7XppTumbF6NfbRdRm66rYxZ/zSEd7YwQB
         Xja30Cbn4zxleWKC6R8QIwJSyb14H1Ve2zp/jvZGnxQ1rR/sIDumbAhy5YglnjlDm9cX
         4lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865128; x=1795469928;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/IRCZAR2uINU2Yz+quelX7uIQDJ1pWTDySOsZRw7Ps=;
        b=iwTh4Pls9lcOIVZ+S0dJTrhiAZT31M+RZckH2ZOtRghu3j3tuCTe0RLwKT8Xs6rtqp
         WtNVzPmuXgpztQ0m5gYdV6PLDcPRng60jUFYgkXs3qKdD5591SOhVfaky1f132ka9bUf
         fjsKkRQi6MydctzhWkuLbHFzFY/xMrvksknHvVXsBht6unEU+86fJeHcT5DrJStZ4ciQ
         JySoepLJ1F88WcoeBWLhzwcm5sQIWVK0N09cTXd+69IuutEg09r97hNzk4uWYc14Xur/
         09roesRt/YYQu05qhEA5o3kGkqxiWpe1euD3EPSpql7NrxoHNABkU1q9XkrsGwmg3XNA
         Oj7w==
X-Forwarded-Encrypted: i=1; AL+hErE/xlEnLjAA9E0IRAQrFoptrVCnctiE9upjviaAU5J0S8ewdy8TjE0jVbYLsZbcFespoIZBpAqccQibPH3+f4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Wb/v+Lwt6tqTVFJKtma239L6Dy3L0/lgwwGPt/Qfr17mywtZE
	V1ydFi1+oKshgo/0cMA7CI07lr80umjeEVhjpJecFVpSXFNuBdw+EoKg
X-Gm-Gg: AZFdTZdloV3zYWSB7D1bMLJ7LJgbdionLTWKbQhtONJFWFlEc2hU954IBB3dV+5/Doa
	Jz5zdZN9f6w87Mods2IbvvgJ+YnObM0QO1xxKWYL6Sj9K/fgpRNrymZcO+vU57HuhQDOKoGPi9L
	905U4/FXo6YoB4IH0lCFKp/HlUTuUEb6kEA3q1Lt7NREi8KqlK4wHdKJJLTlRSGVKmGOxrUgIBJ
	uWgugbSMyLMPHsk45juBOkSeoZ6zHtLZ9uaHh78Jrsc8aF8zyVngVsTb9Qzl2Po+DKB+h87yjVZ
	jC6u9hxGlS49Vgd6Rbw/S/brWSQfAdu0JPCiWgS8LrpUPpJQ+Loey+W6kIFG6ruwgi+MBCW8ehT
	Yl1z/HHoYHz8w+yE5GiUs/El2EKzROR1bpiiLE9j3xzrODkDorE6SWqEn15RBTcytPhaOQIhJD8
	GNSVzGWvPYNyNkTFvW0kKnBtJ5Gn1ZtNhDvHmZYmTFoQdAbYY6lLGuceAbckdSeNSH5NQh8oYWF
	8lntAFYKCi+U42Jlh6tOuNKduHkWiGQGKm6eyXNTRk7wAZb92QMCcB6mf3wXQllbFXTSolgzN9M
	1dyCDZAlYaAkaOzYqSEvO00UA12G3E1zA8sMYOdeA0MoiqMuqCEnjsVmZtJ8v+oQGQdioTFQQTc
	Q6g0pa7OIBRNi7uSvCX0SpiGHNudYXmCIhHSYp/lNANXdQ66roVfjGwE8cNMkpnvdGxrPQyYH0J
	FX5QcEWkjfQJ8aqIGntyC0SgeXx1bwB2/YpO2CKImcTB9SShatzWZGHI0TuA8/t44=
X-Received: by 2002:a05:690e:1907:b0:67d:bb23:631e with SMTP id 956f58d0204a3-67dbb236663mr1529423d50.97.1794865128041;
        Mon, 16 Nov 2026 13:38:48 -0800 (PST)
Received: from [192.168.207.4] (104-12-105-135.lightspeed.miamfl.sbcglobal.net. [104.12.105.135])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec06ff89sm9325807b3.31.2026.11.16.13.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 13:38:47 -0800 (PST)
Message-ID: <4a1efe5e-ec67-4caa-bb84-35759e66ef42@gmail.com>
Date: Mon, 16 Nov 2026 16:38:46 -0500
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
From: Jason Perlow <jperlow@gmail.com>
Subject: [PATCH] Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The BCM4364B3 combo chip on Apple T2 Macs, e.g. the MacBookPro16,1, has a
UART Bluetooth controller that reports LMP subversion 0x3032 (001.016.050)
on some units and 0x305b (001.016.091) on others.  Neither has an entry in
bcm_uart_subver_table, so the controller is logged without a name:

   Bluetooth: hci0: BCM4364B3 Trinidad Olympic GEN (MFG)
   Bluetooth: hci0: BCM (001.016.091) build 0115

and the firmware lookup only tries the generic "brcm/BCM.hcd".

Add both subversions so the controller is named and its firmware is looked
up as "brcm/BCM4364B3.hcd" first.  Tested on two MacBookPro16,1 with a
v7.4-rc3 based kernel carrying an equivalent change, one reporting 0x3032
and one reporting 0x305b.  They now log:

   Bluetooth: hci0: BCM4364B3 (001.016.050) build 0082
   Bluetooth: hci0: BCM4364B3 (001.016.091) build 0115

Signed-off-by: Jason Perlow <jperlow@gmail.com>
---
  drivers/bluetooth/btbcm.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 065536d4ec..92ba7aeac3 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -519,6 +519,8 @@ static const struct bcm_subver_table 
bcm_uart_subver_table[] = {
  	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
  	{ 0x2128, "BCM4384A0"	},	/* 001.001.040 */
  	{ 0x4119, "BCM4384B0"	},	/* 002.001.025 */
+	{ 0x3032, "BCM4364B3"	},	/* 001.016.050 */
+	{ 0x305b, "BCM4364B3"	},	/* 001.016.091 */
  	{ }
  };
  -- 2.56.0

