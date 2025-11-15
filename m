Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E618A94C;
	Sat, 15 Nov 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763216728; cv=pass; b=BQxefWNx+4TXLkmE4VD21eP7lqpjqpzyrWoUO1A+rdCW4yGiquu6ONxOqoiEHHiTDujB1AFa42/i5xFk2V4fvit+I7fUaROi1iwtBXsNHlW+C2cgOBtuzb0xB12YtcPRvAOWptcMC7pcSPj613sJissUi3HZdKp5NMjW1xs7f+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763216728; c=relaxed/simple;
	bh=hpAQFB1Kb6jcZvBKHqaPuPoZbYbH1GYkl9tWAE7tqJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SsQJdUXhsgGqmHeHWCwvSeTmAmFTO3wg5iGPxifqBwdA6Do4H/usy1+1xXBTC1s3rMVnymvEAVIiHxDDEQiAP9qtJ1KGGdHANtIvsw+nnSKfldM16VRLlo9do3Q7eYBRTl0jm51YHw5TbG4Ff/oVuhXGfAm/Fz75qhmDTaEb2bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=YTWFX5VF; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="YTWFX5VF"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d7x9m3WCTz49Psn;
	Sat, 15 Nov 2025 16:25:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1763216717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpAQFB1Kb6jcZvBKHqaPuPoZbYbH1GYkl9tWAE7tqJU=;
	b=YTWFX5VFu84+60s255AgiD4u8+MKgC8fvWUYqsDWf4RlBuP61dW/FffAehsgqeKHgTLTVa
	GgQqICmaWS6id5mGj9WLvD6fWt0gsJucin/ikU9N+8NZ8r+PTutuPcSSnxa2b1iI+FFGbv
	jW5guTKDT/nNp1hWXjFlzAWcPbo9T1zUWNGJFFx4e+yzgLUoHxqPPm8VJ3CPjlz1VTIswQ
	w+kTEHhbeYu+p12hz5K/yyWZgg2xCbouthr2rM5GAVnnyBm/bvyLJj2ZNFqm2OJQn2hrG3
	4UYhM7LxeFqCXY7zpdEGQiMJdB3zvabi/5Nul/uH7x5wutDDVqg3RTtE6IhhlA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1763216717;
	b=laRX0XZc0cP9WsLTm512VuGFNJqDPKxoC3W/EKlMHAlgMPFazdv4jyrAsIk8EmwyLgv2i7
	kLjRI7rzJtbftuj1LKn+DC4lfP7liKR4dPWqq2AeWa+DfwZpIh7Wgvu1AuWiAyLvE+YPG4
	VxRugp0NPfiPwCPUOnfnLV4qY/4DkueQDEcJ+3pfaA1tgYvN6d7P+er6iHpUsrorYjLty7
	9WifwHtoDzrDMKEFs6CPjVHxJdQ6nf60azJYm/FaxnjpbWIQhcTymQqFZN+gkj3RjPqgMm
	pK7FA3H2qGSPV0ncm3+0G9cIsqmMaHQGVWaUstBSh0PDxPRXVaEJrQ+zu/JZ0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1763216717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpAQFB1Kb6jcZvBKHqaPuPoZbYbH1GYkl9tWAE7tqJU=;
	b=AADciGYdyj9GaVzH4IDnoReBQ37YIKFZnBYe3mhR/eixFrertqfp0wp/mgnBXH63AIQqI3
	sJUbLONEYzHwE9Ys8z/T1JzTIxrff9oQZxYkjuysSBjHU983X2AbM9iRpeNqR95C6CNnqP
	eZMJR/g8H0uJjg35Ay96ai5x+5ASMdn1hQH8EUsOfvDJ4qd/c7fLwxvE3AsrGwTi87SZrD
	3hueJnlB4N9o2N1dmNoeXLRv+Z4fDkNdP/6utHKZb0KgYDR2s2pFqZMLMY80HKjku/+Zb4
	p6Iqc2j3+puX4qPZru8d8DyfKSY8AnD3xYzA1MPALysM3yfGHbSAQ+9IVEy33w==
Message-ID: <6c550cbe2e1f22c18efd6dada81966bbb5269eaf.camel@iki.fi>
Subject: Re: [RFC] Bluetooth: SCO: make locking more systematic and fix
 missing locks
From: Pauli Virtanen <pav@iki.fi>
To: c Z <rollkingzzc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Date: Sat, 15 Nov 2025 16:25:14 +0200
In-Reply-To: <CAB7XQsFfTn3gL6TksbTNnC3E7SRPt+odtkVUJa24b=LmP3615Q@mail.gmail.com>
References: 
	<CAB7XQsFfTn3gL6TksbTNnC3E7SRPt+odtkVUJa24b=LmP3615Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2025-11-14 kello 01:37 +0800, c Z kirjoitti:
> Hi
> maintainers,
>=20
> I=E2=80=99m the original reporter of the SCO UAF issue=EF=BC=8C
> but I=E2=80=99m writing from a different email address now because my pre=
vious
> mailbox is having some issues.
>=20
> Could you please let me know
> whether this patch (or series) is currently considered to fully fix
> the reported UAF, or if further changes are expected?

To my knowledge
https://lore.kernel.org/linux-bluetooth/9ca502845fc793f3f76c02aef316a273d3b=
6929c.1762026583.git.pav@iki.fi/T/#u
should fix the issue.

It's RFC patch though, I'm waiting for feedback from you as I don't
have a reproducer for the issue, and Luiz if we want to go this heavy
on lockdep / sparse.

--=20
Pauli Virtanen
