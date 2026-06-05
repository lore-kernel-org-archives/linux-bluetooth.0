Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0331E822
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689199; cv=pass; b=W659PqeR8o3IHTsJrkrzUsHmW4RXdOEk6K5lYcRATNmsntDI5OJTN5n5D16DhruG1xuQak6pZDgQ4kVUTfmQs5Hodknixzkx9dqRPjZ4hCrkKr1h+rOs3DlETXz/rynzJPZO2cohwSl/f5cI5yRmaZ1HRNaiJN6FSjNd0fXAQg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689199; c=relaxed/simple;
	bh=Dw70O0GWNyDt4UEHE0u7eI1KBaTbzGtxrpq3vVPhK4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqBdyFo+u4GE2BIf/OI/yu5UebDSUUR6IcAqOUN/BnJTVHCu+RNFX/J9m+enhkTQAlWPhg37gb4kuUxqu5jkT3xiGmpPBX9ZAx2UeRdM8yxlEkRFdupWZuEUdiJ6kKZ3DSP7cE6leIryjAeEd9o+UNs5MuXwp7rLFIKCAPApb3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAkYmxev; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAkYmxev"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66077e90382so2456295d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 12:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689197; cv=none;
        d=google.com; s=arc-20240605;
        b=QNh43D3Jt5wwvhGEKr9bcUuNzhsnyBRhKggmSW9kxctPPpvRJwlxC4yEJCWXSGWKH+
         J+CPqaX4v37fZlo19/83JsgcvAjZBb9+2OlNl2gGsnyEciZm9Dk7+dVHdz8h6NUchQp8
         AgOQdLILWmMiMU5PEfdnCXBvVWrbqtiy/yil45q6CI/RwBYKzIjjdPu1tsOr6LJkjklA
         vwBZ020nfGvwhcYB0y9YlUYx/sG7lGWMAJV0durfHlKV6Ig2+5mztzF9zP2//cI34kVQ
         hyDZQYKa7gBECGlQIETFKSd7JZbW7buam4JLgN/o5ezmc5YISSGYGRhTRoyX3AOm07Bk
         +dxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jtBc+cZwMMXc8ihV5eWP1hHJP2YCUyxqCfEqdOGn3sM=;
        fh=Nn3NT7Qg/qR3HevGtYLkglO4NyygIeDODtp8Eq4W0pY=;
        b=OJIqetYopbXQWXDWIhx5WrQ4QFJ9Jr3nPm2dJO9VvH85zDB017oij0ASBzcJ8bDHBo
         OurALdFrXWW+Jhk37bXB2a0oSWF6Z0q05rqJqlkcYi+qK0341Xkd9AAG5LVcDSNsxAeY
         Hfi7TnJ/jCrV3TqEFOMFnZ9+6jUNTG1eWtojluSy9m78mmPtGfx3TXz7TG8a2goHVXlF
         P6Q2xZ+uLYrBQYekgZp3lZ77+ayVfglY64F1+0dimX4004Z0l9f/c0bBMWdyGzCCifvi
         Os3DZnqPhf4Ivm0NLi34TXt5rf+yY8wSFKqp/sScRu4DHshvyB2aqajFSr3p4Ni6uxQV
         QCiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689197; x=1781293997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtBc+cZwMMXc8ihV5eWP1hHJP2YCUyxqCfEqdOGn3sM=;
        b=DAkYmxevBzhVSunSKsJoFYK5lOwEH75R6iLoYHEbx4i3X5HOo2naaq/e5RPxEf1gCI
         SzjmShG03Bwu9nRAXvEVb269oLTsg6V9pPUVtOEm1AKpBimdS8T7kjqYv0FlZDfnZ8PN
         xtpWCcbEHLmPSv8ivXXfqRpAMxunWpiZYqq0sAJOq1RXhypfiA1Fn1nFg98SqaUzw0RR
         V6QPQxIWznfN0RA4iIX1KnLqTrcI71vQJghs8g/HARlQA62BQjINimrNNRvWD4NTjyDB
         E8nDcP+5BUgD00V9JI236G0+XFgutQqvLSbWzFzCmiQL/Eju9BVVhnnDzz8SYvJ3JQ2w
         6BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689197; x=1781293997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jtBc+cZwMMXc8ihV5eWP1hHJP2YCUyxqCfEqdOGn3sM=;
        b=qnJgM4UG1iybm1v2U3I64GNZPr7wZLFXWpbnn29RqCKdMNaufemFqdC0Z3h3cBAtRq
         4vHQYznrW3YWqLbtILE4s4vA0Ty2qz+hbGMytCesJDKsvzzjEtwIRyZFSZwfoMXkwZp8
         WaFhdz3/UOtP/Z3TQ7OGAKNeLzJaNf02QmHbkfC4odRN1kCJwzHy4EaQe7nCnJ7LKcFS
         IXJHKUu2ZrR2yJgpbR+mAS14gZDxEiTQHi0kZwQHudAabiOBh5QR4dWDcuI/+m1qiqZO
         XHVRAEdm8V3pc56I/twk6vBkHxNg7i/DW986fc2odZ1WSIU54IVhjR6CSlgwIAi/+YC5
         5cMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DtbzIJReKFzjo5W5boipC69+IuAZLDCs3inGj+AZ91efHU5CWQ8smrZV23q1hIF3bu/GYKjiyRvAa+ii+zB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqV98/sd9tMQDvNDpFTm53XoHxAW+7n20xnDE3sfJt/KVETfl7
	fid+5ZhJ5T8tUvOlIGFFx1/k/hw0xI4iYQPnq6HNuISzYXg5qTH0CfqkrLOAdLGuzVFOxNZ3Vdd
	kTjQvmzLRR/DnFl/zhnHoLmG47AjdR9Q=
X-Gm-Gg: Acq92OFMCivZfPhkIFQa0xpt4hRV0ZM6YteSEEGap30dUMV5DE2ssqEFNBl9g4mJFdW
	jIuxdsYZ52dbSS6FCU5hEtS98aqXPYdfQAlHMiUd9zfo/R9C0ZxAKqA1m3mhqcKyzkQ8KQ4L5KH
	wT3UlkmJY0Z4g6STg177F0zJHqmAlY5GIEIMmoIaJTV+EdBAS6TgiXYq9ZdN7yB0dR16NkHytIC
	0l6BZI2CjaLU5Nsf479c/AaRvaa+8abx4b95LM29CEcZBYePCyZiZlHCxa6iZc1NPIglVu+eAvj
	fw3LgNXF9mfOkQ19mlXYtlHJ+k3SqhsL1jScahPZXlXXFdc4+XFiIyuo0WMyE97/MlzuVYC2RIe
	4KYyz
X-Received: by 2002:a05:690e:418b:b0:660:5520:1b8d with SMTP id
 956f58d0204a3-66106ea5388mr4525384d50.11.1780689197177; Fri, 05 Jun 2026
 12:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604170633.730139-1-tim.bird@sony.com> <8def22a9-85bb-493c-bd37-a299285a8f79@molgen.mpg.de>
 <MW5PR13MB5632F713AE9A9C87F131E28DFD112@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB5632F713AE9A9C87F131E28DFD112@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jun 2026 15:53:06 -0400
X-Gm-Features: AVHnY4JM5zGFzkE0Z0LaNSvp2xhmlPHEzsR8DCJQeWsXh9fvvPqjh5y3lOYSKTU
Message-ID: <CABBYNZLO8iWYgdXav+aG938FcorDtLd-3gqbrjjt5JH0LMUsGA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add SPDX id lines to some source files
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, "marcel@holtmann.org" <marcel@holtmann.org>, 
	"jannh@google.com" <jannh@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"kiran.k@intel.com" <kiran.k@intel.com>, "chharry@chromium.org" <chharry@chromium.org>, 
	"gustavo@padovan.org" <gustavo@padovan.org>, "prameela.j04cs@gmail.com" <prameela.j04cs@gmail.com>, 
	"maxk@qualcomm.com" <maxk@qualcomm.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Fri, Jun 5, 2026 at 12:26=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Paul Menzel <pmenzel@molgen.mpg.de>
> > Dear Tim,
> >
> > Thank you for your patch.
> >
> > Am 04.06.26 um 19:06 schrieb Tim Bird:
> > > Many bluetooth source files are missing SPDX-License-Identifier
> > > lines. Add appropriate IDs to these files, and remove other
> > > license lines from the headers.
> > >
> > > Leave the warranty disclaimer in files where the license ID is
> > > GPL-2.0 but the wording of the disclaimer is slightly different
> > > from that of the GPL v2 disclaimer.
> > >
> > > It is not different enough to cause licensing conflicts, but is
> > > kept to honor the original contributors' legal intent.
> >
> > Could you please add a note, why you use /* */ in header files (suffix
> > `.h`) and // in files ending with `.c`?
>
> This is documented in the kernel policies for applying SPDX license ident=
ifier
> lines.  See Documentation/process/license-rules.rst, Section 2.
>
> The reason is that some old tools that parse .h files do not (or at least=
 did
> not at one time) correctly handle the '//' style comments.
>
> Did you want me to repeat this policy in the commit message?  I'm not
> familiar with any other places where the official coding style is explici=
tly mentioned
> in the commit message, when the style is used in a contribution.

Nothing to worry about, Ive already applied it.

>  -- Tim
>
> > > Signed-off-by: Tim Bird <tim.bird@sony.com>
> > > ---
> > > V2 -> V3:
> > >   - move Signed-off-by above changlog
> > > V1 -> V2:
> > >   - Leave different warranty disclaimers (which is most them)
> > >   - Remove files recently removed from drivers/bluetooth from the pat=
ch
> > > ---
> > >   drivers/bluetooth/btrsi.c         | 12 +-----------
> > >   include/net/bluetooth/bluetooth.h |  5 +----
> > >   include/net/bluetooth/hci.h       |  5 +----
> > >   include/net/bluetooth/hci_core.h  |  5 +----
> > >   include/net/bluetooth/hci_mon.h   |  5 +----
> > >   include/net/bluetooth/hci_sock.h  |  5 +----
> > >   include/net/bluetooth/l2cap.h     |  5 +----
> > >   include/net/bluetooth/mgmt.h      |  5 +----
> > >   include/net/bluetooth/rfcomm.h    |  5 +----
> > >   include/net/bluetooth/sco.h       |  5 +----
> > >   net/bluetooth/af_bluetooth.c      |  5 +----
> > >   net/bluetooth/bnep/core.c         |  5 +----
> > >   net/bluetooth/bnep/netdev.c       |  5 +----
> > >   net/bluetooth/bnep/sock.c         |  5 +----
> > >   net/bluetooth/ecdh_helper.c       |  5 +----
> > >   net/bluetooth/ecdh_helper.h       |  5 +----
> > >   net/bluetooth/hci_conn.c          |  5 +----
> > >   net/bluetooth/hci_core.c          |  5 +----
> > >   net/bluetooth/hci_debugfs.c       |  5 +----
> > >   net/bluetooth/hci_debugfs.h       |  5 +----
> > >   net/bluetooth/hci_event.c         |  5 +----
> > >   net/bluetooth/hci_sock.c          |  5 +----
> > >   net/bluetooth/hidp/core.c         |  5 +----
> > >   net/bluetooth/hidp/hidp.h         |  5 +----
> > >   net/bluetooth/hidp/sock.c         |  5 +----
> > >   net/bluetooth/l2cap_core.c        |  5 +----
> > >   net/bluetooth/l2cap_sock.c        |  5 +----
> > >   net/bluetooth/lib.c               |  5 +----
> > >   net/bluetooth/mgmt.c              |  5 +----
> > >   net/bluetooth/mgmt_util.c         |  5 +----
> > >   net/bluetooth/mgmt_util.h         |  5 +----
> > >   net/bluetooth/rfcomm/core.c       |  5 +----
> > >   net/bluetooth/rfcomm/sock.c       |  5 +----
> > >   net/bluetooth/rfcomm/tty.c        |  5 +----
> > >   net/bluetooth/sco.c               |  5 +----
> > >   net/bluetooth/selftest.c          |  5 +----
> > >   net/bluetooth/selftest.h          |  5 +----
> > >   net/bluetooth/smp.c               |  5 +----
> > >   net/bluetooth/smp.h               |  5 +----
> > >   39 files changed, 39 insertions(+), 163 deletions(-)
> >
> > [=E2=80=A6]
> >
> >
> > Kind regards,
> >
> > Paul



--=20
Luiz Augusto von Dentz
