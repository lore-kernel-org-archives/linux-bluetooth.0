Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFC231A3B
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574246; cv=pass; b=k6LKJLby8B2cI/OlEN/oCluiA1seKKhMvj5AUDHEC2/xIyMaXbtztdMcGDpHBC3NzFLVxqxnqeNRHSyKxLl6LtVJRV7YO4JuAlTGYf15/hhDf+o0V+UBD7jozOt2kmda9J+ODvnPcIEewEeAQ8VfFQpiG7+H+31lMAQtrrhKqgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574246; c=relaxed/simple;
	bh=OA/IQfIHVZX8mp5DLLn2skk1qa8fi110PDwQ8uSe5aM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3Ye6vHYpbjCFoJBUO7M9ISpubseUEVjyquSCNxplOavEZpv1YfhwCyEgmsVMngtGt98FreOR9ti0RLbJHGLDLrTp/MJKLSt7jfiGc/2Y1CQuybPCeuuuN3nbpIHLfkCHEgckPvBTZvfS8k9GffLOp61hfv4D2lLU0a3WWfkUl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=XY0O1Tlr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="XY0O1Tlr"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:5:f011::a05d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hBxMf1x1Pz4BKFl;
	Sat, 01 Aug 2026 11:45:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1785573902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fxn5jmUfhp9OsJE5wEp23LDGyzYHlkGrFuHlwvwU3Jo=;
	b=XY0O1Tlr7Oy2eHoYZ1D4HQeoRXiSRHstR/g1OliybhYgjxkmg88u7r2wmy5oa1yiPIOm1I
	G49In7EB0FM+h+pmPv0kcQb3uQZixob3FV3k19GwORkIxbxPOtArv8aF4sqkWotVUuJUt/
	VRNsyOlPLRHdYWrf0DGF9K9gS5e83NJZ8407gqs+7ghee/7IsGpPpHdcF73erEW7YgMU+v
	RgUjuKqGCBqz4Ks1Hnmad5kwpjVNB9XbNv2G+Og27RZFPQT5LD+knCfXu0dXF+4HOuXygP
	9DQmc7lHAQcPAkjS7u1fjt0rVgFkZL6ZM2IyPYUWZrwar2vU/1i1oBE1LzDeHA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1785573902;
	b=hM7pa1/Vckn0rmts+BIMsv+//5P+VvDxrtsyQ6zspwJggwxtLhhJTNHkoUtxOiHalODU+b
	t+8R20aBGRTXoPGYVex3sUW6litG9Xw/ZXZt1kyb/6cRbQ1MT7zBP2aczZWpHMhjRmUAlW
	p8SHZRxRD8DfM7R+slk+4SbexR5Fj84cy4mOzw0MWKxcFesbNCyiJZBMuMoFT9fwmVctCf
	rXUYSBYea+cDVtop4koHbdg6CJ5Xm8VEHOJbpFqLFecJQdOR0ZlJ403F7VT9E74aeQ9wxh
	J6HOfO3uNdpXcV4PxghIFNGjrY9nJtVqpppUhgw178LSwL7upvlXRKgTSWjM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1785573902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fxn5jmUfhp9OsJE5wEp23LDGyzYHlkGrFuHlwvwU3Jo=;
	b=jqbJ78+V/EFosFh8hEjdBflha0WKhQPHWyB/gKQAVGD8FZA8HFWqlXVeW0K7gFjPd3zBif
	gjHYkyf4ymTJ8H0yyxvsGKsWF+TRyqkyf4FJUfPoix5qilpzRm/FSat9TcEpSeWdEhMQQb
	btu20wqohjb9xbcDSMxf/OPpLkYu+PsB43codyJUMkaofUx2zB4oXpaCmRNH+E+vf1n7kZ
	g5UcF+arI6TH+xMOAjPcy0EWyjN42BEWbs14dK3E+DIFAnHuWytrpqVDLAYhR+CFH4uC6w
	XE/rhwj/1oDF4ztql+sJC6HttX8+TgVDCv++Km98HAAZ8J/HkJENwtGIH3h53Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <b108ce022c439d3a5a7453fc5c33952c0029daaf.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_sync: add conditional locking annotations
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 01 Aug 2026 11:45:00 +0300
In-Reply-To: <20260731221840.GA4066390@ax162>
References: 
	<528c354dca68f05cfd17df7c80f8b04419c0fb74.1784973709.git.pav@iki.fi>
	 <20260731221840.GA4066390@ax162>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

pe, 2026-07-31 kello 15:18 -0700, Nathan Chancellor kirjoitti:
> On Sat, Jul 25, 2026 at 01:02:36PM +0300, Pauli Virtanen wrote:
> > Add context analysis annotations to functions doing conditional locking=
,
> > to suppress analysis warnings.
> >=20
> > Fixes: a3ad01d51d4b ("Bluetooth: hci_sync: Fix advertising data UAFs")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
>=20
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
>=20
> It would be nice if this could be applied, as this breaks recent clang
> builds due to context analysis being on by default and -Werror enabled
> by default with many configurations now:
>=20
>   https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs=
/30660246388

Do you think the Clang build can be enabled on Bluez testbot?

My plan for this was:

- Copy https://github.com/pv/bluez-ci-image under github.com/bluez

- Replace "ghcr.io/pv/bluez-ci-image:latest"=C2=A0
  -> "ghcr.io/bluez/bluez-ci-image:latest"

- It should rebuild the image via github actions (may need push=C2=A0
  a commit / rerun the action after copy), which uploads it to
  https://github.com/orgs/bluez/packages

- Adjust the image address in https://github.com/bluez/action-ci/pull/7
  to ghcr.io/bluez/bluez-ci-image:latest and merge the change

- If there is some issue, the testbot can be rolled back by reverting
  back to "FROM blueztestbot/bluez-build:latest"

Later, the image can be updated by just pushing commits to the bluez-
ci-image repository, easier than current process.

>=20
> > ---
> >  net/bluetooth/hci_sync.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index d5554fbf3129..f5545f270f09 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -1255,6 +1255,7 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev,=
 u8 instance,
> >  }
> > =20
> >  static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance=
)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> >  		    HCI_MAX_EXT_AD_LENGTH);
> > @@ -1343,6 +1344,7 @@ int hci_update_adv_data_sync(struct hci_dev *hdev=
, u8 instance)
> >  }
> > =20
> >  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	struct hci_cp_le_set_ext_adv_params cp;
> >  	struct hci_rp_le_set_ext_adv_params rp;
> > @@ -1499,6 +1501,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_de=
v *hdev, u8 instance)
> >  }
> > =20
> >  static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 ins=
tance)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length=
,
> >  		    HCI_MAX_EXT_AD_LENGTH);
> > @@ -1552,6 +1555,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct =
hci_dev *hdev, u8 instance)
> >  }
> > =20
> >  static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 insta=
nce)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	struct hci_cp_le_set_scan_rsp_data cp;
> >  	u8 len;
> > @@ -1693,6 +1697,7 @@ static int hci_set_per_adv_params_sync(struct hci=
_dev *hdev, u8 instance,
> >  }
> > =20
> >  static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance=
)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
> >  		    HCI_MAX_PER_AD_LENGTH);
> > --=20
> > 2.55.0
> >=20

--=20
Pauli Virtanen
