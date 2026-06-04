Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A063421F0F
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572143; cv=none; b=fomRrmMGagzkmE7wQWolzP2j1UOZRaf+qnCRmo9LxSzRW/xHH6A/0c7/IdQqS0lwmuw4wi0BEH1TEu5rUmHl+AehqwcK3zxwDunfWSIe24+hDHgdm9q/nY/65x7MrcRAacWmPLOsAuymdtEsuAzP3Nqc9HqrSG4pYNz9Q3UHzPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572143; c=relaxed/simple;
	bh=c+/RPS93PMLLyxLjwM6M2ZXc7WTpOfvYWi5OrILg8N4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijzcDb2pLALZpwTiCJkFGVUb25PRT7wtPJ9Cdv8aYUPPeWVlwS9mRPBBnN7VldiWgaPVA75HVXWjTMWV/rmKuZNrlsEIJri30LSDzx9dD9zzvik5NJERiM3JS47VghI/O8SbdfrcrKT4SzEi+GWaSeJFAJul/OYnW7R14EEXzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA0CD3EBA8;
	Thu,  4 Jun 2026 11:22:18 +0000 (UTC)
Message-ID: <b62bcc3b0d5ba09ed47c593078d66834bfae161e.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2] profiles/ranging: Read measured_freq_offset
 field-16 bit as per Core Spec
From: Bastien Nocera <hadess@hadess.net>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, 	quic_anubhavg@quicinc.com
Date: Thu, 04 Jun 2026 13:22:18 +0200
In-Reply-To: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
References: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF5CZk13hrzcZSjvMDzzkePC9tKj20z1ePKjOHnFerxFJvxIvIS6BH4sBpIFqAY+EcHbKf6cSZ64DHGlgufLsA0wtiHEabw1itcBO8Q3pGfW1QXnB7dpFzM50/ddS9MuJJwtSL00hYKmqohtZXgELWx5ltsNivEtuQoyG1aZYfrtuhmFsgfE/I6n2qtidfewDPSY4VRksLFguxgwCOGRG4NndXlexcKQ3UgaWECy6Xhjp+sRVi48wqC0UZ9MUDjEgt0nR9BX7c3mYipXS6MT3XWioaYGW7zK4lA6ODS30gBxacJ7AQUnMs4O5asnrRaUr2gHRq2oyvigiArLFM8WMxvCvxgpForPJz9YrAKoBo6vmg8fNKqnOywZn+jXyTxw2bNSLkuLl0VVJiUGI2yTggpM5u8ZeOjE52R9UTsfF0XVDC4P8NwxyHt+TWswpeDansnbQOVFarmiXcPMGqbsnGpHNW+6AqHbcLstrulL37webEci7XAJNTh7Irc0XgwKLBbd60mYZvXw3rnj39RlxS92uvuXU31Oej1couz8C8FwpIi2VQ3itU+xslD7+tBWCIwP0V8dOnMO5KUAI43mF3w5rQRt2udqvZHiVUY+sl4TMggUlWzG/t8nV81wc0coirzGqXVVzzzH0dT9XxnlkHNrptVbxwGOL4If7Fw4SuxvQ

On Thu, 2026-06-04 at 15:32 +0530, Prathibha Madugonde wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Could you please add a reference in the commit message to the part of
the Core spec that's relevant?

>=20
> Fix in V2:
> Fixed compilation issue.

This should appear under the "---", so that it doesn't get into the
commit message itself when the patch gets applied.

> ---
> =C2=A0profiles/ranging/rap_hci.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
> index 8e65e5ef8..febe23384 100644
> --- a/profiles/ranging/rap_hci.c
> +++ b/profiles/ranging/rap_hci.c
> @@ -601,7 +601,7 @@ static void parse_mode_zero_data(struct iovec
> *iov,
> =C2=A0				 struct cs_mode_zero_data
> *mode_data,
> =C2=A0				 uint8_t cs_role)
> =C2=A0{
> -	uint32_t freq_offset;
> +	uint16_t freq_offset;
> =C2=A0
> =C2=A0	if (iov->iov_len < 3) {
> =C2=A0		DBG("Mode 0: too short (<3)");
> @@ -614,7 +614,7 @@ static void parse_mode_zero_data(struct iovec
> *iov,
> =C2=A0	DBG("CS Step mode 0");
> =C2=A0
> =C2=A0	if (cs_role =3D=3D CS_INITIATOR && iov->iov_len >=3D 4) {
> -		util_iov_pull_le32(iov, &freq_offset);
> +		util_iov_pull_le16(iov, &freq_offset);
> =C2=A0		mode_data->init_measured_freq_offset =3D freq_offset;
> =C2=A0	}
> =C2=A0}
