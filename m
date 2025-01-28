Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534313632B
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738095671; cv=none; b=N1B7pwenovZD6RHjkTc3k9QVVLUeRxqk7OOe1Z+eLpXEoIRQABJMml1V1vMXt+V+oK5lyod4x1q4xWceGHzjCSCAdRiplnn+kgiYzMI8dvU1FsLNA1dWE77rZ0ToK/asEWSlwcJi10cu26wN0yjPLPIkb//jMLgxQA6WVBo+7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738095671; c=relaxed/simple;
	bh=wTMGcI3EAdWS/ljw+43/zNMInB5v9EZGxJ9eFqCrohE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ml00cKSlTkrLGnESh8D2xaK8fy95XY41b7EHYkcy2H4cOFWmLpxbSRVd5gk64D4QvQPvIlG+rmHqQq1lNL1WK3qqwDXvNKY5K5x5RtdRPWcdq9CAWD/Phs9PowTugBxuSwCiEK9xMuWROyeVFDe2kelCYf5joWJdfsLuh7ZfvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/fLj+S/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/fLj+S/"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543e49a10f5so236057e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738095668; x=1738700468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTMGcI3EAdWS/ljw+43/zNMInB5v9EZGxJ9eFqCrohE=;
        b=C/fLj+S/gxXY0a9axyKb6PKQ1/tMBMnGbcEtK0ayzWyp4FSfmwXuxszNXEj7ne0PDy
         ta+WxFej9E5knoJ3xOOzI7iqQP4BriuwjcBUtMXq+V9ert9fgbrmKs7PA7C+02alxbj1
         Sqi5+Rw0vQMk0pwHAlznBvombU3mf43TjH2UjKpuhPrwU4QOcsvZddisUgJy/Nz9HWo+
         cwKCSYv01xAo/NBKE2dZI+xN1Eni5fpqYwVBrV9Sf/Be4VDMKD7F5iGW4uTVbJ2Z2uxE
         GxJNa2xNRmrwBo2v80vCBPiWdpUk7G6QMCyDt+pG9YXXt62dKjiuf+clHYaHUXyw13X2
         u5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738095668; x=1738700468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTMGcI3EAdWS/ljw+43/zNMInB5v9EZGxJ9eFqCrohE=;
        b=vnm9zspTgEFssujrPro4DUGY+rlZpRH2TQ+p52rVPt6xQPro2a7LX0V8ZM57C3YZpu
         YpoEgWM8Hyf/2YuLETdgq11JOM7reQOebT8yI62VIiH3M7vm38HMx2YlYnezaoaMUjeX
         tfzQdZBtuhyU2Kd4CVK4DhQuEvmwe/z6VsEATENexftUSLZSoaiISDMmKKgDlBHel5/1
         FNPU3wxytgayPoCXuYbd/1GlpwlgUyPYWIlL+MyRACltOxzrZL1v4O0v23tLvR8CX9se
         AeFxNCc9UEbcs8eU5RzMjh/swFpf0S1gJoLGnnD+mTYbOTPRkCTOsRyT372AqbBsfWVI
         CxqA==
X-Gm-Message-State: AOJu0YwbHDgZon/XS9un6ammNC1o27g1OwijKLnIg+Hc+n1Iq3pzuGet
	t7dV1993aoEZBiPh/WfFEijt5KFFbXByb37QR7zaVczpugO9unFxf54ApKMF3XPDReXc/Rfxjo7
	UadtBKj7/oJwwq2zoWFGA8oyjFm4=
X-Gm-Gg: ASbGnctFd5lVzOO0Xlf7NG6YoLiEbCQmjhUge/cfpFORjkf0HCf5d/9uPyEqhy+zT+u
	Nb0I3gWW3RnErUxcTwfMm76JFqg+/qXHKvvY9LhwCnJNVK4ihKcZh0U/T2RHQCx8NCr9+J4gIng
	==
X-Google-Smtp-Source: AGHT+IEDkUhs1pOWXbJxM5OjizQQ77313JRYNUTdjO18OQFTu4yhkiQbIRYLU3r6vjLbreEd+9b0IDdxRKEnbdIjXXk=
X-Received: by 2002:ac2:5d2d:0:b0:540:1be6:f15f with SMTP id
 2adb3069b0e04-543e4ba6bf7mr106939e87.0.1738095667855; Tue, 28 Jan 2025
 12:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127221052.197899-2-deaner92.ref@yahoo.com>
 <20250127221052.197899-2-deaner92@yahoo.com> <Z5h5b-YkINKqd01l@vmi2410184.contaboserver.net>
In-Reply-To: <Z5h5b-YkINKqd01l@vmi2410184.contaboserver.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Jan 2025 15:20:54 -0500
X-Gm-Features: AWEUYZkL7uGp-qRsWlZC04zSNOh-ynm46ILmDAKhZ7xjMj0zs1gJogBmdiNBsr4
Message-ID: <CABBYNZJP0XGzcMRFNiUH5_BOn1jiWnmAseUHhmbrYdLdmsc83Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove unnecessary braces around single line statement
To: Jeremy Dean <deaner92@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org, markus.elfring@web.de, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Tue, Jan 28, 2025 at 1:30=E2=80=AFAM Jeremy Dean <deaner92@yahoo.com> wr=
ote:
>
> It looks like this is failing a test case at
> tedd_an/TestRunner_mgmt-tester.
>
> Is this test failing because of the test itself?
> How can test or description of the test be obtained so that
> the necessary modifications can be made?

That is some race with mgmt-tester it seems, not related to the
problem, that said you didn't include the output of checkpatch.pl that
you are trying to fix. You can use git commit --amend and git
format-patch -v2 + git send-email to send the v2.

> Jeremy
>


--=20
Luiz Augusto von Dentz
