Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D026363097
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344159; cv=pass; b=TAjJ5qEkoHGctbUlyXw2lFPQq8KXiA/Y37wD4no02zh5PCAAD4d/9QsJDTHtALc4YEL0oTKNDj7xCNNkDJz4i3IFAZHF4fVbWz8y1V7c5L/q6JdW/UcXqqOn4bjOMnUth48SJE3fKYbMVBjyhuPaJInSSelsyfquJ2unDAMyKQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344159; c=relaxed/simple;
	bh=cYGK1+IXRhVq8uhF2xxBEYJjpNCNLgxDgdVVjFpds6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRCpSsJmRFC+g1O3g45jM5OUEklL1Uf67tyup057Fal+gGL5V4sJcp2oAGTUk2ef3oXlDEdDRsP4wNzActQugZt254YJLNW6P3Ijx2nsiOU+v5Dm4Nf8qYNTTRhG2DgNCkZRAONJMVE109j7cJSGilNnlprO+jHw2TNgo6hZr98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ4SEFfR; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ4SEFfR"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ca09f2056so1153825d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 12:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773344157; cv=none;
        d=google.com; s=arc-20240605;
        b=gAaUtXbHr5sAU7f11l0PJTO3yK0wLKiuYbgndNeAPHzZt83/p0jUU3wtyckLx+zO5U
         3uYJPEDV/ol5rRmdu9sqeFdbh8NWkS+qN/DqUchbBV7Xa0/ix5bTGAMvd4Onv9R7jQLf
         o6LG4ZYLFh3YxCPayux88VFxYe2J2HiyE3vZODpdp5DK34YZTCk+0DHbsgXRuBl8Wkyn
         ZBUYiQjxKL2eJrcKU6N6mgcshYyV9OFH6JHptc1hyVvzpg0UaEwGmSXJO5vsxS9luYcG
         KhNqxOnUYyZx5kDsyDyfU3GvtsjvAB4G9DdOXY48Tl4qE7YwxL/OAgchvxOVxTe++AWd
         ypZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uWMSuKYWOr0Wi9ugJUdt//fWBV/eYeFL0OKIPG+JO/A=;
        fh=0H6J9+Uqg4nA2AjzG7hKidolbWoVB5NsENpzsnN0yOY=;
        b=cFSQlg4wcRfIFQaoJlIHvu9cWClrnWcgV8b5NvqqfLlJntFTSoz5VUvkPvw9v48d6N
         eezF7uon3BVe4A75707eyjo6qouvj4o0qBxGHcxeb2gCugBB2L3suNS5UnxgdvbV2XXk
         xZgk2fiudv6QcTNZDrNk1IvnibGNsJrXFH9jtKdA3Sh/etnfcZ24cP++6MGAPzV20PHu
         rqBPydBW+ktESHbuAQv26rItCPUdwr5jGwwprI4mBsnSlFKFkDPxH7xkmDg+opdud7Ie
         yPEE4ndue11axZUNVXc+uiiZ64ApbBdOGQD433j0VxnPLIHzZgtDsj3UiipVKLhKaANR
         OcwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773344157; x=1773948957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWMSuKYWOr0Wi9ugJUdt//fWBV/eYeFL0OKIPG+JO/A=;
        b=HJ4SEFfRgM96opZI+dZ9nyDUQmksQfLt4I8wM1dCLVl/f053+cvmfK33nkpNEe0m9R
         8kb2M29DfODDra2WA4RKhCsnnhUiZ3wm9Ci0TOfcuagQXxQG65gAxNV8cg/ivJolK2Px
         szmMCc7VkjyKZ44lblqYopRIgJ6cziwsHQJhAyiUcEw1OWclrH18R9TdDuI+f+vnDFNn
         28PJ2Yd8k5Ex/ZqYXEYWhcksRQ459N0Ek8iX+Q6z+Gji8zIi+ADgmJW+TOffKdmhgBqv
         Fh/L7H8jYQLkbqc/LmseBl0rU+np8FVU4shEx+GvLHT8dXmSlOfAdtJNjF/6bKZbQus9
         9RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344157; x=1773948957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWMSuKYWOr0Wi9ugJUdt//fWBV/eYeFL0OKIPG+JO/A=;
        b=CfOpRO0cbG4IpKsFw7eCiyifet1HAZ40LvZZLrVr/mceGH43wwr8EmG1o4uXLXG9jQ
         c67ZZQsY0pWT8t1yGq2TRhRob+wAcogUHfMgMOyf2oTHORkHytjIbR/LIGFdQJxsgciG
         PB9Fu78nOTDwPL4IjtkvBND9w3qK/QT+dffjYTtb+t+S9BYLOV28udjAq2JysnhMV81C
         wY+MFzhDZogLmbgL0zFTR9u3Xno+x8t/GSTNiVSCuqRcBa7jiQndrN/razUDI3l16tRC
         HcclGmcEz3l6RQlcW4hya03FV4fJaEqirZSwkdJnIYNZeQvfLrunTeU2ExEj8Egt80h1
         4JbQ==
X-Gm-Message-State: AOJu0Yy4C9cptEQr33JpjX/NqpZJ9aT0OM10RRg6znQ/9egitvKJbREu
	c0QFDyUJXy6pESjNAtiBGOIPk9Ggqw4fyuFMy5j8o4K+4WGjrq5uZu/AjtwDdYhZVP1I5JskOr7
	lfnFi005w5pkuHpLxyE7wxxH/Sn/ehsuulzIj
X-Gm-Gg: ATEYQzzwDNYb88BJmesItpEC6L4jLTPSYey2ZAmkGqIKveYKr9eGqbUULmXDYFnQ8GH
	RSwGgX9O0AoQT3GbyXci8vFwAqTJe/S3lYRAtRH/Ru/1BrbYB0ylvSNLtZpsPy9BdKTRkP++83C
	6vdDPG/2ez7UWi83FeZv1nyR3TRAfbGVlJTc51eGo+hkWjp0nW5VRNljs5XBG5gk9ROiYODvcBI
	nLLnFm3o2m37pIAqb37+hSEQ9RfJY7ypA3LhGnTk+AXR5Yf05aIBtZIcPWbeYKxsZ9K7ZtcapR7
	QUUcn37odTHg/bJb849v6WVk8ezqyXpV7EQ2PxBo4RVakUDtSUeAg8u3t5qEsHZLXU5/Dw==
X-Received: by 2002:a05:690e:24d2:b0:64c:e7b1:3573 with SMTP id
 956f58d0204a3-64e63041455mr588234d50.54.1773344157227; Thu, 12 Mar 2026
 12:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309040136.159073-1-berend@deschouwer.co.za>
 <20260309040136.159073-2-berend@deschouwer.co.za> <CABBYNZ+6mVQFhLBd6KaFfKLvOC2D8F-Pt6W+y5TT_hAC3Pu2sw@mail.gmail.com>
 <1cadd6cce1846e3c9c9cadb44a8ba1764b623a37.camel@deschouwer.co.za>
In-Reply-To: <1cadd6cce1846e3c9c9cadb44a8ba1764b623a37.camel@deschouwer.co.za>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Mar 2026 15:35:45 -0400
X-Gm-Features: AaiRm51BSCTOftqSSskp4QUdPw3ud4G8XT0RaUTCYnl9OqTZVnjiyojG71hKkFY
Message-ID: <CABBYNZLuwRpaxi3RZFJOGd7kNKMcu-WfPEhrx1T9DrqrSF4SuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Stop and start some actions on suspend and resume
To: berend <berend@deschouwer.co.za>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Berend,

On Thu, Mar 12, 2026 at 2:22=E2=80=AFPM berend <berend@deschouwer.co.za> wr=
ote:
>
> On Thu, 2026-03-12 at 09:13 -0400, Luiz Augusto von Dentz wrote:
> > Hi Berend,
> >
> > On Mon, Mar 9, 2026 at 12:02=E2=80=AFAM berend de schouwer
> > <berend@deschouwer.co.za> wrote:
> > >
> > > Stop active device discovery on suspend and shutdown, and restart
> > > on device resume.  This uses dbus notifications, so needs a running
> > > login manager owner.
> >
> > I guess this is implementing the following functionality:
> >
> > https://systemd.io/INHIBITOR_LOCKS/
>
> yep.
>
> > My question is, is this really necessary? The kernel already has
> > handling that detects if an active discovery is ongoing, pauses it,
> > and then resumes the discovery state upon resumption:
> >
> > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_s=
ync.c#L6239
> > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_s=
ync.c#L6132
> > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_s=
ync.c#L6371
> > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_s=
ync.c#L6292
> >
> > Maybe this is not working in your system for some reason?
>
> It's not, in bluez 5.86, and 6.18, assuming those lines apply.
>
> I would be happy to accept that this is the "wrong place" to fix it, as
> long as I can help find the "right place."
>
> It also happens on reboot, as long as the power isn't cycled.  That
> makes me suspect the adapter hardware or firmware.  Or maybe ACPI.
>
> I'm quite happy to get debug info or logs in bluez, btusb, or btmtk, or
> firmware, or any other place.  If there's a better way to fix this
> problem, that's great.  I have no idea at which level it's broken, so I
> fixed it in the only place I could.
>
> The current solution isn't working, and there's repeated problems
> reports by various people, for a number of years.  Search for Logitech
> in the bluez issues.  I was happy to find it had to do with discovery,
> and happy to write this patch to prove it solved the problem.  To --
> finally -- come with a solution and not just a vague, unrepeatable,
> problem report.
>
> The test is easy with the hardware: open discovery, suspend and resume.

Interestring, we even have a dedicated test for it in the form of:

tools/mgmt-tester -s "Resume - Success 9 (Discovery/Suspend/Resume)"

Resume - Success 9 (Discovery/Suspend/Resume) - waiting 1 seconds
Resume - Success 9 (Discovery/Suspend/Resume) - waiting done
  Set the system into Suspend via force_suspend
  HCI Command 0x2042 length 6
  Test setup condition complete, 0 left
Resume - Success 9 (Discovery/Suspend/Resume) - setup complete
Resume - Success 9 (Discovery/Suspend/Resume) - run
  Registering Controller Resume notification
  Test condition added, total 1
  Registering HCI command callback
  Test condition added, total 2
  Executing no-op test
Resume - Success 9 (Discovery/Suspend/Resume) - waiting 2 seconds
Resume - Success 9 (Discovery/Suspend/Resume) - 1 seconds left
Resume - Success 9 (Discovery/Suspend/Resume) - waiting done
  Set the system into Resume via force_suspend
  HCI Command 0x0c01 length 8
  HCI Command 0x2005 length 6
  HCI Command 0x2041 length 13
  HCI Command 0x2042 length 6
  Test condition complete, 1 left
  New Controller Resume event received
  Test condition complete, 0 left
Resume - Success 9 (Discovery/Suspend/Resume) - test passed

So yes, the kernel should handle it, if it doesn't then we have a bug
somewhere, or it's incompatible with the controller or something
similar.

--=20
Luiz Augusto von Dentz
