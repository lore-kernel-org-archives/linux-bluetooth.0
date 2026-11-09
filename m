Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794234680;
	b=y5KUbn6icdEY9EWLKNg2lQDZtXYWA7cGF7cJDpB3mw8aI/tia/SSsYsTxqzq2EVBOQO8
	 bqIAtEo0hmP86kjNnS6T2WDoKIYyTE4sLelA77XaLYNjBzn3W7d6VBwHKz+7iekzdVVR0
	 4c6bx5OHAXiT8pynac1ufzQAzhVL7vjmzwwujU/mgjKL7hlSOWE4eJ8fPFIcOxTYvbWaw
	 NYWAvF4my281RG2tstYRe0JPzFO2NKdyHQ0yaY+iCA9Igdm34wB4STWNj9lD6ozrL1JOZ
	 ALD82OapNkkVuhWFzNOLuTN53rHRbOm8LVgoMrstojhlMU2be8nUL2j1naSWQFgnY8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2hGgVjuBd7o01YUmJ/lhfhe3s1xssDwDp1EX9JHo6qs=;
	b=LVD7wcnfZPw+67SeJAbwBBPwhxlMcsD1KdZLWYdQ67YJGnGljeRksq0Glg/66BHCfoxk
	 rXWTwxM9I+W0mddSKulAfjm7mmu9GIwnv/J+xK+Entd+LTcPB9D2MLicQJTBFPd1DQLZi
	 +fSTyoem1IuyFs2WTQAUxmrp/svvXXJl0ih/It1M64wuUfMiFbpLNiG/nQVKrZ4b/IEES
	 TwqBawA9IROSGtwHPrju9rBNDdmWCwz1dxVgO8145+rdqwExqMtnXd+K2M625V8qw/0BI
	 qac7XIiSysvdvpyYkS2rDdOXDWJwaYqfLqLlOoFMPfMQP+lzQJ0pcjn4+UTiWdOZJ4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttRUao1o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E30606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 14:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E30606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttRUao1o
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67bee1f693bso790701d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 06:31:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794234679; cv=none;
        d=google.com; s=arc-20260327;
        b=aPoHv/qYjAg0BTS0u1t/6RduyFiFn9q26++eA7oOEVRo+mcUmoXidijYw0hH6el+hs
         RCbdUVeeICFd8l82CzcsPbGWr1BoD+s1ZsP75SFx3dkgrycIbPNIICjuNSQCTVcHAK6L
         6Np/+uaq4mZm0oIs/O5u++qxuz978cBHp2Ps4DjPi+9nKbTj/deSp+O2rbsOMsmewU/r
         DTVdZGePCj8iXhO4tq1p4W7vYPoFUQudoepHtpP29ZGN9b6oGpED8ggL6AFY7g1Qf27g
         EA7KrcVAgp1KMNgPZDG/1qWiPC2hzOt3INQPGRe5oIz3L8BTnus41BJqiCFbIA/xR7rf
         vRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hGgVjuBd7o01YUmJ/lhfhe3s1xssDwDp1EX9JHo6qs=;
        fh=I5tRH0QtyVnSbQGfBfvOLepp/S4VfLN65sDHqni1TAc=;
        b=rfFUbeANU3/TJ2Z0ZQI+IrpQ3q72ErsR/CE+9S4H5nFbQ+JJUWe+RX2zZECZLBngqQ
         FC4Vrfx43Gl7timiorDz9vwewlJ3csrUfdytLS5bhiOQWvH4hMlv3eSdjdyOU+stMFlS
         +4rZywotLDieIMmTMjnjR0WvlF9vhAabdqwSIqXkplYfFrmZSBbzwelbl6JQsqh6H2sV
         sEs8FCY/A/8u4UW3vi+48U+0NLaBsu9OqJ+UPlYMtXRnjKT8QBLkMHe7Id/LHDAW6MPQ
         QzmVV+Dp6TWx2SCspdRAt89CiIMODEGyiq7vCvMLpuY50LGAugkY7hrFnTVWL8M1aSuk
         /BKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794234679; x=1794839479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2hGgVjuBd7o01YUmJ/lhfhe3s1xssDwDp1EX9JHo6qs=;
        b=ttRUao1oMJEK0GIoEsUQc/0kpqOv3LZIqlBq1vdTL2c01zDiEjFzVX4VKWns4lm7iB
         mcX96bZ1Q4Lj1g9ycg9iUrWTdv3c02JhdRGUUrt65DtPzsKIV8ce0s92TrU5G3feYKNF
         sFKYtXnsM/eW834z6KundYNwFUqSogrkUnWoNoXe/HUv74loET58qB44heSvVI8c2NYt
         pPT83QFLtePKNJcxPyiUdhHRcnKigmxgA3XaUHdToTQiMWscqtzFhucfDzljG8ITFdKt
         tqcOQ7c+egaIeg1g5uC6m4SCpd6Vau2rRobn17W22MXgyGtrK0E4uIQOlsNgm62fn8Ka
         rEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234679; x=1794839479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2hGgVjuBd7o01YUmJ/lhfhe3s1xssDwDp1EX9JHo6qs=;
        b=2JXt1Aq6DB7Y20W+vwF8E3iqVXjb07xos9H2LDuFqoKuUV9VLSEywTqGZtCgzSY4ti
         8FWPJEwOXOmfNn9Mr2ukOuec6xblwXO+miU7LWn78Qa//UaNC1wtold+dvMqRSZdbxnX
         3fv+pldBvKPxxtg4b+v8fX8bXN9bipEPh78vcK3sVcuw97s6glFGMO7mNJeNDMidCpkV
         UBVH1wcmVZ1+0tdl8I8m0HHdv+ueUVvrWFgWpPJqffxIXWEyo5Jg0EVzeMEohczgF/pj
         NPjvGf5pK5BEUOD7hV8xUTMAEnVmF/mT6YtdMWb/EPSgW7eCrphsJt+wbCbn7kOnyevH
         8l2Q==
X-Gm-Message-State: APuU4Z/g1zUdJsQxJXRNC3A5ExYZRSjLNU4mkWq7JPyyAmoCrvgUvaMR
	hloRZU7CkW0ku5m6OCPgPeQmXiR6aiHyCYWOdSKogJf4EopKcJGhmogwv1eBFXQ/lrGLP1QQBPl
	TIWhY8uUOHLUHhm6Vi/Om/9qrpwzWes8=
X-Gm-Gg: AYBFou2Vwa5gvz8+DDop4SQLN+JVha8kqgAV/7mhnv+aOzaFgUeoB2DGqmDt5XA0qzX
	M/IPxUXxHDfrj6BkGEKOqaQ0wfTaeCl4JskCU0kuY42wQlY+i2nhrj5bgOmcE9UH8a1GYumG2Ys
	0Dgmt9SABSeTpWOwQvTA0yOwDzkaadkR6VST/P+mJOhO4hejAmhpsEOc9OQ1gZssxLJbxe2yMU4
	APQOMPyNmVhbmUzsANcqXWMOhaw9WTilnnfwoWdFNBTZxzAmu9wJQ6M8PoGHjUjc1kpyZdjQoBj
	XdG4Y+wdHL3ZMCCYJiQ3ZGJBVlLzIrpY78jF9gmpaxpFyyiCzxK68WsSTwXzwgCv18W0umzVeav
	1rjtP8HMMpY4cz/xh5bA7WfUQVv8qRkUkxK2IRozk+SrCITWuDiLEMSc4eVDtyl+Gkc0oeocub5
	LPGNXvZq7D7PcHJWXm1jk/5xUyH906kaBESUFJfBhcUx4QwVWSY8DmmaBQ
X-Received: by 2002:a05:690e:440f:b0:679:b50e:af with SMTP id
 956f58d0204a3-67c3d9f5453mr1961393d50.73.1794234674106; Mon, 09 Nov 2026
 06:31:14 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104083429.4111632-2-jinwang.li@oss.qualcomm.com>
 <6aeb639e.87c3a088.228e9e.5ddb@mx.google.com> <CABBYNZ+6c45s-+_X7s8qE9DXihX5O7xYFTJnJmvnKT-sy96Ksg@mail.gmail.com>
 <192181e7-5935-4f0c-8d4d-b54218d99a05@oss.qualcomm.com>
In-Reply-To: <192181e7-5935-4f0c-8d4d-b54218d99a05@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Nov 2026 09:31:02 -0500
X-Gm-Features: AclHuK_hVnMehfSG7W6uKgl3sisL4vtJzUEwfOhW3AYqLdNNkkvDae1gLHKcoko
Message-ID: <CABBYNZ+E-HjcBxjsoH6c42B9W1_GFc1h=7JMQMdhYxcht_BBqw@mail.gmail.com>
Subject: Re: obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jinwang,

On Mon, Nov 9, 2026 at 4:34=E2=80=AFAM Jinwang Li <jinwang.li@oss.qualcomm.=
com> wrote:
>
>
>
> On 11/5/2026 11:37 PM, Luiz Augusto von Dentz wrote:
> > Hi Jinwang,
> >
> > On Wed, Nov 4, 2026 at 12:14=E2=80=AFPM <bluez.test.bot@gmail.com> wrot=
e:
> >>
> >> This is automated email and please do not reply to this email!
> >>
> >> Dear submitter,
> >>
> >> Thank you for submitting the patches to the linux bluetooth mailing li=
st.
> >> This is a CI test results with your patch series:
> >> PW Link:https://patchwork.kernel.org/series/1201470/
> >>
> >> ---Test result---
> >>
> >> Test Summary:
> >> CheckPatch                    PASS      8.55 seconds
> >> GitLint                       PASS      4.70 seconds
> >> BuildEll                      PASS      23.33 seconds
> >> BluezMake                     PASS      197.66 seconds
> >> MakeCheck                     PASS      13.22 seconds
> >> MakeDistcheck                 PASS      105.32 seconds
> >> CheckValgrind                 PASS      164.16 seconds
> >> CheckSmatch                   PASS      173.53 seconds
> >> bluezmakeextell               PASS      69.20 seconds
> >> TestFunctional                PASS      885.71 seconds
> >> IncrementalBuild              PASS      250.73 seconds
> >> ScanBuild                     PASS      687.43 seconds
> >>
> >>
> >>
> >> https://github.com/bluez/bluez/pull/2760
> >>
> >> ---
> >> Regards,
> >> Linux Bluetooth
> >
> > Copilot flagged a couple of problems:
> > https://github.com/bluez/bluez/pull/2760#pullrequestreview-5775992507
> Hi Luiz,
>
> The first three comments are valid. v2 will fix all three.
>
> I would also like to discuss comment 4, "Clear JPEG image capability
> until photos are normalized."
>
> The Default Contact Image Format feature is mandatory for PBAP 1.2 and
> requires PHOTO to contain a base64-encoded JPEG of at most 300x300
> pixels and 50 kB.
>
> The three backends currently handle photos differently: Tracker uses the
> photo URL directly, ebook passes through inline data or a URI, and dummy
> forwards the PHOTO value from the vCard. This series only advertises the
> feature bit and does not change these behaviors.
>
> I don't think obexd should perform remote network access, image
> resizing, or transcoding, as that would add unrelated networking and
> image-processing dependencies.
>
> Without those, I see three options:
>
> Keep the existing behavior and only advertise bit 9.
> Validate inline PHOTO data and omit non-conformant or URI-based images.
> Read local photo URIs, base64-encode JPEGs that meet the requirements,
> and omit unsupported or non-conformant images.
>
> Do you have a preference for how this should be handled?

I don't have a particular preference, it just needs to be spec
compliant and pass the PTS testing. If each backend uses a different
format or method, perhaps we need to converge on one. That said, I
don't think the Linux desktop cares too much about PBAP so perhaps
this is just to exercise whether PBAP could be qualified? In that case
I would just use the dummy format, or read it locally and then check
if it meets the requirements.

--=20
Luiz Augusto von Dentz
