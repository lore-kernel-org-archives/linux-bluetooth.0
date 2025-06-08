Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505181B040B;
	Sun,  8 Jun 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749410504; cv=none; b=N7G13EifFV7sI2+ed0F364GvuELZc2vwGXx1KNXHuFvwVKasQSFDZIA4fKxjWi2+/OlNmvq46Bixs436ZJtiKrhisQufyqVFIVpse9ZEQTQ9u0ehFoUAF+a/Te/DR7iw8A/FguHa43LCPtOwPsUTHcaB3tuXqfWTe6sbzGM+abQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749410504; c=relaxed/simple;
	bh=z6pDM7n161e7ASEL2VWQOkxKn2/u0AaHSXnzI5iLjS8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TudVmhmg6GhSoycqPCE4AMIriwRIteJn+LY6+qEHjgk7Kd3V1x90VelXQiRhvArMfsBIMqEQRmjhI3H9NATbNQXNz3lW6px6zdJV+XwklGX2vL+gj5Esn7UtdgAIDEFt2aT/xfrH8fV+o9DCS7oP3h5xZS95ZfWlcgIEP8vnjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UH4ngKKj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH4ngKKj"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso4141945b3a.2;
        Sun, 08 Jun 2025 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749410502; x=1750015302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEBHAv9xkzy6xa7wK9C1MXh7dCKcxoM0mrh1n66r7Fs=;
        b=UH4ngKKjEuA9fluXAuz+qWzEQkNNtuucB1N/79Q+94dfe6fren5wLMr20AlOamHjB7
         WkKI8hTKEw2knLUU0Dx2YuwSARiYTTAC6kRvk7g78AIZ4iF2FgVNB1D5w4WA5/ytz44o
         Grzd2cUWiBt7yTrGvVEoEtZUEESj6zE+xWOHGJX9ThlaQjnSE2E2oV04nXEJCqEsmCQ/
         sICbFywdqd6zuMBHxHCINB8UBG8Ms3sF/teLSE2y4HfS1vRLHIq3cnqpUxM0vPwa0eLy
         ptP0ev82uM7xviz9juhhsO83oensxCOwTcWJkZtoDb/JOSUpAypGABqKEs0Bt/Z/9Qnd
         gUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749410502; x=1750015302;
        h=content-transfer-encoding:in-reply-to:content-language:from:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEBHAv9xkzy6xa7wK9C1MXh7dCKcxoM0mrh1n66r7Fs=;
        b=isD3W1OO8XiApygblyq1rHS8ITc2KlRnnO2fVa6cJTVBenJKOu/G+YtzSP/xMOcKOH
         sz2kiadj6JhEDEXhQbxVL7OFcKXQUNSOjSvq2kpcidiiTayxH8R+/Dl2gwwgYyhXAY5+
         LI0+gxJeX3IGrUql8QJSZ/24YBzO2uVA8TubYADZsq3IPzc/XsxBNmVfqUWVQlM7bRq2
         igMAo/PPn2i8cjuEmUHIlWbAp13Z4m3gwjSsTmCIk7EiWK1Cu639IwzuRKbpl5BcUnlc
         fig0BXbv0AQwkp9KFLa5lqY3o/Mn+/nFFoO63lcy3+no/2DbbwYfpULEe7VA4kR8EJvw
         IhXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV53mp2hQqhQJw03ci5f3YZzpevHvfphDPwKMD238/cu2QD76xn6XJ0BARPtcARzaMvw2lmuwOJZ4R3mwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFja6gVfIEE6ujjWD+igTvAcvDDDqHZL06QoyqlwEKfmv2av5
	9tfR28iaKd79tfx6OVxhA2pMsUHkKGSJ0StsDLjInxCSanjG331HGeS0
X-Gm-Gg: ASbGncvcbMDX35hY3yUexuwXJOtqChrJOvtB5BLaJdjJJQbFXOyqhw7U9doY91/dGad
	kR9bFBLgx88aa2h3vVzfKvoKEkLVIBG3r2ZbWIa6uXYd+sN2kpo6ZvM/jXOdFT+dnR3DwiLmLwW
	a3D4943NIKqLXJsJeO+0AgUyvGHu9xdHHM5pAYHT0nnhXXGkKV7mR1Exuuf030QBb5a5fpaWqBf
	FgAaRNSLz1k18TJ5tmgbg6S68+BtOX0H35Ii0+jm9o5kBByJyjHYUxi+2GUDckQJcZCJ5rH/69C
	lfVU0/ayvtUgBDG9KWRMHWkJS9vTjRuroMtM0nJL+AY4OKoIgLTAijE2eAgEDxagWW/vwGVYRy/
	01+MxHwEBlJDl1ZKs5JLLbCb1XMVa4PmOSw==
X-Google-Smtp-Source: AGHT+IGg7LmA5G+L48cVcxhfoa2u1/D818F3A1iUL3CmvBg7wDC+ry4NHlcOaYYIUtyOaNyoUFkvaQ==
X-Received: by 2002:a05:6a20:b40b:b0:216:5f68:c83a with SMTP id adf61e73a8af0-21ee699a0b6mr15384364637.36.1749410502474;
        Sun, 08 Jun 2025 12:21:42 -0700 (PDT)
Received: from ?IPV6:2601:646:a000:5fc0:64d8:7dc1:9e89:fbeb? ([2601:646:a000:5fc0:64d8:7dc1:9e89:fbeb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f89d639sm4033189a12.77.2025.06.08.12.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 12:21:42 -0700 (PDT)
Message-ID: <01c4295e-1fe8-48c9-8bee-c43c8023dd2b@gmail.com>
Date: Sun, 8 Jun 2025 15:21:41 -0400
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67eaa688.050a0220.1547ec.014a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in
 hci_devcd_dump
From: Ivan Pravdin <ipravdin.official@gmail.com>
Content-Language: en-US
In-Reply-To: <67eaa688.050a0220.1547ec.014a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..1232c9a94f95 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
 static void hci_devcd_dump(struct hci_dev *hdev)
 {
        struct sk_buff *skb;
+       char *coredump;
        u32 size;
 
        bt_dev_dbg(hdev, "state %d", hdev->dump.state);
@@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
        size = hdev->dump.tail - hdev->dump.head;
 
        /* Emit a devcoredump with the available data */
-       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
+       coredump = vmalloc(size);
+       if (coredump) {
+               memcpy(coredump, hdev->dump.head, size);
+               dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
+       }
 
        /* Send a copy to monitor as a diagnostic packet */
        skb = bt_skb_alloc(size, GFP_ATOMIC);

Ivan Pravdin

