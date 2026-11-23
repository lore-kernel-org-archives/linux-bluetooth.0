Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795446027;
	b=ZBzdenWT445tnAe2T0oMUpm3A9Iod1J3mtl1lbWam9vMGzsaLqd0BXGJIo8BykVq2G4d
	 8nNONfvwCpwXfsB9FFuTsIwgsYzPm9aS0S5+Mma7D4hjZyo9ExEnoi0AWrmjLyA5T5uP+
	 EW4j1LvEF7p3ZAWX5EG1qftDCD/PIWa9Ioy3y1vdWuzi7VBFFIVFylUFKnFvOGo9UuNY/
	 /rbcPIt8o95An6FpaHML3UUisG435FQKQrGC+Ury5CfX9sH8wN0BAxUvzzMShH1/6tIs8
	 54LmH394g/7qCeXTp4NhAzL+Ug5tDbjVEOco93O/OhA+o2/SfzmlU2DJ6LyqE2EevEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VeEEIJAON9TMJ6/VnQUMJ2SXw/RPCgqm4ysH5Ih2KRI=;
	b=iZM2S7rOrgPOK328UrEEuLqG5qJAXdvqO6CFkmBOdLT5IiTV56o+xGFdTByr6nrMNzyV
	 EQcFrj7S//5hVCzdtsSJUBfJP4kcgMa057l8SMF9LD9d2eXwNSeDJx7qIIO1nc6NCEkPy
	 +YePTeL6jyXtDPAx8sN/ClOHbi3SgjjcZAoRSe0qCMwLhCqujLiW+oAr/MpToK/m/k98S
	 Uqoy2ZcNd2OyYMV9cfBtVp4isFuJoEpwIzBx85E5O4VJ1sRMxC9Os8XEBua0TX+SUE3a2
	 GgrRWcKTnnvunt48PGwDrdNf/XPcqKjwzhZ4qqMio0dXx8T2TvtOHiQXwBv49rghqNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P2gvmpYv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FB606A332
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 859FB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P2gvmpYv
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso3980731d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 07:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446026; cv=none;
        d=google.com; s=arc-20260327;
        b=bo8Cm/mbyUCg5c9T/H+kANCDpb99irOGE9mOo5+xIAAY7odjr5oJEjo17Tdg8g+u4E
         ECQz0KqZP+gHh/LRz8u2trmT7j9ZX0ReRww2KnzgB6UgAlPibItM5NzXAYWT+hLaDkBG
         +xX6dvU+7xOQ8qZlEyMl6RB0wk0Hv8iTBL9b3KBS2jF5GEipBak+EwBdmdmOGCqCcNpO
         +ki2T3pHCM5A7ujYlLJ1R2UXWMZ4tlu21bnn1RP0ZksFhgk1ivHZUwF0pDH53U8gdjSJ
         v070rJCaS1Sl8Is0TwLX255fhb/Gyna1EyGR1mdpY9IxYvQEcV39bTWRvdSEk2Y7wcw5
         4rDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VeEEIJAON9TMJ6/VnQUMJ2SXw/RPCgqm4ysH5Ih2KRI=;
        fh=6Ejz2qDC1kzAz/SGTrdN+HkwL3203PQPsV+Bv5fThMU=;
        b=Cz0O9EIcgwrkTDw/AFo4g2nZe6ADsCBwP7zwjMnv2tf/aQ6Ntvs8fDGR7sazvQRtko
         AobaXZeIdKYqKl/8rRFahlm40m4W8EjvQHrrRlwatV88Ydpaoa8DEuxbpMN0pUwHCPrd
         v2sXcF2np2SC5kNYMwue/6D7UYt/GYnwAXYtN4L7qegB6frHmMkU2Upvn/mACIAAHdNv
         KC3Vh9M4acGw46jzEpwTgDPoXrTrIZDc3aMfuE6wLBjlRC65bymRdQcEEShOuWmq/AUi
         5A2GWC+NzTZgz9Vt6uBDVbHckzTwOTKK9vBIWZnkef9uhkOn+PF2jPfC9FVyPXVZuu6a
         +n9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446026; x=1796050826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VeEEIJAON9TMJ6/VnQUMJ2SXw/RPCgqm4ysH5Ih2KRI=;
        b=P2gvmpYvrJE5Pf1Zspi2z9OI5lyloMIdfYuXfiynYrSnvsGxc+KcyRS8NPEtHoeGc7
         m9KUSuASwTfc/URdzl+EviMWps5Dq/eiFLbW8ld3F4/7fCWPocZSEKN15gmLPyUWtOZL
         M56GFNmcbzhYg5TtOvig3xXsSfDMMZG0Z/ZESk4XxWS0l5oNiSibkr127kI6Ixsc1C+h
         dR2dMbpoEGCa3d6c9I2+BotiM3LwhS4qfrXY77yCSMCtsOa9iGoE6g0kz2XoUd0j9+HK
         DhgYpKZzVSdK0nR+ggTgbnXS6JSvRf8lfSfxOTY6xrsWFh0aWhbaScaZkGT1+TprAa7L
         laRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446026; x=1796050826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VeEEIJAON9TMJ6/VnQUMJ2SXw/RPCgqm4ysH5Ih2KRI=;
        b=qVUHYTHK16bha9nt7a9ur2j8D0X4QgXEVJCcPnOFtYrkExgvV9KcbB9U6/extUCLkf
         Zl680WitNvURFMvcjlOEIIfoluWpQTUB1R/jK7UeUV35hkiM5i9bSLM5i0qTdjhZ3oKx
         ovkPETxsknK3xFtLW7I7nb65lsBzR2DzGfM/6EhYCUEGPrnInfwpj6WCms4YflhyK9Sd
         uY7XDpT2b6vEdy+yTLFxhIHj9vB8nHIS5zcdfEYtOHEZ453URuY8Kg3Fl9AWup5z3s6R
         eKYiTnspEGreUT8ipVnpPsiR+iTNBjKkkHG1WyL+WFLBaT0z666jCzEpAUgZ+ZDPu1mS
         ZlHg==
X-Gm-Message-State: APuU4Z9yjrinbAilmXXQ1VuD/I7eBgzRi/sH7nmanFwgFQKDACuLZzoe
	LziwZzthqBnF0aa3uaNyCccSIl7sf40hLVg52Y9/7RXiAB34qeURew+/1PacC9N2HqLkid1UQr8
	BBd82PrH6MF6WevwH7RqUllxO4f1zRvza1fnz
X-Gm-Gg: AZFdTZegCQMVrBUSGSq2wx7kXoG2bRJn0Bml9BmhfeAs85ptaHH1FE86/bmcjP/7ZHk
	2+dLQ3f8eB3GdKSUVbNtut+Pa8w4vuZ11ei4slxgCjTiTjC15K+ozM3bl4vnkiiAw4mDuNcKOeU
	cfdsKoE4058CHlyDIJ2eEXTNWHE1g13EpvT+NWU/Qhfsb/M98ymOETIibp+evHMOs62PQpjy8cL
	qhJoaA4SyvjpA4DRTHlrq1pKweybdHfHLKCkhVwdWDjxkSHETkl4xZlWhKkMgtUUmD8Lu44I7xk
	uj5uPSx69eBlhdBdfPJ0gZgk+6KmS2g/P7KDh9Uqy087DATgzjvJA9G1qLCwc3n7cMiF3bCp6r7
	1Bhdhx1C1H/LwqMDjyRaw5w72HdA0ovUNkiAsMp8gUuVhi+BEV4meFPb+FtLsb0tk4uebNHpiz2
	DLYNIaYpF6qo/l8xPZBTIxNwDwivG9H2v/5iws5DgxKGnR07fn05aZF7PQtQ==
X-Received: by 2002:a05:690e:1385:b0:67c:18:cc98 with SMTP id
 956f58d0204a3-67df44b0b01mr3863841d50.134.1795446026254; Mon, 23 Nov 2026
 07:00:26 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123102548.61362-2-frederic.danis@collabora.com> <6b044a95.dff45fae.23ef3e.6892@mx.google.com>
In-Reply-To: <6b044a95.dff45fae.23ef3e.6892@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 10:00:14 -0500
X-Gm-Features: Aa3M54rAaJDTq3_Z3YVSt4FRZH32aNp6fbTUYJJm5bIgQ099UlHC4Qn5zo4ksWk
Message-ID: <CABBYNZJaPVLm_v-EGPPN1mu-aXYUSi-dYhU8Ka9=GOQBbkYSeA@mail.gmail.com>
Subject: Re: monitor: Add an OBEX protocol decoder to btmon
To: linux-bluetooth@vger.kernel.org
Cc: frederic.danis@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Mon, Nov 23, 2026 at 9:15=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1219437/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.70 seconds
> GitLint                       FAIL      1.12 seconds
> BuildEll                      PASS      18.68 seconds
> BluezMake                     PASS      274.64 seconds
> MakeCheck                     PASS      13.54 seconds
> MakeDistcheck                 PASS      139.12 seconds
> CheckValgrind                 PASS      338.32 seconds
> CheckSmatch                   WARNING   250.09 seconds
> bluezmakeextell               PASS      90.52 seconds
> TestFunctional                FAIL      1145.47 seconds
> IncrementalBuild              PASS      321.27 seconds
> ScanBuild                     PASS      985.39 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [BlueZ,4/4] monitor: Reassemble L2CAP ERTM/Streaming SAR fragments before=
 dissecting
>
> 1: T1 Title exceeds max length (84>80): "[BlueZ,4/4] monitor: Reassemble =
L2CAP ERTM/Streaming SAR fragments before dissecting"
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> monitor/packet.c:2293:26: warning: Variable length array is used.monitor/=
packet.c: note: in included file:monitor/bt.h:4220:52: warning: array of fl=
exible structuresmonitor/bt.h:4208:40: warning: array of flexible structure=
s
> ##############################
> Test: TestFunctional - FAIL
> Desc: Run test-functional
> Output:
> FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts1=
1-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed
>
>
> https://github.com/bluez/bluez/pull/2880
>
> ---
> Regards,
> Linux Bluetooth

Copilot flagged quite a few problems with this one:

https://github.com/bluez/bluez/pull/2880#pullrequestreview-6023439406

--=20
Luiz Augusto von Dentz
