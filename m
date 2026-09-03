Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068E4A8FDF
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440565; cv=none; b=V/bdnFTDXmvJkf20IOmgXkgL8LXT3pYcOkPscoP5kIfZBiOrcfjPZmBHQO8SjU4vum1DQ1Yd3kSKC1i7J7mvTkhrgGfm81hQG4tJpxwOMoJeNByP6zLVtDazlbYKf5Hop22U4ytKeyiqcVXbcgpy0/N6OtxUeHyUT9O5ek2r/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440565; c=relaxed/simple;
	bh=Ahw9+/yNKnwEW6WUF0mpMYeome17rOMqY6slSSgAHCg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHbo87M4qL1iz7SfsMUK6aq/QMN2KfKuU3Kwg1z98h7Zr9SHTaquB0GfuRjQYbsJHGgGDsZWdzEoXExZRxq9p/nZyUDI2AK87xfeIuMyBeb4Jh8k9j4yllNtsXXm0Isca3He/3PkB8pueDfLL4ivUMIE3DXcTK7tD2kQW+M2YgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AFF33ECE5;
	Thu,  3 Sep 2026 13:02:28 +0000 (UTC)
Message-ID: <7446da9c8c5bf3615a148d463f9b590fd32adbb7.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1 1/5] avrcp: Fix out-of-bounds parsing of
 ListPlayerAttributes response
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 03 Sep 2026 15:02:27 +0200
In-Reply-To: <20260901175315.1348621-1-luiz.dentz@gmail.com>
References: <20260901175315.1348621-1-luiz.dentz@gmail.com>
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
X-GND-Cause: dmFkZTGAm5iqiKMwaa1AdpV7XtWpeC++2tHucM8Nvzp57WkUD48Odri9s/DMYdGHKSQO/3SP3sONYaMvJ0CMj4+3sOiTDHXXdUnlIR958NHfjPRN5RPbEzxvuXHGj6qehX5upVAcPqDMdAkMAl/mGPpiApa53DE2hEcvXMGiA66rfybK4IogBYFngQFzLxjlXjw0Q8VfrlEzVVW7Vw4TaKAE8dSZk163iLncDycnG+EA9PFLhfjGGvcDlSiFBc4NaTstiFHB2lQLwdaEoi5qC5ErFnhPG5SG4lOoScIbSqclffyA9v9LGCApLND8VP2rULuKkaxRTzupfaLKYkYzBzRdqNiYOqJX8v/oh4TQ+T6W0HBVvVWgrh4XNmVK4xTB9R/ZDJdVctdyPNCS+PW/lCSlRd5ezUJvMFgZHXOzbfRFWuc9lGDihJ5l1TiUdmhTS67aUFSXOAazjaj+saMGlKAMn+Uea0Prl3zh+I4TIpfszvduPrxea+85PU3U2jhwl4IJWt7Qj4SZmPhoJtXNoJo/WE5nO0m7t1JoBTGH5EEo5JZVaOkpzkV+P/aBVJZI+0bPTra4W+SfxwMW6G3eVvLyXnoviNLIZKPcKypKP0zSkd0Vo8VLwwBzHl/9OQO45yYijWlAdpvdtuDdNYqOfRUZ9xc3nqRxq9ojzM3l1a5QnwaiVw
X-GND-State: clean
X-GND-Score: -100

On Tue, 2026-09-01 at 13:53 -0400, Luiz Augusto von Dentz wrote:
> From: Bastien Nocera <hadess@hadess.net>

The patch has substantially changed from the version I posted
privately, so you can remove my authorship.

> In profiles/audio/avrcp.c, avrcp_list_player_attributes_rsp() parsed
> the
> response using hand-computed offsets into the operands buffer,
> without
> accounting for the fact that operand_count spans the 7 byte AVRCP
> header
> as well as the parameters:
>=20
> - attrs is a 4 byte array which could be written out-of-bounds if a
> =C2=A0 length greater than 4 was declared in the first parameter byte.
>=20
> - The attribute bytes were read with a bound derived from
> operand_count,
> =C2=A0 so a truncated response could be read past its end. As the receive
> =C2=A0 buffer is reused across packets, those stale bytes could be echoed
> =C2=A0 back to the peer in the following GetCurrentPlayerValue request.
>=20
> - params_len was compared against count, which was only ever 0 at
> that
> =C2=A0 point, so the length of the PDU was in practice never validated.
>=20
> Parse the response through a struct iovec using the util_iov_pull_*
> helpers instead, so that the header and each subsequent field are
> bounds
> checked as they are consumed and the remaining length is tracked for
> us.
> This lets params_len be validated against the actual number of
> parameter
> bytes received. The attribute count is still clamped to
> AVRCP_ATTRIBUTE_LAST, which is what bounds the write into attrs.
>=20
> Reported-by: @ax-nnlabs
> Closes:
> https://github.com/bluez/bluez/security/advisories/GHSA-m2vx-pw5f-rc8v

It was embargoed, and it's now been made public.

> ---
> =C2=A0profiles/audio/avrcp.c | 32 +++++++++++++++++++++++++-------
> =C2=A01 file changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 3271b84782e8..906f93424872 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -2395,31 +2395,49 @@ static gboolean
> avrcp_list_player_attributes_rsp(struct avctp *conn,
> =C2=A0					uint8_t transaction, uint8_t
> *operands,
> =C2=A0					size_t operand_count, void
> *user_data)
> =C2=A0{
> +	struct iovec iov =3D { operands, operand_count };
> =C2=A0	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
> =C2=A0	struct avrcp *session =3D user_data;
> -	struct avrcp_header *pdu =3D (void *) operands;
> +	struct avrcp_header *pdu;
> =C2=A0	uint8_t len, count =3D 0;
> =C2=A0	int i;
> =C2=A0
> =C2=A0	if (code =3D=3D AVC_CTYPE_REJECTED || code =3D=3D
> AVC_CTYPE_NOT_IMPLEMENTED)
> =C2=A0		return FALSE;
> =C2=A0
> -	len =3D pdu->params[0];
> +	pdu =3D util_iov_pull_mem(&iov, sizeof(*pdu));
> +	if (!pdu) {
> +		error("Invalid AVRCP header");
> +		return FALSE;
> +	}
> =C2=A0
> -	if (be16_to_cpu(pdu->params_len) < count) {
> +	if (be16_to_cpu(pdu->params_len) !=3D iov.iov_len) {
> =C2=A0		error("Invalid parameters");
> =C2=A0		return FALSE;
> =C2=A0	}
> =C2=A0
> -	for (i =3D 0; len > 0; len--, i++) {
> +	if (!util_iov_pull_u8(&iov, &len))
> +		return FALSE;
> +
> +	len =3D MIN(len, AVRCP_ATTRIBUTE_LAST);
> +
> +	for (i =3D 0; i < len; i++) {
> +		uint8_t attr;
> +
> +		if (!util_iov_pull_u8(&iov, &attr))
> +			break;
> +
> =C2=A0		/* Don't query invalid attributes */
> -		if (pdu->params[i + 1] =3D=3D AVRCP_ATTRIBUTE_ILLEGAL ||
> -				pdu->params[i + 1] >
> AVRCP_ATTRIBUTE_LAST)
> +		if (attr =3D=3D AVRCP_ATTRIBUTE_ILLEGAL ||
> +					attr > AVRCP_ATTRIBUTE_LAST)
> =C2=A0			continue;
> =C2=A0
> -		attrs[count++] =3D pdu->params[i + 1];
> +		attrs[count++] =3D attr;
> =C2=A0	}
> =C2=A0
> +	if (!count)
> +		return FALSE;
> +
> =C2=A0	avrcp_get_current_player_value(session, attrs, count);
> =C2=A0
> =C2=A0	return FALSE;
