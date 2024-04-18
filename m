Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B71649D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460079; cv=none; b=fhVqmsNj9Wej7hfybFkeATGJZp6qwt2Ka1tKDMQXt9KA6odEXTkwE7Zw6dm+h8CNXyyMUtKULTWHVwiSP1SdPl12JVtC4e7ItKy3vn1LEoZxnrpzRw4BgTx5vWJ0cJs0JXJXVuNblTTE1KTDqMUO81XZZkKufm1iXgu0eVnGui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460079; c=relaxed/simple;
	bh=Hc1W/ZOnzWS6RSOj0FopqcI2D9TPFbUyF4BTBM+DGe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAmzVdwIAEdLXST9lyiHACsarHKOjcsu7t0ki0l/awLtOSDiVGP48y9Pawd4WZO4/fFG1W1uGahO1h9XxpqUx8UzSrZ0+Z5n736SX/AP6OGRLTDCgJ35TgldZ8YwBLi6J0jWHLo4IrNxPS1tt8vzaVqSXY18d0nLPpJBD53XqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS6bjGrj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS6bjGrj"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d872102372so17913091fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713460076; x=1714064876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc1W/ZOnzWS6RSOj0FopqcI2D9TPFbUyF4BTBM+DGe8=;
        b=DS6bjGrjcPHeaRxqzclnRFTCp9x5R7OBqL1KDuZzvZM+JVWKbTafvypXIeC5hwf4Wt
         Qv1XXBuSGtq/25Iyu21BQ3S1/pIdQ1EOoxIldrs/Ly3GA3SqIPs7vl1xaCDuUgLW7WtY
         KvXyXkTkLoAigN6IhbDd7acdWUUA/BimsH2emGrofP382THxfaDWJl1+d/kr5SjiOkiu
         Fmum++e4zYioFMLVyih7Na3bkeU+JDrOeGsyfY4Q3KGZiOWyKeIi9sWgwBhzy8nTdtr6
         P7S7Im9eUp1RnLI+lRbSuc9uMuDuYZ6dUj9FJryXu4LbKnUtXPzVJldZDm3W6HZWbEO4
         758A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460076; x=1714064876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hc1W/ZOnzWS6RSOj0FopqcI2D9TPFbUyF4BTBM+DGe8=;
        b=ETQsImc0Bb0KxS+IYRVwJHw0U7DoconRPMEbxQ8qKGMR1JXwe6BVMc4CKNyxa1XCoH
         cp5UVCt9MKdKMNmhGidxNAlUkNlwTF/FA4Z5DsKhdhg5DfURCeTFFG6YVGhp+H76Cx+C
         EoTOZN4ibn1SNgdglNrOlaG7Ep7bageaR0yBo5p1rXX2t/KA+EbBRXrInrSUikb5DYNu
         DkLHULbX64tMaP1YoLWSd2O85MaO1331/+4hu9kmIXWNQZe5wjt7xfvJdVr/L8xwINGO
         99RzlO/ILQehRt0bSw25EyCtfFN6GJ/Dbdoe85h0dKhXngHPAXzmsivKQ4pZgRJvBEQf
         SwrA==
X-Forwarded-Encrypted: i=1; AJvYcCXxoin3rDTNH+/G2jwo1h4Yv1ynXomYBXu9oSq5mmOMnho96c66fpUORUhOGd9CrqGh2VmQ9f9jG35NA44pUj10oHVuanpsHVeNKGWTDO0H
X-Gm-Message-State: AOJu0YxlMA5oU2rzO/necO8qPrBeWcGkfg9WCRbSZ0vJXUv3OT29Ibey
	43+en4LWFHmQp/BwJtSXD4Mj5C4dq6/BHAkamKHbpfvsRDf0U5I0wDww11i3KZgEKnMkTgOZM+t
	rlrNsMjf/DPrOhvmbCbKI1qmQNYM=
X-Google-Smtp-Source: AGHT+IFTHP66AtYjtoiV5p+zDukFKe+wYYe+swscdyOeQw0wdWmmHP/XiAdWfghcfg7rbgQBAg2mQx+pk48EefHy77A=
X-Received: by 2002:a2e:9355:0:b0:2da:6f6e:ebda with SMTP id
 m21-20020a2e9355000000b002da6f6eebdamr894303ljh.24.1713460075572; Thu, 18 Apr
 2024 10:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
 <Zh9saGbOl-fXP6SD@hovoldconsulting.com> <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>
 <Zh91zq13nZvH3-Yj@hovoldconsulting.com> <4dac0caa-629d-4b4d-ad54-f6ab15268524@quicinc.com>
 <Zh-JNzlskY6ZvsSm@hovoldconsulting.com> <4313bcc9-8fbf-477d-90f2-013681cdebb9@quicinc.com>
 <ZiFDWeW_-PpI38GQ@hovoldconsulting.com>
In-Reply-To: <ZiFDWeW_-PpI38GQ@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Apr 2024 13:07:42 -0400
Message-ID: <CABBYNZJNiDXCT=3dT9-N7z_ntn1xDKO4SiThJQW+wKmzAGbOuQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev devices
To: Johan Hovold <johan@kernel.org>
Cc: quic_zijuhu <quic_zijuhu@quicinc.com>, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Thu, Apr 18, 2024 at 11:59=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> For the third time, wrap your replies at 72 cols.
>
> I've reflown your reply below manually again, but you need to fix mail
> setup and habits so you can communicate with upstream using the mailing
> lists.
>
> On Wed, Apr 17, 2024 at 05:38:59PM +0800, quic_zijuhu wrote:
> > On 4/17/2024 4:32 PM, Johan Hovold wrote:
>
> > >>>> https://patchwork.kernel.org/project/bluetooth/list/?series=3D8441=
20
>
> > > In it's current form it's a vendor specific hack that is never going =
to
> > > make it upstream.
>
> > 1)
> > ioctl()'s designed purpose is to complete such non-standard config.
>
> That's irrelevant.
>
> > 2) present ioctl HCIUARTGETPROTO which is not exported is used to
> > specify which vendor protocol is used is it a a vendor specific hack?
>
> That's an existing interface, that's ABI and has clearly defined
> semantics, unlike what you are proposing.
>
> Those protocol values can never change once they've been added.
>
> > 3)
> > hci_ldisc driver don't touch user specified settings and pass it into
> > vendor driver directly does it has any problem?
>
> No, because the protocol values will never change, unlike the random
> data you're shuffling into the driver.
>
> > 4) for tool btattach. it does NOT get any board config info from
> > DT|ACPI compared with formal BT driver. so i introduce a new ioctl to
> > supplement such info when possible to make btattach work.
>
> I understand why you want this. I still think it's the wrong approach
> and in any case the interface in it's current form is not acceptable.
>
> > > For a start, you don't even make sure that the types becomes part of =
the
> > > ABI, which means that passing, say, type 5 can mean different things
> > > depending on the kernel version.
>
> > it is specified by user and ONLY be parsed by vendor device driver.
> > it is user's responsibility to specify the right value.
> > so i also don't check and care about its value and it don't need to
> > change any code for further added any new soc_types.
>
> That's not how Linux works, sorry. We never break user space so your
> type data would have to be well-defined and can never change (you can
> only add new types).
>
> > moreover, tool attach is mainly used before the final product phase.
> > namely, its is mainly used by developer and customer's evaluation.
>
> Also irrelevant. You still don't get to add random new ioctl() that
> violates the Linux ABI contract.
>
> > > Can't you just retrieve the device type from the device itself? If it=
's
> > > already powered, you should not need to know this beforehand
>
> > 1) it is the simplest and lowest risk fix
>
> No, it's a quick and dirty hack.
>
> > 2) different soc_types have different responses when read its IDS as
> > shown by qca_read_soc_version().
>
> I'm sure that can be managed. You claim that these device have a common
> protocol (qca) so it should be possible to probe for such differences.
>
> > 3) the way you mentioned will involve many changes and it also means
> > high risks for many current soc types.
>
> There's no risk as hardly anyone uses the line discipline interface
> anymore and it can currently only be used for the old ROME devices.
> Just make sure ROME still works after your change.
>
> Probing the device type should result in a better user experience, which
> I'm sure your customers will appreciate.

+1, thanks a lot for putting in the effort to explain in such detail.

--=20
Luiz Augusto von Dentz
