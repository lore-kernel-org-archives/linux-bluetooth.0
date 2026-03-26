Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1891F30AD
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774500505; cv=none; b=SdACxQ+zQDEk4gfGwFg0eVBBhq+YQColebC2bOJseY30wzR0Y2V5ga6uqJEh7Ai80oCadkF64kfrELylejANQ+fK4277nhDU0ZtWvfTudw2Zmfxtw4MwlHM4E3S+TCu18CXxf0WCTVb4PiRHptiutuM/SjiZOUBbZu+eSHzTGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774500505; c=relaxed/simple;
	bh=pK8IitOhj+qJYRG0RQz1aH3TD26+Pq23VmPLgDzAB1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYDhaMtmki13k/oEd8tGWDSoEAKETC56jvSmyCueD7pKdHIf9cPWGQB7cmfxD4cSSf2+aK5QDzAFB/mJchbuTfn/mD/x9EKHjEKAjSPzpUL1oUD6l8b1KDvoLfcBpAVt8bi2xfuR+dE+t32wJCZE7Mvjh+RGLINxCa4EXDBwDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8s9pbqj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8s9pbqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D064C2BCB1
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 04:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774500505;
	bh=pK8IitOhj+qJYRG0RQz1aH3TD26+Pq23VmPLgDzAB1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A8s9pbqj4y9Rc3OBhR3hAU67szsVAjaMru7+kpQ5U8oQeGlsjKG+jem5YBUTiXak1
	 FOeV9VjTnCHTFNbuu5F95RzEihJ/7zXGOeinIZEuPpu+qwINJVzDJ7aEWq6NGAPvGl
	 3DFstdd2OlW9hfcOl2yuPClPur51CEtko397EluLjyTIZpvUSnn6ijE3EHPPOmxbf/
	 Qzgjf/um+dUDXCogYmF69IiSjN7lrAYFf+sSjIuxWZPlBOXnAfrHKRX5Ulc0DkfyVQ
	 BjAw7jT/9UCzwgTHM9R8P4SjJnv4e7i3hB7+o3/Jj60W3rGFHoQ4lYmVQRn8mJaMnK
	 Q5Y51O2mi93FQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a32d36396so3752731fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 21:48:25 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyq3SZs8Ai4sg2fGdMvoF4FIMbN3+XfWFvJ7RGJE9cbIcI/bOdQ
	IY+qlMeQL9h9xsdSfLV4489hAjVGgQVO0+kSoRJcttHrUF4GDFpbTv7ZOqkMY64CFjuRhZv532X
	Eurc924YM4v8h46JkCXWxnHzwK9oRQkg=
X-Received: by 2002:a05:651c:3250:b0:38a:539b:f67 with SMTP id
 38308e7fff4ca-38c653a066fmr716601fa.14.1774500503745; Wed, 25 Mar 2026
 21:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326002348.4F98B1EA006B@mailuser.phl.internal>
In-Reply-To: <20260326002348.4F98B1EA006B@mailuser.phl.internal>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 25 Mar 2026 23:48:14 -0500
X-Gmail-Original-Message-ID: <CAGp9LzpHUANcUVavpZi-jNhJRWuYdtJ0HvV2q0ACjR5JNkswZg@mail.gmail.com>
X-Gm-Features: AQROBzAJJTKkWQ4SvTldkO6SARCPPoUpJ15E3gt3p4fwVPZPpa31nGQitjyq8iY
Message-ID: <CAGp9LzpHUANcUVavpZi-jNhJRWuYdtJ0HvV2q0ACjR5JNkswZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
To: Javier Tia <floss@jetm.me>
Cc: linux-bluetooth@vger.kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Javier

On Wed, Mar 25, 2026 at 7:23=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> Hi Sean,
>
> On Fri, Mar 7, 2026 Sean Wang wrote:
> > BT and WiFi use separate firmware.
> > I'm not sure why those WiFi sections are included in the binary.
> > Another concern is whether it is appropriate to upload the firmware
> > used in Windows to the linux-firmware repository,
> > The firmware files are probably intended for dedicated OEMs.
>
> The section filtering remains in v2 since the binary from the ASUS
> driver package does contain mixed BT+WiFi sections. The firmware
> upload question is being tracked separately in linux-firmware
> MR !946.
>
> On that topic - would it be possible for MediaTek to provide a
> proper BT firmware binary for linux-firmware, or to sign off on
> the one extracted from the ASUS driver package? That would resolve
> the firmware provenance concern. If a formal submission from
> MediaTek is required, could you help coordinate that?
>

Yes, this has been under internal coordination for some time already.
I also hope we can have a Linux-dedicated firmware binary rather than
relying on one extracted from a Windows driver package, as that would
be a cleaner upstream path.
For now, the practical step is to make the driver-side handling robust
and consistent first, so it is ready once the proper firmware is
available.

> > This is common logic for the other mediatek chips. It only takes
> > longer on the first power-on.
>
> [...]
>
> > If the firmware download is properly handled in
> > btmtk_setup_firmware_79xx, we don't need the extra bit.
>
> Understood. The BTMTK_FIRMWARE_LOADED flag and skip logic are
> removed in v2. Firmware persistence is handled by the existing
> framework as you suggested.
>

Good, it looks better after removing BTMTK_FIRMWARE_LOADED flags

> v2 is sent with these changes addressed.
>
> Best,
> Javier
