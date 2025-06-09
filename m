Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91C191F89
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496617; cv=none; b=q7/O2+0wDRqQkC3h3nQ1x8s+Dv2BvlstKJojOkjDbFOEJrw78sUdtLI6acpwQN1rOZDDqxb6Sns7YhwCARoyjQRKXjc/0EhtbkNEoJA/OyPD/IF23DdGlDVhFN4OTWlTIETZ+Xsp/Toe0NsvJdS4QtlrTFRygV65NjWulHQgSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496617; c=relaxed/simple;
	bh=AFiJvv833a0SXBndPQN/b+KKKUS92I2ASl4Y/FpDjIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh0GJSS7OUW1MZ64ppRjn6y7Wy3pp06IAEC6w3qvjUpHxAvVFy0bFd8Okmw7y0THUirEFGU/T3rMlc87H15JuZbs9K0sPwIQFV+Tr9XmG4OycXF/v6iUwQFREM3m6vLj8EfG5OccUZEqgJoOBBOJNTwNIfGs3Y4tQ6FZ7g9BvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1dT8ZGG; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1dT8ZGG"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3106217268dso37884971fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749496614; x=1750101414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hop0CfgC25a9tU9Le5qQjCf5hDiBcRiMQYYxY1us/U=;
        b=W1dT8ZGG0cbirO8Z9bk3wp/DheHRetVxEGm+injbiZhAthKX66EopxXeIgyLRXkNTN
         3KaSPbHsD4vUPBGYbN7AGYvYXpsXJ/L70M3g3zgqAGcM39DKwC1VqvHmbgGa89zL8dHV
         Hz5mQQlfVgxIDwWMkabDPm4mTXsVnLlfV88Upqtl1GuV6NcYrDjyV4EVYUDywUSWnJzE
         EI0G1qtxMzVmLusuniz4St1Z6gRba2xSGjdDBQRcuJvlOCPag3mqXA+xrVaGMoxJyLmd
         1FVakpThAXw4S/jCJTQS6A2kbSrGTKDe9yY2cmXJkbEHVXIlr3dquPZ1WLlY5cEql68e
         HKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749496614; x=1750101414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hop0CfgC25a9tU9Le5qQjCf5hDiBcRiMQYYxY1us/U=;
        b=fuluLjoUkob4eYf7SzBbAPRS4YFQExbDDqXSxxYZ1Hz9I1sQllLNsVpmRa0K4mBcxD
         MbAMmRHfEniQOW6OG2jhhVRlXtXPZOBTcmRU86Xfh5qbV1NarOOvk/0kmDNGv+/h1KBx
         cqRCcRMsi9MzYF8+CetfJ4dRBOxjRYF5R2iiwFucUQ18fhG58wdTfjMjzWfRoHUCmQKb
         lu3vIyTQBH6g2Qk/fx8e4//XYIXlekyxGZiSoYLUz1EyncKfec5HVFVxp0AeBnE3ZZTI
         J7PZhq4rM73cs10uxZZmVQF9ZTBA9F6AE6DHMBk8Y+O8CHlgR2h9dX5GlnWIP1l4Hp1e
         79vw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9XDw4ynTDmYoD7+ORLO27vqyWCHkTpO9Tcrty66N3MqJy3j1HWkj0lXVWX8NLkjMzij8ujtxh6YdMgtnY4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/81hQL4ApnxuhNLJLsRwk8p6jNS3qMCq4NKMD/p9OasHM7Q/
	t6Cciu+geNIqIiPRmdYUPJpI2/YpQLXGI1EkRqZAI2eFkoc23P+7U9IO0URhEGJaFGvur11osDu
	+vyeoINq/llb7DWEdYV8kT3LfeNfSPTo=
X-Gm-Gg: ASbGncu1q9Zj1CrvHSDwCxSW7Y5Upbf2KiJsw3ENRNVN8Pjtu4KgFVr3Xb68pLaR9KE
	DcxHKhWGm/nK9wUYVjsbMGCakf/WZ7AyCENE6m/HEraTY7bSOG29gXh2P4ALxNxyxqGGD+3lj+z
	OpC6Y08bTFd5tJpbUpVf/h3gfXvel0jSgqi9tch/akkw==
X-Google-Smtp-Source: AGHT+IFMv0zVYmOW7wNZyc8n0Skn4JOacncf9O47RKJem6mWnsubS3xOUe2BNyvIBvzS3jLpzraUUfE52PfNGK0zcR8=
X-Received: by 2002:a2e:a585:0:b0:32a:6b23:d3cc with SMTP id
 38308e7fff4ca-32adfe22891mr41729281fa.25.1749496613279; Mon, 09 Jun 2025
 12:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749418319.git.pav@iki.fi> <174949592323.1356526.392113193265628757.git-patchwork-notify@kernel.org>
In-Reply-To: <174949592323.1356526.392113193265628757.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Jun 2025 15:16:41 -0400
X-Gm-Features: AX0GCFs36H9Rzi5OeqGwSMVVYMKv21N9H3cBIRRLEeTZ9BhDRKGZHaszDccNbDo
Message-ID: <CABBYNZ+cSSjMiF-CLRaCujNtm+aJQKvfk9A_w6cFN-kq823beA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 00/10] BAP stream reconfiguration
To: patchwork-bot+bluetooth@kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Jun 9, 2025 at 3:04=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Mon,  9 Jun 2025 00:32:12 +0300 you wrote:
> > Implement ClearConfiguration() and Reconfigure() for BAP unicast
> > MediaEndpoints.
> >
> > v3:
> >
> > - Add bt_bap_stream_lock(), instead of bt_bap_stream_discard()
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v3,01/10] bap: do not try QoS before links are updated & io cr=
eated
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7d8eaa56b8cb
>   - [BlueZ,v3,02/10] shared/bap: detach ucast io on RELEASING and unlink =
streams
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D2f853e4d86d8
>   - [BlueZ,v3,03/10] shared/bap: add client ASE reuse and upper level str=
eam locking
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd1eb496cc605
>   - [BlueZ,v3,04/10] bap: lock streams when used
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D40b91712b932
>   - [BlueZ,v3,05/10] bap: add ready callback for setup configuration
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Debed99caa7a1
>   - [BlueZ,v3,06/10] bap: support removing streams with ClearConfiguratio=
n()
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9e0dc968de50
>   - [BlueZ,v3,07/10] bap: add callback at the end of ucast client select/=
config
>     (no matching commit)

Did a minor change to this one:
%s/bap_select_complete_select/bap_select_complete

>   - [BlueZ,v3,08/10] bap: implement Reconfigure()
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D128b0695e2b5
>   - [BlueZ,v3,09/10] bap: don't show error when releasing stream
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D1d3907561f8e
>   - [BlueZ,v3,10/10] bap: delay QoS & IO creation if CIG is busy or setup=
s configuring
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D7feff47a9fbe
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


--=20
Luiz Augusto von Dentz
