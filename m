Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D2443E4E
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836792; cv=none; b=mcwonHNg20Su6Lnr93eY2MKnDzDTcgIDo58ZzwBf5d7BA4tl/CIk/8rnO6Qg7kJ3DN2x7wSc4Wg9kmlsbBF6vBZ6C8P2Wq+3NWxWDnH1ztmDVkGhrrhwrkgIvCdQj1gOnThKswdzHbYLSloRLyZJp52uhjQAOAVW8vEuN2o5jqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836792; c=relaxed/simple;
	bh=Fy2ESdXJNamuXdC/+E3urITlvDOiDNOlnRMUsDI/3OY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b83Odqs8d/UG91SGirSgLY7Jn6o9ZKf7gJIKyp3ECWMnYs5HmyV1dirk5HhdsJWmbMLWFrq5Wyls+3JAGIqJG5in/IE313+VXyrxcXtlI1bPK3YIS+s3AdnTbGlTGRb59tT/mRp/koxhIZBpFS80VAYcnUqlUBsMwvNXZSfCcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 496BE3EBDA;
	Tue,  4 Aug 2026 09:46:27 +0000 (UTC)
Message-ID: <c80cfccc288532015fa968b9fe06f612b5dc365f.camel@hadess.net>
Subject: Re: [PATCH] Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
From: Bastien Nocera <hadess@hadess.net>
To: Elman Shahbazov <shahbazovelman97@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: secalert@redhat.com, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 04 Aug 2026 11:46:26 +0200
In-Reply-To: <CADE-WFdQ+35ePBX35mQt6o61dyz7tBkKByVe1BnKzXxpb-njAw@mail.gmail.com>
References: 
	<CADE-WFdQ+35ePBX35mQt6o61dyz7tBkKByVe1BnKzXxpb-njAw@mail.gmail.com>
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
X-GND-Cause: dmFkZTGrSKHg6yGM9JYGg16SDvkvJSjkzSpg2iVBErps5dbDmokBsmnNMRVj3W4dkscDehKJomKWqPdFcaS8UJI8nwnpBs7xovxx6hRL7Y0d0PceDo67ev+vOcRzgavY5uDgc+/t5oDjAKAY8/Vq2NWVdxnaCX/6QPZ2V+uM/XfkhXTEa0iydnVeCxykTm47kgPZ31Vzk1XLJoJYqVjSArugky0uj3j/u9HzbQQzHaMDOoTY1jCMlF6XZMMDtAeGCGZ+e8f+1HrHcaxQEkELTyyiMOHdsi4jCuZLpx2g4eckeK9OoS60tLLidxBs10wy09LwlzaVGY5+yHIc3f8TL0ZHEwOrr330S/xj7ArmDKhSXiSdo02QH/SA7wNNwkP/zPShFrJqjhSHZSJxeBj5CdwdQHhZxQEirKtuxw9JW+JKJ9K52G54wYJGHpAddPkHmcd6Ye8Zmr/UYNeNv7zc7/npvRO4VIfLNX7HwDk8sjPYYCzaQTdJ7D3tLPlwPci2P1S5NKkWwoVgLppypZnNwQX15rL5Mwm086eh1pikJc4w9x5VUy+h1qvfpOiZI8/eneaz3A4kjd4kSpwYOSQWVLxCbHupA6QRkNis44JRHLQv7gBJN3cJM1IBJ6poC+7+CoBr/VYUAQNzMSFZSjWnOzTz5aBgSaSHZh0bQMC8xKc67wbKEw
X-GND-State: clean

On Sun, 2026-08-02 at 08:06 +0400, Elman Shahbazov wrote:
> Hello BlueZ maintainers and Red Hat Security team,
>=20
> <snip>
> 4. Proof of Concept (PoC)
> I have attached poc_avrcp_obb.c which extracts the vulnerable logic
> and simulates
> the attack using a 14-byte malicious packet with an inflated namesize
> of 1000.

Do you have a proof of concept for the parse_media_folder() vuln?

I'm trying to integrate those into test cases.

>=20
> To verify the vulnerability:
> 1. Compile with AddressSanitizer:
> =C2=A0 =C2=A0gcc -fsanitize=3Daddress -g -o poc_avrcp_oob poc_avrcp_obb.c
> 2. Run the binary:
> =C2=A0 =C2=A0./poc_avrcp_oob
>=20
> ASan will immediately detect the out-of-bounds access and abort:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D113741=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on addre=
ss
> 0x...
> READ of size 254 at 0x... thread T0
> =C2=A0 =C2=A0 #0 0x... in memcpy
> =C2=A0 =C2=A0 #1 0x... in parse_media_element_vuln
> =C2=A0 =C2=A0 #2 0x... in main
> SUMMARY: AddressSanitizer: stack-buffer-overflow in
> parse_media_element_vuln
>=20
> [ 5. Proposed Fix
> The attached patch ensures that the length extracted from the packet
> is strictly
> validated against the remaining bytes in the packet buffer (len)
> before being
> used in memcpy. It also adds boundary checks before accessing
> subsequent offsets.
>=20
> Please review the attached .patch file. I am requesting a CVE
> assignment for
> this issue given its impact on system availability.
>=20
> Best regards,
>=20
> Elman Shahbazov
> Security Researcher
