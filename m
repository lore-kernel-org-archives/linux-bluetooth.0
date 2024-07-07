Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DE7FF;
	Sun,  7 Jul 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720341947; cv=none; b=S25AeSOv8OauIcMdgCv5Or+kO3HGz7+dQ73URCijG2nXF1muIXxZkuzef9ETVG8EeRfQ0qw1kegvJrdpig2o79VjfCqLP2qMTDRsXjQqsUJX/l2x8OdhCK3aVcg1Mir3jSwkUiltrEnSNnnRnqK+KQWvb7NIpFjsH7xtciCDSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720341947; c=relaxed/simple;
	bh=CyTzhOxBQthFyGXcVW6Ge9YgHiZ1vJTkQ/bVRvaHHaM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jrsQeQy5Gwhxvz0KtXOhzKoCj3kvLAqlA8BPA/hdOWru40v30GkLbTKkPaTc3HX8vkaGcazBQejdiyee4TFzZf/jI44/nd5zm3hC0B1DnMSGIvW/9dgJMjiPWyi14EXexxdqr1o7zG995BNFUwKXn/s47a1LcYbTmEiqU4cs9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eadWUsw7; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eadWUsw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720341933; x=1720946733; i=markus.elfring@web.de;
	bh=CyTzhOxBQthFyGXcVW6Ge9YgHiZ1vJTkQ/bVRvaHHaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eadWUsw7y7YOwkSdVRTHKXyD4L8okP2qS7lgfnVcwRqQJqj/5AhEPv40d1DrLoEI
	 8tsnlWeBD5ZFS+osbWTWAfiBdl+ZB9v8fWBy4eSBuNhrdLlBFjp9uMY9vblggQyHI
	 g21LdhVc7fXc/3+JCqQjOR5tEhxGHU4/6pCQ1fflOLRiO9l4xvcEtq4kmQckAutUi
	 sbrvTtTp59d4Rex/AtR2d37kWxLuCGsqd4Aq4NQI0UXW8kOKLVsiVBGkbmRINaXYa
	 VGEtjU+eFNe+7JpA5xwDXxeUaI8D0XCKN9FQMF06Tlp9lskNWxgnif2nZeQTTBzRW
	 uj7mZ5RWraVrH2VG3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1rvQUg1It1-00opnh; Sun, 07
 Jul 2024 10:45:33 +0200
Message-ID: <8b24a50c-ac43-473c-80fd-185ee806b5f2@web.de>
Date: Sun, 7 Jul 2024 10:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sungwoo Kim <iam@sung-woo.kim>, linux-bluetooth@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Dave (Jing) Tian"
 <daveti@purdue.edu>, Hui Peng <benquike@gmail.com>
References: <20240706225124.1247944-1-iam@sung-woo.kim>
Subject: Re: [PATCH v2] Bluetooth: hci: fix null-ptr-deref in
 hci_read_supported_codecs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240706225124.1247944-1-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/OKP/kB0LAmfffMhCRcvGRVdMSFXzQ52i23cPJFJn+XAfU8SzJ8
 2ZQaoCXiwmgGvtPLdY8g9kjL0wtTM5p5vVWgQjHowNmiMBxV4XXRwSdSB3ItarIwegOIClF
 tSJ8/ZuE1NFmIgvRci5VsTFBmg//V5xGGD647yWw5podxTw9EibUb/c4dXfcLrT+439aXnN
 w8HGMS3QisHS+e64VKb1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y1clwikdP70=;PQCF2KiXkStkpGaj/vHKAOZ8oxb
 EtmBOfhTXhbbHKNq9PgRY2vuf5J1kVWwi27/Q1PEPTQ002LOE6CZojUnKsX/alLXEatk85jr0
 YkZLdH+ScdyOK02eSf2rxeFjEhQERrlrWZN20BZsIKGGrDB5sYVc5JhMDuZn9jMykhEwJ7JQR
 hv9+52J7bcOB4Ryg2DCM7OWFRbgiuTLvcgx0p18hy/gAbnj7k6Dp7dnlNwhIul9esvexU0lPP
 oXrn+XHC7qny3pg/l7MIYIQlqC7vqRotMwh326qHyZHtrGj604VnfoN4KaPIW7lv/NoQcIMIS
 X6Yo/SGWv+a8sYnIe7hGZo3p5iYozUEnYVNyrf4KxLUYY8u44xd9SAoAJblR66+YpO1bnzZ1b
 8RqfbpKga5M8AJBOA2WcmWyr+G3vmu1q9J3TIrQXwJHtbuWLLN8Jv1mpH7EZYnyaVBGb6Ibmf
 dYSFhhMPg19s6rODTpY1cDKrUwLcPTFyElFXoPKZF5HyHHPRhjq4bPgQ3qcHZyfUHaAwJUopC
 rKwsRPQbC7DhpCebjkG7Y4ulVAT2TPvOz7Xd8U9737UW1aN1S9k2xxN+AL/QKvEOySVMx227c
 L+zb58hqQ3+gNZG9aVMr4b9KTAb/NrpkHv6f8E8i7ge8wjWKzTPYo2IkVUi121KqWaX1oSsHU
 CTwktJRXnaGjG7PU6gwwIUAoCIH1LSYzuyyOtlDgH/F+s9K2GTUpa5g4fRdkq+U4k6en0QLvx
 HmnLIpxL/WRTatA+RC1Plzb4uQOBuIGizM/w/p+q6ka4WonDHSDWiA1Lrjetuu2FGY96U+EiS
 oZ85y7gzoE6+EF2yfNC2+PnDFkNaj+HHcH2fPxxO5n9HY=

Please put email addresses for recipients not only into the message field =
=E2=80=9CCc=E2=80=9D.


=E2=80=A6
> Fix __hci_cmd_sync_sk() to not return NULL.
>
> KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
=E2=80=A6

How do you think about to use a summary phrase like
=E2=80=9CPrevent null pointer dereference in hci_read_supported_codecs()=
=E2=80=9D?


=E2=80=A6
> Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVE=
RY")
=E2=80=A6

Would you like to add a =E2=80=9Cstable tag=E2=80=9D accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.10-rc6#n34

Regards,
Markus
