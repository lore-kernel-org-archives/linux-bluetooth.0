Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16A2561D1
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509614; cv=none; b=DhC+3b7HjjgFGbZsxCB0tMipsLxmAhnM3PPCtQDf7HFceIzu9SUAuyZtnegIfvSXHVf9Sl//amjHmh8U2QfYP1phmLgJAWZmv62p4X9sebi0XM6LW38nUYZ+yraYh3hWFvg5yAC0QNCWdoX51aNaK/FPYrbvoDVlhOUDvNh6w9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509614; c=relaxed/simple;
	bh=My/vmmlol1U4sgjzv198/vsbtix5I2Jbkk8gD76T6po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=luKkhqHIFzGHikgAXCLSDzgCtRih7NyaBdbEJkmkom6na+R4aseRqJIPRrGBBVJ2kv+FrLUq/WPqJVe3fapkpD8T3rEBbqrgotljhU4e4f3tKX2eXPT6/154Z58rb5iBiBsQQdjXR+Ubla9MoonR0m1lVRiTYEjbJigNZW2FLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=LYGPjdql; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="LYGPjdql"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7dfdcded923so280529485a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752509611; x=1753114411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzMlOxvaXTnQiJBdvm3eyrMQEIb8a/4RhR6Jd+w7eys=;
        b=LYGPjdqlRzgZxARbaAZzc0WIoEvLqh6c98k1kSVkRhSeTaV10rKnGcVkJyyWQL1EoS
         MQ+c8IymwBGnrA2JvQVVhXEqOuSlg27w2Toe35Tqny1qJLwX53Zdv/RH4AZ44mESqxFQ
         Ny3Ahn/Kfbs1tKtgAAFK61J7ux4G4HCnpSlNYJNPC8JO5CX9W8y75vTv7fCSrej4lpW+
         Yw9WMbZU6at5eDH1T+MuFSd48TDj/CnlBhwxCoGj0vTh6Ll4DgCJ/Jv3dCc2c9vy8Wdc
         edygq38KTmvHhACiEeiKNlRSKKk21VXQh4lSpSDejK/xVZgyDil3HRoEoNdH0qc9eWsF
         xHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509611; x=1753114411;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzMlOxvaXTnQiJBdvm3eyrMQEIb8a/4RhR6Jd+w7eys=;
        b=LZ+bz/8VJL7qsTdXOOgrBgpwzD4jKPkV3MO30jjI/4G5w3iMYXKc/FAyezCdk0s+zx
         oRUBq2+SaxCXM4lMKIsAQ2aCwKNZOWaJl41kXGNI3Ugxk6x7Ga3Z8GN/R3QAkDpRyvnA
         GvkjjvdkBnJJMtNx4CaMFsy0yfd4lzmSbTLlckKUSs6TcrZi6awKHb2T/zxMuq2i42+E
         2QeGR7gPmcpOINUox3ONfBKP0BpSK8mfe4F+frlz7rZ9tFU0Afysi85Iv4+ee8aPqlff
         +vo8C1Vgy+0fOmWEHQ6Uxjqtfcs6xvFOGGF+rQrN4HzGQ+hzzLPS+biB3keHWcj4YpVd
         pk2g==
X-Gm-Message-State: AOJu0YxeLgTxjQTPzTRfYCOx8kpR4nsP/O+L3aCsp4rK1JEXw3VLDZa6
	wilktPyNHx7crKGZL60AxuEUwiHdBg4HsTmzrkiriHrdy9BkE73mAn/HfU05td9dppU=
X-Gm-Gg: ASbGncs5QAeLNZmqTDECEKyLLdBReSxfrHCwpbMVedXKBWhq80Uts2Q7rKyjKW6frcv
	Ve4N7s2Ac9qTLSYJ5Zo44Cw9XWa3XOymKJK9+UrYiiMvnkruB3+vfet11i5nBPieoA5AwM8ElME
	SVqtjefW8VrKxYbVwaOmHtu3/bIOe0BgUa3KdqSO41Ja0OUOczcAsA8M4G+LfEPZFV3vosls7Tb
	zgxwGx2cE9AcDWJoKScLeOULTJz1Ox5QT5Jon7v5F9ktffrgGs2CwzQrSQ/N+jc+AFLUlyyXTFQ
	jfb4UTwnUd1OdnFAwrlkHsurTQ8bItnLK87XgqHSi2ENIyCoOjZlUTaySX8GqNbVkrPK5HeyWIr
	hKEXhNau2vIiDlCz3/Rmk/Vz0dzGeV6fK9GdkeKhByKuFx1eImo2X4sqwU09YoOuqId/g1anXu2
	s=
X-Google-Smtp-Source: AGHT+IGiQKGCBKLnbpnFvB06iXYa1QAbFvTBzc1IILpvfobnAi23OE6vdy+IKb4n8picAmWM9K2UCg==
X-Received: by 2002:a05:620a:700c:b0:7e3:340c:2f12 with SMTP id af79cd13be357-7e3377c8684mr34097085a.0.1752509610854;
        Mon, 14 Jul 2025 09:13:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497dd4749sm48555706d6.124.2025.07.14.09.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:13:30 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:13:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 220333] New: Bluetooth: hci0: Opcode 0x0c03 failed (-110)
 on Mediatek MT7961 (ID 3554:fa09)
Message-ID: <20250714091327.1906a1ad@hermes.local>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I prescreen net bugzilla reports.=20

Begin forwarded message:

Date: Fri, 11 Jul 2025 17:53:41 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220333] New: Bluetooth: hci0: Opcode 0x0c03 failed (-110) on =
Mediatek MT7961 (ID 3554:fa09)


https://bugzilla.kernel.org/show_bug.cgi?id=3D220333

            Bug ID: 220333
           Summary: Bluetooth: hci0: Opcode 0x0c03 failed (-110) on
                    Mediatek MT7961 (ID 3554:fa09)
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: igornvrd@gmail.com
        Regression: No

Created attachment 308370
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308370&action=3Dedit =
=20
All logs related to my device and bluetooth

Description: =20
- Device: Mediatek MT7961 (USB ID 3554:fa09) =20
- Kernel: 6.14.0-23-generic =20
- Error: "Bluetooth: hci0: Opcode 0x0c03 failed: -110" (ETIMEDOUT) =20
- Firmware in use: BT_RAM_CODE_MT7961_1_2_hdr.bin =20

Steps to reproduce: =20
1. Boot Linux with kernel 6.14. =20
2. Run `bluetoothctl` =E2=86=92 "No default controller available". =20
3. Check dmesg: timeout error (-110) on HCI command. =20

What was tried (without success): =20
- Disabled USB autosuspend (`btusb enable_autosuspend=3D0`). =20
- Enabled debug mode (`btusb debug=3D1`). =20
- Verified firmware is present in /lib/firmware/mediatek/. =20
- Works on Windows (same hardware). =20

Additional info: =20
- Full logs and hardware details are attached. =20
- This may be a missing driver/firmware issue for Mediatek MT7961.
- I have no Idea what I am doing :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
