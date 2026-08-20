Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FE3246EC
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211999; cv=none; b=Gt/RKQ2kAPo0t0uc6hi/gODATYZ+/u/ltjPHcoeUkcDQW5n0/aDN83VPFoAjvI5kNGw2P5iDT1S5ldNrNsQP99UV4R+qZZNnoZcZQO8s6KCogfYTmSYeDw7nSVvQ17IDx3M76+NZuE8N4MwtuQmW4C64elBJ/qDhVu9lUr4o/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211999; c=relaxed/simple;
	bh=tIVfQ1grGkY0lRStJrzzHWdRi8rM7chJOTl9BoFTlpw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEqcX66g9Avaa+taAsMa2+3mpXjUhOo/5kf6z1bnSwWYK3AsVe+HU1WY/EHfRNDRY51MP/4+srzYYw3IQXmkWRLgPb9lP3XH7OinGiZOcWlltepmnmqLICD2NlgIs/lCEotFTRoy4f3WKFz6O9CMhfSs3VJiuR6oA7o4moqstdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF59F3ED38;
	Thu, 20 Aug 2026 07:46:34 +0000 (UTC)
Message-ID: <9ae70f091f093a644bec0f6ebc030e36a1f7a853.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1 1/8] eir: Fix stack buffer overflow when
 parsing the remote name
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 20 Aug 2026 09:46:34 +0200
In-Reply-To: <20260819204008.2292225-2-luiz.dentz@gmail.com>
References: <20260819204008.2292225-1-luiz.dentz@gmail.com>
	 <20260819204008.2292225-2-luiz.dentz@gmail.com>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTGL6Gba5xPbHrUqI7Q8/XafXuQl2nUn9bnc6EY3GdRP3KE4kyjTMnplLyRhNtSRNR1G7lhKB3EpriEdwHM08xRPcMmc/aXmCR0e9uW7cwbFY8zIujz38/Pp55WzfBHmRimgsLaqs6eA8A9G+KgDGbeTxkCf82Ydn8F6VpC5J0YtKUjvr6/5Jk6JSz9Jxk/AqWb8imYKNmOXRd0dBhp/6sFfLp8DKPRk1GOGjAoLP07+p6+vxmxhzchDn42at674VQdKPMp8e9GAVQw9jDin3qZGbGMxZ/9iUGPrzsyt4qzLchVMZKdou8GtVNlX8zqchTD8DK1ZQTpq35cE4pI/MnHhGoJsXeqc6TsEDm5LToLkYRsJeb+V9C8AJ4Hwl8awzj4ebV2dzDyhREM/lCLos/YujC8Fx3ka40dhaAvyp4PqRqsa5Fw0EZFDx+gLD6VmKsz4AiJGhtpp7wAlpdG4TLbKNUbpvvx+uWCTucqOg8bBo003KwQp74InUcCfZPbyeUiuVn71UxAg9GIIOrYRkYr4Ynb08ECr8PL5KFWtBTZcqBjuxqf4Pth+L3XEjKXCGBxahlR2J6AUBNqD4hBIAJn/cy8pm4as8zQy8W3h+XEm88rECDn8AnS0+uSUvuAGniyurQEw2DCi+eamulAo/g2dZ5A2nwMK1NWTW4RGrfmmuw
X-GND-State: clean

On Wed, 2026-08-19 at 16:40 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> name2utf8() copies len bytes into a HCI_MAX_NAME_LENGTH + 2, so 250,
> byte stack buffer without clamping len first.
>=20
> eir_parse() only rejects a field once it runs past the end of the EIR
> data, and that data is up to 255 bytes, so field_len can be 254 and
> the
> data_len passed to name2utf8() can reach 253. strncpy() then writes
> 253
> bytes into the 250 byte buffer and leaves it unterminated, so the
> following g_strstrip() and g_strdup() also read past the end.
>=20
> The EIR data comes from a remote device, either in an extended
> inquiry
> response or in an advertising report, so the length is attacker
> controlled.
>=20
> Clamp len like the other name2utf8() copies already do. Parsing a 253
> byte EIR_NAME_COMPLETE field returned a 253 byte name before this
> change, and returns a 249 byte one after it.

This issue was embargoed, and this commit is the exact same one I sent
privately to fix that issue.

It would be nice to have either the authored-by or co-authored by tag.
Could you please also make sure to add:
"
Reported-by: @sprabhav7 (Prabhav S)

See:
https://github.com/bluez/bluez/security/advisories/GHSA-68h6-5qgp-3975
"

To the commit message. I'll work on the security advisory to get it
published.

Cheers

>=20
> Assisted-by: Claude:claude-opus-5
> ---
> =C2=A0src/eir.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/src/eir.c b/src/eir.c
> index 89c15995a546..95351d015323 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -137,6 +137,8 @@ static char *name2utf8(const uint8_t *name,
> uint8_t len)
> =C2=A0{
> =C2=A0	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> =C2=A0
> +	len =3D MIN(len, sizeof(utf8_name) - 1);
> +
> =C2=A0	memset(utf8_name, 0, sizeof(utf8_name));
> =C2=A0	strncpy(utf8_name, (char *) name, len);
> =C2=A0	strtoutf8(utf8_name, len);
