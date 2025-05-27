Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0388134AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353778; cv=none; b=tiQ+7vrFxINNrC7eUFJ+/SBamOuTEfldQsRbwHqwAQ89HjEH0LrfrHtpyfZlsl48EIDtjyr94Aa1bx+RUhXjavLS31AXZslt5BE2VyFXjRFvARsalu1sksDU7FGDL6PtBEGqoEnRsTxjSDHFfeqBqUqZU/x2xDLoQO7SEH6OujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353778; c=relaxed/simple;
	bh=vs3ZHOZuF4daWx0dt4IZadkknTAFMN3SGNcoF4E4fUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmFnLaKAPfbh0YrJsrc3+vtokXCzhh0RRJYq+8ekAapm/5ZCxd2yXMtmIofd7Aju0FXQ23SvFeQOniRhQ0FujFZUN6CgYN1n2iXW+X9JuyeTH6nGw1r1kbTIwZKrpk+gt4tEOp8fzqoq6m+5MU1BT0LDsVMNtpHa+3UylMot1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez+aFRVZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez+aFRVZ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32a72e61a3fso3208691fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748353775; x=1748958575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qa1VooJHjlMtXlM4b4B5OwokpiSXUsyXCIHuZSyAtUc=;
        b=Ez+aFRVZC/hHkQy2inqGE/eaCcK+Cr+9DVYHWn60UQfdcCquteDOue0MYJ0BQlcMHg
         Mv5iDwo/V/si7SIcQ73+Cpl1SMpfT4EyDqDJ5q2Rl2CNABxg6Aa5lr4vavZFbua7tOtm
         M0TIX8xqPPrQyF7oHvdJZVjU8N1n3zehlze2f6XtPCEqN5uVM4mGyRZoW24vI5KI8JQ8
         NuE6Pm0QJGLDNwYmby+ONvS6C9PBewqWpPR0q/zxpbPMVcE6O8tDQn+N4FK45ok0ToHJ
         TOdu02hCCZl2Ou/2gPGmpLFi1KaDEuVZqFBf/SSm20aVgGYYAMoac3y283DAInGqn9vV
         8jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353775; x=1748958575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa1VooJHjlMtXlM4b4B5OwokpiSXUsyXCIHuZSyAtUc=;
        b=d/XH767hKXNTBFVKirrto5y+kZXB4Wo9OW9dUSQ4vb+D1/jajxi27zMpNLaNl47FhK
         0/63WegzLz+W5Q0LJUw7ROOoc3Wf+ibhBLK8qbpp7MBGeHT6sPYVtxhlxmQR8djOpqJB
         wG0MA5KTNFq30BvNcdeOCTBB8Nun7CXyOp5ndfyZP35FoCa/np84B4QmfBKuQzSy8Stg
         OLxdvERrCnb2AZHG/TJFZB0h2H60d2JAAml9pakN4oY0BlaOKT0ak7Zkas79vcGsEWBb
         YePnorZKYNjpBZ0ZyoT80t6a687LpsPdm7FtzNEtLHlP7/YF+TdHWXIFiy1pwHCo6Qtk
         i4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNOhXeqEPHtZr5RH6psH/VLkyfXRV9HlCeMmK0yWk09pVzw1y9i3hJavgwZSPeseaLs870YB65Py3JAHw1siY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/qc/4xLw/stk4zdLCVe//c/tJpdvKt1f4GNV6J4slrJdX0GY
	FFCtc6gFBsg7VIfRM0jCRHDvFiuFcjROq4lVgeKMj6XfH8hBssa4VmjJx3mX0VL51ParDT5L1JQ
	ImYpmlwXehZPRVavowRErdMye9aKSV1huiSCB
X-Gm-Gg: ASbGncsDfow6j7QDWsLHAK4waBcm3GJPl9RgJIST2Q1ByY2kq+5u9af2OtBziEoY8XF
	5nzS4Cb6LLpGTlJWl2vWOaNPEcU7ENiJWWew84M/+adL2/EbCmmhv9qXUdw2RQ50Kc831D/X8x6
	emVEQJgKXSNzRhOt/crz99V9JMKwCMzBw=
X-Google-Smtp-Source: AGHT+IFS2gbQDquVlAYbz48RCbTj9pHyrcHjdFS4hkURBUM/hjrZxwYjRtpviibIqjMQ6ExOxiAuGZZ88mFZmtk+r+E=
X-Received: by 2002:a05:651c:4206:b0:308:ee65:7f44 with SMTP id
 38308e7fff4ca-32a736ddd8dmr1957631fa.8.1748353774641; Tue, 27 May 2025
 06:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525053940.520283-1-kiran.k@intel.com> <20250525053940.520283-3-kiran.k@intel.com>
 <921c6c41-ca94-4833-a095-12162e70f90a@molgen.mpg.de> <PH0PR11MB75856C3FA9ACE3A0B795F5DCF565A@PH0PR11MB7585.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB75856C3FA9ACE3A0B795F5DCF565A@PH0PR11MB7585.namprd11.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 May 2025 09:49:21 -0400
X-Gm-Features: AX0GCFvyQfoXbcPCF3pRRpDM8-YkXMwz--Tgh2EUa-Xhki7mu3c8uZ6ecTmMRoo
Message-ID: <CABBYNZ+BkFpJuXoqB-pgNDRNd0-+NJLVEA8wEgyUNK3qBCHU2A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffer
 posting to prevent race condition
To: "K, Kiran" <kiran.k@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, 
	"Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, 
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>, "Satija, Vijay" <vijay.satija@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, May 26, 2025 at 11:58=E2=80=AFAM K, Kiran <kiran.k@intel.com> wrote=
:
>
>
> Hi Paul,
>
> Thanks for your comments.
>
> >Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffe=
r
> >posting to prevent race condition
> >
> >Dear Chandrashekar, dear Kiran,
> >
> >
> >Thank you for the patch.
> >
> >Am 25.05.25 um 07:39 schrieb Kiran K:
> >> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> >>
> >> Modify the driver to post 3 fewer buffers than the maximum rx buffers
> >> (64) allowed for the firmware. This change mitigates a hardware issue
> >> causing a race condition in the firmware, improving stability and data
> >> handling.
> >
>
> >Interesting. Please elaborate, which firmware versions are affected, and=
 if a fix
> >is going to be expected, and how to reproduce the issue, so it can be te=
sted
> >without and with your patch.
> >
> The firmware is for the upcoming product and is not available in public y=
et. As I said in 1/3,  the issue is seen on android kernel and  it's very h=
ard to reproduce the issue on vanilla kernel.

If it affects Android specific versions only then it should be posted
for upstream, anyway this sounds like it is more of a workaround then
a proper fix for the problem.

> >Is the errata published?
> >
> Our internal documents are updated.  I have also entered a comment in cod=
e.
>
> > Why three buffers less and not two or four?
> The recommendation from firmware / HW is to use at least 3 buffers as gua=
rd buffers. Anything less than three causes RFH (receive flow handler - RX =
path) blockage.

Are these buffers discovered at runtime or they are hardcoded, for the
former then the firmware shall be adjusted to give a proper number and
in case of the later then the driver shall be updated, either way
having to do -3 sounds like a bad idea in the long term.


> >Out of curiosity: Does the Microsoft Windows driver do the same?
> Yes.
>
> >
> >> Signed-off-by: Chandrashekar Devegowda
> >> <chandrashekar.devegowda@intel.com>
> >> Signed-off-by: Kiran K <kiran.k@intel.com>
> >> ---
> >>   drivers/bluetooth/btintel_pcie.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/bluetooth/btintel_pcie.c
> >> b/drivers/bluetooth/btintel_pcie.c
> >> index 03f13de4a723..14f000e08e1e 100644
> >> --- a/drivers/bluetooth/btintel_pcie.c
> >> +++ b/drivers/bluetooth/btintel_pcie.c
> >> @@ -398,7 +398,10 @@ static int btintel_pcie_start_rx(struct
> >btintel_pcie_data *data)
> >>      int i, ret;
> >>      struct rxq *rxq =3D &data->rxq;
> >>
> >> -    for (i =3D 0; i < rxq->count; i++) {
> >> +    /* Post (BTINTEL_PCIE_RX_DESCS_COUNT - 3) buffers to overcome the
> >> +     * hardware issues leading to race condition at the firmware.
> >
> >If you had an errata, it=E2=80=99d be great to document it here to.
> >
> >I=E2=80=99d remove *the*.
> Ack
> >
> >> +     */
> >> +    for (i =3D 0; i < rxq->count - 3; i++) {
> >>              ret =3D btintel_pcie_submit_rx(data);
> >>              if (ret)
> >>                      return ret;
> >
> >
> >Kind regards,
> >
> >Paul
>
> Regards,
> Kiran
>


--
Luiz Augusto von Dentz
