Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3CC1A5BBB
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954830; cv=pass; b=cjimX3ZvTc30PWXXJHF3HsJIXqNVyPY9ikzgN0NCCX8i5Vl8KdqlX9He7nNFLs/uCHVSAxGSKleN0vnOLeCsZLDe3qweMYHvuO+tuo3SEgj03iQwYq6j+5l9JoHVWDiqufPZo4gItc4vDeALlw3pnHPBZHJ+L1AEWY2q+TGhpsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954830; c=relaxed/simple;
	bh=zqwshifjQskgGU1En6PZeRyBKfpIRECpXDdSBgEhmfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvVpkMmHK2++TQhpQ5Jsnbq6Y//HMloLafPXonNGZcqX7Z4LNQDrz2vRBZNMDCLCnOffejfFvjR8QBveN6uO+SWaV928JkMGenIJExefdEAkq/iZ8pczJko3ST++VXKgdw4TSc/vHNwgLGeUHuYdS+ZlVWjqipOu316j2pVXYAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Az6cIqQH; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Az6cIqQH"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YqNZp2vGDz49QB3;
	Fri,  7 Feb 2025 21:00:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1738954818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqwshifjQskgGU1En6PZeRyBKfpIRECpXDdSBgEhmfQ=;
	b=Az6cIqQHJ4ccW1mioDEhSU5YpCkb4nzQJHzj3C9aKd04l9nvx5364b7euVl1T7ASCG43P5
	qCMpzm2lO2FxJmLhNPOR0vaKTHP08VqXe62O9mo9OsjbMOv9WTCIvqZGNZ2/djbzagjkNR
	lf1EoSL1Ci9o7t0IRVVqOiMt4N2kvgjE0Tuk/L5xyerBmJOHyauP9FmlYPuNyiQtLrbDtm
	BCOBB8t5FBVu+HCbJXFPrQ8DJn48r/MLPJ34uF9vPqw1KakKgn7Vw1YYLHwzHre9wsB7Ig
	PNhiCE9DMHnF3+cK/+zMPu7xCCZEGSs2vCRu/4h+l7dNn48aCyG0TDcLKqrs7A==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1738954818; a=rsa-sha256;
	cv=none;
	b=JmBSfhe/XuGLjAPFYQYu08jkOoTnBNmUGJ1FbIk0tdyxvU2RXimNri5KRFL/KR/431LNEh
	fiK7CIjMI5NYenpYpKfl8+dcMCRLru2tATv6G4LfGRRLuruGsFQXEuvl02Tw0Lz82OIJWJ
	l8MH24mkNpx48OT70cCEtZJ9lbU7QOBfnXrOVL6TwTpiDcGL12gySLqc7Su4H8YyYP6Pbi
	m7gnxZ37GDW7Ltv+j9XnyHT1wEoXfofNe4dOq6iAp2GNFsX/W13ChqMAlpMqZsn7qSKmai
	CbpQfyA622VKAiJmdy0mlFIj7+jZ/jmjQQvTfSWaxYADX/DuG4Wz2t7Epfml5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1738954818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqwshifjQskgGU1En6PZeRyBKfpIRECpXDdSBgEhmfQ=;
	b=uOz3krBhibDwAgDYvv6VxFhZXRaeZQlJs1Z8VrIN491rYqdVPi49FUEFctnLw5FGJIUV9E
	2mwjSlpuJ8Ben9NazuS61alI7cbstFLoa5wO7th0vogwEYCZL0Ulf5DxUjttAjUgeQ1U9R
	XfEjhpCMfY1E02FAJtnka0w8fJIRZeoXD9Z1/OhbWoZoNhvI4j3a0fS525SoGdZmwGx/sS
	HTlOV4qXUgjE/7ATDvJIuEkjyhAAWrhRlb9587Cl5u6y+DdO0jALgcrVcf6MpIAZAgTVGs
	wGX0wNqCes9EAfCri5ES7JHafr7lDoGQtNswDkMbmM5VXuHi1JxlLfsPfeX8jA==
Message-ID: <664413193a65508ff5becd2098f9d3fe2ded06b1.camel@iki.fi>
Subject: Re: pull request: bluetooth-next 2024-05-10
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 07 Feb 2025 21:00:17 +0200
In-Reply-To: <CABBYNZ+Sa1y3mvX+GpCtOUDu_0jZ9MNS69xLSHY5ShkfBuNfzA@mail.gmail.com>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
	 <20240513142641.0d721b18@kernel.org>
	 <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
	 <20240513154332.16e4e259@kernel.org>
	 <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
	 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
	 <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
	 <7ade362f178297751e8a0846e0342d5086623edc.camel@iki.fi>
	 <6643b02a4668e_2225c7294a0@willemb.c.googlers.com.notmuch>
	 <CABBYNZ+9D-jSyTsRvzRReHE4enfv6DP=Pr4uZCaLdY3-4D6AHg@mail.gmail.com>
	 <0a132561e1681cd0a9b10934a1cc1f96d29dfb8a.camel@iki.fi>
	 <CABBYNZ+Sa1y3mvX+GpCtOUDu_0jZ9MNS69xLSHY5ShkfBuNfzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

pe, 2025-02-07 kello 12:34 -0500, Luiz Augusto von Dentz kirjoitti:
> On Thu, Feb 6, 2025 at 12:13=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> > AFAICS, for synchronization (only) guidance in the specification is
> > (Version 6.0 | Vol 6, Part G Page 3709)
> >=20
> > """When an HCI ISO Data packet sent by the Host does not contain a
> > Time_Stamp or the Time_Stamp value is not based on the Controller's
> > clock, the Controller should determine the isochronous event to be used
> > to transmit the SDU contained in that packet based on the time of
> > arrival of that packet."""
> >=20
> > which I'm interpreting that Host should queue synchronized packets for
> > different CIS to HCI at the same time. But since this seems
> > implementation-defined, I don't really know what Intel firmware is
> > expecting the Host to do, so maybe pull on completion works (at least
> > until user app misses a wakeup).
>=20
> Yeah, I think this lack the clarity on how the Controller determine
> what packet got the what event, in theory the buffer count acts as the
> queue, the queue is then used as jitter meaning there will be some
> latency but I think that is sort of unavoidable with the way packets
> are transmitted over HCI.
>=20
> With this in mind I think one of the problems is that when we have
> multiple connections we probably need to load balances the usage of
> the controller buffers, each connection needs at least 2 buffers since
> with just 1 it is possible to miss events due to the transport/bus not
> being fast enough to notify number of packets complete event and then
> the stack to react in time to send the next packet, so we need to have
> at least 1 packet queued ahead of time.
>=20
> Once we can notify the TX complete we can perhaps use it as a trigger
> to send the next packet, instead of trying to do it time based like
> bluetoothctl is doing nowadays, which imo is simpler and should result
> in a better utilization of the controller buffers.

Another thing to consider is that it's probably more or less guaranteed
userspace can miss the deadlines sometimes, and packets for some of the
CIS are late. (Maybe kernel can also miss deadlines, I don't know if
there's any guaranteed wakeup for the the HCI worker tasks.)

The scheduling should somehow guarantee that underrun only produces
temporary audio glitch, and not persistent stream desynchronization.

So maybe it is still necessary to wait for completion for all
synchronized CIS, and send new packet for all of them at once?

Or, maybe controllers now implement LE Read ISO TX Sync, and it can be
used to figure out the timestamping. IIUC, not straightforward either,
you'd need to deal with syncing packet sequence numbers with ISOAL and
clock drift...

--=20
Pauli Virtanen
