Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9996E3AE6F2;
	Wed, 21 Jan 2026 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769023311; cv=none; b=HlEKQk/Z2P8T9JwbWwx1iFQFb+nridnXBFwhGDNVIrXaL0UuQDoI+e0+Yld3oR9xV8O83kvbGk4sZKCedZoNjWRsFvtI7Yvh4iHjTQ6oiokYw2TGgbnyctqOxzyR+j8e7HXMHy4qF/ftiers/k1Co5WU6wiuquiXf7z1BKihVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769023311; c=relaxed/simple;
	bh=TGlWGqADJDsNYt8k6Oof5l64iMrhOpuXIRF9api7r5U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i3UA9kqQ3lQAPtbItr8YbB6EXsMgZ9ZS62f0Nk13Rf4U/C8urmN8vJ8I8ip3gqt2P9iStL8B6diCXH5W0JsXK+PRP3OeHt46PS0AhAGbxG2LWYAF7cSj+v3K+8lG3QEGVeSrgoYr1uWNou9iaVWLGuKMdgguhV/IX0L4j0AldFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f357.dip0.t-ipconnect.de [79.249.243.87])
	by mail.holtmann.org (Postfix) with ESMTPSA id 27A37CECCB;
	Wed, 21 Jan 2026 20:21:46 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [RESEND PATCH v2 00/11] Bluetooth: btnxpuart: Add secure
 interface support for NXP chipsets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <AS4PR04MB9692855E531E082BC431FD02E78FA@AS4PR04MB9692.eurprd04.prod.outlook.com>
Date: Wed, 21 Jan 2026 20:21:35 +0100
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>,
 Dmitrii Lebed <dmitrii.lebed@nxp.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ethan Lo <ethan.lo@nxp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3878D710-FBE3-448C-8830-138355D8D601@holtmann.org>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
 <CABBYNZ+crY9eDfy6=cz8FwbUqFbjWjqjiVTHanw2J-7QB-Wh_g@mail.gmail.com>
 <AS4PR04MB9692855E531E082BC431FD02E78FA@AS4PR04MB9692.eurprd04.prod.outlook.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hi Neeraj,

>>> This patch series adds secure interface support for NXP Bluetooth
>>> chipsets to protect against UART-based attacks on Bluetooth security =
keys.
>>>=20
>>> Problem Statement:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Bluetooth UART drivers are vulnerable to physical attacks where
>>> adversaries can monitor UART TX/RX lines to extract sensitive =
cryptographic
>> material.
>>> As demonstrated in research [1], attackers can capture H4 packets
>>> containing Link Keys, LTKs, and other pairing data transmitted in
>>> plaintext over UART.
>>>=20
>>> Once an attacker obtains these keys from UART traffic, they can:
>>> - Decrypt all Bluetooth communication for paired devices
>>> - Impersonate trusted devices
>>> - Perform man-in-the-middle attacks
>>>=20
>>> This vulnerability affects any Bluetooth implementation using UART
>>> transport, making physical access to UART lines equivalent to
>>> compromising all paired device security.
>>>=20
>>> Solution:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> Implement a TLS 1.3-inspired secure interface that:
>>> - Authenticates the chipset using ECDSA signature verification
>>> - Establishes shared encryption keys via ECDH key exchange
>>> - Encrypts sensitive HCI commands (Link Key Reply, LTK Reply, etc.) =
using
>>>  AES-GCM
>>> - Decrypts encrypted vendor events from the chipset
>>>=20
>>> This ensures that even with full UART access, attackers cannot =
extract
>>> usable cryptographic keys from the communication channel.
>>>=20
>>> Implementation Overview:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>> The solution is implemented in 11 incremental patches:
>>>=20
>>> 1-2:   Add firmware metadata parsing and version detection
>>> 3-4:   Establish secure interface framework and crypto setup
>>> 5-7:   Implement TLS handshake (Host Hello, Device Hello, =
authentication)
>>> 8:     Derive application traffic keys for encryption/decryption
>>> 9-10:  Add command encryption and event decryption support
>>> 11:    Add required crypto algorithm dependencies
>>>=20
>>> The implementation automatically detects secure interface capability
>>> via firmware version strings and enables encryption only when =
needed.
>>> Legacy chipsets continue to work without modification.
>>>=20
>>> Security Properties:
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> - Chipset authentication prevents rogue device substitution
>>> - Forward secrecy through ephemeral ECDH key exchange
>>> - Authenticated encryption (AES-GCM) prevents tampering
>>> - Per-session keys limit exposure from key compromise
>>>=20
>>> Testing:
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> Tested on AW693 chipsets with secure firmware. Verified that:
>>> - Authentication handshake completes successfully
>>> - Sensitive commands are encrypted before transmission
>>> - Encrypted events are properly decrypted
>>> - UART monitoring shows only encrypted payloads for sensitive
>>> operations
>>> - Legacy chipsets remain unaffected
>>>=20
>>> [1] "BLAP: Bluetooth Low Energy Attacks on Pairing" - DSN 2022
>>>=20
>>> =
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fnets
>>>=20
>> ec.ethz.ch%2Fpublications%2Fpapers%2Fdsn22_blap.pdf&data=3D05%7C02%7
>> Cnee
>>>=20
>> raj.sanjaykale%40nxp.com%7C7e6471862d5d4d6b86bc08de52b47c29%7C686
>> ea1d3
>>>=20
>> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639039132284844210%7CUnknow
>> n%7CTWFp
>>>=20
>> bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
>> MiIsIk
>>>=20
>> FOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DHV0OjNPoq%2B
>> P%2B07YW
>>> WCtrrGUlmxWBamNWMwfrbkan7yc%3D&reserved=3D0
>>=20
>> Ok, I start reading the document above but it says the problem is =
with HCI
>> itself though:
>>=20
>> 'We first present a link key extraction attack that exploits the =
security flaw in
>> the HCI dump, which records all data passed through the HCI interface =
in a log
>> file, including link keys.'
>>=20
>> It does say that it is passed to a log file though, maybe the =
permission of the
>> file is the problem then, either way this would be UART expecific. We =
do
>> require NET_ADMIN (aka. root) for accessing HCI though, both for =
monitoring
>> or generating HCI traffic (e.g.
>> HCI_USER_CHANNEL), so I don't believe these claims are valid with =
respect to
>> Linux since for collecting the logs with the likes of btmon that will =
require root
>> access, that said perhaps the -w option shall limit the permission of =
the file to
>> root only as well, in any case it is not like btmon can be run by an =
attacker
>> without root access, so it beats me how Linux could be considered =
vulnerable
>> here.
> The DSN=E2=80=9922 BLAP paper shows link=E2=80=91key extraction from =
HCI dump logs (e.g., btmon)=E2=80=94a logging issue, not a Linux =
privilege bypass. Our threat model is different: physical sniffing of =
the H4 UART lines (common on M.2 Key=E2=80=91E and bring=E2=80=91up =
boards) where the link=E2=80=91key exchange transits in plaintext. This =
series addresses that risk by encrypting the link=E2=80=91key =
request/response (and related vendor events) over UART, so keys aren=E2=80=
=99t recoverable even with full wire access.

but you are not protecting SMP. I think this should be an all-or-nothing =
approach.

Regards

Marcel

