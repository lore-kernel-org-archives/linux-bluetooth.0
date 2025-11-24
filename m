Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F6315D31
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003320; cv=pass; b=EQ4WDle98NLPL2nwJF56gjs3ROBBOVJHDc35jKKPFLaMRrcECmAc4JSoQ4lgtbQ1ctJk14+SXlxk2ofdIBrl2v5St6AZ79UlTP7i6V/6q+JUWKIX0RK0xq/B89c4VJfKZ0SK/BOiEVx0A7N5NweSJOXsaXCjh9qsaIuI0FmRNQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003320; c=relaxed/simple;
	bh=rQCRupODXw4kt0Bl5doqelAKmKlon8fh1IkFhiW12Tc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AB1N39M+25RyakmtIjTAXmhtKvX8+i2Un8o49yh7AY3vXc4HmuHTDD0C4586Cqu8R+ttZ1Z/avriV/Iv0Lvig/zmSi+RnmCTmVQJ+4q7sZi38y+ZAm+P47Ae15LfOkV6oeM5TdATZkHi7EKugqNalqYQK0vhZ1uG51ZJG4k0zfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=aukBSJRR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="aukBSJRR"
Received: from ehlo.thunderbird.net (unknown [193.138.7.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dFX4Y2GTCzyS9;
	Mon, 24 Nov 2025 18:55:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764003309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRe3C1P1YRj3RfQUYcqi/u3eco6NGkws+fDQJMUFOYw=;
	b=aukBSJRRo0KNCkwAFh36Z1Qyo7LuF+vqqxHTIQKCw2bapbVZlOGbvXC1xyPp1YjBtyVhli
	0hIeuri7NuIfyoh06DPgDMBgNcFuXJfyPgy4hKOZPe2g7Eliy+MjKRZ7bOEcBGfhWzvmOy
	lUU1nxMlCUgpVzPMJnkkoab6TldF1TM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764003309;
	b=n84NKRaeDgB/na0wYGLxKQ286PiGzacuh9eDR3eX9OTjP+eNwuRPes2u1X27n+sjPXUvq7
	H+MjMpKwoDP9nPcidEgDzxHYIiGQYXSDPGtyYyBEklgef3DE6EWpflFC2wSf0mLs4eDNUq
	bwrCdLkxm6UDUFZFI+a7pLowl7GXOSk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764003309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRe3C1P1YRj3RfQUYcqi/u3eco6NGkws+fDQJMUFOYw=;
	b=v9WO5V1fHE4LdyzHc9ER1dv/0QWFklvd+bx5chVgyda1h1qe1J4OBSirYP0uqOQcNK39MT
	zXa33el62hRgQ4uC4RX0Y8Ua85qQjcyjXfbSPm1D1fAfYQWX6ehCApPkt/uEN2OCTWW+ik
	l/49gQpJ/Zbtvz8D6f21NhsoUzcoFTs=
Date: Mon, 24 Nov 2025 16:55:04 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_BlueZ_09/10=5D_doc=3A_org=2Eblue?=
 =?US-ASCII?Q?z=2EMediaEndpoint=3A_add_SupportedFeatures?=
In-Reply-To: <CABBYNZL1qBjvnYir5eXrWKnj4HBSct09o-EtgsENv6+Lq3BQnQ@mail.gmail.com>
References: <cover.1763914558.git.pav@iki.fi> <5cdb0dfff2fef6a269b6e3b990059ea8966df086.1763914558.git.pav@iki.fi> <CABBYNZL1qBjvnYir5eXrWKnj4HBSct09o-EtgsENv6+Lq3BQnQ@mail.gmail.com>
Message-ID: <10AE923B-2150-4946-926D-0E4D00BFB011@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

24=2E marraskuuta 2025 16=2E20=2E28 UTC Luiz Augusto von Dentz <luiz=2Eden=
tz@gmail=2Ecom> kirjoitti:
>Hi Pauli,
>
>On Sun, Nov 23, 2025 at 11:18=E2=80=AFAM Pauli Virtanen <pav@iki=2Efi> wr=
ote:
>>
>> Add SupportedFeatures field for indicating TMAP & GMAP roles and
>> features=2E
>> ---
>>  doc/org=2Ebluez=2EMediaEndpoint=2Erst | 99 +++++++++++++++++++++++++++=
++++++
>>  1 file changed, 99 insertions(+)
>>
>> diff --git a/doc/org=2Ebluez=2EMediaEndpoint=2Erst b/doc/org=2Ebluez=2E=
MediaEndpoint=2Erst
>> index c1ce1d562=2E=2Edd4f03e0d 100644
>> --- a/doc/org=2Ebluez=2EMediaEndpoint=2Erst
>> +++ b/doc/org=2Ebluez=2EMediaEndpoint=2Erst
>> @@ -299,3 +299,102 @@ Indicates QoS capabilities=2E
>>  :uint32 PreferredMaximumDelay:
>>
>>         Indicates endpoint preferred maximum presentation delay=2E
>> +
>> +array{string} SupportedFeatures [readonly, ISO only, experimental]
>> +``````````````````````````````````````````````````````````````````
>> +
>> +List of strings that represent supported features=2E
>> +
>> +Possible values:
>> +
>> +:"tmap-cg":
>> +
>> +       TMAP Call Gateway
>> +
>> +:"tmap-ct":
>> +
>> +       TMAP Call Terminal
>> +
>> +:"tmap-ums":
>> +
>> +       TMAP Unicast Media Sender
>> +
>> +:"tmap-umr":
>> +
>> +       TMAP Unicast Media Receiver
>> +
>> +:"tmap-bms":
>> +
>> +       TMAP Broadcast Media Sender
>> +
>> +:"tmap-bmr":
>> +
>> +       TMAP Broadcast Media Receiver
>> +
>> +:"gmap-ugg":
>> +
>> +       GMAP Unicast Game Gateway
>> +
>> +:"gmap-ugt":
>> +
>> +       GMAP Unicast Game Terminal
>> +
>> +:"gmap-bgs":
>> +
>> +       GMAP Broadcast Game Sender
>> +
>> +:"gmap-bgr":
>> +
>> +       GMAP Broadcast Game Receiver
>> +
>> +:"gmap-ugg-multiplex":
>> +
>> +       GMAP UGG Multiplex feature support
>> +
>> +:"gmap-ugg-96kbps-source":
>> +
>> +       GMAP UGG 96 kbps Source feature support
>> +
>> +:"gmap-ugg-multisink":
>> +
>> +       GMAP UGG Multisink feature support
>> +
>> +:"gmap-ugt-source":
>> +
>> +       GMAP UGT Source feature support
>> +
>> +:"gmap-ugt-80kbps-souce":
>> +
>> +       GMAP UGT 80 kbps Source feature support
>> +
>> +:"gmap-ugt-sink":
>> +
>> +       GMAP UGT Sink feature support
>> +
>> +:"gmap-ugt-64kbps-sink":
>> +
>> +       GMAP UGT 64 kbps Sink feature support
>> +
>> +:"gmap-ugt-multiplex":
>> +
>> +       GMAP UGT Multiplex feature support
>> +
>> +:"gmap-ugt-multisink":
>> +
>> +       GMAP UGT Multisink feature support
>> +
>> +:"gmap-ugt-multisource":
>> +
>> +       GMAP UGT Multisource feature support
>> +
>> +:"gmap-bgs-96kbps":
>> +
>> +       GMAP BGS 96 kbps feature support
>> +
>> +:"gmap-bgr-multisink":
>> +
>> +       GMAP BGR Multisink feature support
>> +
>> +:"gmap-bgr-multiplex":
>> +
>> +       GMAP BGR Multiplex feature support
>> --
>> 2=2E51=2E1
>
>I wonder if it would make sense to add a sublevel as UUID followed by
>the feature set, this is a little bit more streamline since there is
>just one level though since you are prefixing the profile friendly
>name, that said I think it having a multilevel is probably going to be
>easier to maintain since the value domain would be per UUID rather
>than global=2E
>

dict uuid -> array of strings should work to group them per service

String arrays may be a bit simpler for clients to parse though, but I gues=
s can get more messy if list grows bigger

>
