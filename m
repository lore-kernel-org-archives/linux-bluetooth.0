Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF641DED5B
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780941; cv=none; b=PdyViGc9C4YRCyae9K9utd4B2mGewMMS/CTU+qcsvVaZYA4TbbOeT6C8wXJznk/wK6fVvBkYTgBw48YdXW5uWEtvOecQr3CiX7xoT3LVekVepNXim/J6etGkCg7bzelcVbvx+NDOUABxB3WIYPpbNc/m/xLufjWVeMm0D7xWWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780941; c=relaxed/simple;
	bh=LTHb57yoHRKF+h0yw2tNtWvlCWWboZn8CmQEg3rameM=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=NozeSEGHjC1NT0pMbqsG09vy4GXa4Bv83b609mrQ662wlGRiEDoH6APlQ+0hy4UWbgl6WE+f8cdjqohUIg2G+eXp/eW84XOk2bBEe7LUkTJrr0YdNDOvLuVLdrKw+7yKyAANDIC+/GSIqbu9I5276c75SCbWjWQkKOmbtJOSyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=q4YL5ZNS; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="q4YL5ZNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777780927; x=1778040127;
	bh=LTHb57yoHRKF+h0yw2tNtWvlCWWboZn8CmQEg3rameM=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=q4YL5ZNSoVeSprz2sn38a/uteoHAmBh8wlrWcQnEL/wamKG70xl5GQ14pFXwh4BYs
	 kLzECFPXwTR8mhJjy7ME4Fridc2AHiXdCWhBq01ug7BXEfC4a5tgawKt015VBo1QJT
	 mO8q674oYCoLM8OOIafIdMNRzltw+Ser1NIr+D9uWsmx3qUsE4fahcSyZB1ycpdeLL
	 ISho82p/e2q+wFRVyRRmkXUDgKXgtZ5WwdcLyCEM0dXY8iSN1koBXg2TI2HHfiq1pQ
	 wBNA66Thj07xa+HMv1NfAWYi69ahwwd6mnqlAOO3Vtg+UjARzKqNl+9/rY5hSzyhp5
	 KJo9jC7K4s0tg==
Date: Sun, 03 May 2026 04:02:04 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: admin <admin@fluentlogic.org>
Subject: =?utf-8?Q?Security:_sdp=5Fextract=5Fseqtype()_signed/unsigned_confusion_=E2=86=92_OOB_heap_read_(no_pairing_required,_8.1H)?=
Message-ID: <1CgzIVM-hFrHkvg_LOpx2mOjsirOpT0E2HBGPNmSW7ZfluNKQ0ES74B8GlpwWhq4ZtZCyEg4pqjlphoUk38a-0OP-xK3lEhaF5i_07XzMDw=@fluentlogic.org>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: 1b7fa15d840049209acd7e7e0d6a58b0a545b9ad
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=C2=A0 To: linux-bluetooth@vger.kernel.org =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 Subject: Security: sdp_extract_seqtype() signed/unsigned confusion =
=E2=86=92 OOB heap read (no pairing required, 8.1H)

=C2=A0 Hi Marcel, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0

=C2=A0 Reporting a vulnerability in BlueZ lib/sdp.c. =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0

=C2=A0 File: lib/sdp.c:1262 =E2=80=94 sdp_extract_seqtype() =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
=C2=A0 CVSS: 8.1H (AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:H)

=C2=A0 SDP_SEQ32 stores a uint32_t data length into a signed int* with no o=
verflow check. Value 0x80000000 becomes INT_MIN. Downstream at extract_seq(=
) =C2=A0 =C2=A0 =C2=A0 =C2=A0
=C2=A0 (sdp.c:1392) and sdp_extract_pdu() (sdp-client.c:174) that signed va=
lue is used as a length/offset =E2=86=92 OOB heap read. =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0

=C2=A0 Trigger: Crafted SDP response from a malicious Bluetooth device. No =
pairing required. Bluetooth adjacency (~10m), passive service discovery pat=
h. =C2=A0 =C2=A0 =C2=A0

=C2=A0 Fix: Use uint32_t throughout the SDP sequence extraction chain, or a=
dd explicit overflow check before assigning to int*. =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0

=C2=A0 Please let me know if you need a PoC.

Martin Brodeur Ottawa Canada
