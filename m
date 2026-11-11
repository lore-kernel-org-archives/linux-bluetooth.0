Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794426561;
	b=hHYiCdIo1XzUW5Vf5qh7NyEdrjnyoMOa9RpYwQzpQy7i4yeT9R6wsMHCw5M0enLhS36y
	 b/qhzhyiVW5H+6m+kabbfIkTkIEV8Yx1A4GCLUtI2G55qZtOjB4+zuN41MwoSo0uCILUG
	 i2cklPhQcn5LK5dGD2lUMDX/tv1PNjbaA3qXRN6KhLNO7bGu6xaTFAXGimBDRTkAsOTmy
	 f7vet55CgsuWO8XCSi72Q5jRag0olZAxKF31R7hmU1WNLPa8/B6uOnD/mNzJoYS82RJbE
	 Kwkdolzksx9UPEUc1LEpDoyE4OkSdbRrLKbAJvL7CWB4ngK/JH1jYMiGNYRLM9XP+4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
	b=xe6qkDawTgzt4RRsms5Fe9ghig9iMw5wGzkjm8Gn5uRW0yVC32kRuKU7sv+tJQ65tTG7
	 Zq23w2Q2WadwxOBVYZuIfl+FrnEfbT1ahEgtXWDnNCg2uKoXvPVX4FqNaPSUHdymw4MdA
	 eE6HaG91cybNjcv8YSdCIcy4Mamrx5yRZxrtlJOz5/4emOVDi5JHWyt+y1EKJZu7yGbNK
	 CqXan59bIP3IyGri44HsNdH1V0c8frTrT5/PW9RO8V26jj3ayhoQ3J354hNNpXZ1deFSd
	 sO3oUJ4gzNIYxeZlm1weVsjxbO3se3cQR05+oA+szVFHNkSO9tYRN7v2AVuRwNxfM+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dyveBgFZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752C606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8752C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dyveBgFZ
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67c24619b19so3596277d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 11:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794426559; cv=none;
        d=google.com; s=arc-20260327;
        b=kAqRlHmtbaqWzyICwSGMJH5SSRWpcQJW9dVnz3HnTIOjS4UgGMaC3os1dN0SiDcSEl
         B1zHacnrghFbuJwu+IgIV9d5hu4Z6xr4keoA2zjqpm2QoQvDaxz/9DwwliKqX++CQ8H/
         xNR9sLSOCmfm1kZwXT3+vdJOpSbujNGq8EW1twpMCSgKcQqxPs8RzNnfBdbetm+ejNj9
         x2tDIQ39dCHuXoN5h9y3ZJB9A0Sn+s3vvkNVVfb8ekKrBsHB75ZeyFJ44XCGQiYYqbgT
         skxDHbptIB3696UgWBuNiD5/qONPFhMkDfR6qvduHBxZzSzyqf+XQuU38q6gpGQKqhsP
         mLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
        fh=JHiM8eEhqgM09swb/1Vts5eRT14tDrNjiB5MlkVCukA=;
        b=dpys2dGLFwDNrDWTbA1GkQNqDiPprqFES4mVPT558rKN1XwMz74/hj2yFlPn/CNSc4
         lIsgt/+Aq0PplS3dxTMbhrsQIPsKSXkOSzTX0jiW55xDGPx+Fw1BjiOxAQoCJCbP3GHl
         ff7RPT+EQetnpFk86xRwR1LL6kdVl1UJ7ymWGn/4m6MYNNGDjTZ7a99ICgmXqjg4117r
         kvV+rbzozO5edkW4T3i4DmLnKaNiXkspLKnfR2NWIHlMd3a7KoNZ17C/Wb77AoTIEIZS
         YNgPAptTs7sd3fX15UR5DS3dc8/qENr8QWZWIB9W1UkwZuJO6hH1vz0x6csRqlYUaPN5
         aFWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794426559; x=1795031359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
        b=dyveBgFZOSJ1AmxXJr3r+ZDDSuXIK8tQ0OFELTZLAYAsiF2dsH81Vwlxok6b9fbMEP
         t7zC9+EVmwjCOK/QC26cxcLW4IRQaCqP2MWTQE6YzfWG2Tdz2wb4hKYBcBSXBR17Ok5E
         t9vjzioN727NkjJgM1q/lf+Bz0BiED/xbQ9wij/mDpgxo3CKQWQeDMdIzWZXzU0SojWg
         6OU7onAy0aLRvH79OTl/RFgBqhggobkzHqNNIsvr92IpPrypxp+hEcRfuhZzqQvnqbQ/
         v+H4caZ+ytIGVQJd2xzECjkICGv/CIdiWdg+/dHQ8CTkki1meHdcYGi+McEBPK8z5fgL
         cmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426559; x=1795031359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrCovIoPNBvb4tsR5rxNuYJi73Uu0w0ac9LyvXjLqk0=;
        b=U6di1b4RRJOR/E7xlJtPrWH0rnl+65XpbZAyMTSKjyGwX9i3mPHq4NAL9/fkXnJ0Yw
         fWuuv2XY7LTjpXhG4FXqBJv4yTR2LsUKLITPAo4ir2MFl35idT+IedYgriWbpmRE197r
         qGlolvu//g2l1xgQ8mFxwD1Er2f8jmElB2kuHfyYZ61OIFXoLkfm8li+zbKkmNDuX4BU
         jSKHW5xNs+FA0bX5ynajN3m3KN/ffVMu2R+fPM5/91l0Dl4wpVpjBJmj4ccKKYTPphpr
         xjG1m3BOstkIps3uReiMVQBERQpGcCNY4gwWydg6pM0aNi497v4Nlgj55AdjxQjoTUZ/
         Iz6Q==
X-Forwarded-Encrypted: i=1; AL+hErFvJTmwcCplCWE29wpsiDT11wfKOnV4Wqf/C1OeJwMyxOPE/CG4BECl9nb9FuEIFnk8i1AcBDLlzgUmClJyYq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KvxJ5LwwCoinULl4N2Np6+KUzwnH9xCkaYpt6kNBSYCDFeyMb
	h2VkdFy7Az4PXD5yqAoV15DCUIJylMGUo3i2370gxeqHR28myG+obbL7UBXYTkNSLNCwLoYR9Fq
	SrN9clUQEj0QBZpT1jcD095K10Mh1QXE=
X-Gm-Gg: AYBFou33FKlEQX9YdekHcQeIqskL2E5Tz7uZpTwX4d8snwz169uAEMKjtT6NaGxwNj0
	xXmbaI0iLVfYQkJflNsEQu5SZKrtyWuVUpBL/VM/MM4K7ZF2SFEWp/I4T8XnXCRXAz01cDso+mZ
	rCtw3V3csdgzyazAal8p6oKA2xsd/3s3atQhdlKT1wdieBgOhYn2oE+SRetj4YBbURk3fHRpr/U
	p+0ZuaBjGR3dnj45mgt5YxPW7Zd68l2KybfIY4TZZH4v4BPxIlrdgzSMQ0iYRwRZCZi2FF0Y42K
	lrADk8K83kJj6qPFwZa2b2f/2b9bKgx+3mnN7nSVbTuUHXratKBY8S8Gjsqj63kbsLjzkdkMitR
	EfnGTV9VqiErVXXOzjTF7Qb+6BQzgOq9TyOQ+nINRx99XRRc/inKRhgOyDOv26BD4jrn0rVJpYr
	kq9SiKghPxBK6mWu7c4irI7TGLypdc7BqStly2/6pwIi5MXZsUloiirL4955s=
X-Received: by 2002:a53:cec6:0:b0:679:9e0b:dc4a with SMTP id
 956f58d0204a3-67c67f5905fmr1755689d50.49.1794426559390; Wed, 11 Nov 2026
 11:49:19 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110175334.676816-1-piyus@iiitd.ac.in> <20261110175334.676816-2-piyus@iiitd.ac.in>
In-Reply-To: <20261110175334.676816-2-piyus@iiitd.ac.in>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Nov 2026 14:49:07 -0500
X-Gm-Features: AclHuK-nfByfHGxFAPmMdYDp3chGaQIH-KV5UpMqKHJaLwdjvVYyKqOTEoEvZVI
Message-ID: <CABBYNZL9GjdZvU6Z8B2v5_5iGXBno5K-GvqkKfX5vjEaTkV9vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_sync: drop adv instances the
 controller cannot carry
To: Piyus Kedia <piyus@iiitd.ac.in>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Piyus,

On Tue, Nov 10, 2026 at 12:54=E2=80=AFPM Piyus Kedia <piyus@iiitd.ac.in> wr=
ote:
>
> An advertising instance stores up to HCI_MAX_EXT_AD_LENGTH (251) bytes
> in adv_info. How much of that is accepted when the instance is added is
> decided by max_adv_len(), which depends on a feature bit in the
> controller's LE Extended Advertising support:
>
>   ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH
>
> ext_adv_capable() reads hdev->le_features[1], which is re-read from the
> controller on every bring-up, while the instance list is only freed in
> hci_release_dev(). Instances therefore outlive a power cycle, and an
> instance added while the controller reported LE Extended Advertising
> can be far larger than the capability now allows.
>
> hci_update_adv_data_sync() picks the writing path by that same bit.
> Without it the legacy path runs, and hci_set_adv_data_sync() writes
> into struct hci_cp_le_set_adv_data, whose data[] is HCI_MAX_AD_LENGTH
> (31) bytes on the stack, while eir_create_adv_data() copies
> adv->adv_data_len bytes into it. A controller that reports the feature
> on one bring-up and not on the next overflows that buffer. This can
> happen when, for example, a USB dongle answers LE Read Local Features
> differently after a reset. scan_rsp_len has the same problem against
> hci_cp_le_set_scan_rsp_data.
>
>   BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
>   Write of size 220 at addr ffffc90006b679c1 by task syz-executor
>
>   BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
>   Write of size 220 at addr ffffc90006ca79c1 by task syz-executor
>
> Both are reached from HCIDEVUP by way of hci_powered_update_adv_sync()
> re-arming a stored instance.
>
> Bounding the copy in eir.c would leave the instance registered and
> unusable, to be retried on every bring-up. Unregister it instead, once
> the features have been re-read and before anything is scheduled, and
> report it with MGMT_EV_ADVERTISING_REMOVED. Userspace can add the
> instance again at a size this controller will accept. Dropping the
> instances before the list_empty() test below also lets the default
> instance be set up.
>
> The removal is under hci_dev_lock() because
> hci_schedule_adv_instance_sync() sends commands, which cannot be done
> with the lock held.
>
> Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH=
")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
> Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
> Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
> ---
>  net/bluetooth/hci_sync.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 9213e3ef9f26..ee8b1cd9dee5 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3608,6 +3608,34 @@ static int hci_powered_update_adv_sync(struct hci_=
dev *hdev)
>         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
>                 return 0;
>
> +       /* An instance's data was accepted against max_adv_len() as it wa=
s
> +        * when the instance was added, and that is a branch on a control=
ler
> +        * feature which has just been re-read. Anything too large for th=
e
> +        * current capability can no longer be rendered: drop it and tell
> +        * userspace, so it can add the instance again at a size this
> +        * controller will take.
> +        *
> +        * This is safe as long as there is no command send while the loc=
k is
> +        * held.
> +        */
> +       hci_dev_lock(hdev);
> +
> +       list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) {
> +               u8 instance =3D adv->instance;
> +
> +               if (adv->adv_data_len <=3D max_adv_len(hdev) &&
> +                   adv->scan_rsp_len <=3D max_adv_len(hdev))
> +                       continue;
> +
> +               bt_dev_warn(hdev, "instance %u too large for this control=
ler",
> +                           instance);
> +
> +               if (!hci_remove_adv_instance(hdev, instance))
> +                       mgmt_advertising_removed(NULL, hdev, instance);
> +       }
> +
> +       hci_dev_unlock(hdev);
> +
>         /* If RPA Resolution has not been enable yet it means the
>          * resolving list is empty and we should attempt to program the
>          * local IRK in order to support using own_addr_type
> --
> 2.34.1

Sashiko flagged a few problems:

https://sashiko.dev/#/patchset/20261110175334.676816-1-piyus%40iiitd.ac.in

--=20
Luiz Augusto von Dentz
