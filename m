Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5B331EBF
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275410; cv=pass; b=dzvYiIMx4g5jNZYg1z2zzocRFAfeoz+8c0EejAFy5BjYCH/D10COSZs/skAUBKX5GOb7/K2v/NNn7ebLFBRtXpkNWb5AVmz3botOhyLaXtr2vipBnNtS4vC8g6mv+QKUamDz2Ed5vVH/aVpYiAK3wTeLBzC3VT+fq2Dc73dAm58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275410; c=relaxed/simple;
	bh=w2nfYxYASA0giwl+BZunFh4T1jMKsr4eozLXGQlfC2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgRqhz4k54OrT9ACSbwr0AFkPa06Eo3qt3smlE9JGPj3irTjw4tSI/hsHh3H5IIOki3ptT4wGGfRrzWuBlZkjPNlbrfipjegBxfdPUpnYCUBK5A5d+eHEggsCItgJL++/d7PSf9ZYzJzhcgVomBb1PY0kamJdBfCXkV+UOlypkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOj0cjiU; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOj0cjiU"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-660e9fe3c3aso679187d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781275409; cv=none;
        d=google.com; s=arc-20240605;
        b=CnDStWcir35coWDAm80wx0rC1Y4WbS0/1GaG3wlM8itTMX7Qic05RikFJToKTWOGV2
         ZrfW599BsvBKdd/28sWzYyyGnSLrFnhkrDtko0RtCHPpCC2DJk1qX0trSjtQYVkzpX0a
         PsjaN/xj+aTSQ22g6gBFv5ESrr98rJj8HD62VuXNm84ofERQnru1SkgAeTVfoqu2z3mX
         szSTnIz8G+DYPFWxhQMzOjUlzrbM3mD5koCgAkfLKLbO6Etvw4owWKoZZPorncBlNpDM
         c9JE4T34lDdew2zmZ61kjxvUAw6k5VK0r1NYfenWWJGDk5UVsqVhDWvHlAxmuDeRtX2H
         c9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6VIcBkgcxYBFEz2ZSEGflERwIhJmjq3dpuCUDCSMSg=;
        fh=zmL9x4n9ThrOSSqD2h69rie55BtxLVxVF7fY5sqyAnU=;
        b=D6vgcQNRZHdixIQb0FjVd/QP4rG3+62/o4K0Wc1cmOXN2Q9oPd3GyWHUgbELeDsXmh
         3HNsgIFXkCy0ZtMgh4qQT+n+2rD8jR5RabkpcWTf4ZYlC9dPGUXsFI2PNgdwSidPE8jc
         ZG6E8vu13fBbUfESoEJ7UYZk3JZH71BGxVdzxBuD6YApknEUeCizpUST1AgeJbCpKyye
         k6XJgTfz0ZhzkdOXjNBnsphTcQduKAkuWX4/MzPrsyp3Y1i5IoX6H1tx8dJMws3MEJMJ
         jlM99hqDessBBrtii8V8xnL/ZpNtDrXNrHekLcAy0io/D9bqGrv4YzmwBf93XvAfjhf2
         fv/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275409; x=1781880209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6VIcBkgcxYBFEz2ZSEGflERwIhJmjq3dpuCUDCSMSg=;
        b=sOj0cjiU+oLii5kZ9YJ8er3Dz6GyDX9pBlxk57B6nDm7XGOvW2TuGYLkv6TmGrSE8b
         NWkk5Xsph/9a26Cnxc/UO2L1qEk+5dJUGXlj4vmr5QlMPi+SeivvADfupo+VaqDQnCsT
         8iVfHCr2Kzlx4uUVA6Hu1gUrYPR79kYKxVFtCUjV8iUq3hUARiOzr/UDT06CEFP3pFoH
         cYRXDCrkpcf2b1WXlOs0lGzpSvVa4rkp4dOTDXTbK466jLGi3SoRG2UglC/hok+twPbb
         ly0NXwvO9FLa38hAYEMW8o5cejprOjEtkmzO2iNY637RpKToJCPK5cYH7k7p+Yk4ygL/
         X4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275409; x=1781880209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6VIcBkgcxYBFEz2ZSEGflERwIhJmjq3dpuCUDCSMSg=;
        b=QZfkRwMhC6vI/wPDTgXD6aGKnMzF1figtCuPrqnrCBRxVYOpRdvWvPS9bDrXYqbY5q
         GKMaqaBhuwdcOS8GNKYgt/cv5GjEalJrrMr0IlCMx2rDnhFFNchDXlCgEGeNFUuMewdr
         Cis6/xIi85veJDAVBDZOsh2E2a0a53Igk7ILAle/CRICriwY5xZp0ckPlFs/Hot1y+Dj
         bNIkRP3wsYsnwIrZXwA/2pJKyOQjzcg/ZTkV2UNvQSeXLXp/LtMzL2PlgI9LpK+TvFat
         GAUop2dfesUnn1yqf1xPhRnsblLdokWORCfBjZMnE6NLigWXuaH++A+CWvkQAM5z+afE
         L0XA==
X-Forwarded-Encrypted: i=1; AFNElJ8YR5jN76DcEig2LEaDBPg/A/5de+Ap02GX5pVXo383IOV8oUuQD7kvuiL8X1iYIejUW8hAsVN20JtNQlyhsDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNPl4hr1Vd1nGd4xhYhpPCUczUh7X1H/B6m2fATlpbzIsr/ij
	bfLfA4+GJ7BC0+IZo9eLk3GYLnstMg0Bn+eAHQFPoEz7FxmDIxlrCrmiSkqF4+RlI80UaQFx95N
	Tmu1ZfuEAICsqABLi7FT3iaq9/KnHXbc=
X-Gm-Gg: Acq92OFNosEFCehgesSmhv8S8LbEWfTqxTGg6FnHrMNTOiqcPIKPH5Xr/hDcP0L75bj
	tTZP0BUsBuVDh0vdJOQFC8d+g/YiJx33VEgSaIYI1EttsRMFqLTrcT/9EQfD+XkXvnBhnCuw7FE
	LVufT3Oweh2MqJhwveYXk6oPR5Luu+XPBwDPWW8+inwcdVA3Cz2zGWUv4yD1O1TJbQxNK/nepzG
	D+oQNYH9fzz8sLrTrOu+3DIgmbhos4cZpeMdYjpN3dBXxo54/hPyQqM5MjsWWqXt2gccttnPgfL
	WJJQMXLc5aCPYLE4h6v1q3RMJGswp2GGY8xJMqxtWSOez40X1RgQEBdv7bjkLCcD6D/13Mc26fy
	OGauK
X-Received: by 2002:a05:690e:b45:b0:660:d0a6:935e with SMTP id
 956f58d0204a3-662782cf742mr2320722d50.40.1781275408429; Fri, 12 Jun 2026
 07:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJY68zrRO49VEtgEVzQfqVY9QZzwUuc8VoKkAAeKUwAOw@mail.gmail.com>
 <20260612142839.GA598449@bhelgaas>
In-Reply-To: <20260612142839.GA598449@bhelgaas>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Jun 2026 11:43:15 -0300
X-Gm-Features: AVVi8CcNNJ7VW_uXeCu9TvXEetVXekrhRt_l2XVfoJETDiDudc5tf7WtnqOKGeo
Message-ID: <CABBYNZK9e8T_gVyhvyU3EyGqUs7=1BDuTdaUkZPoJCygNUq1sw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_core: Add reset_type parameter to
 hdev->reset() callback
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, Jun 12, 2026 at 11:28=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Fri, Jun 12, 2026 at 11:08:06AM -0300, Luiz Augusto von Dentz wrote:
> > On Thu, Jun 11, 2026 at 10:29=E2=80=AFPM Chandrashekar Devegowda
> > <chandrashekar.devegowda@intel.com> wrote:
> > >
> > > Add a u8 reset_type parameter to the hdev->reset() callback to allow
> > > userspace to select the reset method via sysfs. Writing 1 to
> > > /sys/class/bluetooth/hci0/reset triggers a Product Level Device
> > > Reset (PLDR), while any other value triggers a Function Level Reset
> > > (FLR).
> > >
> > > The reset_type values are:
> > >   0 - Function Level Reset (FLR)
> > >   1 - Product Level Device Reset (PLDR)
> >
> > This should probably be treated as a generic level at the sysfs level,
> > then each vendor can interpret according to its own needs, for
> > btintel_pcie that would result in the above levels.
>
> Are you suggesting that this should be implemented in the
> pci_dev_reset_methods[] framework in drivers/pci/quirks.c, so the
> PCI-generic /sys/bus/pci/devices/.../reset interface could do the
> PLDR?

This is the Bluetooth sysfs reset entry, not the PCI one, which was
created for Bluetooth-specific reset methods like the one above. If
you think the generic level could be applied to the PCI sysfs level
that is perhaps a different suggestion.

> That sounds worth exploring, although I really don't know anything
> about the unusual multi-function model of some of these devices.
> And the /sys/class/bluetooth/hci<index>/reset attribute already exists
> and probably couldn't be removed.

Yeah, I suggested just treating the parameter as generic levels, so we
don't define its domain and leave it for each driver to decide how to
interpret it. The sysfs entry is not transport-specific (pci, usb,
uart), so using pci terminology in the documentation may lead to the
assumption that it is PCI-specific when it is not.

--=20
Luiz Augusto von Dentz
