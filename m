Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068041F4169
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Nov 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762105398; cv=pass; b=TkqXdyP7Ghs6Ol5JG1eFeeRF5w0K8bJvqfUcwCipKWAjhzI04pMQFzBAzrpsjVF3fbPGoBW7n1K3t7xMKpcJVK2m6W4BMq5hI7aK6rr8udB62NNH76RO6As9r31v3VgblTFSDW9uHhsGbyz8xONYgN795nu+x7q8CrVKiCH8Emo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762105398; c=relaxed/simple;
	bh=vzs4sbBG8bWsUbWRzciVxZZhHYOjtaTZUvQNlnP30tQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rg5gfU0f6pGyDB0ZNnJRntYNdr1qyL5Q4MzinA4mOYUmA+5Nog9kyzbj5Iq4iQblGXJmGR77mDJLZVmFTi8JLy8rESD04DTCVjsJtluIvHoEvLQ9GAmL2aR84ErWlSv9R2/hcSJfCVWnKttmHRmVWCqafnsvTpHKu+ArhloMXpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=u7bnYo0w; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="u7bnYo0w"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d029x639Gz49Pwn
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Nov 2025 19:43:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1762105382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3IvcPdXyiPDNZHYBh++VKebhr4USSroVjTBNzGuTfzk=;
	b=u7bnYo0wY2wpx6l2VWxCqCWBNs8+xQvd8Wd3ACAX7Tq7S30JWykaJpyCQP/7E2V8Z/0tUh
	Po+oVwPAJATf/X9JdVVNp62RU/7CE5Hryaf54hgZUQtWCRQlm1pICnevmi/oBVWn2Fs2uS
	HvtSva9EeA9uGmQX+zwtN+fo/c19m3zgHJwW7qthMRXl69OHy8q6kL7jVUjoHors4wUEGK
	HRDGzaPozEs9gNfXiXFpkVLm11Y6/BCZk5VZXm7DNKRCPQZT6V3Ih7GB6+UVtnPPyjSa0j
	4OknKaHLyngolcpMU4zw+HrqotkuT87Qdp040pN/byrHbMEkUZ9VHFU+W262IA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1762105382; a=rsa-sha256;
	cv=none;
	b=DVPY5IPrCrVwXCtDyOZVawj9hNiiHVHfJcoP/2q08o86G8bODOiNg4eJtnPCfKzKB9aSZ3
	pjvbmxzf31324RvbvoZh45HoC5xWsryZN09qR3C+Gt3ZQ+5R0ECI82jWLoaJ+gKMnUELJq
	Vbz2tDb6sLzsO/87bsxcMzDlUyEcaPIOGOM/R374gc600VwEm5a8+AXdAwgCfRIeZjczBT
	gF6NIrioFecbZfq7TCkgMXrinGyBCdEo8gXNqrQZpRjx/OXPJpsuFf82rclcb0QExWk/Rm
	KJma+F8QKEradEQrZMUXvK8X9I+vaPV4Tx3z/KFzpwr4c+xYkGxzm0Rr3k2WzA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1762105382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3IvcPdXyiPDNZHYBh++VKebhr4USSroVjTBNzGuTfzk=;
	b=N03vy1B0HbBcUiiRN81gtRb0irXXtHaCFE+Ro+eV5ISaVHGL+5SeoBkEt37Env594eLry3
	oEHeCEeaoI1YCU/1jwdkyJ22FSKfsnvB0gxHpdsdjn/tM3mueT+5KH02WXEt9WOsVywu4b
	9eKA9zCmLSxL6jiwMV/LLD6qVAc7/e7qwa9Zktr8ey8g8Oa72806mLIDj3Lz0W+mViQvZu
	jfZKk945lITl8tPwoP6jfGAF1wZ5iOAfTqDtDRWthX6B5R2GZsK8rcJlm+s3WlFs51BB6x
	kOQ2DPOio6bMnAEky5BFLjdLBzDRx/JK+ufts8CMa9s/19nFAOmQMg5bPXZwXw==
Message-ID: <f33541272650c13acdc0ea81b1f3a6c79fe4a981.camel@iki.fi>
Subject: Re: Bluetooth: avoid concurrent deletion of hci_conn
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 02 Nov 2025 19:43:00 +0200
In-Reply-To: <69078f12.170a0220.313d30.11b7@mx.google.com>
References: 
	<2486739e3daff8e4fbc0e7fc95fb2e86f866cbc2.1762100290.git.pav@iki.fi>
	 <69078f12.170a0220.313d30.11b7@mx.google.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

su, 2025-11-02 kello 09:04 -0800, bluez.test.bot@gmail.com kirjoitti:

[clip]
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
> WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x97d/0xb=
e0
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>=20
> Failed Test Cases
> Mesh - Send cancel - 1                               Failed       0.130 s=
econds
> Mesh - Send cancel - 2                               Timed out    2.672 s=
econds

The BUG: KASAN: is a bit worrying, but seems like a pre-existing issue.

Earliest is from Nov 2024 when we added reporting BUG/WARNING in
testbot, so probably the issue is yet older:

https://lore.kernel.org/linux-bluetooth/67364c09.0c0a0220.113cba.39ff@mx.go=
ogle.com/

https://lore.kernel.org/linux-bluetooth/68624da5.050a0220.250d4b.db51@mx.go=
ogle.com/

https://lore.kernel.org/linux-bluetooth/6901d2e3.170a0220.3c1513.43df@mx.go=
ogle.com/

https://lore.kernel.org/linux-bluetooth/6905e85a.020a0220.2018ac.29be@mx.go=
ogle.com/

Can't reproduce it locally, so probably somehow timing sensitive.

--=20
Pauli Virtanen
