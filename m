Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A81DE4EA
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175685; cv=none; b=AaZT0KqzxdIL512OBPHkPe6aVzcdzSKPGXCW4JB/D/ineIp+ku33/ElhXz0qZ2IQev6oebhwcJpuYcbdDMBDlxXfDL0ZtbqLFcVBWYBw+spUpFs9gDlY4C//NyYyvY0J3Yt7RTr0y/z5fN9MO4iGvPwmZoK7mKrmrgxICy8MkLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175685; c=relaxed/simple;
	bh=XZXCuEYNxCDeXmQlzHHtX2qrKp3+NZmSuuM9Baje2OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuFjj6Fp+2/dbZhcrPGgPFOu2EWRouQckPmbymEyTUrdon6HYOHj9Kqv69mDHqSYtIt1xDov2fiCZwgLCLPNKzNf4UrFppP8bVWz0vbc9ltUAZy/Rih2yf5cetRH6AKcdI/bYE2ayHgCXVEksOm9Jv69ZqdJZweo110JNWnYrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nzg1XmL6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzg1XmL6"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso11258791fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729175679; x=1729780479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrEeKotPweiFAhx/DXep6pHdZjZHTfrbrQ9uQdA201M=;
        b=Nzg1XmL6M5w2XCFN3EMIQBmEdIOeUGb8rAB6IwcY2odYVvPnKoY6bQHqwYAUkzaBlF
         4kjbVSw0pYJr8PuDZTcE/n1/Z9rUTBnv9cQ93QVfUIxHFjH8RdmwlHc+IXhyJCvUvHul
         vDrWPVL/nU6ClR5G9wOXIZ1MV8N2FJ3czOmhm1PzA6cFFvV0RRrYnc2Ub27NCtPTROZ0
         HqL3CDS3Gb5HGjVea35EtEdwE3TDpsHAUjaUZZtL04DAoAtCincZk7CoMwiNkeozRL8C
         Ecps7faCFGKyf8zhJ20YVzuVJ82gsPhMQK14kEZEsXzlzV4o6RjA+46yvXyKett9CXDP
         X5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729175679; x=1729780479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrEeKotPweiFAhx/DXep6pHdZjZHTfrbrQ9uQdA201M=;
        b=bRa1Bo8sC4T3XAtoe5aChwitkImXGMbDweXDhgm/L3tVm4U7XMvgA+m16Dsri1mYn6
         QEqDVq+58j7ihuHTOy246RLWFLbe8m8lxjPz4Z7+O8CLQmexmQpkLZDcmB+KBnutJxZN
         Ki4iS/tti0v7fKft/f+H1XmvdmSbf3Q3T2beoOxFKMPCPR1+mlWKCss5VJVnjw5TjZok
         ZrSFjcbTVsg5ceScrJ/VDA0NN7Dkg6r0EbwSi71SIr6XoR9uNyO6TPFBng7YMlnbuIOV
         4mN1oAggiZjmgSHTx4TNv3160IG0Wo45IPXpBKZRuz4HhD/BQY9EqtkOfq+DmSDttidk
         op4g==
X-Gm-Message-State: AOJu0YxmbsPoYm2/bozlizLOf2nKv4WzJu8OvEjQfBWx7F7lZlK42v1I
	KyEfJxFEC+7JwCXnYdauVY7EHDlSo+o6V/02LhCq94WbC1/zFAuWz2qQLNjANgBQ03Ng8rCHDZl
	injHX4mvrFVEikkKrd0hJWX84esXjvXve
X-Google-Smtp-Source: AGHT+IEhwNWpXeSLixjsMvHz0MuoPgMQeTRojx4V/qpVuGhYaMHs18Uct5TYnlcUANg7MoM7wimCSjNSLj49JIizetg=
X-Received: by 2002:a05:651c:551:b0:2fb:6394:d6bd with SMTP id
 38308e7fff4ca-2fb6394d91cmr34097451fa.12.1729175678185; Thu, 17 Oct 2024
 07:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e18457d80cbd4c6aa6136c12ebf1e444@quicinc.com>
In-Reply-To: <e18457d80cbd4c6aa6136c12ebf1e444@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Oct 2024 10:34:25 -0400
Message-ID: <CABBYNZ+V_n+x8_m_7m1VJJS5CttZErzEFBBHgf3JjTWgUVkBRg@mail.gmail.com>
Subject: Re: Unable to send PBAP(PCE) pull request with specific parameters
 from obexctl tool
To: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>, "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Thu, Oct 17, 2024 at 8:20=E2=80=AFAM Amisha Jain (QUIC)
<quic_amisjain@quicinc.com> wrote:
>
> Hi,
>
> We are trying to verify the below PTS testcases in PBAP Client profile, w=
here DUT initiates the connection.
>
> 1. PBAP/PCE/PBB/BV-03-C   -   PBAB server(PTS) is expecting the PullvCard=
Listing request with MaxListCount =3D 0 (can be variable).
>
>  Description : Verify that the PCE can obtain at any time Phone Book size=
 information from the PSE.
>  ((TSPC_PBAP_2_2 AND TSPC_PBAP_2_4) AND TSPC_PBAP_1_1) OR TSPC_ALL
>
> User prompt:
> Send a PullvCardListing request with MaxListCount =3D 0  for phonebook pb
>
> Results:
> Failed to receive the Get operation with correct parameters for x-bt/vcar=
d-listing
>
> Expectation:
> Pass verdict
> The IUT issues a PullvCardListing command with the MaxListCount header se=
t to 0.
>
> Behavior : Bydefault MaxListCount value will be set to 65535 for every pu=
ll operation and we don't have the option in obexctl to modify the value, H=
ence testcase is failing.

Looks like we didn't add any option to command 'ls' to be able to set
the MaxCount filter:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.obex.PhonebookAcce=
ss.rst#arraystring-vcard-string-name-listdict-filters

So we will likely need to change that if you intend to use obexctl to
perform this test.

>
> 2. PBAP/PCE/PBB/BV-05-C    -    PBAB server(PTS) is expecting the PullvCa=
rdEntry request with specific filters defined in Bluetooth spec.
>
> Description : Verify that the PCE can retrieve a Phone Book entry from a =
PSE using the PullvCardEntry function with a simple filter.
> ((TSPC_PBAP_2_2 AND TSPC_PBAP_2_4) AND TSPC_PBAP_1_1) OR TSPC_ALL
>
> User prompt:
> Send a PullvCardEntry request which filter for Name (N) and Telephone (TE=
L)
>
> Results:
> Failed to receive the Get operation with correct parameters for x-bt/vcar=
d
>
> Expectation:
> Pass verdict
> The IUT receives the requested Phone Book entry. The received entry conta=
ins only the VERSION, N, TEL, and for vCard, 3.0 FN.
>
> Behavior : Bydefault no filters will be set for pull vcard operation and =
we don't have the option in obexctl to add filters in the pull request, Hen=
ce testcase is failing.

This would be performed with command 'cp' but like in the other test
obexctl don't have the ability to set any Filter for Pull or PullAll:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.obex.PhonebookAcce=
ss.rst#object-dict-pullallstring-targetfile-dict-filters

>
> Is there any tool/fix to pass above testcases?
> Bluez version: 5.65

Hmm, why are you attempting to qualify such an old version? If we are
to add some support to setting those filters required for
qualification purposes they would have to be merged upstream first.

> Thanks,
> Amisha
>


--=20
Luiz Augusto von Dentz
