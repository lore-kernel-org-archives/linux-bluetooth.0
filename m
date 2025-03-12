Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D443450FE;
	Wed, 12 Mar 2025 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744421; cv=none; b=DRyiTzvSBgR1tEL3mRndHDmEbvOPJa75SguAdazb4BwoXyMZNKC4QmN1ftL1pSajOWopRvS37sd38hXxw/b9Pp/mMv/6kGX4BT2mdvl27lcKM8kf53cy8oPchu2UsHj2Y2UV9i51LNCvcYe9ek3/3/ws5eve+SOguEejLWtde8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744421; c=relaxed/simple;
	bh=Xp3j2EaJM9yd8c5tVVjVXHw7sNDJEa+KBQeL7Sh3LeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ82jlKhgu784MzMnHC8QfECCu+w5Lk1Genp2vzOflDcN0/21XTA7SNwNZWWjqRI5HtqrsXudtSwOudLIKOoyNl0WSqtwl4HZLdRdSUAcBXsIvatXRP+dnNlU9/zrdT4m42Hl/8Ad7VW13VvI7TI/y8KbfoCR1Pd9gHHZvAQqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3XuYL0u; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3XuYL0u"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30761be8fa8so68361231fa.2;
        Tue, 11 Mar 2025 18:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741744417; x=1742349217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVNAJraMIOsickEYOAYVZAaZW5NL+QcWjbmxRS0fQLc=;
        b=B3XuYL0u07qqIv4qYrRu3fvSUneurAP6AjC/1RAYWn1ln7hNCIZg0pnucPHJJd/Uww
         uTaj8WLQsHFVkJ2coy+1VWG9tjgC/EDTmQzjprDYqdPFN8UcdDqHMcJMqRxZdZQqKimH
         Yai0ku6kQoAFzXIPAXsoju8EwpsyZpbt1kCs1dn92kQ9M61HqPsUc2OsP2JiOIQczBXz
         EnY5CJtxKdu62Rl404CHuuiDV4u+e9jTIiAD5EXihDW6Pl+B2ABGM2LuIsOJpxCymfuR
         9m4GOHkRH06epnH5lNrnd6vNUBabR0fgkmaI8Yfvez0DxJEzheZvsVaj1DFHdTV8znUd
         Bo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741744417; x=1742349217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVNAJraMIOsickEYOAYVZAaZW5NL+QcWjbmxRS0fQLc=;
        b=ZXG48vJzxCcra67YCrKC1MN5a7Rxptwaq15hn6mj1kEG0HrKgpRRFhceCotYYtaBVb
         jQ6uZaedLbYNBaNBDwojAMssaVhQoIub66UmM2cI7q1AGJ9m8d/v0VIN6uEcabLVeDa+
         KR39x0bpv99fo+aYQhSgmLwwMHaloHvzRYgKtpecAYbBypUCDkrU23YiDM/OMXoqBgI4
         lp40LHS7Siio/VpQP08dAP5UkcWnPEAmtyIRvzLbvyB5TbOcuigfGx41Gq/84e2jACod
         kaDAWbEUTWNYXIRadkcemsYrkJjPgc9YrWov2Dc/Qbbc4UMkhNWkcDogSV7YvpwKR9Kw
         qL0w==
X-Forwarded-Encrypted: i=1; AJvYcCXW3KY/b1VFXJcEBXZwfFbyidWutffdHBsSHeagyRXt7XPRQSOmHMYWJGU1fcLB1plsx3p8vjt8L1uG4pw=@vger.kernel.org, AJvYcCXhj1D+QjKXIxEA+1QfPK8wsE/Q7xWwDKAZsYJ77BmfQv1y2K2VFguM7OcPXs+RY0wc9Js+diqt0fJbKiEvnII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA52KiFaUhmkauSgs0aBJViDgnWlX6oF5LZ+BSa36MHO2DDjBF
	j+2gPk+K79Fh0jBe1JRzl4YlylTkQhbJfJIVr/dWZ0l+XhkYyOQ6spQb5JYpjutyDrNbERotVTT
	yhhHOkhsg6dTVuNu8+qpFNUcF4wk=
X-Gm-Gg: ASbGncvTkhqkI3s+cvEsC5FMkf827mUfXwXTtq8tvx5yz+4MoTnCNgBJLN531ui0OfG
	MsWl8zhfzY0j688O1JziVevIOBeVUD2kzPYYDTYwvifqQnj+ZeRhB31LApiGdef8qn/3LWtPAT0
	1x6LJDFbiEfXzwqLS6obI/VKc3iYomF3cRxdI=
X-Google-Smtp-Source: AGHT+IG+UDnUfcLQys+G2fp1UMFS2L9Nny4gJpJQrWlh5HuY7zIZrNd+Ytqtc0rIwEC/p61VnwHhGO4kJGpn5aIDPHw=
X-Received: by 2002:a2e:9c15:0:b0:30c:2d44:c212 with SMTP id
 38308e7fff4ca-30c2d44c265mr8643751fa.9.1741744416851; Tue, 11 Mar 2025
 18:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8ybO7DfeP3Ag9wz@m.b4.vu> <Z89YcqoED633dr_M@geday>
In-Reply-To: <Z89YcqoED633dr_M@geday>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Mar 2025 21:53:24 -0400
X-Gm-Features: AQ5f1JpMTtjcAOFuAetbKzWXDRkx26sIJ8zj5xyrHOKQUOEDVN-YMbHiQ73MKt4
Message-ID: <CABBYNZJCko6radLuW=M=jTzqUEr2rUoKc_TUBVWP9wFSgkKb6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix for MediaTek reset affecting Focusrite audio interfaces
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: "Geoffrey D. Bennett" <g@b4.vu>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Hao Qin <hao.qin@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org, 
	Benedikt Ziemons <ben@rs485.network>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris, Sean, Hao,

On Mon, Mar 10, 2025 at 5:24=E2=80=AFPM Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> On Sun, Mar 09, 2025 at 06:02:11AM +1030, Geoffrey D. Bennett wrote:
> > This series (choose 1 of the 2 patches) addresses an issue where the
> > MT7922 Bluetooth controller reset added in commit ccfc8948d7e4
> > ("Bluetooth: btusb: mediatek: reset the controller before downloading
> > the fw") is causing Focusrite USB audio devices to fail to initialise
> > when connected during boot on kernels 6.11 and newer.
> >
> > Reported by three users here:
> > https://github.com/geoffreybennett/linux-fcp/issues/24
> >
> > Two users confirmed they have an MT7922.
> >
> > I'm providing two possible solutions as I note there was a similar
> > change made in commit a7208610761a ("Bluetooth: btmtk: Remove
> > resetting mt7921 before downloading the fw"), so I'm not sure if the
> > reset should be reverted for the MT7925 as well as the MT7922.
> >
> > Option 1: Revert the problematic reset behaviour entirely (MT7922 +
> > MT7925)
> >
> > Option 2: Remove the reset only for the MT7922
> >
> > Geoffrey D. Bennett (2):
> >
> >   [PATCH 1/2] Revert "Bluetooth: btusb: mediatek: reset the controller
> >     before downloading the fw"
> >
> >   [PATCH 2/2] Bluetooth: btmtk: Remove resetting mt7922 before
> >     downloading the fw
> >
> > --
> > 2.45.0
> >
> >
>
> Hi Geoffrey,
>
> I understand there's no apparent nexus of causality here.
>
> However if three different users suddenly reported the same problem and
> the fix fixes it, we should take the report seriously and back down
> on the problematic commit until we figure for sure what the heck is
> going on.
>
> My bet is this is bona fide bug in the USB subsystem, but either I'm not
> looking hard enough or I'm looking into the wrong places, because
> there's no way I can see in which way USB bluetooth driver from
> MediaTek could cause clock detection to fail.
>
> No point in pressing this harder, but yeah, take the reports more than
> seriously, because if we don't understand in which way our own (Linux)
> code could be causing this, at least we should take cautionary measures.
>
> In that sense, putting Takashi Iwai and Greg KH to Cc: in a modest but
> sincere belief that this issue is more than real, even though it looks
> like anticipated April 1st. Takashi can help with his expertise in clock
> detection and Greg could help pinpoint if this is indeed madness in the
> USB subsystem.
>
> Hope you and them don't mind the escalation :)

Do you guys have any idea what could be possibly going on here? There
really seems something is not right if one driver affects the other,
especially if the devices are not actually related in any way.


--=20
Luiz Augusto von Dentz
