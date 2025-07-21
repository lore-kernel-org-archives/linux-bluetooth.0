Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9436F06B
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129346; cv=none; b=gLh3zyp0rePPcsvUluavE84w50rWf7yZajWq6m5SHS8UFsIxgmgMrD60MfWRFtP2uchkby8bF20/7yy7KHpmmL/oZte/GY7iaMT+OWDrW3YSglqgaNQ0Hmf5hnCPxi6z0TcGbVQn+3PwBeMlWfaw4zHMyhTQ3Ld7eXgIF33Buiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129346; c=relaxed/simple;
	bh=lF5beg6JygeUAATj1wfWqOR3Oz7lU6bq5DE3+htOPHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZOEXI7OR0z3V2LVrIIzaotizyDkN2KKnrmm1IH4dWwnz229hGqkFNi+6TLpO1VyQEmvRA3EDv8CP4ytEq/UbS65YoScde+W93EsafY4L61vf1+G7KJPQekYuB2ieo3ZbCb5Qud0Nc5VuVuEQBrVp47o9OtbDovwb50pe3S1R08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQkTQ5iV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQkTQ5iV"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32e14ce168eso52470921fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753129343; x=1753734143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfEnyfbiJAXaZi0s53ksTEhcRIhKeSU7CMoXdxLAEc4=;
        b=OQkTQ5iVyyzpEqvfTHkuWwVqkFkfOkvt/29plG+yCJlXoFyA8fF3HPzdV3J4ubWhWK
         qKuX0oXl8DBLqc6IxiEe7xyOHt1tdndM5t2EG2vmNDCLMHnMw/nlSyhuSmix2SJHeqaf
         cdKDZYa3LsQkXZF5rqXLDM1YPRgrTrFjDYCtHlBqIN+he5uP5kVLx/CwlN488ifU1F7g
         MKbmcuevx0E4AlfK0xqyFphf0e09oVrXs7wGPzABTIXuiCJM6gS4xyxbiVOsoN62ceuk
         UAYJ3+L+bo7srtsJW0Ft3I5fQVC0axoH+rU1c9x7WQuP2pmfZ64rZE79PGBjL1ZqzNhP
         ltQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129343; x=1753734143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfEnyfbiJAXaZi0s53ksTEhcRIhKeSU7CMoXdxLAEc4=;
        b=XGU9IQeqHgJDgFtd7v5zBFmhBbrLsFefQGjcl1X2pBzj9dChRfHIDOFCBURTrKrA/e
         MVhH5by0Th1A+NDdMr46CNAFrEjQDR5FXLmfhGncuWNVC3C3bHrLK6BR09aH+MynPO1l
         X3EV2XuwVdaVtEYt5vKGtJ21WbCvux+fI3ZrsnF8p4keFVi7PDv7fn1RXU9tSsFLKSBu
         MgH2qnCASv12Cv85U4Ouh83jj0eW1qEY1j64sBLLG+ICl9Zk4Zqz7hJqg+CrbZK2+wMD
         Vk4bNEM8TrWnWi4Lckx3og5BfX8R6vLq5GY2VowznT5zNSX0717r+rNQPIzxJDlD7qro
         1KSg==
X-Gm-Message-State: AOJu0Yyi0Oloh2inJV1H7qS3mDsb5MK//1dEf+B2CP/ofHRft4+n3GeW
	rKlFQwyZyg5ibwjieVnmveqKz60iW5B5D92XPQvy+dBdUSpelzHyGbolp1AOt1iRHJV3mAyz73G
	7Zq+Tvjrfn5b8Yw39ITkNJbRHdHlVE/A5jz1+
X-Gm-Gg: ASbGncs1jJrJonI0S0NoWcQFbH9ZoQXnTKJLfr309x/9WSvf/H0/5fgOZmEG6NklW4x
	LPwQGu5RC5pZK8clvc/0eV4Hb0/g+UozRkOAi8ZuU+wWmH8ycc9VpfZrtWlc7E49jneBO4PiDJi
	GAg2h56igfG+TFn6clMgst86RmojIoeFD6wGxVUSyBUpQP/3ef9Mr5sGK4VPLTHMuHbOXxEztGy
	yKR/w==
X-Google-Smtp-Source: AGHT+IFtnT9PzmqAKqcz652oJotgOcJp3poR6p0UHwjuyr+FqXSelu5mu/GtSDZq9p+Fl3O2rhEk0vpuRg9G6sIqho4=
X-Received: by 2002:a05:651c:20d8:b0:32f:45e5:df57 with SMTP id
 38308e7fff4ca-3308f5e0edemr40121381fa.20.1753129342148; Mon, 21 Jul 2025
 13:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
 <CABBYNZLUK45-eBcYAn7oq9-gewhE_XLXpnPiwKXPF-tOX6JYrA@mail.gmail.com>
 <119538af-e432-47f8-ae87-4c59750cd4be@quicinc.com> <CABBYNZJ2EAr-H+WKiifzqpC-bnxg8L2NSa1yG-Xjccw=oe3yVg@mail.gmail.com>
 <0ad121d9-0afc-452f-bc85-36344ad4ff25@quicinc.com>
In-Reply-To: <0ad121d9-0afc-452f-bc85-36344ad4ff25@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Jul 2025 16:22:09 -0400
X-Gm-Features: Ac12FXy9tZ6Wjv74hMxCR5jN4rWHhxZtg4xLYXJIYTS3rBoe6ep5X34LKREoZwQ
Message-ID: <CABBYNZ+ufuBAR9ONNBaNU=KHNUVNtAGeHWE1uzHLT=7xab+hyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Francesco Giancane <quic_fgiancan@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

On Mon, Jul 21, 2025 at 2:17=E2=80=AFPM Francesco Giancane
<quic_fgiancan@quicinc.com> wrote:
>
>
> On 21/07/2025 19:01, Luiz Augusto von Dentz wrote:
> > Hi Francesco,
> >
> > On Mon, Jul 21, 2025 at 1:05=E2=80=AFPM Francesco Giancane
> > <quic_fgiancan@quicinc.com> wrote:
> >> Hello Luiz,
> >>
> >> Thanks for your feedbacks!
> >>
> >> On 21/07/2025 17:20, Luiz Augusto von Dentz wrote:
> >>> Hi Francesco,
> >>>
> >>> On Mon, Jul 21, 2025 at 11:24=E2=80=AFAM Francesco Giancane
> >>> <quic_fgiancan@quicinc.com> wrote:
> >>>> Hi,
> >>>>
> >>>> I am posting this patch series to better decouple `bluetoothd` daemo=
n
> >>>> and `libbluetooth`, as mentioned in the subject.
> >>>>
> >>>> I am introducing this change to make new BlueZ more granular.
> >>>> This will allow more control on which components are actually select=
ed
> >>>> to build.
> >>>>
> >>>> Major use case for this change is fixing circular dependencies when
> >>>> bootstrapping new builds where the whole build root is to be recreat=
ed
> >>>> (e.g. Yocto Project).
> >>>> In these scenarios, to have Bluetooth support enabled in Python,
> >>>> `libbluetooth` is required at build time to be present but the direc=
t
> >>>> chain of dependencies would require a Python installation available,
> >>>> thus introducing circular dependency.
> >>>> Separating the library and header files from the rest allows build
> >>>> systems to break the dependency loop.
> >>> In theory what we should do to fix this is to add proper header to th=
e
> >>> kernel, since libbluetooth is basically just used for syscalls to the
> >>> linux-bluetooth subsystem, btw doing that would also fix the likes of=
:
> >>> https://github.com/bluez/bluez/issues/989
> >> I see I see. I read through these issues jumping back and forth Python
> >> (it is interesting that it's covering the exact same case i'd like to
> >> fix :)).
> >>
> >> So if I understand correctly, your suggestion is to remove *our*
> >> internal headers and rely solely on kernel ones? Or better, move ours
> >> straight to the kernel UAPI.
> > Yes, moving our headers to UAPI is probably the right thing to do,
> > that said we will need to figure out if we can do this in one step,
> > and just start depending on it for the start, or if we gonna need to
> > ship with a copy as libbluetooth and have a transition step, from the
> > looks of it we will need to do the second option until distro catch up
> > and start to ship with Bluetooth UAPI headers, anyway we can probably
> > start with UAPI headers first along with any kernel changes required.
>
> Assuming that we can create headers in kernel, libbluetooth would be at
> this stage a
>
> legacy wrapper around new APIs (which are possibly the same names and
> symbols).
>
> This would help not breaking any of the existing packages and at some
> point when the
>
> majority has moved to linux UAPI we can just drop these headers from blue=
z.
>
> As long as these changes do not land into kernel uAPI we cannot change
> anything here.
>
> Question: where would you drop them in kernel? I assume it is
> uapi/bluetooth to keep

I guess that would need to be moved into
include/uapi/linux/bluetooth/, I took a brief look and there is also
the likes of sdp.h, sdp_lib.h, hci.h and hci_lib.h, these header are
either exclusive to libbluetooth (SDP) or partially exclusive like HCI
helpers, anyway it should be easy to identify what symbols comes from
the kernel and exclude them from libbluetooth.

> same path as libbluetooth includes? (Internal Linux kernel headers sit
> in uapi/net/bluetooth).

Usually the uapi start with linux/, for example to include uhid we do
#include <linux/uhid.h>, perhaps we can do <linux/bluetooth.h> and
then for each socket family <linux/bluetooth/l2cap.h>, etc.

>
> >> I'd like to help here if you can provide more details I can work on a =
v2.
> >>
> >> Thanks for your time,
> >>
> >>>> `--enable-bluetoothd` flag is added to the `configure` script and
> >>>> it is keeping the same behavior as other flags.
> >>>>
> >>>> Francesco Giancane (3):
> >>>>     configure.ac: introduce `--enable-bluetoothd` flag
> >>>>     Makefile.am: build `bluetoothd` if enabled
> >>>>     README: document `--enable-bluetoothd` flag
> >>>>
> >>>>    Makefile.am  |  8 ++++++++
> >>>>    README       | 14 ++++++++++++++
> >>>>    configure.ac |  4 ++++
> >>>>    3 files changed, 26 insertions(+)
> >>>>
> >>>> --
> >>>> 2.49.0.windows.1
> >>>>
> >>>>
> >
> >



--=20
Luiz Augusto von Dentz
