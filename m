Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E83BB9FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297667; cv=pass; b=nBG2uSI97CPu5vzFBy6iCyAJz+GbyZeDorczAMcatojClolrSJsoe9aL/SS9dYu38VEAaYBkwEegEKDwpSEoYcN4tBv1+Iul1g3yPbmBb6XQPDY7NyPZ1/auUEFSUKY/Be5ekDewRyZ+C2a9tJl3PcndGqi2uBb93OFraFaBr1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297667; c=relaxed/simple;
	bh=Va9hV5lPpU3v0Or+rwQKjO8Euh5dC0K2hdQzLjbVzfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7QKMtCmCnRZGt9ds6JwxyIhEUflE8zRk0qOsL9h1wSy/iERvIpXknb5JmRNU8OPiFr1yW1f88kt98hYQRXfmyst0wGPutGD2QvjAQeaeTYwl5HZrcH4SPz5vkHL4HwK7q5rVgu9JMWCeC3AYyzpiEqtKOC4XdfL85AC2j9gaUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoFs/Gto; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoFs/Gto"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81e9d8f3289so56440437b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784297664; cv=none;
        d=google.com; s=arc-20260327;
        b=nCqIfK2wpX/4Hhu6dBtwJX5I96+JZwEjsMJHDqHxgjHcqDKSLPVmjBWCRaM2d1kCCH
         raEO9exeoo3CgOrt6sMAepgkxsdc7bhndtk1BGKXxenIpyKOwzdUF/BeIbbqx9N532F7
         HN5k5vgeKEl7CsCl20m/gQkwdLVux6RPQUgSCGwaQ9P5CiPi2o8IN4GUi5LUP+2V6xFm
         /ord1576iNPN6oZeWKtTU8Q+Nckkx8DxvDmh3B4dGN3UD74i+pcGcE2R4JlikuCTT85B
         jdMSvjqOknZotjKsbY9e0JdT9aeayTMfhgG3HJKXKZ04PAnixFcJn3j8271BGTviL/iB
         z3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HojRGrf742nLV0xRTX05eznvpOep/lzC4//3gy9WZiI=;
        fh=OVKswAkwWiYRiw4/jm1+w+lY4E/3x/2/3xjGrBhrIWo=;
        b=KyuFdU+AaFhmQWwcUOofUm8KoZMURO5O8yxb0bLrWdMcGq2/WU/Gq5yzS4vwXrIktB
         ieL7fjZdyNdalgll9Vm2O5wqFHeCkBgHJ9mDw7wWfBbQf6fRmCMSJoAY4wL50poc/7Zy
         7kb6rda1H7N5vIoGkagtQDVggsQfQBzNn7QxpSYsqTYC4Ska2nTO7PPQeNDPovQluQs3
         TqdgfP+RIpvCkpbICbhlBrVt18655aGGPfPovlhK6RYbTzfJeXq83BCae5aab8sivXrZ
         J4XGT5gahtrE6frI1o6cPXolAwwnkG6S724r3HuINYpaiDDeN5r93svC51n2a1fWxYXG
         rpUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784297664; x=1784902464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HojRGrf742nLV0xRTX05eznvpOep/lzC4//3gy9WZiI=;
        b=AoFs/GtoaeFFeM2HhZwDNoRISH2VkXuaw2c3IuSzhHiitYAVVjqbrVYwf+Z+P0Piav
         FAeJHK5E8vyuW8/vvsAU8dY/JW5YHHrBAwy2MuCf0iDkx58yYwDo7WlRQJNP0Hby6SvR
         Ui/lFAKYSkAsdyNv+EtfxnmMxLxBkSY4wLdgkxH2c0uaP1Y2Q/Nc12wIpDx3uPAvZBee
         7WGdIALZ1MJjTc1JhEDxitlDFJAqMWo4UBRipKXqfrwNREWyZaUNBXyoqjDMRNAxZRDl
         womw2wK2hw3jIR7i7HRBxb5SPmCDdzX+1i7a3BvBrmtSuK5vXamM7XRfc0upoFMevgXX
         LHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784297664; x=1784902464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HojRGrf742nLV0xRTX05eznvpOep/lzC4//3gy9WZiI=;
        b=MCsLaq5AWGv6hDcleT/t5kXMRlo5KzELRyXx0nvVMOa9o1RyMjGYhjZTqh507MIlkP
         YwvPMKENd5DB17qC2SwEg5DohATgeCYYg7/xROo6sX+Cd0TOdeRLzK9ILakSfb2FaLw3
         YKU9hXjZMxx0zdfTPE7N3Y9jomKlan7rJ8cZF+Kv8ha7SY6Po9NecuBCmKNMhGf3AEaI
         5cE+GBf1U5xYsGlk/slzNOCuXpV95aoMYOYKRNcWBHx/30o8HKeGZkTv7Yak3l2MYV/E
         ZMAa/TYGW+QtueTAsNMY+7Civ4YodEjfHmF/uxw6vtnFE2KcJ0d3pLGrV4C6rtHNmZwL
         ewOA==
X-Gm-Message-State: AOJu0YyUxx8Er9Rr41zOhURFgy6/9mGzpQK30L++Zr5IQXPWv+znIfWm
	ht5CIbMTTNiIRSZe+dZCQxSTizblL4f3zsEb4QwgJkolO6KPJEgesV7mqi6GAFyJlhf8cINPyv9
	BqqUivD656FRzRg6yfUisc0lRgp6sg2+8BCPY
X-Gm-Gg: AfdE7clh6/WlTFjtNZ+XkDrj1YeZh+0RKZeDdDiaLPOBFr/6dTyh5WaAYzPTSxOj0to
	WPcEqHP5g6qEWK9c5KnfFVr7iDkcLLrVJANxmHSH55Rq4DkHV2p2JayZ0HOKN+kvYC3OBqZXJvj
	Vfde7/DABAzoA2/Z4e30pGtucIGMAVqd+N6JBR6T6/ZnG+8KzvLZ8YrskG/UJSNiq8/lna4XBiv
	mYqGC2yRqjmWnO+HWoSu/H/Kg+Wz850qrIT3iVoyo8W+FDj5yLaE3e5XO93Ci4YCfTik504ZAzA
	eiWxV5qXydcQdaJo7lFFkXdtF4lfgWkV9zpa5y5cRzhbM/20appBN1QJj48=
X-Received: by 2002:a05:690c:6303:b0:81e:51aa:ff79 with SMTP id
 00721157ae682-81ef25191d2mr9016297b3.18.1784297664327; Fri, 17 Jul 2026
 07:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716204514.79356-1-pip@pipobscure.com> <20260717082347.8429-1-pip@pipobscure.com>
In-Reply-To: <20260717082347.8429-1-pip@pipobscure.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 10:14:12 -0400
X-Gm-Features: AUfX_mzHka_t2JtJmUPaKRyI8XU0L48bzb1uTBFshWiBb1KcfVbACPV7ZnGWnvk
Message-ID: <CABBYNZLZXephdTwsvp7S5z_V_wRMRx-sLJy9dQGA7mH5zSfX_w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] adapter: Infer BR/EDR only at public LE addresses
To: Philipp Dunkel <pip@pipobscure.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Fri, Jul 17, 2026 at 4:27=E2=80=AFAM Philipp Dunkel <pip@pipobscure.com>=
 wrote:
>
> btd_adapter_device_found() records BR/EDR support for any LE device
> whose advertising Flags lack "BR/EDR Not Supported" (EIR_BREDR_UNSUP).
> The address type is not considered:
>
>     if (bdaddr_type !=3D BDADDR_BREDR && eir_data.flags &&
>                     !(eir_data.flags & EIR_BREDR_UNSUP)) {
>             device_set_bredr_support(dev);
>
> When the advertisement uses a random address the device gets a BR/EDR
> bearer whose address is that random address, and start_discovery_cb()
> then prefers SDP over GATT:
>
>     if (device->bredr)
>             device_browse_sdp(device, NULL);
>     else
>             device_browse_gatt(device, NULL);
>
> SDP requires a BR/EDR ACL, so bluetoothd pages the random address. A
> random address is not a BD_ADDR and cannot be paged, so the attempt
> always ends in Page Timeout, and the failure tears down the working LE
> link:
>
>   connect_failed_callback() hci0 5A:B4:98:1F:CC:04 status 4
>   bonding_attempt_complete() hci0 bdaddr 5A:B4:98:1F:CC:04
>       type 0 status 0x4
>   device_bonding_complete() bonding (nil) status 0x04
>   browse_request_cancel()
>   btd_gatt_database_att_disconnected()
>
> Nothing requested the connection ("bonding (nil)") and the LE link was
> healthy. Any LE association that outlives the page timeout is killed by
> it; measured on one host, applications get about 4.7 s from connect
> before the link disappears, of which GATT discovery already takes 2.3 s.
>
> Current phones advertise Flags 0x1a (LE General Discoverable plus
> Simultaneous LE and BR/EDR, with BR/EDR Not Supported clear) from
> resolvable private addresses, so this triggers routinely rather than in
> some corner case.
>
> The Flags bits describe what the device supports. They do not promise
> that the address it is advertising from is a BD_ADDR. A dual-mode device
> uses the same Public Device Address for BR/EDR and LE, so the inference
> is sound only for BDADDR_LE_PUBLIC. Restrict it to that.
>
> The other two device_set_bredr_support() callers already require the
> device to have been seen over BR/EDR (bdaddr_type =3D=3D BDADDR_BREDR), s=
o
> they are unaffected. A device later seen over BR/EDR, or whose RPA is
> resolved to a public identity, still gets BR/EDR support recorded there.
> ---
> Changes in v2:
> - Commit message only; the code change is byte-for-byte identical to v1.
> - Dropped the "Assisted-by:" trailer, which checkpatch rejected as a
>   non-standard signature with an unrecognized email address. The
>   disclosure is kept below the --- instead, see the note at the end.

This is a false positive, in fact we do want to know if this was
created by an AI Model.

> - Quoted the two code excerpts with spaces rather than hard tabs
>   (gitlint B3).
> - Wrapped the bonding_attempt_complete() log line, which was 76 chars,
>   onto a continuation line to fit 75. The text is unchanged.
>
> This patch was developed with assistance from Claude Code
> (claude-opus-4-8). It was reviewed line by line and the results below
> reproduced on real hardware by me before submitting; nothing here is
> inferred.
>
> Verified on a dual-mode controller with ControllerMode=3Ddual, against iO=
S and
> Android peers advertising Flags 0x1a from resolvable private addresses. A=
 GATT
> association that includes a ~7 s user prompt, which previously failed eve=
ry
> time at ~4.7 s with the Page Timeout above, now completes:
>
>   before:  connect +0.0s, GATT resolved +2.3s, first exchange +2.7s,
>            Page Timeout +4.7s -> LE link destroyed, transfer never comple=
ted
>   after:   same host, same peers, classic still enabled, transfer complet=
es
>            with the user prompt taking 7.0s of it
>
> Setting ControllerMode=3Dle instead of applying the patch also makes the =
failure
> go away, which independently confirms the mechanism: with no classic radi=
o
> there is no page to time out. The patch achieves the same without giving =
up
> BR/EDR, and A2DP/HFP continue to work on the host afterwards.
>
> make is clean with no new warnings in src/adapter.c, and make check passe=
s
> 39/39.
>
> No unit test is included: src/adapter.c is linked only into bluetoothd an=
d not
> into any unit test target, so btd_adapter_device_found() cannot be exerci=
sed by
> the existing harness. Extracting the check into a unit-testable helper lo=
oked
> like scope creep for a bug fix, but I am happy to add that if preferred.
>
>  src/adapter.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 4ffa32a..30e7679 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7415,8 +7415,17 @@ void btd_adapter_device_found(struct btd_adapter *=
adapter,
>          * older kernels send separate adv_ind and scan_rsp. Newer
>          * kernels send them merged, so once we know which mgmt version
>          * supports this we can make the non-zero check conditional.
> +        *
> +        * Only infer BR/EDR support when the LE address is a Public Devi=
ce
> +        * Address. A dual-mode device uses the same Public Device Addres=
s for
> +        * BR/EDR and LE, so in that case the advertised address is also =
a valid
> +        * BD_ADDR to page. A random address (static, resolvable or
> +        * non-resolvable) has no defined relationship to the device's BD=
_ADDR,
> +        * so recording BR/EDR support against it makes the device look p=
ageable
> +        * at an address that can never be paged: SDP discovery then fail=
s with
> +        * Page Timeout and takes the working LE link down with it.
>          */
> -       if (bdaddr_type !=3D BDADDR_BREDR && eir_data.flags &&
> +       if (bdaddr_type =3D=3D BDADDR_LE_PUBLIC && eir_data.flags &&
>                                         !(eir_data.flags & EIR_BREDR_UNSU=
P)) {
>                 device_set_bredr_support(dev);
>                 /* Update last seen for BR/EDR in case its flag is set */
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
