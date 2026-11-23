Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795445125;
	b=GskuL14OlF8aKDIhDQBAPa1fMooiG2Oe76KyCxwNKXmM8h+qLQ/+2yvsgXBEg40pDl9Z
	 zyMXXDyaFHWZRRMAxe5kMRsdy0v/UX6t3/Duy4dWA6cv0AzBKy8Tln9Edldpjl5oD49H+
	 oRVn7CXd0st8YOUA1eoj/nUM+GqSL68kVEGEdp1Sk7F/pqrqoGY8LeDmq5gfeFnAOLtq/
	 kWau5ouyWMTbxLXILzWkEwGN4zynseuBTn1W/SndTQJAfERxotstwI3w3CZcH4qw6JDa8
	 X2KcWF1pzADtSSzHyo/E5d6d5rEswcWdXqGNamlxGIyC/lX7NyRmo5d3QDpnLLG6r/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=GcjuKvo5csKU94jMjaVI4RiQ21k56pTEtYx+s8JEl8w=;
	b=ZtWguyBQpDUgC+x9E56GeQJTKoNFnMwejMHpnAO/qRK+fpn1RBkmEcAHRN6L12kJdkwL
	 aubEXRwIDe13RHGOK6Hdz8t/220TsNgsG4lEL+bthCn4EDduAuzEgramJ5mpTFztiN//z
	 GplPKk6HIP6VzqamknPXJEbCoHbhPHYOSt2nUUYBELaXxTDMR8ScfhoChJ/bb1Ks81BoH
	 ZXPCXeTqJrz7d3iTZxvRYbR7HqjM+k3WaVMoPkzIbs7NSFh3en5AIbk9hYB1Ih2eIeqlf
	 /oXEWn7Nk8SeuMpdjYFIAwXjMxox35UwKHE8voPeNrngyiMJ8uCnVsdy76W6cT4qvfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E58JMlmc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83192606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83192606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E58JMlmc
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67dc7eb1442so3545994d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 06:45:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795445124; cv=none;
        d=google.com; s=arc-20260327;
        b=gTfElSe5MRkMjqwdtHgl7AcVV8OJH50mY7/MnJnPz4gbkadyz1uACRurO8+6sb69/a
         JlkayIZjLSg1vfIo6MbodK9pljEER6/RaPfJzbCQuyDjUlfBto0hH5aGKc4PZy+bskVK
         3aOcbckg0ppb5Ea4ZAW42eDFKBOucO6LOOsO9BLguA1dJnjkX14Zc8ZzfvaTEBoNbXcS
         dOcpkxYTBX2/wPyHPexTYUBCL3nLbgu5fD2UDXpIxn9J9jCqcSCO6dWgLEO3q0l6wvc8
         9HiaErOF6ANkaN7XLeTIyQCVMXzKu2YxIQ6fN07TEZnF/cCq7h9Z0ZgnPT47FBw3G8el
         j+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GcjuKvo5csKU94jMjaVI4RiQ21k56pTEtYx+s8JEl8w=;
        fh=dTzD+sIqnwBkIcVZ80uGkoLsiNeeBlhM/8JkiCbQjww=;
        b=YoZP9b2bVehY1jIyOOUGyI9HSs8U0tIrO1NC+fReup6UtvI1SmqceFBmiIvDLWSXSB
         g3HlvzuIRRWevf5uv/roJy8iUtQx/omPhx87GFuxhc3Ddpwbp12o/2tsPWhfYTyEtmmr
         GUos14TmO5S0XFOP5vYadBE/3I6/UDz+/7AMP2yA5UzO9u7gZrjJpczCspuhbK2DqPNK
         pTM7yODunRrfmQAMzAaufXVCqgqZdV/870Tk4k+6HjJL/7JOO8YDJv+BBaGmj91Rhgxm
         V//zCEhooCg5e6DXFvqaOM5Iz3RjtDH+tdZW0YoX1U7QkzfKzOrPgPZREaHmAAXc0ftF
         X1eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445124; x=1796049924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GcjuKvo5csKU94jMjaVI4RiQ21k56pTEtYx+s8JEl8w=;
        b=E58JMlmcbw2D8Y81i4K0hGXov2CNHhDi03kfsg4OXgAs0akZOKqv7UfpappL2hthf3
         bdxsJqcG+2xy53xQFBWCfoSgOdv9UHRwdUM5d8PS66dx3F5eDah00bjp0jfwOCAAQKDv
         DNGfsEzjdGyZTTKsEz6HRJKO0cKtLFkGEAwdDayI9wcQEShZPCkQBUjIiNVfi1c4L2vn
         MklNOPeTFmHfNZvy5piQ+o+WgNWw/HVkTX9sWW99dw2+cm8UUSdFsXv1qJUPcXjSzLMd
         WnnNwqmzBTauxkSTOwGDDSj1E4sDJF6EAQ3D/1a835rB+F9S6BgHd+Btik59cio7QSq6
         FrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445124; x=1796049924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcjuKvo5csKU94jMjaVI4RiQ21k56pTEtYx+s8JEl8w=;
        b=g9x/DWZu5F7Sbl96pJX3T3z7UOz2Udnmwko+RNRRgIsa2CKbMrpm6mDN6VgqFxsKbP
         ZPB6a92Kqj5xjSIlJRQxBT4yMQv0wp1HCfdnDSWiixdmPV5StiZDWZoR5/4pfv09EiEH
         rjaW5tpQuGFwGFtRUkOj/z+SQvnCVfOKpxoZJh3bflPW6kKqj/JxCViO4NHAxvalj4NV
         RF5Tg9Z/3l4oapya17pizjH1jO2Ah+dqmo3QjVBoZDMrDNNXTiY0Ii87dglitfoUaSip
         HsKKDCr9lfPYmj9iB1TzVRRUtrrfu3ULJGDU536IJ8beKzAI8yIARQ/6Tat56K464+Ek
         M26Q==
X-Gm-Message-State: APuU4Z/n+W+WTLuLpRgr3klVHBMQNG6U1KMt0vaaTf1XZ3TaEFD52fAR
	WzXOL+v1MDcMO+LD2SZ4AICVQnVFQDuPHU21rku4MLZrim7Fa/xz92Fy5L/uM1CJvQXx9+43WCY
	K+R8W+8T4DWW7jytDwvH00Zwghovko7G9iQ==
X-Gm-Gg: AZFdTZfaOq0cBXqND5+A3/qlVcFbpXeY3rw3LtRcrRo6KqrYobWbyY/63ETepxmp0US
	dB8G/rfY8u7Ve49GoybtB+vnFdoeSGNrcFA9go0bCsRXeHwEoIk7r6M81OBRg4+8rmm5JS8WVot
	pJicMJIZlIXusW/7tsGA9YW/bA30NMMBCjBFK1fbN5IKBtBri99V5xVYh1grcujByAln+NrY1uY
	X1GW5lY6VbYaaeufyZxSfIisgyk+rZ2FuSdGUVPOOTudxIGwOVCsv3GFt3+nTwYuyWmyoI7YEA2
	KHfnhzM3Wq0KZclxb9R7d0oNrKLLti+uCGuDJSVkJFERPinkZeHg7JVBKOgpfBt8bO6ddjtGtfB
	tiCjVf1gJPw4GLOb19Wm6RJoYLu3uCVO8zpBuP9U/I5SoVnxy8NLfUIpeY12aZ6i0HkH+oTYPiK
	mjURO7sVjPc6L4TyzTgneDYIYCXMJgz94uYlR2o/mPWEhK0UzdYveSt5iY5yk=
X-Received: by 2002:a05:690e:a4a:b0:67d:c309:5416 with SMTP id
 956f58d0204a3-67df44c2325mr5399166d50.105.1795445124085; Mon, 23 Nov 2026
 06:45:24 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
 <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com> <edb6288e11cf9eab058cada5151c0c071587eb3e.camel@iki.fi>
 <249d8212-f68a-4eee-b92c-efb339dd9de4@oss.qualcomm.com>
In-Reply-To: <249d8212-f68a-4eee-b92c-efb339dd9de4@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 09:45:12 -0500
X-Gm-Features: Aa3M54pu_a3IBXRU-QYTfcH8aW1mrBCQNcIOSh6aY4rlv-0Hg0y0XTs3pItp5As
Message-ID: <CABBYNZ+-8kb2wA4fd5oYq=_hi9BSfFwie-RSpsZdVbCM57qCUQ@mail.gmail.com>
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64 hosts
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Sun, Nov 22, 2026 at 8:04=E2=80=AFPM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 11/23/2026 12:24 AM, Pauli Virtanen wrote:
> > su, 2026-11-22 kello 02:34 -0800, Zijun Hu kirjoitti:
> >> Add arm64 support by:
> >> - Using qemu-system-aarch64 with the virt machine and the arm64 Image
> >> - Passing -cpu max or host, as the default virt CPU is 32-bit
> >> - Using earlycon and leaving out the x86-only options
> >> - Warning when /dev/kvm is not accessible, as QEMU then falls back
> >>   to TCG
> > Should it actually determine whether to run qemu x86 vs aarch based on
> > what the kernel image is, and not the host system this is compiled for?
>
> I don't think so. Choosing at build time is correct and simpler than
> at runtime:
>
> 1) The guest shares the host rootfs and runs the host binaries, with
>  test-runner itself as init, so guest arch =3D=3D host arch =3D=3D the ar=
ch
>  test-runner is built for, namely, the build arch decides both the
>  host and guest arch.
>
> 2) Kernel images come in many formats (bzImage, vmlinux, Image,
>  Image.gz, ...), so detecting the arch at runtime would add more
>  logic than it is worth, while QEMU for a given arch already parses
>  its formats with -kernel.

I guess that is a fair point: the tools binaries would have to be
built for the same arch of the kernel image. However, that doesn't
rule out running test-runner on an x86 host while mounting the rootfs
with a cross compiled tools. I guess we shouldn't recommend that setup
since it's counterproductive and considerably slower to compile and
run. That said we could perhaps print an error if the user attempts to
pass a kernel image of a different arch; test-runner should probably
fail with a clear message stating that this is not supported.

--=20
Luiz Augusto von Dentz
