Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916A4BAA15
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445970; cv=none; b=e/VilNDRWbrXCmzqLOEyunz5fnJlGt73sY4dMhEPzFf5W+hTiNIcRi5zMufgE9ONRr83U/Q2oaHZ/32FXhzW9x4SAj49KZZ45SATyLEBP7Wc6Xp3WeIroS+0rfnUF9GDy3xHdXBy54EvUGCmRt0QU/l+envXZb1jWOuhDlGmzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445970; c=relaxed/simple;
	bh=778igekglPT3hmf40saRabqUOPQthPYPVwFHCyCCRR4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHSF1slA0YuIddMYTyRpG6F//0plAz4qQek+MSiMBD1l6M/oWzmRXnTdwAtYxuQtfyEi9o94m1C53tcgVdbd3CBJ0BGW5oG3piNJOtC/QP2wIltHDl7fFeTnfNUL8vxCp3M9ttGoCPLnooi1xFH6H8ig62y4TdRMR1oVMaX6mHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82A953F541;
	Thu,  3 Sep 2026 14:32:28 +0000 (UTC)
Message-ID: <623958ca416132264a96dbf207a3bf9e51658435.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1 1/5] avrcp: Fix out-of-bounds parsing of
 ListPlayerAttributes response
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 03 Sep 2026 16:32:27 +0200
In-Reply-To: <7446da9c8c5bf3615a148d463f9b590fd32adbb7.camel@hadess.net>
References: <20260901175315.1348621-1-luiz.dentz@gmail.com>
	 <7446da9c8c5bf3615a148d463f9b590fd32adbb7.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGm0qQvVveOxhZgySao49dpIcHgffMMKiiIeAyJaSxU/yhokAMe8rBA7oeMDbT0Xf2LPfPt6E+gw15bHmcU4fDNtW7DdICe0NitLbkxoJToQfA9uZhtywSGO2TRsUZ8UnlbCv08HFiqmEs9mOl/C7NxLAsagRgQGRfbEqd2TkXNW5/Y//LJIj0urV7zKgzPsjdzd5qcpMZaFKU1pKqwYrUHKgB8ymT+axlIx7e8u3xV9cOMqaBKHfi//47SDn96Bu/YVuMZwK73dwg+UQ4xyS8hLiOcgMPOeLoSyEJeCIsCIgvIMzkFfAWGnARhJ6VotAYvIzptEnQaNOQh0r4dLiKvtP+ONtQ1i7wrNSusynKlVBO6VxcMzhBEyEaFalSXJEOlqWNQc7Ss8Y5k5vWAfCSJ4gunxBzI593cUaczFHg4rIm9zvrYlJ3hBEPByVHeKUIJlZol+EYCbuCYhm7VVSzfiXFW9BYcblYcYgwWD856n8jVEUAj6SeOI4mLghGIv8oLxKxKvuyVZN2bFSr4jYzBr61o+cmeEGwRDkFv2kcuhk94rEQTyhTAR6M4JBpCipXTSxxrqvLktZ50h6joN9tSB1k4HZ/e/Yg4ZjYw8IyAocgmwVWmFtqg4tFuP0LzOUhnxve6C3DWN9wYFuIQnjdHH6G2uMvNaHY/SVwYFLVthA

On Thu, 2026-09-03 at 15:02 +0200, Bastien Nocera wrote:
> On Tue, 2026-09-01 at 13:53 -0400, Luiz Augusto von Dentz wrote:
> > From: Bastien Nocera <hadess@hadess.net>
>=20
> The patch has substantially changed from the version I posted
> privately, so you can remove my authorship.
>=20
> > In profiles/audio/avrcp.c, avrcp_list_player_attributes_rsp()
> > parsed
> > the
> > response using hand-computed offsets into the operands buffer,
> > without
> > accounting for the fact that operand_count spans the 7 byte AVRCP
> > header
> > as well as the parameters:
> >=20
> > - attrs is a 4 byte array which could be written out-of-bounds if a
> > =C2=A0 length greater than 4 was declared in the first parameter byte.
> >=20
> > - The attribute bytes were read with a bound derived from
> > operand_count,
> > =C2=A0 so a truncated response could be read past its end. As the
> > receive
> > =C2=A0 buffer is reused across packets, those stale bytes could be
> > echoed
> > =C2=A0 back to the peer in the following GetCurrentPlayerValue request.
> >=20
> > - params_len was compared against count, which was only ever 0 at
> > that
> > =C2=A0 point, so the length of the PDU was in practice never validated.
> >=20
> > Parse the response through a struct iovec using the util_iov_pull_*
> > helpers instead, so that the header and each subsequent field are
> > bounds
> > checked as they are consumed and the remaining length is tracked
> > for
> > us.
> > This lets params_len be validated against the actual number of
> > parameter
> > bytes received. The attribute count is still clamped to
> > AVRCP_ATTRIBUTE_LAST, which is what bounds the write into attrs.
> >=20
> > Reported-by: @ax-nnlabs
> > Closes:
> > https://github.com/bluez/bluez/security/advisories/GHSA-m2vx-pw5f-rc8v
>=20
> It was embargoed, and it's now been made public.

You can reference CVE-2026-85218 for this one, thanks!

>=20
> > ---
> > =C2=A0profiles/audio/avrcp.c | 32 +++++++++++++++++++++++++-------
> > =C2=A01 file changed, 25 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 3271b84782e8..906f93424872 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -2395,31 +2395,49 @@ static gboolean
> > avrcp_list_player_attributes_rsp(struct avctp *conn,
> > =C2=A0					uint8_t transaction,
> > uint8_t
> > *operands,
> > =C2=A0					size_t operand_count, void
> > *user_data)
> > =C2=A0{
> > +	struct iovec iov =3D { operands, operand_count };
> > =C2=A0	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
> > =C2=A0	struct avrcp *session =3D user_data;
> > -	struct avrcp_header *pdu =3D (void *) operands;
> > +	struct avrcp_header *pdu;
> > =C2=A0	uint8_t len, count =3D 0;
> > =C2=A0	int i;
> > =C2=A0
> > =C2=A0	if (code =3D=3D AVC_CTYPE_REJECTED || code =3D=3D
> > AVC_CTYPE_NOT_IMPLEMENTED)
> > =C2=A0		return FALSE;
> > =C2=A0
> > -	len =3D pdu->params[0];
> > +	pdu =3D util_iov_pull_mem(&iov, sizeof(*pdu));
> > +	if (!pdu) {
> > +		error("Invalid AVRCP header");
> > +		return FALSE;
> > +	}
> > =C2=A0
> > -	if (be16_to_cpu(pdu->params_len) < count) {
> > +	if (be16_to_cpu(pdu->params_len) !=3D iov.iov_len) {
> > =C2=A0		error("Invalid parameters");
> > =C2=A0		return FALSE;
> > =C2=A0	}
> > =C2=A0
> > -	for (i =3D 0; len > 0; len--, i++) {
> > +	if (!util_iov_pull_u8(&iov, &len))
> > +		return FALSE;
> > +
> > +	len =3D MIN(len, AVRCP_ATTRIBUTE_LAST);
> > +
> > +	for (i =3D 0; i < len; i++) {
> > +		uint8_t attr;
> > +
> > +		if (!util_iov_pull_u8(&iov, &attr))
> > +			break;
> > +
> > =C2=A0		/* Don't query invalid attributes */
> > -		if (pdu->params[i + 1] =3D=3D AVRCP_ATTRIBUTE_ILLEGAL
> > ||
> > -				pdu->params[i + 1] >
> > AVRCP_ATTRIBUTE_LAST)
> > +		if (attr =3D=3D AVRCP_ATTRIBUTE_ILLEGAL ||
> > +					attr >
> > AVRCP_ATTRIBUTE_LAST)
> > =C2=A0			continue;
> > =C2=A0
> > -		attrs[count++] =3D pdu->params[i + 1];
> > +		attrs[count++] =3D attr;
> > =C2=A0	}
> > =C2=A0
> > +	if (!count)
> > +		return FALSE;
> > +
> > =C2=A0	avrcp_get_current_player_value(session, attrs, count);
> > =C2=A0
> > =C2=A0	return FALSE;
