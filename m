Received: from mail-200166.simplelogin.co (mail-200166.simplelogin.co [176.119.200.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45453B8BBF
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953258; cv=pass; b=sroalBRXDgwXxqj6AH1B6VKXybl9bh5v0nIy7kiFBgiXoqhQadxPmHom9XtEMNU7TBSIgO4JtEO8S/0j7pn+qsHM3f2/O0U9zqIa4661FLOsCMxPgRjtmQx6wLUo7npfqoupko0rKuq9Sx01QWEOiCridMEaFeIpupVl7hIsZsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953258; c=relaxed/simple;
	bh=8ZDl+dRv9dMq0NT8gkWB9tebGYS+A1xWJMfzSEU6lwU=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Cc:Message-ID; b=obdJ6nlFbK369rPwf2A7WLz+SojHYGM5SX6+JkxJje+7vrP2czQ/TWyDXiGS6mFDB9tr7nHSfI0fvjo2cvDIWCkTD9r+el9NH91JWgIeyjZFlRKwy0sHZZuUGPxQnS+Inc0Tc8vRF5gpRXvEOXMXBByc40K4eonRxO972yNqooQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kaiser.moe; spf=pass smtp.mailfrom=kaiser.moe; dkim=pass (1024-bit key) header.d=kaiser.moe header.i=@kaiser.moe header.b=QJSsgKD/; arc=pass smtp.client-ip=176.119.200.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kaiser.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaiser.moe header.i=@kaiser.moe header.b="QJSsgKD/"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1786953249;
	cv=none; b=FAFRVykUQ3diJCi2rU8BYynly0xWz5+Le/rZqWnqTPw7GNJ4aOLwpTSycOfCv2/I0UP3eCip1fT2+2u6fCNMUHaNXCTPoQHGbK0j8TN8iCIqjWE++hRkTWL2+nUcLkGQ1vmxONrY9UNUl0RcZ45L1BQ+sZU7pRRjwBC1PoiI9yPknPIzY6mo6RgiyD4c5vEX3hGjP7790xnKvaotXBLW7qztaXDkvxbNLNdi1+TiZUVRlI3E6APw2UvyrdQYwZYiJ2BWSWeKbnkt7SEtGRqb4KgNraltaSTUgFcYzkoNpApLcK5Psz2SHpIKRCaivOuvm7uA18CqIFg19bNQ9n5m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1786953249; c=relaxed/simple;
	bh=8ZDl+dRv9dMq0NT8gkWB9tebGYS+A1xWJMfzSEU6lwU=;
	h=Date:Subject:From:To:Cc; b=OyZqX3srz6tHw2XUvY5HB0Zdaz+nOwFP/p76kNwehWrBEYBYAqi95mFKfghuwvbgsYxrcKXjGau8ZKvzXl3DQqPZxG4VgGfCS6wf8P1P+tDenmhAT+TdbussFbdAWwNPb5E2BhIcxHxNlc/HE6TV/9E2txUhyve6zhAY/Y14GAA4AhL6d5xnAyH8wQKAlmyZRb3kqrSSW/J6VwAt8pLDOz6sH6hHQtS/07fEzOyOGJDcevlSPa2Obqb8cI9ktzNeGRRZfuczoQXFWKe5r5ROTYM9m1Z+bb943wvN8v1HTUP5KJYPspiL5s+5coczN5OH9qQuSx4QS84g4xtbmvd9fg==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaiser.moe; s=dkim;
	t=1786953248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uF8Zhxv3iYxWoabH7Xl9fF7C5+IhA7JUqLEBT77xttE=;
	b=QJSsgKD/vbG5DeWqgdgK3X7NQQxJp0PX25/01xJgm7CTadZxeM9pNYW+crg7xthA6J76R4
	taFXwDLPXx3Wkedvxcta2TVglu2CJV/FM6Aogrvh0Nh7GT79navKJkMxLlBcKgGTv5+H3M
	FjYjvxvLHE/Ck9YTAbUE3j9AAfFb5sI=
Date: Mon, 17 Aug 2026 07:54:04 +0000
Subject: MT7902 Bluetooth (0489:e156) not supported - btusb/btmtk
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Kaiser Bh <kernel@kaiser.moe>
To: Marcel Holtmann <marcel@holtmann.org>,Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <178695324809.6.15793290053564777912.1554499092@kaiser.moe>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1554499092
X-SimpleLogin-Want-Signing: yes

Reporting this rather than submitting a patch. Happy for a maintainer to
pick these up.

Hardware: Minisforum UM880 Plus, MediaTek combo card
          (BT reports hardware variant 0x7902; Wi-Fi binds mt7921e)
USB ID: 0489:e156 (Foxconn/Hon Hai)
Kernel: 7.1.8 (also tested 6.18.44-lts)

Symptom without patch:
  Bluetooth: hci0: Opcode 0x0c03 failed: -110
  No controller appears; Wi-Fi (mt7921e) works fine.

Two issues found:

1. drivers/bluetooth/btusb.c
   USB ID 0489:e156 is missing from the device table. Neighbouring
   IDs (0xe153, 0xe158) are present with BTUSB_MEDIATEK. Without the
   entry, btusb binds via the generic vendor/interface rule but
   without BTUSB_MEDIATEK, so btmtk setup never runs.

   Adding:
     { USB_DEVICE(0x0489, 0xe156), .driver_info =3D BTUSB_MEDIATEK |
                                                  BTUSB_WIDEBAND_SPEECH },

   changes the error to:
     Bluetooth: hci0: Unsupported hardware variant (00007902)

2. drivers/bluetooth/btmtk.c
   Hardware variant 0x7902 is not handled in the setup switch.
   Firmware BT_RAM_CODE_MT7902_1_1_hdr.bin already ships in
   linux-firmware, and btmtk_fw_get_filename() generates the correct
   path via the default branch.

   Adding `case 0x7902:` alongside 0x7922/0x7925/0x7961 results in:
     Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20250826211444
     Bluetooth: hci0: Device setup in 2312557 usecs

   Controller then works normally; DualSense pairs and functions.
   Grouping 0x7902 with the existing 79xx case works on my hardware,
   but a maintainer may want to confirm this is the correct handling.

Both changes tested on 6.18.44-lts, 7.1.8-arch1 and 7.1.8-zen via DKMS.

Kind Regards,
Kaiser Bh

