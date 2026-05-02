Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD8155C97
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 May 2026 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742425; cv=pass; b=fxxb5dLVF1fuCQ47bEjbITSKycEot2X/ihYBXQ/2lo8FCO3yjoA4vPDxPAwZaQ7iWVyN9UTaO+zNqn7NNRCq+6DM7jIvhBhJs+MLk9vLxI+f1ETgyKpFZyBnX34twfdw8s5T9Q8HyhsBqkfF/0gdhBvsHx/Fr3iy8d+STPoGV+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742425; c=relaxed/simple;
	bh=UPI7dnLRVyB7JpqUv8/totZ0/6V2PFGRfsTrWh7PyVo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cDM0QBVP8NMi5R1kTspBIU21MzbAi2xt8BK6YEa2D7aynSRXZAT++stkarOjR7D5sdAUew6cOA181fDFvPZLT5JYCCxuDPOKUx/Owzu178oxuXt2oEUqH3yVhfBpovlVJ803GVIT3jbfYvg0a8HVvx1Mw8MSKklvXEyBHEtcgtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkmLAKio; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkmLAKio"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80148ae949so125553a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 May 2026 10:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777742424; cv=none;
        d=google.com; s=arc-20240605;
        b=cOWhVRUG0Rkd4ZsX9F7GJivG7ZO4tNedgOO+ThJjyHZVTM2DqentA+j203RL4LTTEm
         f1TfcM1FXAV0q1JZfYTKmbWb69CxI3TuH6j3hZwDJd+dEeG9NVrynIbI5kbMXvKtIVcq
         aCQHiJ+pS/04ONiy8jFn1e6Jt9heJapL9lBaxC9YMem9BMoGO4DHqdlRNWbUBVjg64t7
         rQ2hjN09qEluHKDZNhQyqW83qslicnfXK8lEj6Q/gnpnbhDHaiK6gQlPYtBkAjJUZAjp
         TLsq0VYdpw2Bm+i5m6fYUivX5UyumjB+nhQcn5i+km9JYEBLHeqq+qk/jOxqIoq8G9ca
         serA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QpoftyVdFBkKQrVOlauPyWIKEVbTr/Xendt6u6y2tCg=;
        fh=PaJip4GGio3yhV+YgxUGeni3GlgqmLpUy4lYmG8qStU=;
        b=bqXxLcqHNmwHYCXnKt08pe3nfRczBNv4VYyIZi8sCSF3j6DGAseLpORLHwOXCPdtDn
         VIRFcbaziunPHbeTVxdo0CG3IRxVmQUy5lxO9ZpdKjZEZ6SfDpWbDARCvq+taNfkOmPL
         V6f21jBg8c6JsE99Z3KitIBOlUZ3JGBL3FrmmM73XXqNpIKYfLumeYWR5qwKUzvWqB2G
         7T1MTMR260JT6SjtECb8VTUHBS33HSqA0zT8WaQri6wBdZ8c8oxH+KRcGOj/ka8i0c6J
         Pp7ONTu6b8eeocI3wf4r5QDdoTsU+9aAHxfMR99ExKulQfLPMG59c2s9bdvVFjpaKhc1
         bNGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777742424; x=1778347224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QpoftyVdFBkKQrVOlauPyWIKEVbTr/Xendt6u6y2tCg=;
        b=hkmLAKiolMfY//ybCbQHlXTTAQKyxWniarGg6w3EVT3mfjiWr8NKQj/ShhfGWsUtAQ
         OfdSaygJZXt+Fnq1MRUhZi9TBO4pxnAi+xDfWWxFTESkZ+eXYieV7zws54RFDfkSuJh5
         K9XZAGRWjQ0K8oFRnXCWbdzBPQacrD6LGDh6iWr8sSFvFK/D8v7JRf2WnVCHnNfyaZxO
         75uNfgTsRLqOzUByGio13fxs2cm2CAcItuH9wTahkOPxraawnYNL5Vi3pl4r3mOgxo5R
         jsLkh5ECowJR8O7nzV1kZhZP0f+rWWUigcbjFPMI9Hx6QLD14W0EzGlg4J6XqwUhXtPZ
         ZoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777742424; x=1778347224;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpoftyVdFBkKQrVOlauPyWIKEVbTr/Xendt6u6y2tCg=;
        b=sTlOXSJvFTF3JZ9iAhqqOfntqdrFAJDeAOMXMtWOQwLu1FEAW3hb4pKpnpHEKkv/oe
         hOxS7d47Ay8wKcky1G5tQ6jjPt+8aXwSTuWyFvugjhMQY7rZk4o+g+fmLS8FmoPnX1Fk
         EgaDbpKeEL2IPIsPWFVdZ8WPjiJohVgyjPcI4H9piiZ8JSOre+nZCOC3wH94yHVHtc8q
         0gIiUerFdEWR6/fIqrZz94NFKuWrdxVG2D+V7Ukr4+t3mCspsAsLLSK7QbALDo9uMseF
         YEgaP+ByBx0+o5w9beKgNCcg7CKasgBgdNfGons6OuQroZm98D7HZxSe5XBzubeXcAnU
         KW2g==
X-Forwarded-Encrypted: i=1; AFNElJ+fz3DKuZ0B9wYiuknTDzRF8Ga2YUljqOtWPQhdHuOMSjDME5TXhwpORjCwQX9PQkP2bXyP+iqNxvdpNyD12W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbefnsspd/JDAkwykj40IYp48QzQ0Kv8EMueCBCg5wdksGYFq
	6xbZHrnXzXlGN0JmV6rWK2KAfX7dDYMo1WwL47XbvOHWGj6AhVmMwQmhNFA0ZsKYjVRtwHSukwH
	ehVnDPvOqk0xMxt1YeGdFTZZZrzcIREY=
X-Gm-Gg: AeBDietOdtQBuF/Ejkg4STyiynfvjEPJPGSDjarUiJABqE3MPSHwr95HkocJsGJoF6A
	kEdXugDkxLONKLt7rbTe7GHX/Cqpm6rrReXUFJTijrjSQjhh03Qi1WGxmYOnJ0/tkntIlK4fdNq
	whBjowCAB3dcxm7rzpY78jDite7RHdpUJn9obUMxjIg2BfuD7wW0PlhnO/giH88LspUVH5/3TBD
	+lUZjh8X0RXmXCGG0KD46NiNZly1XbZUz8KBrMRRbpHd0Y1uN6xoDdQmAbcX3TZ5hlT/j7WF5XJ
	h9gDWTVqWqC2kDeM9Q==
X-Received: by 2002:a05:6a20:729d:b0:39f:216:f400 with SMTP id
 adf61e73a8af0-3a7f1a84c15mr4039937637.14.1777742424009; Sat, 02 May 2026
 10:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JrQuNGA0LjQu9C7?= <kirill.kz.902@gmail.com>
Date: Sat, 2 May 2026 20:20:13 +0300
X-Gm-Features: AVHnY4IlnCA5FtPDsbdiH_bqBzmMx6Vb3Mp4PJvsf7d2RHydCwbAXJHDtc7NVfg
Message-ID: <CAL2ecxgBeZNSSuwJROmuvGFsajjpxqV1+LYnoz5dYGUPA30HeA@mail.gmail.com>
Subject: Bluetooth: btusb: Add VID/PID 0489:e156 for MediaTek MT7902
To: sean.wang@mediatek.com
Cc: luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

Following your MT7902 series, here is one more VID/PID variant
that is currently not recognized by btusb: 0489:e156 (Foxconn).

Adding the entry below makes Bluetooth work on v7.1-rc1:

  /* Additional MediaTek MT7902 Bluetooth devices */
  { USB_DEVICE(0x0489, 0xe156), .driver_info = BTUSB_MEDIATEK |
                                               BTUSB_WIDEBAND_SPEECH },

dmesg after loading the patched module:

  Bluetooth: hci0: HW/SW Version: 0x008a008a,
                   Build Time: 20250826211444

/sys/kernel/debug/usb/devices:

  T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=05 Dev#=6 Spd=480 MxCh=0
  D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=1
  P:  Vendor=0489 ProdID=e156 Rev= 1.00
  S:  Manufacturer=MediaTek Inc.
  S:  Product=Wireless_Device
  C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA

Could you include this VID/PID in the next MT7902 round?

Tested-by: Kirill Shubin <kirill.kz.902@gmail.com>

Thanks,
Kirill
