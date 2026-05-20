Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386D3546CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293729; cv=pass; b=d23w9mSTUO96WIKjV+odtHutEc3XTx/hH72XMwtr2zapdqdACp332LPDIpdFcFIiR5ZOPpcaX8lDyKU37UhbZ/T8wc+7BBhC+Z8fXpKlm6/2hdt1hOYlWPT02AomnBcaI+NYD631Rv7NQNocjdmTntFjxOOQbbQtQ7H5YcuMADg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293729; c=relaxed/simple;
	bh=JKxF9mERknSE7lZLZj7DBF4Zib3RcqW9UlhDD1cBWUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3fK7r0fhSoXRkCFZ8MecxTL7dugvxJs9y9hR5GYoicGO1cNPdSJlaxnaDEJdH44jCL8r81d9cjHAqP290LgpAwq/KuMC6ruoHcCXkiAJa1ecwSfIem1zKyq25rck/fTzKcIkC2j0WdkkpAUfh/zwn+o1igDbf8UhdHQC4H87ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYbP/aa4; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYbP/aa4"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65c7a459105so5409320d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 09:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293727; cv=none;
        d=google.com; s=arc-20240605;
        b=aUUhlPNGYrltTLO8uQtr8KC5Gyndm3BGiYXvma6nD1JzK4tEcmzKY7aNHYzwaEwFaD
         EWawThtxf7lBOrVLJoV5iyoHVuBmZFyyAmpTJTlHILwdEBHBUrfDmA/utEc/RlB4RIaH
         yGCVUbxbIEoq42aPUn4nUjqmRs1HiEM7eNzdOPNSHN7IwXPYh9jMYo3aRrVMxS2Vi7TP
         9mDGdzbUh8OqZ//NwiQLAQaY9g3+LT6rD3AAxZJTQpb6tv4cfJXjod/mHSUD/2T0gI/r
         yMNqQ1gMGGO8xX7I3jGj6P8ccu7B4hCurvJgSAR/P55s2eYB72b2972BXfgrI6qRMULO
         T+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        fh=Xihdo4OJdVp6y8jeKY1QkpLMHHZguJLxPSEkGeMItXE=;
        b=dCRXOm1E4QgZgC2dlSEd4jNf6smUsS6pw7tn1DNmLvknj9N9LFyBf20/X7VoImOKeO
         KdEmGkMaTWrLLwsXD2C6JCSY6Kuc8V5V/NpeQOQku7qqb/6BuhPcbd6DgDxUb07V0VC3
         vfRrd660cfRd49JfZVYdaRpBq37Gq3aN0dFvFh9dUpIv1Dc3FWg8DVJB7FIhfsDLyAVA
         wbUpxWbHDE3BrNUIkecnMoclwY9RCNn6u2CfxhQrL9l+kfEx8p6NKC/ftf8mocOW1g0u
         IcaX4w8JAdaVlEoOmvwNYY5z5yzVR3jKNtP3/gU7V4R92V34QS7A8dbbtSi733JlrA1Q
         1ZzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779293727; x=1779898527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        b=oYbP/aa4DNiUSrjan9DSw6AH1ZnmhqQQj1Eb64Q8HSjslVtHUia+Z3lE2lR1DsSQeM
         WDN/FLqeDiEPH1gAK3jqZ1aT7Ye2hX23/2KqnXg36YcN7kBT3JaylANQp8SKzVYEF99N
         OhXtLJBVMLfGFQO+L3LqATJonCqf+GPbF7udOCMRobPjSsJmGULek2G3/ATE4Womh+3W
         fse9q8orENg+SS3FZcgjmFlBQClI4a+cGzTyxn0Vr31DTgk/BgzKnNyA+pRZPeuJDgxN
         +lA7bbbLjwGisMystojo6jPFAwkcKepfm/UjilNcXhR1mfulUJlTJjxS+YL77dS65lrO
         px1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293727; x=1779898527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        b=eLVtJwp+/hXZgOP3PqSTkP0bEvwxbt7vTojEQfSi6HnRbpAfSTA9+d9wXa8fZCRtlM
         eBSIeRldTCGlndeFo9DDZAxSvLHl4u4Fqre697I8RP1EizhHInHjO+XDCOnMf/KEV7HE
         aUGNOrQzM+UlmwEiW/eU3PyXhqG2Aca5vajAkUe2oeqq58li+A2S5CrGZZf5/Mt/rDW8
         Rk3d/qMuZJ5FAWVGEzLjHSuEHZ7O37R9QASdn/0iWaA+D4F8G9hOPBsD26LFswa1gNvD
         4Bx0/GbexsJFYlARK7QJmsQdU5w+Ru7/WLq5piKP8vIUljuyI4g4iuPCMQYPnBaHNx2A
         LpOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uQkxtadvbu2DHmGR9Uh+iMbfLIqnzuu0LlehpB01qmPztp/8UjZiHmo4eJtiyLH+/gkESCVilkwhZtE5BJZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2b5qcSvB4gyAToNd6kmQVbHSR4keBeHdsSixv4LYA/YUK1RZ
	XRDpmNXlB6P6HvCvWaJu+HCSK/LXQKSfF5ymdmtojKDfnN/X7MMzRdZWADQNH7KW84TZsXQwKkg
	bLBbH80qMQ9e/cqsveAypzG8XyoEzZro=
X-Gm-Gg: Acq92OGwVfMT4DtkdI1sbh00Nxv1NQe+47ea6FB+QBq1ficf+8jC5cYUSvIAkZST8IP
	p5vLGRKv1vr2JWORwG8JVBjsgXhb+gE9BSmWjEIfdCxfnR0QBKtGE3/yLEaOaKGbJeR3FqS/26P
	4vI8InDbBtB3TGpiuYKLi3da04757UZxb5XooAiKBiioeHGlpMW7xsUSfqeDIBNaWNZepxHZhJB
	JSV9/X8Y/uY7j1bVfDoFvAaWZZwrscXxxOAwh/9GIvBOsgBM11vFj+MWWNHhhX8xPrqtdNLqpOL
	JrGmBM41wPJ1zqPRaZD7NP5sbD5AgaTgkR/txjKn8ZYF9TW9ZfU4lf95VVnqxPG4KHw=
X-Received: by 2002:a05:690e:480e:b0:65c:6f05:ae25 with SMTP id
 956f58d0204a3-65ea8363d6emr97017d50.30.1779293726841; Wed, 20 May 2026
 09:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
 <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
 <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com> <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
In-Reply-To: <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 12:15:14 -0400
X-Gm-Features: AVHnY4KLzY6qZrOAlROfkxchLK6iuGJuEWScellTpWFEb2rNkqndHXLtgHsJKfM
Message-ID: <CABBYNZLzYGJgq=U1AHm-xL_hMCaOFVrJTnSxyqQiqjKQ3JUowg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, May 20, 2026 at 11:23=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 11:19=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > This coming from the spec is priceless because silently discarding the
> > packets means the remote stack won't know the responses were
> > discarded, causing the stacks to go out of sync. We also shouldn't
> > process packets beyond the allowed MTU. Therefore, I strongly disagree
> > with the spec requiring an identifier on the reject, as this implies
> > that even if a custom MTU is set, the packet must still be processed
> > if it exceeds that MTU to find the first request command within it.
>
> Should I keep a verbose comment string about this rationale in the
> next version?  This seems like something that might trigger questions
> in the future if there are issues between Linux <-> noisy/buggy
> stacks.

Yep, be as verbose as possible, and quote the specification whenever necess=
ary.

> Thanks,
> Mike



--=20
Luiz Augusto von Dentz
