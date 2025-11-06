Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32D301477
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471314; cv=pass; b=n1SeKPpEP9w40b006BUPX4C9+VEms8EMWTp0O1B67pxRMw2u1bTZwhtXjxB1Y4K/wfGQI1epkjYHtOkm1YlSFgXRFImbMEcip8//CEMyhoH3+Avc8U4JCmN6K4S6Gok1uCpdkvue/YDK5mBkncp4yP0QeBDJmb19shzhLB9kZjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471314; c=relaxed/simple;
	bh=7Ip+canK/OMp5ENq14OucRm32cqUtfLCzrTrvj/I8wY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOqvWn8g/iUvmgYyVYcjhACWIjCg6AgvLQDmFtgiwIwYpnw/ockU6ZsKb5w+Wcu/+J4M1IN5WZBMvHPKuiV2eiDi+rfQBFnTgvQ0x2fM6ebK0c4dulmE7BQhCm7xGkI6pibwruOt9RrlEFkRegChU06CurW3I3LAq/U+AkYx2V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=oUooEEqm; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="oUooEEqm"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d2dVq65Zjz49PwY;
	Fri,  7 Nov 2025 01:21:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1762471300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ip+canK/OMp5ENq14OucRm32cqUtfLCzrTrvj/I8wY=;
	b=oUooEEqmUUkDaMkz77AKNx3bJBrtuhdwDhlY2sMh0i6KFNPkGPPVdcXk+p0NhLWjJQ71IS
	JE6VDIHkeBavWD8XTdud8AbpEOnfVmKQ8loYHJawanRQL1x4a0iJc5bq6LBM2/B8vaRbRj
	qcfSzFt7AWmvXBDMpGhiu68cS8oFinN1Q9DoW+RQ0WfAgIn6ZkZ9xTyvxBEO5ln9QHmcJn
	EklQuPWzIMtEnjU8GjY3atm9bH+keT7mtjaHeu+knDp35oB/A+ZE/YpFaaj6YoMGVR+jsP
	+ZzpwbS2Xo+U/zqq7xNX6E3sX17Gqe++0ZDGhViCJC1HeIOdENTzALrnPD7EAw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1762471300; a=rsa-sha256;
	cv=none;
	b=c6ZdEvuCOmAOniqfVAoS33H7vTdvnyBK9c8JBi4c0wLCKWvFe+bjGt8NH8EfPAZ/m1YVIw
	SsjlnMKPxcKldgtM0pmUnMl7eOq2Br3FM1krap/IhwbCnHnnujNLCp0kIFOi/Yed3fEBhg
	f4/xnpjEoBIkCwpM+r6MGEVJ8BASx037QJwQVtcP+dYQmIrdADKCPcA9zhmhyh2G7KB+dM
	kT66lFQ4EnxV3ozMHqKBMfutozNnTjiOZ4uJefNRhLI7cI6a47AZXB9F5d5tnbwIcGlqck
	KSUx2CLoun69bFUInMHWQaZUKymqpsn/bf3M9vPl38n7aj6cbNDSf8vu4uVOug==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1762471300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ip+canK/OMp5ENq14OucRm32cqUtfLCzrTrvj/I8wY=;
	b=TlS0yrZWsxRhVxmtFC3KbtPL/BTwcauwrr/b9brhMFAOL9LwGC3D3spGva8O0XMb8kwMKz
	IFlOFPUwRDHIKJU+5C1cGeDkQlArQV444AYagwoKYGtHsMiF/Kqo5lXtt0PlUZ1Sbh6SEM
	6afxqz3V0wiYLXxQ0WP7+FCncvrjBrjwBlzKpojogBzfqowy8BIbtkt+CdQsroKm2O7MpI
	OK3463oYkZhgCKnYyOstuHkaf+dpH1HCYvA0ePCtBDkaDR1ta3lJfwd+NTTL+8z4W+UgvK
	ISMPkWvXktMYSnOJhCD/luQ4nZE/AVrEOmIElrb0UOQZz8ML5Chz7OGGgMxJGg==
Message-ID: <2651e38dd7c26f9447eb27b665caf1b6c8e0e3cf.camel@iki.fi>
Subject: Re: [PATCH BlueZ] github/issue_template: Add basic issue template
From: Pauli Virtanen <pav@iki.fi>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Fri, 07 Nov 2025 01:21:38 +0200
In-Reply-To: <4db3ceb11991630d7622551dc789d8c317be079a.camel@hadess.net>
References: 
	<4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
	 <4db3ceb11991630d7622551dc789d8c317be079a.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2025-11-07 kello 00:11 +0100, Bastien Nocera kirjoitti:
> Hey Pauli,
>=20
> On Thu, 2025-11-06 at 19:44 +0200, Pauli Virtanen wrote:
> > Add issue template that instructs to use btmon and indicate software
> > versions.
>=20
> Could you please share a screenshot of what this looks like?

Here you go: https://github.com/pv/bluez/issues/1

>=20
> Cheers
>=20
> > ---
> > =C2=A0.github/ISSUE_TEMPLATE/issue.md | 41
> > +++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 41 insertions(+)
> > =C2=A0create mode 100644 .github/ISSUE_TEMPLATE/issue.md
> >=20
> > diff --git a/.github/ISSUE_TEMPLATE/issue.md
> > b/.github/ISSUE_TEMPLATE/issue.md
> > new file mode 100644
> > index 000000000..ba384e120
> > --- /dev/null
> > +++ b/.github/ISSUE_TEMPLATE/issue.md
> > @@ -0,0 +1,41 @@
> > +---
> > +name: New issue
> > +about: 'Report a bug or other problem'
> > +title: ''
> > +labels: ''
> > +assignees: ''
> > +
> > +---
> > +
> > +### Description
> > +
> > +<!-- A clear and concise description of what the bug is -->
> > +
> > +<!-- A clear and concise description of what you expected to happen
> > -->
> > +
> > +<!-- Include any other relevant details -->
> > +
> > +### To reproduce
> > +<!-- Steps to reproduce the issue, if possible -->
> > +1.
> > +2.
> > +3.
> > +4.
> > +
> > +### Logs
> > +- btmon log: <!-- Bluetooth traffic dump: (usually needed)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0. Power off connected device
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Run: btmon -w btmon.log
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Connect device, reproduce the issue
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. Ctrl-C btmon
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. Attach btmon.log to the issue -->
> > +- bluetoothd log: <!-- Run: journalctl -u bluetooth --boot 0 >
> > bluetoothd.log; if relevant for issue -->
> > +
> > +<!-- Any other logs etc. relevant for the issue -->
> > +
> > +### Versions
> > +- BlueZ version:=C2=A0 <!-- Run: bluetoothctl --version -->
> > +- Kernel version:=C2=A0 <!-- Run: uname -r -->
> > +- Problematic device: <!-- Device model etc information, if relevant
> > -->
> > +
> > +<!-- Any other relevant information on platform / hardware here -->

--=20
Pauli Virtanen
