Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E333CEB99
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487830; cv=pass; b=fmKhFSri8PigZa6wKXRPYXYukaQYyD++5sQEusM8Js7NfbUY4SHdcmF1p9qN/TngOkK1AL11SltWZfdqOoMNpQLsB9PaDAzIQHKMpeCHzZHWQzqFo1CP2ryV2mJk190n0Mi7Bx3PWsfrCYwoLxZtq/Zo+Xje6EdfvwCkOrSreVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487830; c=relaxed/simple;
	bh=1ESeKpIkIM8B9mnRrUIKCy5g9dt3vx8X5QQfUZ18PT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ao7ZU2U0VSAisFHgXj8LeSyVsG6dyLBSP8BVBL+RvlAUJcrTUJZMMWbKHBqNDDM6UHSn4vscT7B9iTBUBKR1I+KephmoMOsOOW8NfY1TKeeMao1p7AXF7QLf9Y/LRsK9d3YyAIf5Fn+mtWnoXlsSL+/kvWNpGNI6xTpo+acz2Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHBbgSbl; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHBbgSbl"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so2740247d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 08:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789487828; cv=none;
        d=google.com; s=arc-20260327;
        b=RDbgiU9zYrVafLHGtfZIB0qRcLwm4+OB370rk/X8ZGQYY7Pk0BzWmG/9HX4wi1OG0l
         C5/w+2c2EAUrUX9JIt8v6MYw7+mw1zvC8gazOKG+SHpwr8HQg+svYoLO1iSZwUers/bC
         1vYtKEsXBdHD4BjhCAqsf0+vzzkNw6SZj1PJ3iqNapXFnPC8SZhD4gTpPQfUPJjFkCo4
         gX8Ns27yWvzY2Us/1LAk8tr2pkkZ711f3qGAhV6x/895K8FLWxXqUYEnu1w2kV9+hId5
         /mqW/AP7uOONTA9Um1HKed+u7I/t0BddaUxs19Uwh5R1zW4pD9kdfF+JocuLcmlZUFtd
         Ji+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/M5+Mrl6BmcM3qf582riaCj978rf9FN2OyJe/3kSyU=;
        fh=UeUzDNEl7a5VMucsQdf0ffDI/PHd6R4+v7SDClo34+Y=;
        b=GbYyUwNRIoPgTZ+Wi8+vTY7P86RM7RyTmDQR3pqT4JJrA7VvRLNT/bGe5nOU5mMyY3
         PmkelklnNdHQ/6d6XktVmcXyK1dT42nH2bR9uBmghtXp+ejFJ5NLk8VXkKDK6hcJVdiS
         Si36tnUhxhToxHU7oQa0H0QOIfeyxHdzaTQoHvVYkOCBbP771uJIXzXcS6odiPodCTko
         D7WkznK126kneku3S7ZBAzJA6bR2VzE6I+s7F9E1KkebYVNSfi7/GTDWIat9t5Cn5+7E
         68yjlq/4ThPm/rRA2iiStVtQrilTR4PfIHWOWpNkWHiCvPolkLuhkMv2Yd1lZ2kCYLvE
         ZSiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789487828; x=1790092628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q/M5+Mrl6BmcM3qf582riaCj978rf9FN2OyJe/3kSyU=;
        b=WHBbgSblE8Z1whhpbjIL9Umf0q2//fK3xAnflAKBUE0CbKm8FrbTUo0aBKoREZaP1v
         7HW94RhB0uDCIcwNNoBUTc5PS0t9vSkfuHFwQUNvPSeiiJlOPudG5dOW/R+QhCrKVU2n
         +eNnYLNybTZDlYSKGRVYucYNikCscpKmuo+GtVGyWw7ePAwjqDrCJOmapNMaaMP9Suja
         TE/EfG15H15HhXI/eX0Tp1woNB8CtjJGb1gW9MDE11L9jW+gqCEAYk3cHXmeALr8z9hp
         RxtHg2s/5cvbIsTO4TaUjZ/sEwzconn5zSpJgZ38rFZIQzdRdqI/yleNubhthT2VyGeI
         KJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487828; x=1790092628;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q/M5+Mrl6BmcM3qf582riaCj978rf9FN2OyJe/3kSyU=;
        b=rPJCYhbfl5ZT3kcP5M2pyM0UcClHtPhJp9KxxX815vQcQnFJI0aq2HCj5rudxECWM7
         ph/Nsxc8Okl0UjQMQPju6ZO9af9fdkwlRE38SG9Ru987GQ4FRKIpMGq/3/N6CUnBanPq
         A0cxU6kReKcTTHLKvMGLYf9HB2f7xHVNLAD0ucyCv/hbVrIaZ/ac/4SP19oenp4pIpaf
         hRq9AD19yHGA235eQ2oRE8QAkMPAvY74jI2de/RU5U4I9Me7/o4MMu/2CGztTT425UJi
         qCHJVPAP1YF/YbwDgFQAZPJ40vOLycxYCI8gjvhIsI0Q4ebfMWyMtK/lKoUWYDThMmbc
         2nFg==
X-Gm-Message-State: AFuF++mQymPGJDLEAGwM6u9E3Jxz3tpavxaYQePC7mXw2HAjZWRO1lYJ
	VlwUOa/tzvS6tugmhP+KBxJJxQeYRpe+l9U0ty0EEyDUVmy6im81FeYRQakTRyd7mwwINdo7IBo
	cnHNBMTt1lLiaQFrJe351+L8CzZmxYb8pJfp7
X-Gm-Gg: AYBFou0hRFJbULZxfqpU+SjJS1AOJEj2472jLxX4lEQnuOOL8kTqoqoSh6VYg6Fgsk6
	SQ5JEHOYOY1wv0gv8Kx8w+Qz+gLo/Vp6OBcVl/MLzKBuB4LJ0t01DQg//xpiLfjHIEBQMXGFWkY
	gcfFUXDBRnHHK5A2Pl1T1idl+L4zUQrJcU0B++ylgyzghLq4aXjCzfrwn08ZLBbHJU5x0HIxW4R
	rMsRH8Nbo6Vr5BllygReG8D85UUDJwZmhMW8MYHXqMB38dAx0NaeV4L6qDYNvHghkPIO4P6UUzA
	pJF8rcbPPvDzh04NuMvGP6/9Xwbox2hf6gmTkgpGENL4vJq1V2OKdooeRc89jOIFv+Mvp6LIpkT
	a2ZCRMe2+Awq/kwwMg45EaVNS4xFkDyvulRh5QEs=
X-Received: by 2002:a05:690e:454f:10b0:66f:c6c6:aab8 with SMTP id
 956f58d0204a3-6714dfdd135mr2257843d50.15.1789487827886; Tue, 15 Sep 2026
 08:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914175136.613532-1-luiz.dentz@gmail.com> <6aa883ab.1ce3d5fb.ae9c9.b59a@mx.google.com>
In-Reply-To: <6aa883ab.1ce3d5fb.ae9c9.b59a@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Sep 2026 11:56:56 -0400
X-Gm-Features: AcwNN1XOTrRuR28LtBMejek1Sl7fIePR_lJmEJQy2O1G4lEiY8bTR6zfh2m9yGg
Message-ID: <CABBYNZKN656TzoAKcv9V6UfQiJBYDHWf8QjvQzPLhgc5b0vVJg@mail.gmail.com>
Subject: Re: [BlueZ,v1,1/2] doc: test-runner: document the virtual machine architecture
To: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Sep 14, 2026 at 7:30=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1164802/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.52 seconds
> GitLint                       PASS      0.41 seconds
> BuildEll                      PASS      19.42 seconds
> BluezMake                     PASS      371.20 seconds
> MakeCheck                     PASS      14.23 seconds
> MakeDistcheck                 PASS      139.01 seconds
> CheckValgrind                 PASS      232.65 seconds
> CheckSmatch                   PASS      290.59 seconds
> bluezmakeextell               PASS      95.03 seconds
> TestFunctional                FAIL      1057.13 seconds
> IncrementalBuild              PASS      389.26 seconds
> ScanBuild                     PASS      1125.63 seconds
>
> Details
> ##############################
> Test: TestFunctional - FAIL
> Desc: Run test-functional
> Output:
> FAIL functional.test_kernel_testers::test_kernel_selftest[hosts11-vm1-noc=
]: failed on setup with "ConnectionResetError: [Errno 104] Connection reset=
 by peer"
> FAIL functional.test_adv_monitor::test_adv_monitor_GHSA_hhgc_hfgf_8m4x[ho=
sts1-vm1]: failed on setup with "ConnectionResetError: [Errno 104] Connecti=
on reset by peer"
> FAIL functional.test_btmgmt::test_btmgmt_info[hosts10-vm1]: failed on set=
up with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to establish connec=
tion"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_show[hosts7-vm1]: fa=
iled on setup with "ConnectionResetError: [Errno 104] Connection reset by p=
eer"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_list[hosts7-vm1]: fa=
iled on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed to estab=
lish connection"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_script_show[hosts7-v=
m1]: failed on setup with "ConnectionResetError: [Errno 104] Connection res=
et by peer"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_script_list[hosts7-v=
m1]: failed on setup with "pytest_bluezenv.rpc.RemoteTimeoutError: Failed t=
o establish connection"
> FAIL functional.test_a2dp::test_a2dp_transport_created[hosts0-vm2]: faile=
d on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_a2dp::test_a2dp_transport_acquire[hosts0-vm2]: faile=
d on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_obex::test_obex_ftp_list[hosts12-vm2]: failed on set=
up with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_obex::test_obex_ftp_get[hosts12-vm2]: failed on setu=
p with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_obex::test_obexctl_list[hosts12-vm2]: failed on setu=
p with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_agent::test_agent_pair_bredr[accept-hosts2-vm2]: fai=
led on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_agent::test_agent_pair_bredr[reject-hosts2-vm2]: fai=
led on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_avrcp::test_avrcp_GHSA_m2vx_pw5f_rc8v[hosts3-vm2]: f=
ailed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bap::test_bap_unicast_transport_created[hosts4-vm2]:=
 failed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bap::test_bap_unicast_transport_acquire[hosts4-vm2]:=
 failed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bap::test_bap_broadcast_transport_created[lc3-hosts5=
-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bap::test_bap_broadcast_transport_created[pbp-hosts5=
-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bap::test_bap_broadcast_transport_acquire[lc3-hosts5=
-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bap::test_bap_broadcast_transport_acquire[pbp-hosts5=
-vm2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bap::test_bass_past_transport_acquire[hosts6-vm2]: f=
ailed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_bredr[hosts8-vm=
2]: failed on setup with "RuntimeError: Process exited unexpectedly"
> FAIL functional.test_bluetoothctl::test_bluetoothctl_pair_le[hosts9-vm2]:=
 failed on setup with "RuntimeError: Process exited unexpectedly"
>
>
> https://github.com/bluez/bluez/pull/2528

Any idea how to fix the errors above? Locally they seem to work just
fine, so perhaps this is something related to the CI environment.

> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
