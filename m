Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794723540;
	b=dMWmNz7KAG835RK1cam0qCmRobhob1Po3jFotE1Z7vJOhDmtv8aSVrqneotPyNX8tHh3
	 8OFoWhZijj3nd1UuP3eek0k6Vpymd6zkbJZHu0YppFHkbM2Z0/C6SOsaf4rcsh5FMcN09
	 b+LGsJAMGvL4g0T/dQ5ExrUnfRMZrCobmamU1XULCK3zrmweKQBiUGvLz1zqRQK8l337u
	 b3Af/V7XwjTtej+iSvxbRIBei4Vj6/8brGXZ0ASGacECdGzRfRd8CVoZOtBhrG+TwgG1o
	 Gol6bb3lnc9dPf4BosYAHBPixmQ+PBqKMCZz0UVmMPFI71X/YHuE6fr5uHQ7gwjZ1bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794723540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EiP72np40bx2xDBJ5GjnlxGCI+LE6l2A3ZHgQbH7kng=;
	b=DihEUjuHvo8ew0kr+V0+4KxY9Bq+DAFJdN2RIaELy1AOPcl+6LREintgsKmH5SG/LfnD
	 zrV8GuTe5tUC6FLkd6gCstfmCnq6mrYtsGdSHR5lKxedLUDBNbrm9E+r4wUczJLD51pvo
	 5QiK7S3YVHKkXLiM3zTlSQ91fUHQyZ+/lBzn0+a5RYugO0Pvcd0VXke1U89CFmo2rDj1t
	 FdwgiTscj5ikZfWdEnhP/N2DoBXirk9kbr4NqLYNZzKcbNIbzDxU+fS0OLLIwTjyM1cyl
	 PYXl689Al5Z+ErXyCXNFBCxNN9q0vK2e/zzX+s7HkQsl5l127mkoF0sWznjh2XvX0/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnlUWAgj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E92606A323
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 06:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E92606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnlUWAgj
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5062bcb857so36182166b.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 22:18:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794723538; cv=none;
        d=google.com; s=arc-20260327;
        b=g9WfSS155fbXOrbsJaZErjj9SCbBKu+7Uq1bnt7UHp5cjqg+leVPLNheltqrLQv4a2
         wfBjcZbyUael63A+Wj+BK9ZIK/rGgNx2MXtbmgpWOurRp/u/hOtq2KKGCWL4xPy+RzV3
         1qqqCBNmZxk4202MToWCyNjY8QiT+Tm49v0tn72Bye3nL/OVbjyOSr5SdjqCw2qJYyHB
         DkBaSzntqtlFx1Kbx/zFsYab4LKf0q2ipWBzvIBxAtIiRY4FhR5/wWLHT60tiuNZdAjZ
         XcWZY056ZxB8pZwSRvEDEudASsL989E6cco16ju3+pZA+L6Ig+b5ixL8ogEa7JKY76Ed
         yPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=EiP72np40bx2xDBJ5GjnlxGCI+LE6l2A3ZHgQbH7kng=;
        fh=4bwqjuJlb8n2BYR55ua0qsy+2KYx35eEBv6FM+rbixM=;
        b=MAB7bZ97SzbWlcmlHtsd9uO0IszkJjdJi4gu4pGyqwZPdNOAu+E2a/vR4JZkDEvhdd
         LfwxAkGOmhN0t6GqmEamLFtQGsAWNdqsekKyfvinKYfOVAVpRHbTYrWuVV30KWrw0lb7
         /07LaWdzrOkiA0SLOwsMjqs7V1exifRXb2c2lskV2Gnm2ODykAJ9PxPssiQJ+2g6dQr6
         8xeW/NqyC5VLXsxOfPoa0CTO8EIzvVUsbwvIEjIFZExHOVWR7mtbV0CzXEETnrFmVhsf
         brCZvwI/Tj45Zk0jzrwDyJKETFNIqWe6EmtoS9k9bn0nvv6hFQCFplGLU75amYsuQkd6
         HxoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794723538; x=1795328338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EiP72np40bx2xDBJ5GjnlxGCI+LE6l2A3ZHgQbH7kng=;
        b=GnlUWAgjNPngl14gAPmQGP/Ir1JXCkP3rsfhMkEp9oJ7hbmTB4Gxuzrdqz7rnPlbu0
         5QTVo9QgNNz/BSHkEfvq37BHoTzO3MmmRJ+hgVF9HuiPHqat1C1zNQpUTz0eQbWyuiWd
         5rloP1D9x/4AVo5Hp3+u98ZNzKYqmM/u+Irj/qRpdZVmQuLmoL2zFD+dT3L7YMrsuzpy
         /gpJyN6v5UQdORitsGYUig6KC10bsQayAgMVS/tBsbRto32N83ZcB1KqC5qnGg6J8l7z
         riHFo0MORu06fE5jP0XaYah96F3XKWtGFU7cYOc+iBYoDSsZJXR03Wnvdx3kTPEHkAt0
         Mcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794723538; x=1795328338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EiP72np40bx2xDBJ5GjnlxGCI+LE6l2A3ZHgQbH7kng=;
        b=q98JjHjf/MWhaCj1blpOikueNjDhb7TMgYCPIgyyZbu3jmv8L3VbN/wZSDP1V/5sjz
         8WBP0A6qZZ14GQu4uvgczAQK0pIgnW4hikpPJ4c2Sh/LFG3o4nmvAnWTtiC7oRqvRUt/
         eaMxduxSo5C5V4WYApx5ARzXrkClCvj6L246QE2IOBr49VJZl7PkNZh/iAAAabd+UvcP
         6omiPwD/6TsxDo5uUFYfIoRoRQAZM47a0FOLNYF7NcvqctkNt8C2fY0eaShkZPPEOMo8
         vReBklHZfNuVB5QHi5lZKHjnK7n0Oorg7o//9A2ol+maT2C0kmTWbD1UULTda0KQdP2u
         bgXQ==
X-Forwarded-Encrypted: i=1; AL+hErEzp81nBmqRDyCTlSB8Z+JuHQeuenMxOU+/U3AjSAxSfK73cbmVls78YEbIZmTyjMrJ/iWkfC3hQ+G+CUyLjwg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pTD0uEHS39FJ5gb8MS0sCsYd1IxoAYgz81FE2qhU8EUnbooun
	S8Zpug3BggtsqttCPD3a/VqJzHzSE2Qpy7Hg0nYmIfX0ge0zqbvP/I57Md74fsJ0XgwOAkg+C3R
	KDLJLfs58aQLJC8eRmFTX+9UCpqR+Xm4=
X-Gm-Gg: AYBFou1QxMErt4jOgcrfx+bw6ZeTgqk/snTFLdsPmabopAkkwxUvMMDyXXWk9tF0KYB
	uk5h2qOZ8jKQeGaHHtqdUksu001oiwh2Rq6cAkmDGf7+Hyl+W19up9XX/FzLtUwP6Qa5/MaQ3T3
	HINWvM5PKPjA2gS1CNLRnT3mtb/H7MLdA7TEek2rqxOw8RZHgK6yzO8qnCsfBn/CCqGg/EfebNP
	GA5qgaE82QH03IQSvSwmYk7P7RTBF8IVnpnLxSia+kX8Kz89KhM7rg6sIwQLA618vHPxjyNbzc6
	58qZINsBWQyfH/JyOWlKt4n+RLaHCJMOHHS5VCbGrAaXRk/WmCXsooG5G+gImQEwfWW4fi9DnDm
	ry9hi+OQg0itRQi75KDaDN0iIHr0npc81F9s=
X-Received: by 2002:a17:906:3482:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c5095db0da6mr565969466b.0.1794723538077; Sat, 14 Nov 2026
 22:18:58 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 14 Nov 2026 22:18:57 -0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Roger Zuniga <zuniga.roger@gmail.com>
Date: Sat, 14 Nov 2026 22:18:57 -0800
X-Gm-Features: AclHuK97LFwnHdupMlEAXAZvCZ0w8D6TofFihWmMvPfxsXr4oTztllWb4hTNzNg
Message-ID: <CAAYEUU7YWz4j=xUUO-hiA4SzBoPWWZUqZ7J1C+TXKpd+=cbM_g@mail.gmail.com>
Subject: [REGRESSION] rtl8852bu: Life Q20 BR/EDR playback disconnects with LMP
 timeout (0x22)
To: linux-firmware@kernel.org
Cc: hildawu@realtek.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello linux-firmware maintainers and Realtek,

On CachyOS, a soundcore Life Q20 repeatedly lost its BR/EDR connection
during audio playback, roughly 28=E2=80=9330 seconds after BlueZ opened the
audio transport. The Realtek USB Bluetooth controller is 0bda:b85b.

The controller reported:
  HCI Event: Disconnect Complete (0x05)
  Status: Success (0x00)
  Reason: LMP Response Timeout / LL Response Timeout (0x22)

The same timeout occurred with btusb enable_autosuspend set to N. The
kernel excerpt around the dropout showed no USB reset or controller
removal.

The packaged rtl_bt/rtl8852bu_fw.bin (CachyOS linux-firmware-realtek
1:20261019-1) is byte-identical to upstream
4ca3317e935e3e9ffad49eb51a3468136c3fdc96 (0x127C_FD78). With only the
firmware blob overridden by the copy from
59def907425d9bbc49c826c9834d6707af5fe97d, the kernel reported RTL fw
version 0x04479301, and one playback test passed two minutes without
dropping. The packaged blob was verified on disk. I do not have a
runtime firmware-version line from the failing trial or results for
the intermediate revisions. The current host reports kernel
7.3.4-1-cachyos and BlueZ 5.88-1.1.

Could Realtek investigate this Classic Bluetooth timeout and advise
which firmware revision to test next, or provide a candidate firmware
for verification? This concerns playback disconnects, separately from
the previously reported BLE keyboard issue on the same firmware
release.

Thanks
