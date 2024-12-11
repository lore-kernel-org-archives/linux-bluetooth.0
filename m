Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4461BDAA0
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 05:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733893885; cv=none; b=e94hcJg/cZ21XhUVMiI7/q4UJ9S7f+qbt1mAyS1V1mh+STO57vw7ZVFzr/E3KjH0nJv8gbZ2LFIQaj8nFdPmsYPVpsliLULsIfSW/gzd6r8Z/6t4YlSUMLVgb46Ekq2qNoWz+b9ncQ7bR4d+XGS0OZs36FS3ZLlEjwDsErl2L0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733893885; c=relaxed/simple;
	bh=FqcyAxwIyVA48yjOSVad9/C2IYc/6lvjrTLZMnEd888=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TC5cc8ZgnPJqP6c81RyfyFeXdar3lwIORUMkR6+eZ0/i9Rj7dSrPZoyD38WdcnWp9s07nQduNT1SueN+wA+9Sg3lHhYfSqcG8EOfoOYrg9AzCRA/jHRuifgUbu7x+i7nMn9+c9jAWfqXbN38mFiuZxap4QmXUsxthve4y/6MYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgFMxX7c; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgFMxX7c"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f2b71bdeeeso1291394eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 21:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733893883; x=1734498683; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TEnLRT3NhnzLpU2NkPA5aa7Ub7IoX1B61OnbqM1fAs=;
        b=KgFMxX7c3XwipJ8+l+yn0bmcp79yVJ2IqYEqfUsAKgHJmvcxyb+Kuo/VQH6zMj7vpZ
         /PSMyz4l7qccmhvpaSJKk77xs1kvx6L+t95ySHhzO1zozhJBrc5R2No1t+c7yR8cu+l8
         av32bB8D+sauXVgQxglYbPDNNmsaRGnX9N8MSbnK36x1VQvJvYYgdNO3CgJKMSGfv1uI
         jUg8mnUiktyMiRI1577AKYdAYVxSeNul77ie64tJ1x+3gwbEcOY2bY1IWR9gBze62NNz
         Zug6jUa30lf8rAVTaF+t2vw48CwhSI+ICuSLoZMXMXrIi3MY6+8v6pl97Ta46ppJJtbv
         mYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733893883; x=1734498683;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TEnLRT3NhnzLpU2NkPA5aa7Ub7IoX1B61OnbqM1fAs=;
        b=TU+hdrQJ4qItwgeHHp6UV4p2zXvWAAfc1Er5FibVWNpgUBPuC2ZFJJw7Wjrt1g+xtB
         f46hKNN4S++1puhOqriFtJdn4sNFwDdrANkDmvFsjJ3PunX7PaT77qDOOsvhqxMWvnJw
         9N/zU591fTNfdnOSvnvOmQqf1aNMeAp9IOFrAL1trCRQd1OiPd061jl2TmarODuv3K0L
         moKMFgM+/aeBq6o8Ec1IU+APSCCLI0vomi1tth8KuXhSDKi388tbTjk/1iGXv22L/Z/E
         vN+neZYcWxdmR6hJ2vK0lYps8BH3DQObIBmTsfNEFFrIri7pRkrdYeS2KP3a4YXsQGyg
         eViQ==
X-Gm-Message-State: AOJu0YxIa73+3Pp5E6dQ7lBzeJrrSgcrlE9uH9gxJvV0J61Zn6p/pGrG
	b7aLuVJjINpmT8iXscshX8Hrj6MYgyYKYGRy8+bbIQu+iwwaCOtne6CsbFi8vgpf/bpxAj3vzMe
	gLIAitDeD8JJlMOdN02HZ/olKX09qSelx
X-Gm-Gg: ASbGncuWFctIKQf3AOlhb7AikLLOEZVZOCFYCq1my6Eqdl20vWwqBoUdzv7J66UsLtV
	t/WrkVbiJk77zJVxFYWO8wYISZ60FURk7ww==
X-Google-Smtp-Source: AGHT+IHSFNeX3p0gz6LEdz1yhRBZ1O+qnJnda077GXnfy2eOZ+wXxxMY1mBJxfZjWSpKM3uHQpPuHtx8qrFns+YwTgo=
X-Received: by 2002:a05:6820:1743:b0:5f2:c035:9d1c with SMTP id
 006d021491bc7-5f2d9f79c06mr890211eaf.0.1733893882705; Tue, 10 Dec 2024
 21:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALYKT1iDhSkSA7CDgohgqGdN9qm97tqpPGZLhh9mpM6mNp=VyA@mail.gmail.com>
In-Reply-To: <CALYKT1iDhSkSA7CDgohgqGdN9qm97tqpPGZLhh9mpM6mNp=VyA@mail.gmail.com>
From: Jeonghum Joh <oosaprogrammer@gmail.com>
Date: Wed, 11 Dec 2024 14:11:12 +0900
Message-ID: <CALYKT1h0Xp7P+rVXsLeSYQq+ED2HaK=-v2jJ9fxhhDi8oNP6xA@mail.gmail.com>
Subject: Re: Termination caused by a suspicious exception check
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore my previous posting.
I compiled btgatt-server and btgatt-client wrong. I didn't use autotools.
With autotool built binaries both btgatt-client and btgatt-server
seemed to behave correctly.

Thank you!


2024=EB=85=84 12=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 10:54,=
 Jeonghum Joh <oosaprogrammer@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Hello list,
>
> I tested bluez tools - btgatt-server and btgatt-client.
> Both of them stopped working complaining "Failed to initialize console".
>
> So I just prevented it from exiting, and everything seemed to work fine.
>
> I changed as shown below:
>
> btgatt-server.c
>
> me@mypc:~/Projects/bluez/tools$ git diff
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index 90a6c9b0a..e2e999eb2 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -1242,9 +1242,9 @@ int main(int argc, char *argv[])
>                                 EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLER=
R,
>                                 prompt_read_cb, server, NULL) < 0) {
>                 fprintf(stderr, "Failed to initialize console\n");
> -               server_destroy(server);
> -
> -               return EXIT_FAILURE;
> +//             server_destroy(server);
> +//
> +//             return EXIT_FAILURE;
>         }
>
>         printf("Running GATT server\n");
>
>
> btgatt-client.c
>
> buntu@ubuntu-desktop:~/Projects/bluez/tools$ git diff
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index b47914da3..ad7f8bb02 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1857,7 +1857,7 @@ int main(int argc, char *argv[])
>                                 EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLER=
R,
>                                 prompt_read_cb, cli, NULL) < 0) {
>                 fprintf(stderr, "Failed to initialize console\n");
> -               return EXIT_FAILURE;
> +//             return EXIT_FAILURE;
>         }
>
>         print_prompt();
>
>
> The prints of them is as shown below:
>
> btgatt-server.c
>
> $ ./btgatt-server
>
> Started listening on ATT channel. Waiting for connections
>
> Connect from DC:A6:32:AB:74:1F
>
> Failed to initialize console
>
> Running GATT server
>
> [GATT server]# Device Name Extended Properties Read called
>
> [GATT server]# Service Changed CCC Write called
>
> [GATT server]# Service Changed Enabled: true
>
>
>
> btgatt-client.c
>
> $ sudo ./btgatt-client -d A8:93:4A:96:88:F4
>
> Connecting to device... Done
>
> Failed to initialize console
>
> [GATT client]# Service Added - UUID: 00001800-0000-1000-8000-00805f9b34fb=
 start: 0x0001 end: 0x0006
>
> [GATT client]# Service Added - UUID: 00001801-0000-1000-8000-00805f9b34fb=
 start: 0x0007 end: 0x000a
>
> [GATT client]# GATT discovery procedures complete
>
> [GATT client]#
>
> service - start: 0x0001, end: 0x0006, type: primary, uuid: 00001800-0000-=
1000-8000-00805f9b34fb
>
>   charac - start: 0x0002, value: 0x0003, props: 0x82, ext_props: 0x0001, =
uuid: 00002a00-0000-1000-8000-00805f9b34fb
>
>   descr - handle: 0x0004, uuid: 00002900-0000-1000-8000-00805f9b34fb
>
>   charac - start: 0x0005, value: 0x0006, props: 0x02, ext_props: 0x0000, =
uuid: 00002a01-0000-1000-8000-00805f9b34fb
>
>
>
> service - start: 0x0007, end: 0x000a, type: primary, uuid: 00001801-0000-=
1000-8000-00805f9b34fb
>
>   charac - start: 0x0008, value: 0x0009, props: 0x22, ext_props: 0x0000, =
uuid: 00002a05-0000-1000-8000-00805f9b34fb
>
>   descr - handle: 0x000a, uuid: 00002902-0000-1000-8000-00805f9b34fb
>
>
>
> btgatt-server.c tested on a labtop + ubuntu 22.04
> btgatt-client.c tested on a raspberrypi + ubuntu 22.04
>
> Before starting of the btgatt-server I did things as shown below:
>
> $ sudo btmgmt -i hci0 power off
>
> $ sudo btmgmt -i hci0 le on
>
> $ sudo btmgmt -i hci0 connectable on
>
> $ sudo btmgmt -i hci0 privacy off
>
> $ sudo btmgmt -i hci0 advertising on
>
> $ sudo btmgmt -i hci0 power on
>
> $ hciconfig
>
> hci0: Type: Primary  Bus: USB
>
> BD Address: A8:93:4A:96:88:F4  ACL MTU: 1021:6  SCO MTU: 240:8
>
> UP RUNNING PSCAN
>
> RX bytes:16771 acl:0 sco:0 events:2280 errors:0
>
> TX bytes:554822 acl:0 sco:0 commands:2280 errors:0
>
>
>
> Did I fix the problem correctly?
>
> Thank you in advance!
