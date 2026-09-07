Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C44432F2
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770430; cv=none; b=nqBQcTj5/sAL4/5oUvmG6c2eU6AirYMONOOFsyrFkIpVdxeXdqSM0/DkoZbFYURLC99WJ2JF9/EP5GRKaRp8ctdXvyllv9G2tlQpsepSGvQyaW/wFJYm5xNuLN3MNZeJJEAIeXxFuk3WAGspLbjOm+zHueG7f4+VQKG8qKsnmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770430; c=relaxed/simple;
	bh=h1ANNBcQmbPctwjnrps5dgnvbB39XaPakmaRrntLq0U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XWJ9tW994xdhuKo2DPFtPUkiFqnuFN4iH0uUuUzKa44nxFAfXqZtg0WJhmXtltRRZ9vKtlK9dkhJtN50mQ6YJHympMMn0wn/Dol90g/BgoOLaeQl3Qt9pywGdcq5V+5Vg5W359cY60cxYvVTFyP1FlLZKnx323Pgo4BCKOBYk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mJnc2lGc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mJnc2lGc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7jR1os2hhFmOhMH91YJkBbFxcfzJvaKHrLBf3t0O02k=; b=mJnc2lGcRZYT/sK9ciSG7bY3mF
	TD4SWLz5cgy/E93SVBDONCiNjn9QklrdjBrikuaiL1eDKK08osb+1CY/sP1EYDRunKEh51i/oOF05
	3s+o1Vt49uE3VqocMwvGaq+ytzoY1BcBd8BJOkTAgEfaws2UCi+bOyD+PFELlMQhrAfYgy1jPla4g
	JdASMokAihyQzMTi0fzaw/z21vbD6b4mkIkOJkZk+Xz803KB1WXatv7a06hbSJHZk489KptlT1Eob
	m3WFBJwFo6Spfbtj8QbUMwbb9psOqXj7pP5JgwtuuF2gcjTQajnakgUhsKrV/tiUR3UuJg0aHWTeo
	s6gTlfhQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.96)
	(envelope-from <bigon@debian.org>)
	id 1x3Uto-001Noq-2c
	for linux-bluetooth@vger.kernel.org;
	Mon, 07 Sep 2026 08:40:20 +0000
Message-ID: <44081c21-4d08-4cde-8efe-2f9943b0a90f@debian.org>
Date: Mon, 7 Sep 2026 10:40:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US, fr-BE, fr
From: Laurent Bigonville <bigon@debian.org>
Autocrypt: addr=bigon@debian.org; keydata=
 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
 wQOeCC+SiVSdSv0zm8D5
Subject: Disparity in Secureboot reported state by btintel driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: bigon

Hello,

When debugging some secureboot issue on my laptop, I saw the following 
disparity in dmesg when SB was disabled in the UEFI parameters:

> sep 06 14:44:00 eriador kernel: secureboot: Secure boot disabled
> sep 06 14:44:02 eriador kernel: Bluetooth: hci0: Secure boot is enabled
This is coming from drivers/bluetooth/btintel.c

I don't know if it's just cosmetic or not, but I wanted to report this.

Kind regards,

Laurent Bigonville

