Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597175;
	b=KjUb/khki+Ewf4LsuqszkIJtFeZ/3eCkLnWiWWPAO26slbNNcrrjwq5SZRpAd6HlF67i
	 hQu6mu+KfXknnpum/ZkN1wZLfuYtMdKo60XPrvB9OlahTo+m9xBgB1QTIZQsrsDzExEPi
	 4m9KHeQYUSD0LLTlGTtlvuzzK6fCbOMaGOcZGMzCSphvDWFwpTVv3E9ItGo8IX0UF2WCM
	 ZeA07aAMoy5W4tcNVx9vN8LJkI7OlNtXAFdeQZiwmdfuMh3gcEqqksgxJBzmkzIMPVdhS
	 TPmQOknW7JYH1ye8m+8bmKaTw/0AHAHN/y6qviHjS6doxb8eLICxRvLi9BzTZ1dRlrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597175;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=gN4CUQUTI4A3aQzoXeKsqYPNwgKYiOurkvLSM0Ikrms=;
	b=cexaJ+CJPMI3wW6qFFlNyfqcZZKqVNsdNYgVx1VF37aDgABf82XB2GFRdYLn5lWwYJYu
	 TI4podqAcl6nPMOSdbL/2beeAjKqVufLw4MkJPgaF7DRAWhLgsr60VGPob4kqxg0s4jlk
	 PbJv6voDKKwtivzrDirxA8KdaPy+8Mt9VWGYKhNzolROQENQPrOT7MLNuIKJlpSbA0QAA
	 O2oqZKvLL3Aa+4Yf3oHg2u1TZZic92m/MShbw+td6FvvJJ0h/tzMchzLowDN5VlXZWDs0
	 UWN1lYwe3D8FMJf3J8oULTUpBzqshUKMuPcoRrpSQcW0e07eBkwV4ci1hi9IzrmRJxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.194
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122C606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7122C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A9BA42997;
	Wed, 25 Nov 2026 08:59:26 +0000 (UTC)
Message-ID: <1277316d1d687050b546a2bc006c14a1a9569b5b.camel@hadess.net>
Subject: Re: [PATCH bluez 1/3] doc/test-runner:
 s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/
From: Bastien Nocera <hadess@hadess.net>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>, Linux Bluetooth
	 <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 25 Nov 2026 09:59:26 +0100
In-Reply-To: <20261122-tr_arm64-v1-1-4eccf35daeca@oss.qualcomm.com>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
	 <20261122-tr_arm64-v1-1-4eccf35daeca@oss.qualcomm.com>
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
X-GND-Cause: dmFkZTGnony62tuoZ8NSvh1Xjvdg6ZXz/4un/s0WSMOQPfOiBn0SqFh4/6HVMjZ/Mvztyf0QKjLu/tucy0e7MkEwvkfjoi3ynTsBKDp9G88yJ9miV3TS+BVSVMakH9ugoRNYlK6X6U76sKhszKfwrbtWQbs+dVXqQzQkkGjqreLXVQPWnYqA014ws5eblbXxtwQMgJb0NptPWQfo9W1EjAC6uRMjYHT1QriO3YXUUslyYgKUlHpvLzRM540RS4qYXx+LwcbDcRSRTT01RschtUVNI3Q0pG4mnEBW/atqXKgeQUjzj2ZicmsncMZEF3lOcq9ZfFPyHBT6XyZz7U7GM9PZSukuXQYhZ79P2jheVftspP+MgJ3UnV1b3/AWUtpyaVOdnhB0EHFI470gO4owy9iK+DMMQxQGAPl7/1znWrz4US3rwgxekpleigvI+NLeCIe7KEgwSg/oCFDNXm03SHwdXv+WTbiexkGhyOWpstKLx38Nj3SQ/wfS5o3M0Y4OVdhl6hPgaOp9BJ+1lO9qbQ2swAek2Hf0qvlF/V2mKGTT0Rc2pu4DHv6mmtRfnt9TjvQ9IgWfr1J63uo4HaOXuKvrOfmfPZPvRWehoUcvwMz7MADNSxlKDkJHcHR33WMLas1amf62Wy9ksAmKpSyuTjK+tXolM/8q7E5hYKWEhggNp4Xa2w

Hey,

On Sun, 2026-11-22 at 02:34 -0800, Zijun Hu wrote:
> The btintel_pcie driver is enabled by CONFIG_BT_INTEL_PCIE, not
> CONFIG_BT_HCIBTINTEL_PCIE, which does not exist.
>=20
> Also split CONFIG_SERIAL_8250_PCI=3DyCONFIG_DEBUG_KERNEL=3Dy into two
> lines.

If you need to write "also" in a commit message, that usually means
that you need to create a separate commit fixing that separate problem.

This is the case here.

>=20
> Assisted-by: Claude:claude-opus-5-5
> ---
> =C2=A0doc/test-runner.rst | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> index 220a2cec1c55..b5876e4f5108 100644
> --- a/doc/test-runner.rst
> +++ b/doc/test-runner.rst
> @@ -190,17 +190,18 @@ option (like the Bluetooth subsystem) can be
> enabled on top of this.
> =C2=A0	CONFIG_NET_9P=3Dy
> =C2=A0	CONFIG_NET_9P_VIRTIO=3Dy
> =C2=A0
> =C2=A0	CONFIG_9P_FS=3Dy
> =C2=A0	CONFIG_9P_FS_POSIX_ACL=3Dy
> =C2=A0
> =C2=A0	CONFIG_SERIAL_8250=3Dy
> =C2=A0	CONFIG_SERIAL_8250_CONSOLE=3Dy
> -	CONFIG_SERIAL_8250_PCI=3DyCONFIG_DEBUG_KERNEL=3Dy
> +	CONFIG_SERIAL_8250_PCI=3Dy
> +	CONFIG_DEBUG_KERNEL=3Dy
> =C2=A0	CONFIG_SERIAL_8250_NR_UARTS=3D4
> =C2=A0
> =C2=A0	CONFIG_TMPFS=3Dy
> =C2=A0	CONFIG_TMPFS_POSIX_ACL=3Dy
> =C2=A0	CONFIG_TMPFS_XATTR=3Dy
> =C2=A0
> =C2=A0	CONFIG_DEVTMPFS=3Dy
> =C2=A0	CONFIG_DEBUG_FS=3Dy
> @@ -381,17 +382,17 @@ Running shell with host controller PCIe-
> passthrough
> =C2=A0
> =C2=A0In addition the above kernel config option the following is
> required:
> =C2=A0
> =C2=A0.. code-block::
> =C2=A0
> =C2=A0	CONFIG_PCI=3Dy
> =C2=A0	CONFIG_PCI_MSI=3Dy
> =C2=A0	CONFIG_ACPI=3Dy
> -	CONFIG_BT_HCIBTINTEL_PCIE=3Dy
> +	CONFIG_BT_INTEL_PCIE=3Dy
> =C2=A0
> =C2=A0IOMMU and interrupt remapping, without which vfio-pci fails to
> allocate
> =C2=A0MSI-X vectors (-ENOSPC):
> =C2=A0
> =C2=A0.. code-block::
> =C2=A0
> =C2=A0	CONFIG_INTEL_IOMMU=3Dy
> =C2=A0	CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dy
