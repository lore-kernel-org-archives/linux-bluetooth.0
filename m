Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87847F7CC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282947; cv=none; b=NTO0PHqiDlEWjkN5aLMRueMh2c6vSxNAORclCyWtwhPnuFmnelFMzZ8dYFJ32UNuExmQBiHNmF1YBM4OfutXFrZ1zTafTF4BRM7qI1X2fCnXxJS1Dfg4Br7rxjGS+X42lEWOfw9k7Sy4yY4u1YIx5e/AcgV8GJqJISpyCKN6BMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282947; c=relaxed/simple;
	bh=lygHSHaRbgSpjWs6DKaT3ke3UxVu3JanIjYDM1lWwFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnw4lIF3JLtOWxYDWlUcPpQssu7uSD66U3SEknl7GwkbfFUu94qaZhTRAdV/1eKdr9OnjqR33Nj0rDoY3EnlmZMqFIFHNBuhNz0bDbUocmyCLFE6SO+6zEeB8dhGXSc/7oh4RfJ3y/UOTXKXY8fsx1ndYzmrLCGGGgNPZx5YHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfPtWokg; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfPtWokg"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so11467411fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715282944; x=1715887744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAe2GGibyfQZ+JyC6vgv47NIOM8DZ1UuVnSvz2Ybsfg=;
        b=FfPtWokgZy8eiVXWUy8XpR1/oxVrdIPSGsA+vCOt6i/PVoodt9qpxkDGFFC1FZelXP
         OiR7GT3C/dvIXAn3riokk6czmq0SbRdCgXJi8ssw9Lh1AboFLGOyjN4Lao1KbRTgSVdi
         2jKlETwOU3P0ZExMnJAw3nfOhbnFBeFkdv/EkByA4Q7IHMTIsW8kyzbsyTPYF/u2PEvl
         0ULECgq4TWwXhtO1KYxcfFg08NV9DYZervc/9x1Gn0HkJDz2U4Vi40Vz44sZ5/s4483A
         cMPC1iq8uIWWpUnS09zwqohq7M9FtmBew7uJdsNJ3KuMrObE7ebXo14/lrAW2OnPYAr3
         Cc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715282944; x=1715887744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAe2GGibyfQZ+JyC6vgv47NIOM8DZ1UuVnSvz2Ybsfg=;
        b=WADejEYYyB3hBwFNbT8MrB7EgJtr5pD0Tl9qLpnVDjF+kAt6TWlUJ0R8wUuy9iqve/
         8cDQ+tCaED9s7drwIBm4x+nEhA8kcC6qSyYevcFJ3CpxnKTNt3q6uePDrfoELyZKHbPm
         +7y2wkWAtGOEJs9pjdDfi7wypPjYUSF9SWpWeXQA6iRpOIn0MXUEuX9ltlmtOiFTNsJh
         L2V17Nz6mboL0tU+gYuZftFkYU3I64a/K73VnBBdJUqoZzcvw9I6X0rH8L/TdqMqLM3L
         7jdMFEhDMPGxwkD4yM59i9yqEiXIKdqpcnomlNizQ4wyRsN3EQUdYCNJrERMhktJv0cG
         Lh6A==
X-Gm-Message-State: AOJu0YyyszNIyyBC/rrZj+++gyo72XjqvX1eUuAxozDvL9VWWRHU5Qqj
	jVJ7uedli/dAZSMrEoN6B9Z7tZG18+cYACpodboRn0bUgU5x+qcRNpkdSE3ere1sfxVY9/WFCtp
	PS+o2L/gR0c66Ad6i7r4tD3A9JJGv0/X0
X-Google-Smtp-Source: AGHT+IGP4vDQtVzNJALfW9pTAFT+SHaT1lpGbqGDJNT0dBrGDwZmPV1Jwte5le1LDB7e6WlK8BT3jduLTwoirBQw/tE=
X-Received: by 2002:a05:651c:1033:b0:2e2:ee3c:40f9 with SMTP id
 38308e7fff4ca-2e52039df62mr2234881fa.43.1715282943508; Thu, 09 May 2024
 12:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509231839.3005270-1-ajay.k.v@intel.com>
In-Reply-To: <20240509231839.3005270-1-ajay.k.v@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 May 2024 15:28:51 -0400
Message-ID: <CABBYNZ+Xn1YsXMUSgGK+Xmmn_M3UwZAwuBG4j9vwNP-DK9tL=g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] doc/ccpTest: Add document support for CCP test interface
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ajay,

On Thu, May 9, 2024 at 1:52=E2=80=AFPM Ajay KV <ajay.k.v@intel.com> wrote:
>
> call control profile interface has been documented with
> man page added.
> ---
>  Makefile.am               |  6 ++-
>  doc/org.bluez.CcpTest.5   | 82 +++++++++++++++++++++++++++++++++++++++
>  doc/org.bluez.CcpTest.rst | 50 ++++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 2 deletions(-)
>  create mode 100644 doc/org.bluez.CcpTest.5
>  create mode 100644 doc/org.bluez.CcpTest.rst
>
> diff --git a/Makefile.am b/Makefile.am
> index 05d02932f205..07019f4e1628 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -377,7 +377,8 @@ man_MANS +=3D doc/org.bluez.obex.Client.5 doc/org.blu=
ez.obex.Session.5 \
>                 doc/org.bluez.obex.PhonebookAccess.5 \
>                 doc/org.bluez.obex.MessageAccess.5 \
>                 doc/org.bluez.obex.Message.5 \
> -               doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5
> +               doc/org.bluez.obex.AgentManager.5 doc/org.bluez.obex.Agen=
t.5 \
> +               doc/org.bluez.CcpTest.5
>  endif
>  manual_pages +=3D src/bluetoothd.8
>  manual_pages +=3D doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
> @@ -465,7 +466,8 @@ EXTRA_DIST +=3D doc/org.bluez.Adapter.rst doc/org.blu=
ez.Device.rst \
>                 doc/org.bluez.BatteryProviderManager.rst \
>                 doc/org.bluez.BatteryProvider.rst doc/org.bluez.Battery.r=
st \
>                 doc/org.bluez.AdminPolicySet.rst \
> -               doc/org.bluez.AdminPolicyStatus.rst
> +               doc/org.bluez.AdminPolicyStatus.rst\
> +               doc/org.bluez.CcpTest.rst
>
>  EXTRA_DIST +=3D doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
>                 doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.r=
st \
> diff --git a/doc/org.bluez.CcpTest.5 b/doc/org.bluez.CcpTest.5
> new file mode 100644
> index 000000000000..b16097d08270
> --- /dev/null
> +++ b/doc/org.bluez.CcpTest.5

The man page itself should be generated with rst2man so no need to commit i=
t.

> @@ -0,0 +1,82 @@
> +.\" Man page generated from reStructuredText.
> +.
> +.
> +.nr rst2man-indent-level 0
> +.
> +.de1 rstReportMargin
> +\\$1 \\n[an-margin]
> +level \\n[rst2man-indent-level]
> +level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
> +-
> +\\n[rst2man-indent0]
> +\\n[rst2man-indent1]
> +\\n[rst2man-indent2]
> +..
> +.de1 INDENT
> +.\" .rstReportMargin pre:
> +. RS \\$1
> +. nr rst2man-indent\\n[rst2man-indent-level] \\n[an-margin]
> +. nr rst2man-indent-level +1
> +.\" .rstReportMargin post:
> +..
> +.de UNINDENT
> +. RE
> +.\" indent \\n[an-margin]
> +.\" old: \\n[rst2man-indent\\n[rst2man-indent-level]]
> +.nr rst2man-indent-level -1
> +.\" new: \\n[rst2man-indent\\n[rst2man-indent-level]]
> +.in \\n[rst2man-indent\\n[rst2man-indent-level]]u
> +..
> +.TH "ORG.BLUEZ.CCPTEST" 5 "May 2024" "BlueZ" "Linux System Administratio=
n"
> +.SH NAME
> +org.bluez.CCPTest \- BlueZ D-Bus CCPTest API documentation
> +.SH INTERFACE
> +.INDENT 0.0
> +.TP
> +.B Service
> +org.bluez
> +.TP
> +.B Interface
> +org.bluez.CCPTest1
> +.TP
> +.B Object path
> +[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/CallerX
> +.UNINDENT
> +.SS Methods
> +.SS void Answer()
> +.INDENT 0.0
> +.INDENT 3.5
> +This method can be called to answer an incoming call in progress.
> +.sp
> +Possible errors:
> +.INDENT 0.0
> +.TP
> +.B org.bluez.Error.Failed
> +.TP
> +.B org.bluez.Error.NotConnected
> +.UNINDENT
> +.UNINDENT
> +.UNINDENT
> +.SS void Reject()
> +.INDENT 0.0
> +.INDENT 3.5
> +This Method can be called to reject a call, which can be an active call =
or a call on hold state.
> +.sp
> +Possible errors:
> +.INDENT 0.0
> +.TP
> +.B org.bluez.Error.Failed
> +.TP
> +.B org.bluez.Error.NotConnected
> +.UNINDENT
> +.UNINDENT
> +.UNINDENT
> +.SS Properties
> +.SS uint32 CallState [readonly]
> +.INDENT 0.0
> +.INDENT 3.5
> +call index defined by CCP profile to denote the active call.
> +.UNINDENT
> +.UNINDENT
> +.\" Generated by docutils manpage writer.
> +.
> diff --git a/doc/org.bluez.CcpTest.rst b/doc/org.bluez.CcpTest.rst
> new file mode 100644
> index 000000000000..79ead19ad538
> --- /dev/null
> +++ b/doc/org.bluez.CcpTest.rst
> @@ -0,0 +1,50 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +org.bluez.CCPTest
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +-------------------------------------
> +BlueZ D-Bus CCPTest API documentation
> +-------------------------------------
> +
> +:Version: BlueZ
> +:Date: May 2024
> +:Manual section: 5
> +:Manual group: Linux System Administration
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Service:      org.bluez
> +:Interface:    org.bluez.CCPTest1
> +:Object path:  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/C=
allerX

I'm missing something perhaps, but it seems we need another interface
that creates the calls and something like CCPCallTest1 for actually
controlling the call. Perhaps we can following something similar to
oFono interfaces in that respect:

https://kernel.googlesource.com/pub/scm/network/ofono/ofono/+/refs/heads/ma=
ster/doc/voicecallmanager-api.txt
https://kernel.googlesource.com/pub/scm/network/ofono/ofono/+/refs/heads/ma=
ster/doc/voicecall-api.txt

> +Methods
> +-------
> +
> +void Answer()
> +``````````````
> +
> +       This method can be called to answer an incoming call in progress.
> +
> +       Possible errors:
> +
> +       :org.bluez.Error.Failed:
> +       :org.bluez.Error.NotConnected:
> +
> +void Reject()
> +`````````````````
> +
> +       This Method can be called to reject a call, which can be an activ=
e call or a call on hold state.
> +
> +       Possible errors:
> +
> +       :org.bluez.Error.Failed:
> +       :org.bluez.Error.NotConnected:
> +
> +Properties
> +----------
> +
> +uint32 CallState [readonly]
> +```````````````````````````
> +
> +       call index defined by CCP profile to denote the active call.
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
