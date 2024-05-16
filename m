Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F61369A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850823; cv=none; b=Spp1vO11H9g9NMW6ZFuk0+8XSfGFnUJxNnR/1KirfYf9UsB3jFbidg3aKCC9XL/G34IhCQYCNyso8km/yFN56FMZfHJpqUuchez4HbcxIzzGl6VN1wYcfaxPF/xyCPAlRCQLIE3Agm26O6x+wqUpf6aOjegRz7xooYqm9AEfaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850823; c=relaxed/simple;
	bh=RyEBeKhga8MF+0FaMIPzfAGukcqiF6lIbOPmToAtDCM=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=hk0Kj3DEMjMnhUDwoXR3nmEI/y3MiHw6/mzVsb5a6Yyqrwj1SvqDa4tcJL52geLtXA7FbSj9Ts7RTA9+ggpsD0VwUtyLpIc8AXbtNRm5WZHQhceu6XsYfY67hrSOK7mxlTnPshalQ+td7ep1MA9vsOTFokymk1qlXdry9u4RrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2B6640002
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:13:39 +0000 (UTC)
Message-ID: <78e4c9a65b6e7509a1f743f945270568a8548f26.camel@hadess.net>
Subject: seid structure in profiles/audio/avdtp.c
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 16 May 2024 11:13:39 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

Hey,

I was looking at the code in profiles/audio/avdtp.c surrounding those
static analyser warnings, and couldn't understand how the seid arrays
were constructed.

There's similar code in android/ which might also need fixing.

I could only find the code that assigned ".first_seid", nothing about
how the rest of the structure is allocated and assigned.

Cheers

PS: Please CC: on the answer, as I'm not subscribed to the list

Error: ARRAY_VS_SINGLETON (CWE-119): [#def29] [important]
bluez-5.75/profiles/audio/avdtp.c:1675:2: address_of: Taking address with "=
&start->first_seid" yields a singleton pointer.
bluez-5.75/profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid" =3D "&s=
tart->first_seid".
bluez-5.75/profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid" as an ar=
ray.  This might corrupt or misinterpret adjacent memory locations.
# 1677|   	int i;
# 1678|  =20
# 1679|-> 	for (i =3D 0; i < count; i++, seid++) {
# 1680|   		if (seid->seid =3D=3D id) {
# 1681|   			req->collided =3D TRUE;

Error: ARRAY_VS_SINGLETON (CWE-119): [#def30] [important]
bluez-5.75/profiles/audio/avdtp.c:1690:2: address_of: Taking address with "=
&suspend->first_seid" yields a singleton pointer.
bluez-5.75/profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid" =3D "&s=
uspend->first_seid".
bluez-5.75/profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid" as an ar=
ray.  This might corrupt or misinterpret adjacent memory locations.
# 1692|   	int i;
# 1693|  =20
# 1694|-> 	for (i =3D 0; i < count; i++, seid++) {
# 1695|   		if (seid->seid =3D=3D id) {
# 1696|   			req->collided =3D TRUE;

Error: ARRAY_VS_SINGLETON (CWE-119): [#def31] [important]
bluez-5.75/profiles/audio/avdtp.c:1799:2: address_of: Taking address with "=
&req->first_seid" yields a singleton pointer.
bluez-5.75/profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid" =3D "&r=
eq->first_seid".
bluez-5.75/profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid" as an ar=
ray.  This might corrupt or misinterpret adjacent memory locations.
# 1799|   	seid =3D &req->first_seid;
# 1800|  =20
# 1801|-> 	for (i =3D 0; i < seid_count; i++, seid++) {
# 1802|   		failed_seid =3D seid->seid;
# 1803|  =20

Error: ARRAY_VS_SINGLETON (CWE-119): [#def32] [important]
bluez-5.75/profiles/audio/avdtp.c:1912:2: address_of: Taking address with "=
&req->first_seid" yields a singleton pointer.
bluez-5.75/profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid" =3D "&r=
eq->first_seid".
bluez-5.75/profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid" as an ar=
ray.  This might corrupt or misinterpret adjacent memory locations.
# 1912|   	seid =3D &req->first_seid;
# 1913|  =20
# 1914|-> 	for (i =3D 0; i < seid_count; i++, seid++) {
# 1915|   		failed_seid =3D seid->seid;
# 1916|  =20
