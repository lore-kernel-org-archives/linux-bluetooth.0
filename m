Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963815;
	b=dZIuLQoDJyk/I7z6hD/m0gKbdeQNH5+FdeZ6f1T++9QYFsjPN2D5Y2z1A9fsXaT5waTz
	 3R5czsBvX9rQ31TinlZClP3X9Rj7X920O75QmLbsea3u5HUus169PcvuheUH58bNr+v01
	 DErMGXpUJ3ymv1h/iZXGChOnwwXaO3LRDTI7e0z9Jb6267bkN/+nam+uMK1sHiHX67r+g
	 XPEqWXEPp1ooeQpoQ8GblGvFE7710bYoolj6m8ROP9wRMzesB/h2/HnY5VoZ1kd3B3DoY
	 wsLLMBkar7q3QZUQ7+LrptAlNt1sUufqeXobHQ1uQqIkgtSAtbacC9ZETJhyniQKeXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/2eFiE3bQ464FmO2JJo4VW5PfHFjibC+F4cl51xjGiE=;
	b=BErkmSOXF6AYrDf5e9QpI6+s1XbAh5Zh9Td1+9QDsq+TUjA/aafJrx9kBFrT5bjAa1Hp
	 8waBWjSF1E2Rz+o6iWXTiSVZRUT3a4dfgqUfBrf5IZBVcUy/Sk1GIqF/8ag1LvAQrtlmz
	 zBxD1VCxrnZQCwo0zndXsLpqulCtKQKmAVgGEuJno0VcdMdMk58/err/c3rb/izy6VFPq
	 BGqNf3Xy/meidZCew4tRPleJjAVbWSchsnBxeDhGABGMGaCXAAuOU6YchhdbFukFPaBwc
	 HdQ352s355NWhZXbjM7+rByOH44j4ensVv3E5JmM9Lk0BoKzmGOU8bjs7Oh7kQBGIxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fhCKYdsQ;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DE606A322
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 21:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 625DE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fhCKYdsQ
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c34bff61551so335842066b.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792963814; x=1793568614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/2eFiE3bQ464FmO2JJo4VW5PfHFjibC+F4cl51xjGiE=;
        b=fhCKYdsQ0OyMh6sfuOIAo3sWCrsg/U2CMwUsTWVoLNM6E4aIJSXdw6bxDKSvR4csCW
         E4HpFqoTo0lvGnx1G2acQkNs6fhk5ruW1hDejUFGLm/TqlCu/enFwrL79TAfmZmSSH8j
         zzQZoj3e2m+cedl/uDnFRFSNCGHFWaiD4lIuD58F4vO16fJxYTg2B0HGqUyWspn5902d
         KdN4e1YsyNdxzlA++oNeas/rKymOFsim22w8eVLmRbTZT46V22WHFoKCr67WKaR+WKEP
         XXKtSYgRO18cnwiUBo/5DC07QHztJNJBxPJHoq5vBif5AHhNVWGxWjP79WyCtd+90yMz
         4S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792963814; x=1793568614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2eFiE3bQ464FmO2JJo4VW5PfHFjibC+F4cl51xjGiE=;
        b=Nq4CAdM7nYPh6m9s5Qi3zvVdG6WPa3xEjt+H3ZnPI8AstOzZRNIUoWLoZHM1Nlchk+
         DLOT3y5vNkWOmklwAwNa4bzMAAqe7w+8k0rrmffYjNobTCMIm9POJsEeuohpfmhaTcDP
         qAY0jLvMuJC+6vk5B1kkeU60wotyWuz7WNY9GVJjb6UvZvHSVsaGEwz0j4dyTq6O5jk2
         M5PMtCl5wCf4+GlNFsjQSwkS4GeBNpb9jLCAOzgyKYBpNEirpKchpYzqeTRbeqtvLf/F
         MV5ZPWzdDCox/vzulItIOxy4x5LJ975OLc/HfCF534pgYczjVOFh99WDHNSt4tMUnzQr
         DItw==
X-Forwarded-Encrypted: i=1; AKwUvBxe9kEt0/Tqa2uX7nKYI4IcRFu1NhsH1x34hE6worJmA3j1UPR3r61Ox3ejXxBeYeKrkeuxnhqP1elPzaEsPCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA8wpk5nntYJvm+60GY3nXVNj/0JdzwleZp2aG1AgS102dEwzN
	9ufQ6Wrib2rBievp5WTH3O2+0T/ZXenZFSqXvyBHi0mWSMmF1cXhYivd
X-Gm-Gg: AYBFou1rOUUJ6k/PdQSeLZpXNvAqQok5DvkolTI3ZcZNUxt8xSVwstOiKuvdEvCz0B9
	cSE+DtUBSc4cJBuIteQY1k7Y/HGpxRhKJM/zhmV2izQMme2ycs/ihI1qnMiWKIuLSLQjgnNMAPe
	VuYZd6DRPyYT9/pscL2kE8eZaOELA88+JUrhnp6R87VcYFU75M39nmPomeWpDq3jT+RC6oEBPb6
	aHzrjYjvkBUWcArhzUIJPF3tOsjVIBZKiR1jumqOD3sLtkjIJ6RRqSpvhA8MBIEwbjJNfGh4qB4
	9aOzOzNz+P20jkbIk48oz3UywklMeR5+1Zhi+IVNkXpGp1JtAAzMy1GVfSOFb9eFHnRMm9KsQXM
	zEfeyHdVthbO6YHnq0oya1tq6dvT8gswh4SRlUJXa4prvQi2GPq4hhAxRJ3IQ1EeMt0vgK/74H+
	OOl25pYWaLtxwcm6yCVS5WX8cV/ReVU8wjAoNg+R2fH/zLrWzSfc93UkEtG5SVqPIn2QcymyaRR
	FM8vcvNlldDqy0ue4TWB0aUfcCWpnm8sYQTNRmWRPp48f6GovF230lJKqPe+FQ=
X-Received: by 2002:a17:906:dc95:b0:c34:83c0:b92b with SMTP id a640c23a62f3a-c46bde24eebmr627862566b.23.1792963813604;
        Sun, 25 Oct 2026 14:30:13 -0700 (PDT)
Received: from nb-xps.ts.zxczxc.org ([78.56.243.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm243556666b.64.2026.10.25.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:30:13 -0700 (PDT)
From: Nikolay Bryskin <nbryskin@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/4] driver core: add device_schedule_reprobe()
Date: Sun, 25 Oct 2026 23:29:48 +0200
Message-ID: <20261025212948.11474-1-nbryskin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <4ffa0608d32b6a68e064b41b17b6d35096b9a7fc.1792203271.git.daniel@makrotopia.org>
References: <cover.1792203271.git.daniel@makrotopia.org> <4ffa0608d32b6a68e064b41b17b6d35096b9a7fc.1792203271.git.daniel@makrotopia.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 17, 2026 at 08:56:27AM +0000, Daniel Golle wrote:
> driver core: add device_schedule_reprobe()

Tested on a Dell XPS 13 9310 with 7.2.11, called from the .restore
callback of hci_qca (QCA6390 on serdev) to download the firmware again
after hibernation: the reprobe ran after restore and Bluetooth came
back, and s2idle suspend did not trigger it.

Tested-by: Nikolay Bryskin <nbryskin@gmail.com>
