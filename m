Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1139AC4
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz/VGThJ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc6acf5e3dso37850041fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 12:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703018667; x=1703623467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfln8sVYZuJrSKK4xNrYYTObJduJpBORGY3Thk/bZm4=;
        b=Jz/VGThJYWTWQOR9p0Ef59XGXuncrDuSA9JVMzXqbxtWltvbVrmPK+6uN7wFyrEW1V
         UA1n0Ns3Egto8GeZ1FBaFMXpvgeqt0Q6H5VMvyPJZ1k1yoP+SJKzMWzaGzmQo8n11uCx
         atl6sjRvFPMqvn+syMIvNDw1bCgmpFU1B6UGn0BS2VlVtyBdR3OM6IOwlENAes95bS4N
         PfFbK+HnFzn5UwVeU4qqHZUDnaM3oO0mqrW3Nh+3oKs6V5wkp/zWnE7WVt3Af0hmwplE
         oGRcziRdqwkhA6jXGKlCSDtLokCq2wJVROF5VOL6k9t0FgYYiGhiTqwUQFtOGCs7ziik
         GcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703018667; x=1703623467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfln8sVYZuJrSKK4xNrYYTObJduJpBORGY3Thk/bZm4=;
        b=khR+K5VLYCnPFD7vGr0CERPey1GBNDrdRwum6+Qp+h1Y9JyDWmsQIlrpTjzJiauVdA
         40Lt9JyC2HMz6qGtdlYiv669vc69TTd/D0HvX58vhuAG0Y7RQVquQlV1o7sa03Xac8ff
         uNrg5elAGUWRlxq1t2QGlM86bhP6N3WgQMeU2X9cta9Rj+PrzU2JJRuxf1nCtOdwAuhE
         VrMPfi/bqUVXyRa4DdamzYGewlKIeBMRUfx3QAVBdfkEJt50cz4jls/hAIB8/xoD5eBA
         j5ym1TvEYzhI3vI2WJfv8ad9T9VRXSIp7QMQy7qNtXLpQIbR5q6Ku5CLZRvylUXlRlbn
         mcMg==
X-Gm-Message-State: AOJu0Yz8VlRWZTqolGa6IkLfYbIJHmqs2z7tjnjbJAG20ZH43TcogSgk
	itmU36FJBrJZEAYPgKPTUHDW1jWa/0cuQA3a61srVbke
X-Google-Smtp-Source: AGHT+IHaess5E2kp38RnEryxYvpCMZdPSES0MzX5wefItDexlQouW8t7NeW+5XRT6yGXe22Lw+EZw4cOm4QqBmvakZQ=
X-Received: by 2002:a2e:b8c3:0:b0:2cc:2043:43cf with SMTP id
 s3-20020a2eb8c3000000b002cc204343cfmr3930168ljp.214.1703018666913; Tue, 19
 Dec 2023 12:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <976f20f9-d711-49a6-abde-12a25088d795@gmail.com>
In-Reply-To: <976f20f9-d711-49a6-abde-12a25088d795@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Dec 2023 15:44:12 -0500
Message-ID: <CABBYNZ+A9LYVf5pgbCuebFGosdKc8EvHPo-Z=47DqwRQmR2Ozw@mail.gmail.com>
Subject: Re: the setup of Grado GW100x has failed
To: polinsky@acm.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Tue, Dec 19, 2023 at 2:53=E2=80=AFPM Alan Polinsky <alan.polinsky@gmail.=
com> wrote:
>
> Hi there. I am a retired computer programmer who has recently purchased
> a Grado GW100x pair of bluetooth headphones. I have an older Dell XPS13
> computer dual booting between Windows 10 (rarely) and 64 bit
> Slackware15. If I boot into Windows 10 the headphones connect perfectly,
> but under Slackware I get the message: "the setup of Grado GW100x has
> failed". About a week ago I installed a new version of Bluez from
> Slackware but the problem remains. I don't know how to even debug the
> problem. People at the LinuxQuestions forum suggested switching from
> Pulseaudio to Pipewire, which made no sense to me, but I gave it a try.
> I get the same result. Perhaps you can help.

Try checking what is going on with btmon, what kernel version are you using=
?

>
> Alan Polinsky
>
>


--=20
Luiz Augusto von Dentz
