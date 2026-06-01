Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A52F39B9
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780347950; cv=pass; b=h3Yfg5o3BdDndHW6b9CyCou+DNbPY+KUX+9ddzS0RfGEsOEMt3OdOrXDCCGAQYIrNPS0MMFil6cYpMX+zslQH5VqqK6gHM1mw0ZkgqXTXcxK+wDME8Y19yxmpM/AUd+JmYTVGODaRgvSVxd5ZzkZvKXpmhJ+YX85F5Yv2ISEfJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780347950; c=relaxed/simple;
	bh=vGRSCR9e6ES0mdBTsFGsGWOnswxRL2kxXiZVZvnTd/o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EjOrms30A2qzgOlpVX1Ik6FAVQvh/eDb12Qiqxc1Ot7e5mx5Wunleu5Hiz9HVGOLYT1mhdOlJhIGTn1mT15cRkmO+dw5siJbkAtjN1x+ALR/6Andm5ya3htKhhW7AlOOW2vZPhOnrDHDbrBF8BQs+FFtxdJVHcegK1eXV51nlHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=DQyDC8Ky; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="DQyDC8Ky"
Received: from ehlo.thunderbird.net (unknown [185.65.133.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gTmYL67kGz49PwS;
	Mon, 01 Jun 2026 23:59:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1780347576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyvUOrvanznVa1BWecFO8fTrrlqnvkqnd8JCum4c33s=;
	b=DQyDC8KyNMOKEjNYW/tqTnVJLHSaEUGDoGJqmqJgZY9uIHaYNDISI6XaIY64TkQlfCsltc
	qbera6pA6ddbX2NdSAHmdZtQmCx5ityAydHGLK0VqXb5M1i+623xMyqXB4Mft98GnrPzoR
	CqnXvKflmwVzh49BUSjWyv4GX/Y6AQTFofND0/ZhdfiAe6+Bjlinq6c6xoDJOtF/CcYUti
	0MhBr7mX2g881x4mO6jAYR6zpmQ+jZByBvu5rioUPew5MnmX2RKo/mqVWPGKYGi94gkQmg
	lW65lTcwG+jckOHBWE6rjMtOzn3juuCXmzJ1dr0BxTTtUsStCai4p89bx2Cv8g==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1780347576;
	b=WSG/FN7y34WY8mxRsYxwwh8AYxnRL28yXvBHhbhGp/eT70tuqwErwjKd5DyJNywgQiMBeY
	8XkMVRA+INZvQ+aeT1rzOmEG+M+Bnl36fwYc57DauQfVPVFN+J9J4YZvyf7Xvo9BC9GmSt
	kzhKWN/VCYamAj1c1XKHSeaEiqohW4GKt2xHGTRMc/g+oAVZdfhIiM8PSfnA74D1sMSBT2
	XSFLsHoNLUfjTRfAW5xAccNXmvB6/YmEN+rMmXYE/+FmCyl4HmPbxRpUWAtOsxasG7sTYv
	JyBqzjA7OnYZqZBbnC6pOWlI1Rr9PKXgG3SAc54hrBBHaVeAG4od0Ln81F6GZQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1780347576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyvUOrvanznVa1BWecFO8fTrrlqnvkqnd8JCum4c33s=;
	b=TziTA1ArwNflr5RiFfl2u6O/fq9Ljiewq4evKOnqQHHRf7hDtCPXspP5iRNzbSsG1zNCsA
	/EsTVnNXa+sxQseIMKRv2f2KiypL0p+eKgyYa3ftLhHpr8HbznDhUZMbR7FXdnKRw+y1rE
	Ba5VLI731QnOxc9VpBGICSYY15bKNPGm1MxEydrMma5+Ov1jPgrpRcnCqOFMq7tJul1fa+
	BYOjquRayxlilY/9ciBq6ERYwQoIOSVe0L5uF8c1mXAAMROZrTlpXWvqrIqXwDs9u6fYMr
	U2jfi6wxgFV5TlVbAhnyxdwbYneBSCLmyBy4TFRVYydP90j8ffrBse7SL5402Q==
Date: Mon, 01 Jun 2026 20:59:29 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Bluetooth: enable context analysis
In-Reply-To: <CABBYNZKjKr5yM2ORC_v67tpCOuDe86WT6e4hYbOFL92RNOtTcQ@mail.gmail.com>
References: <cover.1778930064.git.pav@iki.fi> <CABBYNZKjKr5yM2ORC_v67tpCOuDe86WT6e4hYbOFL92RNOtTcQ@mail.gmail.com>
Message-ID: <1DCB2BC2-AC3E-4BCC-886F-F59FDEE09AAC@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

1=2E kes=C3=A4kuuta 2026 19=2E42=2E39 UTC Luiz Augusto von Dentz <luiz=2Ed=
entz@gmail=2Ecom> kirjoitti:
>Hi Pauli,
>
>On Sat, May 16, 2026 at 7:15=E2=80=AFAM Pauli Virtanen <pav@iki=2Efi> wro=
te:
>>
>> Set up compiler context analysis that generate compiler warnings on
>> problems that Clang -Wthread-safety can detect:
>>
>> https://docs=2Ekernel=2Eorg/dev-tools/context-analysis=2Ehtml
>>
>> Clang 22, and probably Clang 23 [1] will be required=2E  Sparse locking
>> analysis support was removed in commit
>> 5b63d0ae94ccfd64dcbdb693d88eb3650eb3c64c, this is its successor=2E
>>
>> This series enables the analysis and adds minimal annotations to silenc=
e
>> some false positives=2E
>>
>> Also, one patch to fix what looks like a legitimate locking issue in
>> iso=2Ec=2E
>>
>> In future, it probably is a good idea to make more use of it and add
>> __must_hold, __guarded_by etc annotations=2E
>>
>> Kernel test robot appears to be checking for these, but not sure in wha=
t
>> trees [2]
>>
>> BlueZ testbot doesn't check these currently but it's possible to add
>> https://github=2Ecom/bluez/action-ci/pull/4
>
>I would like to merge the above changes to action-ci but apparently
>there are some conflicts=2E Can you fix that? It seems fine as a
>starting point so we might as well merge it if there is nothing
>blocking it=2E Or did you submit it as an RFC because something is still
>pending?

I can fix the conflicts in the action-ci, should have time for that next w=
eek=2E

This series is also RFC mostly since we don't have this in CI=2E

>
>> [1] https://lore=2Ekernel=2Eorg/all/CANpmjNN4O=3DW70sAc5gaVkTAFdrGGOW+X=
BMyuehfz3_QMiT=3DuCw@mail=2Egmail=2Ecom/
>> [2] https://lore=2Ekernel=2Eorg/all/202605060005=2EJYWpZXr2-lkp@intel=
=2Ecom/
>>
>> Pauli Virtanen (5):
>>   Bluetooth: af_bluetooth: Add minimal context analysis annotations
>>   Bluetooth: hci_core: Add minimal context analysis annotations
>>   Bluetooth: ISO: lock same hdev as what is released
>>   Bluetooth: L2CAP: Add minimal context analysis annotations
>>   Bluetooth: enable context analysis
>>
>>  drivers/bluetooth/Makefile   |  2 ++
>>  net/bluetooth/Makefile       |  2 ++
>>  net/bluetooth/af_bluetooth=2Ec |  7 +++++--
>>  net/bluetooth/hci_core=2Ec     |  3 +++
>>  net/bluetooth/iso=2Ec          | 14 ++++++++------
>>  net/bluetooth/l2cap_sock=2Ec   |  1 +
>>  6 files changed, 21 insertions(+), 8 deletions(-)
>>
>> --
>> 2=2E54=2E0
>>
>>
>
>
