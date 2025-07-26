Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4B2D052;
	Sat, 26 Jul 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521519; cv=none; b=UQgTpCPJMr9H22QfjZLUtu1sT+96P4JQIx+1oAslpevbdmAxaEffs6pDXzSirWaqjnq0eov/IVND0NtPjq2KL8GfePPLOLUPCScR6fwivDTVd1xNM8uBErrPUVyX402kQkvTL6xUF/VcHsmj3j2h8QYYOPBSoOkK9nJvLX7gjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521519; c=relaxed/simple;
	bh=MJKLLhpwjRrp3CQjVxZ1VB+2pAKysiMyMbN0Y7oDcx0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tuhleR4AlZOHhVg5Bdu6T3XksS85VpPrVKsuGscgbvrdbVj64uJXc6+bGXzOwdVwGHsBYspaRhadeDT/cnUfVq8cu257Sp/Zp0nhC06ifdcFt6X9WHZPnzbag/YrZ4+TuNZB+c4ISFKY3CHOnG23/R5faupoyYLIZWLomyMGJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=S9Wt3yNX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="S9Wt3yNX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753521514; x=1754126314; i=markus.elfring@web.de;
	bh=MJKLLhpwjRrp3CQjVxZ1VB+2pAKysiMyMbN0Y7oDcx0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S9Wt3yNX2HkYj2PxOQy+84fco0pYx3NJIAmG/4dGyL0DJ6iOkV+aF24wEh5GMw1V
	 Oz/q0RrKTB9FZ/OZWWWfNNHo3djZadQUoLHZcXNC1hSksYAkTKCJswVQ1v42bzMv/
	 3Z1ODBl8hmxDijOecGRVk4HMvf+RnDF+zttA8Q5+6csn1Q7+Dg/EBQL75pM2P2pqV
	 NTSawwphdmpQrmejikBoFecuJ73I6nBDaEhJr72Ux6teIq9zMuJTKB7XM1iI0FB/A
	 aX4RMmZ8R+vNe2qYg5pqnqSmT/NSO08qCsoXJEjcN48mAoZqynGZeJkyliQDV8PCS
	 4Uk+sHzlhhKlnowwwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.228]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXXND-1vCORS3kSN-00L1f6; Sat, 26
 Jul 2025 11:18:33 +0200
Message-ID: <96504934-0a58-4871-a6ee-acef27130791@web.de>
Date: Sat, 26 Jul 2025 11:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Salah Triki <salah.triki@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Luiz Von Dentz
 <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
References: <aIR46cMM38E8iJqC@pc>
Subject: Re: [PATCH] Bluetooth: bfusb: Fix use-after-free and memory leak in
 device lifecycle
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aIR46cMM38E8iJqC@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qkNZuD3uxlLBgsYNoBXDXgYvOmMla8azFS2A5gR2595wLrRJwpD
 1auETavIrPDqLg3zYvdA/Qn7XLRjNZTLqnOli41MujHafOMwGV/ClMJx5I4+yVLGLM3njr5
 RBywxTdRwPGCf44pOadIHePEYgKHYFGPNM8jGNFiUV6dCE0Y0tOgd6nqtyqBArOSC99Pl95
 UJurJpSViKlpiFL1EXp6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NDsKcD2qKcg=;N+0Eu0LPKlDaavR+I/dhovwBNUd
 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

=E2=80=A6
> This ensures `udev` remains valid while referenced by the driver's
> private data and is properly released when no longer needed.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc7#n145

Regards,
Markus
