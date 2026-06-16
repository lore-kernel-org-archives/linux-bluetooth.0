Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559940BCAA
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596198; cv=none; b=ULClWulyXatqQAVt+/VctKIBw9MQKRiH6kg+kHTEY1AbThE2L2dvRKg4znlRnZYp/Q1vSmnnOtfjqkEWB0E0bauxPc2J2pcDUqzXRK/jIMuYvJnfsKbWSLTWDPO9VGDp5J7AJBdcVkux/8oarLuQNIE5y02yEGzma5Oa/dniZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596198; c=relaxed/simple;
	bh=J0mb5zIXwfgqhQSz9m9c5vdy9XnkrfZqjTH5IvCK+DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YROfciVZPN8uMAD7GqHYVMK6yBljmDHub7FPGlpteqTNdd2jhgSYp8Z2iBrpIDO2LOuuGXQYU0bOUh3derk49Y/G4oPLJub1hGWrulCStY2wEWLoVj+5qA/AkBMfv+JHC7baiQx94m7LN3G1NQ/WmIj6drOhU5tEkBUBZal0Sm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgK5rF3r; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgK5rF3r"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so2106538a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781596196; x=1782200996; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YRjjKwd+HfHNFTmY+ywFQxNy37HvLFGrVP/h6UuY+g=;
        b=mgK5rF3rXWK+u4sgPatTIaRvnzOmUbxVuWB1FTit3+p+3iARPpjFTGu4tbBzmnrJCK
         afeqfCxA3KZtTjA+2+1G3yLHFGcLN84OQVIZe95XlBjGvOiB4jfLdCdNWjZk2IyQrH1b
         kcA7XYllo7aWA+Tcyzb4XP1NBnp4Aj5X7T8KhwGnhXsOsRirmRpDNfBy/V/HyDZroYCO
         G4ejPIly6Hp3BV6eo2yhI68A2WseNrc5zjwIttwQGGMFZ3/jwxjlviSTgSXqKq+GjuDs
         d+fEYxeaXzuqMA0gtyQ2hVD7t7P44CehugxXXwqoMtx5O36Ppb+Vy0EAqDRr3e/7JCOK
         wDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781596196; x=1782200996;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YRjjKwd+HfHNFTmY+ywFQxNy37HvLFGrVP/h6UuY+g=;
        b=jddN500lav90HBZvh0aFDolyZq08OlC5ti3pZisEtR3+Fxp33mJha1RfMXa1w1XJeN
         Ux8NCRf1kJG2FNXMAFTQDMlicZbons0PLqGhJhYJKldtqCfsMomi4taiIz+VTLEikrzL
         GciqImMu3bLAZg53lpQDqQQXm+ldd/OTYVcfjXyT2AN3hGRwyDYug2CQCcSJJjLlVM/L
         O8bHEwuyAM/Ny7Zdd/i24jcihmLoo1sWuCbenx9CZn5x9OVEN2rcuInEHTjHs05rAkJt
         rcIJrMMLvflAPHTKM9O9ZFmgiQzTJyz+UuKhp4sfFgEg49OYmiIaRCwJSjFJwjEj1rB9
         yExw==
X-Forwarded-Encrypted: i=1; AFNElJ+lQwOSS3QYR22nCDbE4ZznNbbQDXNAaABjF723kY0LerdLJGbkY6zFwSKiHVrcaEfkxDQOzW2gW/Vzst43V7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPoth4ddF+M27WXpjKt/VgQp/fPcKqqML4JXatw7k5HJDaA8UN
	//h78Tzpts3IhLiy//A6VEZUj8VNGEqdGxtJhtHIrDDx3+BhNSnepXlUSr4F5Q==
X-Gm-Gg: Acq92OG++NBeNnsO/of+fBxJE/ip82fZZ+RHiOEtn9vpvnTnhKAOEKCEP2Haot1X3V8
	46jD762l55IrpegMiAw4Bpst2YbkoOCt/YwIqokQ6oLeQMMlY7oTKJGyI6FX5fGxWO9LA6Kor03
	J1GClCNkQLGV3zJyrEzf8IJh8BZWhjrnH/0KhRyu5maOZqUOZiZhn4cCQudgAM3+/HImZcWUBoX
	oO0XldTuLLcsZ88x1wMeFSBsI2mss/7lDC0CencgAgpEYHkWyG4RKVX7E9C8xaQX9RWi82dyGI2
	D7xpcieJpPJOL/uh27MVvgQr5N1OSpKrRWxlj/BWu4wSqLCDcsUiNcqnTmFOhLABFjSq/nR/f7e
	eUN3DLEV2fYUI6JwL6QpiR/RyUr6KI21gZeJgHqbqfUwWLxCELM0vc1/7sgzHBm1plAYm2Yavfy
	FCYkxOKu6+ZteLq1+D3/+ZPpt8VHsmAX6GJK4rysHKDiN1TG+O
X-Received: by 2002:a17:90a:e70d:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-37c2bc73c79mr14927629a91.8.1781596196484;
        Tue, 16 Jun 2026 00:49:56 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb67sm1944299a91.9.2026.06.16.00.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:49:56 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: btnxpuart: out of bounds read of firmware in nxp_recv_fw_req_v3()
Date: Tue, 16 Jun 2026 15:49:52 +0800
Message-ID: <178159619299.2177923.13356195860330189592@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I think nxp_recv_fw_req_v3() in drivers/bluetooth/btnxpuart.c can read past t=
he
end of the firmware image. I would appreciate it if you could take a look.

The chip's v3 firmware download request carries a u32 offset and a u16 len. T=
he
handler checks only the lower bound, then sends firmware from that offset.

	offset =3D __le32_to_cpu(req->offset);
	if (offset < nxpdev->fw_v3_offset_correction) {
		... goto free_skb;
	}
	nxpdev->fw_dnld_v3_offset =3D offset - nxpdev->fw_v3_offset_correction;
	serdev_device_write_buf(nxpdev->serdev,
		nxpdev->fw->data + nxpdev->fw_dnld_v3_offset, len);

Nothing checks that fw_dnld_v3_offset + len stays within nxpdev->fw->size. So=
 a
chip that asks for an offset or len past the firmware image makes the kernel =
read
past nxpdev->fw->data and send that memory back to the chip over UART.

The v1 handler already bounds this. nxp_recv_fw_req_v1() guards the same writ=
e.

	if (nxpdev->fw_dnld_v1_offset + len <=3D nxpdev->fw->size)
		serdev_device_write_buf(...);

The v3 handler is missing that check.

I reproduced the read on 7.1-rc7 by replaying the serdev_device_write_buf()
source read, with the firmware image ending at an unmapped page.

  BUG: unable to handle page fault for address: ...
  #PF: error_code(0x0000) - not-present page      (a read)
  RIP: 0010:... (the fw->data + offset read)

The fix I tried bounds the request against the image size, like the v1 path d=
oes.

	 	nxpdev->fw_dnld_v3_offset =3D offset - nxpdev->fw_v3_offset_correction;
	+	if (nxpdev->fw_dnld_v3_offset >=3D nxpdev->fw->size ||
	+	    len > nxpdev->fw->size - nxpdev->fw_dnld_v3_offset) {
	+		bt_dev_err(hdev, "FW download out of range");
	+		goto free_skb;
	+	}
	 	serdev_device_write_buf(nxpdev->serdev,
	 		nxpdev->fw->data + nxpdev->fw_dnld_v3_offset, len);

This needs a misbehaving controller, not a remote attacker. It still looks li=
ke
an out of bounds read to me. Does this look right, and is that the place to b=
ound
it? Happy to send a proper patch once you confirm.

Thanks,
Maoyi
https://maoyixie.com/
