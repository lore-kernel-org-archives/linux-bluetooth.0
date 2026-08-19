Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A3283FE5
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156749; cv=pass; b=GuHOtUwuGpBafQ7btE6ZYdocf/CShwwiyKsAxILSSdjKCZGUaEwx3FHFlXjp5qYGD4efkscS2kW9yRsOxJRsnWuhzBG3uzfRTICwluZmQTCJkSWxPgylpgV0AJm/T8i5/iuE8k36lch9qUpX240k9TKpSPlVI6hngDJOc3TErPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156749; c=relaxed/simple;
	bh=QTZ8swtijkfVi+YJxPypjtVivCBfWnCvFhHDw9Uxp70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSbOHzfSnwBYnulmcp8utAtG86aWMsAS5BFYLLoydf/GFBA6rmy2PuhpWqBueZy852+VQ1ZfyTArXtI2+48eqHDsKxW0/mh2jJoDXG7ByDc7SV+Kmr8pucDe2nMGgaGsyT279X4zK58VU+gMikBZEsYLIfUxQxKCOznodVLleWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzCm3Q9I; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzCm3Q9I"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-836cbcd0a48so19000047b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787156747; cv=none;
        d=google.com; s=arc-20260327;
        b=bulVG84Eb8t6rJSkktWBoQXvk+mOf752o1Zl3de+8tg3nyN6jOdvFwBY7dbCQDljgf
         6HNhgijmzzuO+82Rayn+B4athBz7Qoo7lkdJF3Mq509I/GHrIu67fKOwnTzCBaUFDtDG
         jg93MJ38kurD0H9nhn0NJCG1DYMO7G0Vj5sq9laTieUoGGd1nex9YDj5TNIR38jUpaFw
         M4H2yeyxArcJ77Pf5by9Tcvs/3jyA1SBeUJg4L252F/3/7uKxENd9i/i4xqr9HE/rjTh
         9DAVSxRDX5maBiccNWDFfdJFEse9loJ8H3a3lGDRyd3rAmskxfHmAXRmX0CLB+JAfbu6
         jbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W5RCTORorN4Bf1q2o7H3rQstkMAtNNGlwtFQtYofGT0=;
        fh=KvX31vT1+6+8GaKcNQXYEueCpVbvb3Ll0YQS1timrEc=;
        b=OaG9YwmuZjLlt1DeTnzE6CDSF5P8kdh2I7YGusxnkKoi1/SGQz9brVs4tysX1T6XAP
         RQfbNpkcIEMUL8psg2TQFC7eUGNhlS41CZmTFIO73bbEunEOdsFYK91cOVMcGhuWdtri
         cmZcx9RMwvZ9v55NwXpJ+80xvVEaXOpJ1y8EVBLhmAUuwYRX4eQdjNZ9b15ISaRlxag0
         0hXc5AqtvrpYSleQ9kO++g95hD+vglZhR/jocRBI0MPXpSve33Yexx3lzaf6/AI1X6Gp
         06PhStedtIFm+RK+4ucWteALzJRiU6wpRh5pQiBLnKeX8M6NNnna3FPMlqbvXfzMplJD
         RRkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787156747; x=1787761547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W5RCTORorN4Bf1q2o7H3rQstkMAtNNGlwtFQtYofGT0=;
        b=IzCm3Q9IPhbjf4P5i5Vr2s0EnW98xBjtdQLwrTdMUFzkOfYhWZNHIIJB/tge6I6nUl
         ku3alYhF5Uhfved2w5uFSZFTEwVvsPI//gA+iDw8oss5PiW/4OzfIpVg0d9b6+og5otz
         mmDiK0MEvEZntZFlpCGBLupmhzeEqHYN2y9kqASFRaB7cjzr0OxNPqia4d6M5D3dmt9S
         Q9gdcIJog6bnphrt9fjsLFF0njWeCuLImRaTZ+JBaKWwON+CI6oNg0c0LFieHBsm9W1U
         3Ed5DlZBsm19peXcK+vMwJ9zSBuz+eG8G6NBXWcgh/GZzrjkOmub/6qrfsEHdFYH3IO+
         XqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156747; x=1787761547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W5RCTORorN4Bf1q2o7H3rQstkMAtNNGlwtFQtYofGT0=;
        b=VGHCKHC3mqTWKKk+zdQ2f74rIOt4FZGLoW8HsAK0PO1VxD56b4DGDQvWNni/HsIshB
         371aJ8e4dMHc/2vvXZcPs2dhBTCI4OSn5MsMyeIHB23gVEAAcqmJjkrY2U5atfnaNYxt
         IWAJ8Zr5ux3/4MyprBFFYntpkN0YwPyNJ+r9tWXNCbXkKxsFtuhOeafFyiRKfrwFxbun
         rfxdt2uS3miBVzBxy24IcfmByHhwQjR4QRL2WejoETh7HCbZpd5FsLf48nsw+OxGyqOv
         9/A+eVnjrd8w+6j6IIkw6TwtRlxoNADnXT5sd8HfM3mrviQ/S3sQ/A/s8UFYChMHn9zk
         VUzw==
X-Forwarded-Encrypted: i=1; AHgh+RogJT5d3ftYrsKDjveuCh8EkduG5pzawa6rga4KpnJQmYN4AQIVLFdEXhE7abo33jwJkgoUHHfgFQqFFjpzFXc=@vger.kernel.org
X-Gm-Message-State: AFuF++l0+BPb15CHlLInsdvg8U4qmmuGiLtpEs5NAg8ZjkwIbx9IOr+K
	D85Zw1qxkGo4KbFk/cPJnK9mx9AVacjXXa/bvhriS7l3zXKaq0fTVREEeVhzjhit2ne5yQZG7fw
	mrvUEHRhvlvn+qF89S8pP8DWWTDE6ekI=
X-Gm-Gg: AR+sD10++FlAtRKLzYCsLRKdn2zfVlc5hy4rhdjTpOoMNIJhjdwPlihXF352R5loJae
	SZCguYWGTfmcscGBvnPn7Bm9ppmNsmLqSmRFq9RBs4WiiUutUhDeGKXBiaH9o2xWHDYBruhLUPC
	FEdfsgkfarLUQeq9TF10zFFgeB/k7tbCkIpw0tug3dVcKneYGyhXqq4jPVLfL8SZD/+uPJ+1EHI
	tWTTCWr02dqZOTzYa2kd8uPYOVkNvY1TwoXTkQRUZXpyoJyJOtaSUEp3RF3wpd1acR08oX+yXmN
	lKaFe7qpo/UgBn1EJd+5vPPQyCPXli7GJeT8K9bC4F41glv5zDPSmw8Gq2a5CmKUhe0U3Waefbc
	plox+qaqRJrQlG1hD5zRU1g3zWdbEoe3XELn+JCc=
X-Received: by 2002:a05:690c:1b:b0:81e:6c2e:f0f5 with SMTP id
 00721157ae682-844e2324f52mr29600307b3.28.1787156747164; Wed, 19 Aug 2026
 09:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com> <340c1443-9e2b-4224-9029-f1defc644494@oss.qualcomm.com>
In-Reply-To: <340c1443-9e2b-4224-9029-f1defc644494@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Aug 2026 12:25:35 -0400
X-Gm-Features: AcwNN1UAZPpOUZd10LjgTjceqxpa1OAV7zOqXLke9NZvRrCNfgsWSzvPlCS6wUc
Message-ID: <CABBYNZ+cFGH0kD5iLw1WnUWuhSxkgwu0BZ1E0WYCzOg9D92quw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_qca: Do not write to the serial port after
 it is closed
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed, Aug 19, 2026 at 8:59=E2=80=AFAM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi All,
>
> On 19-Aug-26 14:54, Hans de Goede wrote:
> > From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
> >
> > hci_uart_close() closes the serdev port if HCI_QUIRK_NON_PERSISTENT_SET=
UP
> > is set (for example, for the WCN399x family). A failed hci_dev_open_syn=
c()
> > following a successful qca_setup() calls hdev->close() but not
> > hdev->shutdown(), so the port is closed while power->vregs_on is left t=
rue.
> > qca_serdev_remove() then passes its power->vregs_on test and calls
> > qca_power_off(), which writes to the closed port unconditionally.
> >
> > Seen on a WCN3988 by unbinding the driver after a controller failure. T=
he
> > trace below is from a 7.0.0 based kernel, where qca_power_off() was sti=
ll
> > named qca_power_shutdown():
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address
> >   0000000000000038
> >   Call trace:
> >    tty_set_termios+0x50/0x238 (P)
> >    ttyport_set_baudrate+0x84/0xc0
> >    serdev_device_set_baudrate+0x24/0x40
> >    qca_power_shutdown+0x158/0x1fc [hci_uart]
> >    qca_serdev_remove+0x54/0x68 [hci_uart]
> >    serdev_drv_remove+0x1c/0x2c
> >    device_remove+0x4c/0x80
> >    device_release_driver_internal+0x1cc/0x224
> >    device_driver_detach+0x18/0x24
> >    unbind_store+0xb4/0xc0
> >
> > Check HCI_UART_PROTO_READY, which hci_uart_close() clears in the same p=
lace
> > it closes the port, before writing to it. The regulator disable is left
> > unconditional so the controller is still powered down.
> >
> > The dangling serport->tty that turns this into a use-after-free is
> > addressed in a separate patch.
>
> That separate patch can be found here:
>
> https://lore.kernel.org/linux-bluetooth/20260819125748.194377-1-johannes.=
goede@oss.qualcomm.com/

Hmm, I wonder if both should go via bluetooth tree?

> Regards,
>
> Hans
>
>
>


--=20
Luiz Augusto von Dentz
