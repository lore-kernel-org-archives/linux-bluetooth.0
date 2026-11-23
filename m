Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795443495;
	b=KyW5iZz+DskP8op948IBsML6+C4sMZyegqWJCppQkr3OQhyWTnxRVBS8hn/SSzkKVYFx
	 DO0BDQ6rVY0X/3AWVc8Atghn4Ol2SCpZFB8WeoFp+URrROK1PDzi2RxqMQ6/i8+E8JlZD
	 9OQnjCsn4F/PcI+29cw75bSwJ1i4uK3PsyeNUPreP+HxMrVYhClbt57dwBkDQxpRomnHS
	 yTi8zBLr0WAwz+uQ2OnxnXDwZqnlt36rw/Vw62+bdaKWnDCoYeKACGXS6E0IwkdHEa5GH
	 MjrKEY2BYBXGCplHRLyDWHaAT71OQM9BcNbNp5OKYy9XsVeL9WcC+NdPBPKb0hSqbsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QrXghCIwH0qKWRuSZNGllp6+4zGOUV5ncqxHPuY4qZc=;
	b=TGURZ9Fm3+BPPX1kdv8bpQZtH1Z9+UTlUQfhmaLPGwLQBcFopyJwjQD6Px1chGIKpEjW
	 Tw8O8+hrKqQ7dAwAbrMFHuCh86Npm9ITObrhcVzKczmmo/A2gRJ0kosXoNI4k/VshvQ8i
	 +TvaLngsTTbRUYXPTPRzHKSn6wDVe4AEaZTqIOZhIdlvWeibWs2Nsk8Yez8FKlKDw+k68
	 BIg2gOx5xVoF98cKP4jCDHkHC8vfYGYsDRSVDXBY714bO475eqORcec2qvTOCYrBnUoOp
	 J3lu4tBH7Dlxm82nifuKC5AOV+VWvjkisWw2hkx+ESH8L+j/NV1EdouH6IdQgf1mbEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hmXxunpa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BAF606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5BAF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hmXxunpa
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b51389f58cso34450297b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 06:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795443494; cv=none;
        d=google.com; s=arc-20260327;
        b=fagPj4vZAe8ZR5Rwp/L97S36FllVxN5hAIYsbJpbURR1BQKNqpylzu9lvJuimn1BQ2
         kaf9WnI1NoSgg9NED1stS53FZayhBdXVrkiDpDzGxPUAE+sgSPedj30KxdYMo4KaQEyo
         gq4gPyr9sGPYmbjtfakFnRhgK5SYzrbEmIwNhn17C/gS21ydP8VJyaog0dOIKluBqZrM
         wKAk1+BrCKI1IIEBVYS5XVY8iqP/qO2R0eV+r5E7bCI4SHC4UZJZwFoOa3XYuycryGmY
         ocZQ5NcCZwJ5f7hPnxAz4AfqnRuf32GkmQh6oeY2gNx+AHEB06nSB4IaFDnzN7Tsq+Yk
         FDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrXghCIwH0qKWRuSZNGllp6+4zGOUV5ncqxHPuY4qZc=;
        fh=UA/cNErwqknDfefZj80dwpXzGaUZl6eKpR9TO5+4Joc=;
        b=DmJ+iOUxNnzBYX6StGuJgqJEFwJFIr8FqKXz0tnvhKi1xJreZgWmcGufdaQ90IWrH8
         aIhv1udk5WdhaHygLa0gggAEHH5p+0e2rDLGnnAK2pjYWBQXxF4qhi5Gt+uCglKsCXh5
         MwVAsljGy4cPY87cVQfLRINGazDLueoiX7Ta7T6loQPAmk+E9OzOd6g8KMXrOvL5BAcH
         sIXRI6xCdXx0P/VOTjxhbTGibdjF3Gi760DrcpWM63n9z3rqZSWv+su7x6cbwzM7k/jL
         8SawFUnwS3aXqhhLBNtEMfHA6hzZoBOm2CIG8viWNE0pQtYylxZZws1ZqSir1AYR6hTm
         b3+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443494; x=1796048294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrXghCIwH0qKWRuSZNGllp6+4zGOUV5ncqxHPuY4qZc=;
        b=hmXxunpazDBQ3HMvxjmEUk6OlnJFXWu0OM9A+0gfwjchZ7nXHYrXds6MdSKI3Kkd1T
         0GgOrhj+GjBdakqAs5bX+OeYWOG2jCLzlE9GiV5wYie9nq+oBiXfjlSiFofIkuKoBGDL
         YTqxC4llhjRrvnRv8QhQNVQ2C6kmut6542JnxYaK/A3csaGkCM8w5jszB1uJR5On5+1v
         P16I8F9FSMKw2JcH4z3bVdqZpOvaQrKpClXTkkH0f29FgadWlLomhZTNKBMgTkNBwB8F
         cQKEGx6IElKy267i3CeRamK+3gfLL1xOTZpw/8BNvpUqBsMMxGRk0G+73JZDj8Hubo67
         Wulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443494; x=1796048294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrXghCIwH0qKWRuSZNGllp6+4zGOUV5ncqxHPuY4qZc=;
        b=SYqbZ/AwngZ92gTZ1lZjKbJ2SHMj05jBlbPsnQGmYjg+CcrnhbOyFZ3hOglqx2Hq2Y
         iZeqPLqNNzdktM2/G/vjhHbSHJsa62/NF5VM+hTIrSHQZNS32d3noz2lTGf+381linzA
         WV6kZToxGh0Y8XBt/9IcqAaS1OTximO/fNcr9Cw+F++qzDYlgHnnU/zoqUNeCHddyifq
         RS3VSH1Muws7/Pr648hy3aXnW8G19T4BlKxvitXVM5bGo9NmB0JkaaVgzerKrg/Fs2u6
         LNvgvxNsviDJTHx0o9c6g2VpY/q4sFkhrqwRFJeKejtDU5F8v3qErRVIuOHcCRgjUfrj
         8NkQ==
X-Gm-Message-State: APuU4Z9PrDCgEVA7mCiekOFF9tIa1s9dO0AuJHzeSyr7vb8m2eY8Kwd6
	NnEPBhj9MzbH9PQ89ICHo/s0KOqCnlVG5WW9lqhSE6LGJmvQ7woqFLRJSLCt7SgIi6PdTTbpXA+
	D34QrP6qpkXd+9zhEtx9IRpDNN78wHx0hwkXu
X-Gm-Gg: AZFdTZesyFz7dCh3zfOSUzR3LJAl+zLQB+RHEcJ5jUricLRAHJGeFnYGtKa1X8pmoO5
	lXQQSPD4DH8YIBrce99bUzlBPsnIKdxSodnXgPWfdaP3fwmjbhhqtnrFwMYrk9vHCSnpAgb5paH
	oMwt7riWP6ubOZHcqkhanSTFpUQsPe6vbSfGC++GknsGHRaVlIHCWgQuOrx/a2Qm1OJU17NForK
	+5IzDh2cDAqjQxbkJB6dsWt5upBULMz8Xfn4UxOgGpfMgMovlIFi3Vv0zlFLsGpWzIhGfAdcPTF
	v0l2OBCP9uc4BCN4OdlONjUyCAQsfZiK7qRsv2PDsqjpbrCMOHT5f5zb8/hleRzpT1Dc+ZUcS0q
	Pq/fPjlFCqIXPu12EmzDFMi7KR80MXzwINY3r9CN9pptDYfgSNSSSIzdlZhRgXuzLoKVgYaxkrk
	IZYd4wOaCzcGJLd4gEEszZQwqcKRpVGQlO7RxBGCFuEGyra1PYnSgKdLUDdk4=
X-Received: by 2002:a05:690e:d5b:b0:67d:f1f8:d147 with SMTP id
 956f58d0204a3-67df443b9cfmr3114560d50.42.1795443492079; Mon, 23 Nov 2026
 06:18:12 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122201328.2852883-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122201328.2852883-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 09:18:01 -0500
X-Gm-Features: Aa3M54rQ0n6fngb5rMBysttI0R749sQ_KKCNsOs7BznPA2chj36pKQTB6ZTjWkk
Message-ID: <CABBYNZ+UG_2o-RjzUDyzYv5m9G2N4x43TQKdPqNgrBepa8gd1w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Don't filter duplicates while a PA
 sync is pending
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Sun, Nov 22, 2026 at 3:13=E2=80=AFPM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> To sync to a broadcast, the controller needs an extended advertisement of
> the source after LE Periodic Advertising Create Sync, because that carrie=
s
> the SyncInfo. Some controllers, for example an NXP one and an Intel
> BE200, only use the SyncInfo of an advertisement they report to
> the host. With the duplicates filter on, they report a source once per
> scan. Passive scanning starts right before Create Sync, so when the sourc=
e
> is reported in between, its later advertisements are filtered out and the
> sync waits until the host cancels it after 20 seconds:
>
>     21:59:14.147 > LE Extended Advertising Report  50:1E:2D:9F:95:23
>     21:59:14.149 < LE Periodic Advertising Create Sync
>     21:59:35.131 < LE Periodic Advertising Create Sync Cancel
>     21:59:35.132 > LE Periodic Advertising Sync Established
>                      Status: Operation Cancelled by Host (0x44)
>
> Turn the filter off while a PA sync is pending. The accept list limits th=
e
> reports to the source being synced.
>
> Steps to reproduce:
> 1. Start a broadcast on another device.
> 2. Join it, leave and join again, repeatedly. Rarely the sync takes more
>    than 10 seconds, and until then there is no sound.
>
> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connec=
tions")
> Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
> ---
>  net/bluetooth/hci_sync.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 638589f77081..88ce0ceef394 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3645,6 +3645,12 @@ static int hci_passive_scan_sync(struct hci_dev *h=
dev)
>                 filter_dups =3D LE_SCAN_FILTER_DUP_DISABLE;
>         }
>
> +       /* The controller only syncs on a report it doesn't filter as a d=
uplicate,
> +        * and that report can come before the sync is created.
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_PA_SYNC))
> +               filter_dups =3D LE_SCAN_FILTER_DUP_DISABLE;

We should probably check if the HCI_QUIRK_STRICT_DUPLICATE_FILTER is
set though, that said hci_le_past_params_sync may have a similar
problem wrt to mode but I wonder if we should really work around this
or inform the hardware/firmware does have a bug, because filtering
duplicates shouldn't mean treat as they never happened just don't send
them to host otherwise while attempting to synchronize a BIG we maybe
flooded with PA reports that have no use for the host.

>         bt_dev_dbg(hdev, "LE passive scan with acceptlist =3D %d", filter=
_policy);
>
>         return hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, windo=
w,
>
> base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
