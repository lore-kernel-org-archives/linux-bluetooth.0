Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604796;
	b=R1iFLgfA7xaXLAPNZqdT+AUIhW8/kxh6717uIxXT4jgai6b+1xNVnvNZ3s7Yf5HoX3yw
	 lYEcz/wVHdwCfSJNqAACK0AcBtUPB2878b6Kjd1eLA6ktnf8BhTRzl9DxYnkZxlZLuGPT
	 akt8a5/hLbtUn9cjw+G8ggTPqCkONKHNI3zWYwdJJ62sCEIsj3HiPHe5SrtBWeonrP6Pe
	 JWJQIBeKJeJIwbWb+PIE+Dfm7F9qILayCoiVjaHkPR3wzzfSefyvCvm0UnCQ0KnTJbuIu
	 uOO8o2D7iM0OrpWat7wWHW/j7C2LNjO/KIhRm6Mk0ete0bTXX001s6P16d8eJ05e4/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604796;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=hjaaJ2AXbi4k7IrQKc/tr/IFbWe16XxbnquVtoaCf0k=;
	b=MjmTGvBfBnYDgkVVbdpajWZgTM9I68HbKKFAeQUHY/8PEY2+r3VVeJp7840FCWc1DGvj
	 bcwsvKxGydnpKDpiG2xTTca2Qvo48cO0vBty0E93N9eW/YwyFH7dX/gKn9JgCTLvjA9B3
	 R+fR25YKL4W0E3ABCt+0t6yY8353GRragVtUZpc5+4yQBlk9eEB1tZHADt+qo4bssDLVu
	 TSD/dYFV9TLiV2kWNSihMeUWZG9n1TavkiZaJM7b9f7xhYH758afb1EXYP5BzOJg6AGRe
	 ETdNUhK6p+2G1SyjUG1YYryCdcGZjX2y488FEEmOKKu07190p6SRKjAq8oSBCW7xGoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.197
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABFB606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DABFB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 805193EC29;
	Wed, 25 Nov 2026 11:06:26 +0000 (UTC)
Message-ID: <4b5ba0ac52fec3399f7d9891e60a822303a28fee.camel@hadess.net>
Subject: Re: [PATCH bluez 1/3] doc/test-runner:
 s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/
From: Bastien Nocera <hadess@hadess.net>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 12:06:26 +0100
In-Reply-To: <20261125104335.3321147-1-zijun.hu@oss.qualcomm.com>
References: <1277316d1d687050b546a2bc006c14a1a9569b5b.camel@hadess.net>
	 <20261125104335.3321147-1-zijun.hu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGAhtR18fNf2oF9TWeQCvgNeilCcZpJGzh1HPbI+H+CRqj7//gTK0okaR5Jvm3bCZTj8pZQHEl4Vu3YkdvOOxxzVxd9wf3yeRYJRzKIWFASibHnc8QJHxNFNaAPLcNOR5/p/rYqIPFCy2I7OL8vmyeSnGVLhKWKai5KE3A/Kb/9Nc93k+aKlLPJpbBld/riaXqOZmP02IGSWtZEgFjj2osJkvKQB6ChAbLm79lzusJehNWAgnbBbJrGIvDyy2sKDcM9YZ50FBLkW5C5SAYrazV3a9UK/+cKtazVak99+ZiwLf6qaSQ3aibK7JWOsE8XrH7f/TqBMSqesWombP53Ogr5SCoOLCkCo4ZiK3yv/ownB181BG+TOICJCNR204g5/YaD4b5eWp1CBIp33E+kkwwILuKrKJ1uwDjmV0Arl6ek+/JRxy2RfujY3s3WmlZNSYVGON89NH3v8gtBI7OerpQHX+i+GQG44YrUQwtIQoYu9AcnhpuOqSyx+2ERxXSplDJt07xO6/Yv/7MfT7KE5gVOAFtjEf+wtXkuuMDB4WE+F/rwnYlp6k0rpshqC2EDgyJOrjXKVVFI7K2zyRvzhh6LqltW+btBKeqYb3NShdVHULCi0yCu2Y45lODXJeZxRCXCAsiXb/cD2UjI1w2MnWVFHRsl0NM0GLeqCqNLnQqqPg

On Wed, 2026-11-25 at 02:43 -0800, Zijun Hu wrote:
> Hi Bastien,
>=20
> Provided this repo also follows
> https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/process/ma=
intainer-netdev.rst
>=20
> "Netdev discourages patches which perform simple clean-ups, which are
> not in the context of other work."

Given that it's a fix next to somewhere where you're touching the code,
it's fine. That's not the kind of change that the documentation is
warning against.
