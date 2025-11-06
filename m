Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FF2BE7A6
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470719; cv=none; b=QdCZlvJkbriCZWDif0+81ahUjD35HqmQ2bLYTtwFec6T36Low797tdo3W8LUE5q/7r8GqbTu+V08s//OGnWdVc9ywX+SWq68KvZilDHKRMZzJsZN2UOvVIATGFO4LLmaxUFaDnnUCl/f6yj9msvAcgvcX6YbNxq08pAFOTFVuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470719; c=relaxed/simple;
	bh=okqsxFDghO7DgdXs1eClq8hRLx33SMYBPoXVb6SAdF8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EeZWaSZN5eYOKcelN+zXe70LBKTipVvPfrK5pHYG3AsVty1G20TzuHStM9Ix+8A7ayF6NwZ/EBkLW9p1/71fYdG8SwXyBAiRFb78jmCovDiLT0hMJJdnR5O+PF41e6GjV22Pk9qOSj4qsDXA8OBCqVQIxsBMYCuU7vJWkHJ/xpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA73541DDA;
	Thu,  6 Nov 2025 23:11:48 +0000 (UTC)
Message-ID: <4db3ceb11991630d7622551dc789d8c317be079a.camel@hadess.net>
Subject: Re: [PATCH BlueZ] github/issue_template: Add basic issue template
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Fri, 07 Nov 2025 00:11:48 +0100
In-Reply-To: <4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
References: 
	<4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeektdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepphgrvhesihhkihdrfhhipdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

Hey Pauli,

On Thu, 2025-11-06 at 19:44 +0200, Pauli Virtanen wrote:
> Add issue template that instructs to use btmon and indicate software
> versions.

Could you please share a screenshot of what this looks like?

Cheers

> ---
> =C2=A0.github/ISSUE_TEMPLATE/issue.md | 41
> +++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 41 insertions(+)
> =C2=A0create mode 100644 .github/ISSUE_TEMPLATE/issue.md
>=20
> diff --git a/.github/ISSUE_TEMPLATE/issue.md
> b/.github/ISSUE_TEMPLATE/issue.md
> new file mode 100644
> index 000000000..ba384e120
> --- /dev/null
> +++ b/.github/ISSUE_TEMPLATE/issue.md
> @@ -0,0 +1,41 @@
> +---
> +name: New issue
> +about: 'Report a bug or other problem'
> +title: ''
> +labels: ''
> +assignees: ''
> +
> +---
> +
> +### Description
> +
> +<!-- A clear and concise description of what the bug is -->
> +
> +<!-- A clear and concise description of what you expected to happen
> -->
> +
> +<!-- Include any other relevant details -->
> +
> +### To reproduce
> +<!-- Steps to reproduce the issue, if possible -->
> +1.
> +2.
> +3.
> +4.
> +
> +### Logs
> +- btmon log: <!-- Bluetooth traffic dump: (usually needed)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0. Power off connected device
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Run: btmon -w btmon.log
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Connect device, reproduce the issue
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. Ctrl-C btmon
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4. Attach btmon.log to the issue -->
> +- bluetoothd log: <!-- Run: journalctl -u bluetooth --boot 0 >
> bluetoothd.log; if relevant for issue -->
> +
> +<!-- Any other logs etc. relevant for the issue -->
> +
> +### Versions
> +- BlueZ version:=C2=A0 <!-- Run: bluetoothctl --version -->
> +- Kernel version:=C2=A0 <!-- Run: uname -r -->
> +- Problematic device: <!-- Device model etc information, if relevant
> -->
> +
> +<!-- Any other relevant information on platform / hardware here -->
