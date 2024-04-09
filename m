Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A353157E97
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693011; cv=none; b=PqqUPzqjibwmVdjdAI4DWmD8PsWr1/PZqB0UxA4v6HxoxY6Ypeok/X47n7H+eAXoyi5saXMjObnPZTlNVI7mgEuMzfBO45sk1LtjjYn7j5yQyC+kW2CXEtYW8641ilmQ7InM+Azj44SvNtrglXGaIVV+DXZXpSHEcE8fGX7ETsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693011; c=relaxed/simple;
	bh=1qXarTs/Ew7HUsn2Fn26vhWqKsb6S2IYDfyqhK7zTV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEoVQdP//TddzvbFf2GMRS+nm1pNyETvI4E9wtAQ0ff35jYMGie76Cd0babTnsdUI3Ex1AQZrUqHFMAlUSVYase3oNMSeEUr96K7rFxjXaWcUoPtaoXP35C4lNQmxrioNTngHF7GIJCMO3A00NeGIKx/LeRLcHo59AFYilKzpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeY6zKiV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeY6zKiV"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d872102372so28714551fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712693007; x=1713297807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+XtKwohOOvahjyFeqiouzbDvFrvBcmWtlOCanpvVbw=;
        b=IeY6zKiVjS6Tgy+YHmQJI3z6hA9xVcWV+Tze2j1+IakyfTzvbwJJfp4c8AiuOKThUS
         ZlWFe/GqVuaV19HZqRSkbZwJ8+x+iDy6WkOFwz1ibXqsUqe+O9Jmbo89AJd7+RrluFsx
         bSmT5XOJhrzWa4MFEZ1/Uebm9HiwciTTUhXxjQi/ywt5isusTtkngOt1cadJMb9k1aIs
         mRb4zpEVt1HuRF7G+KpdKVaeE43/c6dXQVWrVxTP+4XvtYxNnoI+mR039MUnxnpxW2AU
         6LLMCunWCI/3ymvju4pXVPfk65/EvY4MWxKAvSmHp5FzBG44eiqrexVP6NA6GJGbiqan
         2bMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693007; x=1713297807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+XtKwohOOvahjyFeqiouzbDvFrvBcmWtlOCanpvVbw=;
        b=AHJc36jg2O4fE41j00uPV5k2zi30Bd4vqrPCIqFhna5WhEbRNmBUb6uxW1aUOpMYxB
         u5yvNU2J1A6Uzp+RPREfKKckZWJpHg9G0PM4leaZdIZzykPX9qCeQz6fFGqPOwP+hIqV
         RuV+STbm/lUSCsS3abfzqlr2IpOlzKRbjNVPjmnrht719UbT8e5qGGz0ul43J1Yq7fnP
         m/UZa8W96+/uGwBLkSJiKY24lx9PUHffTM1k0rVy/0rUecHprbzvHj/aFDhmYMeLsXwN
         sm0KfTn5A6bfSY+uBQkOZx5hNWrugeQ8A/DcR+j9jv5/r47b4rOgQ8JNlIMRUFRwgGnb
         +8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKwJ+jSGr9/tOzo7PfqBF7J+wtgT+UJRK0NHH1+rRS+E9cYlrGgXExgYWNkBGM+RxtBwY6olkZihGIt97/dk5Eu77Xh1IoombIJYZeWjfS
X-Gm-Message-State: AOJu0YxEGKRgBrZHV/jVBSHpdI/kNWqmF7G+dXsYcluLFmYvEcsKS2iJ
	SyJshwp0a5jh+pdDdfBXA0dlVJ9rZVWPhh0hSnfmOrvmJcddbtTd/yeLhUf3iR192LBhH0q5Ali
	Q6XOdi2NZY95byk9QlZIxHDLm3zlseArS
X-Google-Smtp-Source: AGHT+IGMnsA86JlxnOIckn4z9tOdpIWXxOjLefUfqsfOKqfINVjXCTMG2ibwgRErwBKFL/t7AhMInvEkYp60of9Jr0w=
X-Received: by 2002:a2e:9a88:0:b0:2d8:c3eb:5018 with SMTP id
 p8-20020a2e9a88000000b002d8c3eb5018mr149208lji.9.1712693007062; Tue, 09 Apr
 2024 13:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org> <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
 <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org> <68a31d6a-8eb8-4d78-819b-fb67367cc41d@penguintechs.org>
In-Reply-To: <68a31d6a-8eb8-4d78-819b-fb67367cc41d@penguintechs.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Apr 2024 16:03:13 -0400
Message-ID: <CABBYNZJQUy37fxWuCXV1OgM+DNnOr7V0h_rkgcSdw-5hF7iauQ@mail.gmail.com>
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or disable/reenable
To: Wren Turkal <wt@penguintechs.org>
Cc: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Tue, Apr 9, 2024 at 3:53=E2=80=AFPM Wren Turkal <wt@penguintechs.org> wr=
ote:
>
> On 4/8/24 12:49 PM, Wren Turkal wrote:
> > +Marcel Holtmann <marcel@holtmann.org>
> > +Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> >
> > Added maintainers identified from the get_maintainer.pl script in the
> > kernel repo. Hoping to get some ideas for next steps.
> >
> > More contextual info below:
> >
> > On 4/6/24 1:27 PM, Wren Turkal wrote:
> >> +Kalle Valo since you have the same laptop
> >>
> >> On 4/6/24 1:16 PM, Wren Turkal wrote:
> >>> Sorry for the double send on the original message. I am still hoping
> >>> to get some help. I have added additional info below.
> >>>
> >>> On 4/4/24 12:14 PM, Wren Turkal wrote:
> >>>> Hey there ath11k/bluetooth folks,
> >>>>
> >>>> I am having a pretty major problem with QCA6930 for some time (maybe
> >>>> a year or two). I have this bluetooth device:
> >>>>
> >>>> 72:00.0 Unassigned class [ff00]: Qualcomm Technologies, Inc QCA6390
> >>>> Wireless Network Adapter
> >>>>
> >>>> This device appears to be driven by the ath11k module and others. I
> >>>> hope I am pinging the right lists.
> >>>>
> >>>> I am using Fedora Rawhide. Fully updated yesterday. My uname reports
> >>>> this:
> >>>>
> >>>> Linux braindead.localdomain
> >>>> 6.9.0-0.rc2.20240402git026e680b0a08.24.fc41.x86_64 #1 SMP
> >>>> PREEMPT_DYNAMIC Tue Apr  2 17:51:18 UTC 2024 x86_64 GNU/Linux
> >>>
> >>> Updated today. Here's the new uname:
> >>>
> >>> Linux braindead.localdomain
> >>> 6.9.0-0.rc2.20240405git8cb4a9a82b21.27.fc41.x86_64 #1 SMP
> >>> PREEMPT_DYNAMIC Fri Apr  5 16:48:07 UTC 2024 x86_64 GNU/Linux
> >
> > I looked at the current mainline kernel code. I found the following.
> >
> > I found that there was a patch authored by Zijun Hu that was supposed t=
o
> > address a warm reboot issue on QCA6390 here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/bluetooth/hci_qca.c?h=3Dv6.9-rc3&id=3D7e7bbddd029b644f00f0ffbfbc=
485ed71977d0d5
> >
> > The same code path from the above patch is now slightly different
> > because another patch authored by Krzysztof Kozlowski, namely:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/bluetooth/hci_qca.c?h=3Dv6.9-rc3&id=3D272970be3dabd24cbe50e393ff=
ee8f04aec3b9a8
> >
> > I also see a few fixed over time in the btqca.c file. I wonder if any o=
f
> > these are related.
> >
> > Unfortunately, none of these changes were made recently.
> >
> > Does anyone have an suggestions for next steps?
>
> I am trying to build kernels as old as 5.19 to start a bisect. I have
> been unsuccessful due to compiler warnings (presumably from newer
> version of gcc than were used at the time those kernels were released.
> Is there any secret sauce to getting these older kernels to build with
> newer gccs?

5.19 seems a little too old, imo, or has it been broken for that long,
did you at least tried with bluetooth-next? Try contacting the people
who actually wrote the driver.

> >>>
> >>> I also noticed a new version of bluez. Here is the RPM package
> >>> version: bluez-5.73-3.fc41.x86_64
> >>>
> >>>> My main bluetooth device is  a Logitech MX 3 Mac mouse that uses
> >>>> bluetooth. When bluetooth fails, so does the mouse. I have power
> >>>> cycle my laptop when that happens. I'd love to help find a fix for
> >>>> this.
> >>>>
> >>>> The problem is that I cannot disable and re-enable the bluetooth on
> >>>> my system. Bluetooth also doesn't work after a warm boot. I have to
> >>>> power cycle my laptop to recover bluetooth funcitonality. I have
> >>>> tried the following:
> >>>>
> >>>> * logging into KDE Plasma (bluetooth stops working)
> >>>> * logging into GNOME (works on cold boot, fails on warm boot)
> >>>
> >>> I did notice that the mouse seems to work in Plasma until a few sec
> >>> after I see the background image appears. I suspect that Plasma is
> >>> disabling and reenabling the bluetooth where Gnome does not do that.
> >>>
> >>>> After logging into GNOME during a cold boot, I have also done
> >>>> "systemctl restart bluetooth.service". I get these journal logs
> >>>> during the stop;
> >>>>
> >>>> =E2=9E=9C  bt_kernel_bug cat journal-stop-bluetooth-service.log
> >>>> Apr 04 10:14:41 braindead.localdomain NetworkManager[1120]: <info>
> >>>> [1712250881.7060] device (F0:5C:77:F2:60:FC): state change:
> >>>> disconnected -> unmanaged (reason 'removed', sys-iface-state:
> >>>> 'removed')
> >>>> Apr 04 10:14:41 braindead.localdomain systemd[1]: Starting
> >>>> systemd-rfkill.service - Load/Save RF Kill Switch Status...
> >>>> Apr 04 10:14:41 braindead.localdomain systemd[1]: Started
> >>>> systemd-rfkill.service - Load/Save RF Kill Switch Status.
> >>>> Apr 04 10:14:41 braindead.localdomain audit[1]: SERVICE_START pid=3D=
1
> >>>> uid=3D0 auid=3D4294967295 ses=3D4294967295
> >>>> subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dsystemd-rfkill
> >>>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D?
> >>>> terminal=3D? res=3Dsuccess'
> >>>> Apr 04 10:14:46 braindead.localdomain systemd[1]:
> >>>> systemd-rfkill.service: Deactivated successfully.
> >>>> Apr 04 10:14:46 braindead.localdomain audit[1]: SERVICE_STOP pid=3D1
> >>>> uid=3D0 auid=3D4294967295 ses=3D4294967295
> >>>> subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dsystemd-rfkill
> >>>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D?
> >>>> terminal=3D? res=3Dsuccess'
> >>>>
> >>>> I get these journal logs during start:
> >>>>
> >>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0:
> >>>> setting up ROME/QCA6390
> >>>> Apr 04 10:15:05 braindead.localdomain systemd[1]: Starting
> >>>> systemd-rfkill.service - Load/Save RF Kill Switch Status...
> >>>> Apr 04 10:15:05 braindead.localdomain systemd[1]: Started
> >>>> systemd-rfkill.service - Load/Save RF Kill Switch Status.
> >>>> Apr 04 10:15:05 braindead.localdomain audit[1]: SERVICE_START pid=3D=
1
> >>>> uid=3D0 auid=3D4294967295 ses=3D4294967295
> >>>> subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dsystemd-rfkill
> >>>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D?
> >>>> terminal=3D? res=3Dsuccess'
> >>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> Product ID   :0x00000010
> >>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> SOC Version  :0x400a0200
> >>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> ROM Version  :0x00000200
> >>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> Patch Version:0x00003ac0
> >>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> controller version 0x02000200
> >>>> Apr 04 10:15:05 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> Downloading qca/htbtfw20.tlv
> >>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> Failed to send TLV segment (-110)
> >>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> Failed to download patch (-110)
> >>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: Retry
> >>>> BT power ON:0
> >>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0:
> >>>> command 0xfc00 tx timeout
> >>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0:
> >>>> Reading QCA version information failed (-110)
> >>>> Apr 04 10:15:08 braindead.localdomain kernel: Bluetooth: hci0: Retry
> >>>> BT power ON:1
> >>>> Apr 04 10:15:10 braindead.localdomain systemd[1]:
> >>>> systemd-rfkill.service: Deactivated successfully.
> >>>> Apr 04 10:15:10 braindead.localdomain audit[1]: SERVICE_STOP pid=3D1
> >>>> uid=3D0 auid=3D4294967295 ses=3D4294967295
> >>>> subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dsystemd-rfkill
> >>>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D?
> >>>> terminal=3D? res=3Dsuccess'
> >>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0:
> >>>> command 0xfc00 tx timeout
> >>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0:
> >>>> Reading QCA version information failed (-110)
> >>>> Apr 04 10:15:10 braindead.localdomain kernel: Bluetooth: hci0: Retry
> >>>> BT power ON:2
> >>>> Apr 04 10:15:13 braindead.localdomain bluetoothd[986]: Failed to set
> >>>> mode: Authentication Failed (0x05)
> >>>> Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0:
> >>>> command 0xfc00 tx timeout
> >>>> Apr 04 10:15:13 braindead.localdomain kernel: Bluetooth: hci0:
> >>>> Reading QCA version information failed (-110)
> >>>> Apr 04 10:15:15 braindead.localdomain chronyd[1065]: Selected source
> >>>> 204.17.205.8 (2.fedora.pool.ntp.org)
> >>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Created slice
> >>>> background.slice - User Background Tasks Slice.
> >>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Starting
> >>>> systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files
> >>>> and Directories...
> >>>> Apr 04 10:15:22 braindead.localdomain systemd[1687]: Finished
> >>>> systemd-tmpfiles-clean.service - Cleanup of User's Temporary Files
> >>>> and Directories.
> >>>> Apr 04 10:15:38 braindead.localdomain audit: BPF prog-id=3D86 op=3DL=
OAD
> >>>> Apr 04 10:15:38 braindead.localdomain systemd[1]: Starting
> >>>> plocate-updatedb.service - Update the plocate database...
> >>>> Apr 04 10:15:41 braindead.localdomain systemd[1687]: Started
> >>>> vte-spawn-21527424-cb2d-479f-af17-22251e2b37a0.scope - VTE child
> >>>> process 5144 launched by gnome-terminal-server process 4668.
> >>>> Apr 04 10:15:53 braindead.localdomain systemd[1]:
> >>>> plocate-updatedb.service: Deactivated successfully.
> >>>> Apr 04 10:15:53 braindead.localdomain systemd[1]: Finished
> >>>> plocate-updatedb.service - Update the plocate database.
> >>>> Apr 04 10:15:53 braindead.localdomain systemd[1]:
> >>>> plocate-updatedb.service: Consumed 6.802s CPU time.
> >>>> Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_START pid=3D=
1
> >>>> uid=3D0 auid=3D4294967295 ses=3D4294967295
> >>>> subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dplocate-updatedb
> >>>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D?
> >>>> terminal=3D? res=3Dsuccess'
> >>>> Apr 04 10:15:53 braindead.localdomain audit[1]: SERVICE_STOP pid=3D1
> >>>> uid=3D0 auid=3D4294967295 ses=3D4294967295
> >>>> subj=3Dsystem_u:system_r:init_t:s0 msg=3D'unit=3Dplocate-updatedb
> >>>> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D?
> >>>> terminal=3D? res=3Dsuccess'
> >>>> Apr 04 10:15:54 braindead.localdomain audit: BPF prog-id=3D86 op=3DU=
NLOAD
> >>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]:
> >>>> kf.idletime: Could not find any system poller plugin
> >>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]:
> >>>> qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller,
> >>>> KIdleTime): invalid nullptr parameter
> >>>> Apr 04 10:16:13 braindead.localdomain baloo_file_extractor[5251]:
> >>>> qt.core.qobject.connect: QObject::connect(KAbstractIdleTimePoller,
> >>>> KIdleTime): invalid nullptr parameter
> >>>>
> >>>> There's a bunch of errors in those logs starting with these two
> >>>> seemingly important lines:
> >>>>
> >>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> Failed to send TLV segment (-110)
> >>>> Apr 04 10:15:06 braindead.localdomain kernel: Bluetooth: hci0: QCA
> >>>> Failed to download patch (-110)
> >>>
> >>> Logs are mostly unchanges when restarting the bluetooth service after
> >>> a cold boot with the bluetooth originally working.
> >>>
> >>>> FWIW, I get similar logs after logging into KDE Plasma. I also get
> >>>> similar logs after a warm boot.
> >>>>
> >>>> This appears to be some kind of bug in the initialization of the
> >>>> hardware. Is there any additional information I can provide to help
> >>>> troubleshoot this problem.
> >>>
> >>> I will also say that the bluetooth appears to work throught a
> >>> suspend/resume cycle as long as I don't restart the bluetooth service=
.
> >>>
> >>> Oh, and my laptop is a Dell 9310 if that helps.
> >>
> >> Kalle, I noticed that you reported having a Dell 9310 in 2021 in a
> >> message on this very mailing list. Do you happen to still have that
> >> laptop? If so, so you still test on that laptop at all? I am curious
> >> if it is having the same issue I am experiencing?
> >>
> >>> Is there any other info I could collect that might be useful?
> >>>
> >>> I'm pretty new to troubleshooting a problem like this and would be
> >>> happy to have any advice anyone might want to share.
> >>>
> >>> Thanks,
> >>> wt
> >>>
> >>
> >
>
> --
> You're more amazing than you think!



--=20
Luiz Augusto von Dentz
