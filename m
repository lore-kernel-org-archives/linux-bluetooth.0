Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795618673;
	b=UhOgoHcI3PMZ32f3J0q1l2j2PTIWhU8zfY2gU4kB651rQg2lyFQeSDSsWa8MqwhZvzL0
	 RBrszZRSRIwfr2WHl7+nlqinGDMBPHCsf60c+OMbBwsRc0S7L3mlHBrZqEwRBw8K5mpeg
	 DkfkiczTMnnjizkIiyBe9/snsweuLY6R5NSfntjojAFQFetG+APJ4TNIDH9B4fxJn917C
	 ihbZWRHlMAeZtFf8cA8XHNkEMJdB/C4aXZ2SveGKJ7mHClLgmWYZ4U0HIAhjwyK96N6D/
	 x+Vx9404nryn3X7q7lWBxOYHjlFm0EV8EyQmYEq1Ezm5+qhFYKyXNiJ5x3OvHIgBfpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=q+BPEAlNLCRvXPJ8PKN+/nNbyTc12wIlOBgvlnlepoI=;
	b=cFbkP74ZqoR6r1rrfjXVq8Dna6EsDxo0VU5zwoaSbC4PNVLp5ZTcrgtOkSVQRSX4lqrj
	 gFQfuChmu5WhDexLvWgS9lOFqj6mzYH+sfpL78OcphgpMoCxIc9BlT2c7aOEyEImi6lGn
	 4feyS84xwm+kRWtWxS6di5H6dSIvKW25h8W3B7bz4ojTlB2iiS+PMAoLnw1HW+a38MGpv
	 ca/IudKC1Z/CZDluR8FXCwtfdZAuocBXHpRAesFinlbZ/T95FfgkhGgAz+n7YdBUBXsQu
	 4VuLgjVXrRXyAHcXe1uzuPvh5wDlhctlCysRNAAsuve6rOnagp74Sa02lREBvW6i1Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUMg0HZ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D97606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D97606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUMg0HZ6
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso6150399d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:57:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795618672; cv=none;
        d=google.com; s=arc-20260327;
        b=jttKbxvpHZ1xyxjfIVI+75xuNEfQlsUE/fxpglXgwzSYmHiJoP9SAkBXCHhSn0tr/b
         pWv0gNK2ILnPIHksrDJdLauaMJZN/rwdPdUpbQS9CxXojTT3+QXsrM5uQOsda7cD2QwU
         PwG7+EtaDWZFnJxZZk9qpyzNcJl1kUdnxb/jk0P5qrIej3SepDnRq5VEjAPyER3vKJbY
         nDa6AJ+Hv6E1y1JlSUYUtZYNJWpPlu90nO5zQLTl4qJAAYNxc8Dg//1ib8RIVQVPNjFf
         u92dE1Il0cgum2h2AlsURoX6mH83kK59udYkuPCJaj5DBOB3ssucXw8rRZhGc+I6m0Kq
         o+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+BPEAlNLCRvXPJ8PKN+/nNbyTc12wIlOBgvlnlepoI=;
        fh=EUbNqslT/o7upVbFcoOpU/6y49+dKDRFH2r/i0QHm4w=;
        b=ovWXTnYcmAocWAtbHiAbhZVvMvYeVR3mu9dTMyrqhRzYGY3IqRTsolLmmCTy9oR5Wq
         gsu9CiDVg33aHWudrJWKtPPUIYU36UzvcAPbyE98zuxiqpOcnCKl7cckPX+7wGPImbn1
         QwKyDb5i3Q2x12IiOb7jQUKeiW7egKLXxzl6ZGvjWBBHa6k0xvXWdncSgU1MKIdyTOrL
         1yedWqSiDl8+Cna85qde7NTMndgCLbHFtCZKY7ET49CKpugIoTcqyW6z+XrfEHMxtayt
         q5/nNRAffzBVd7O+oIi2lDZpYYnu0lbSZMMXsAWOdNsBJHveuXnGqyYQpRNfV0a+ulJZ
         apRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795618672; x=1796223472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+BPEAlNLCRvXPJ8PKN+/nNbyTc12wIlOBgvlnlepoI=;
        b=AUMg0HZ6auPNta4fuENdP2v23mX4Yj5aNzGaEM/pyRVioc1ON1+rjzcC9OgEIyMKGc
         zrQOaW1vIqi340Emi7LOIEOZUofhvmPOn/t3T8MN4b1zE8fjI2MllSF5sEsKzHls6M9n
         gsYPah+qsuFtwxMioT5KBuN1AYao6DDbgxCN/sprhXkFcse4xnUNjTFbHGpOiCAN8s+J
         9B/oWTY2Trydmskc+8papxTFh/w8fbWdbn8e9l2DB2bvqlR4UHPKlQJd5Sa7G4ZUmHQL
         RLTlaVX8QfcCa1FCYIzFYU9wmNOVC7h1JOKDdEeo5TadYoavTuj19DR6av5vgfF2mM43
         4RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618672; x=1796223472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+BPEAlNLCRvXPJ8PKN+/nNbyTc12wIlOBgvlnlepoI=;
        b=flF4C1dUJbfhs0wuuBHZXTNPQAUW7QApRmNIfdtBxYvenI0JJe7Mh4D5VozYKraVTf
         ZBNy79C17qvDw+AdAVTiImB9UHf9KHeb/CX1wakgHrZv67Yu8d6sSh0aUaCnAsUShx9d
         27a4QVTad479IhuDhzkRV4Wcy7k8SguZs/tM/9YE2k0cnqhTP7VDAVuiZXNAApAWWt7I
         Dn4j7BmoO5V6YMNQiOYR1MGP7YJC08TM35n0nSoxQxVBjPTVOTvqUGJtANkmoaUSzqtn
         NPkq0ApstJudVaRClo3r70TgGUs3KpybVqbf0CtRnH877wkW2NB32LHaZKfctO5ocTb9
         B05g==
X-Gm-Message-State: APuU4Z+2jCnPB6d6yPEMvu8S/aDrcp/RfYvqn1CQpSynWljI+yT5hBwc
	2ve4fShby1ZUM5Fa5GTkuRXXI7UxV83nmHfj5jaVImRXZyXH/tU2Dpq6S+uyrYE9Q6auwJGWsF9
	gDcAJB18nVGyW4uVsmZ001T4L/tMo3WotmvsS
X-Gm-Gg: AZFdTZfxSLh5YAX5CyOKqeJ59wZeQUCh9EtQXaZuu2T3EmCPdtTJBh9xqGju20XiQSV
	U2qtWceKoY6hfsPUx1+MZaA5l8m+sVL3QaVrnjEskzHgQP4EIv/rHG6yvb8PGyXcxyc1sFQF+3n
	SPcNnMAKU7pg1SnCWt5apjRuRPG7VmCbCUi8Vu+T976oMQOgywEwW6Ry+1LoI0FUrgMaDeP9HMF
	9ow5lIB8J5QgV4VHqv15iNks7AuAM60HwAl77t6OHjlQXIGLirwQoW2kwMH8knwOGwjXI9L3kht
	BIcbw1IrpytAWQORlMWcig5fDDh5jdZ1Ttz8QRwTsHAsZZ4N4l5fdBZsx7ClCh66Pi7s/zdMmlb
	YMDafwKCTIt4LhTpYFqh2Y6EDrIcZvE6sN08JB0DPjll8tgE+ZvMde8wr/52zBA6oKZ7XRwQ+gB
	K2OgcmrjF3mzazcovz7or4ln11OcCBqLGURK20M5XDeixA2il7X7+X5HfQNCY=
X-Received: by 2002:a05:690e:1c08:b0:67e:5ce:90ce with SMTP id
 956f58d0204a3-67e05ce91cfmr5102805d50.44.1795618671729; Wed, 25 Nov 2026
 06:57:51 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <e565cbbeebf165ab5e6efc3c3f2764bc88da929b.1795535897.git.cochcoder@proton.me>
 <6b05fdbf.4b6e150d.279180.68b7@mx.google.com>
In-Reply-To: <6b05fdbf.4b6e150d.279180.68b7@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Nov 2026 09:57:40 -0500
X-Gm-Features: Aa3M54qdab_BTlFCzOESiSayiCHEH42aVFB906wb_ap1X-POFud9UHni34c478w
Message-ID: <CABBYNZJaCc-C=xjPLK5c3B7833jpKe6w9OJVkPq22YzEjjmajg@mail.gmail.com>
Subject: Re: asha: Notify connection interval changes
To: linux-bluetooth@vger.kernel.org
Cc: cochcoder@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Tue, Nov 24, 2026 at 4:13=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1221082/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      2.41 seconds
> GitLint                       PASS      0.98 seconds
> BuildEll                      PASS      18.93 seconds
> BluezMake                     PASS      288.27 seconds
> MakeCheck                     PASS      14.19 seconds
> MakeDistcheck                 PASS      143.26 seconds
> CheckValgrind                 PASS      354.39 seconds
> CheckSmatch                   PASS      282.45 seconds
> bluezmakeextell               PASS      98.33 seconds
> TestFunctional                PASS      1167.94 seconds
> IncrementalBuild              PASS      322.74 seconds
> ScanBuild                     PASS      1106.12 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2911
>
> ---
> Regards,
> Linux Bluetooth

Copilot flagged a couple of problems:

https://github.com/bluez/bluez/pull/2911


--=20
Luiz Augusto von Dentz
