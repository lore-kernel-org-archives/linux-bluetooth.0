Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE9146588
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298245; cv=none; b=sPsl7FaoxEkBjs25ZerU6jRG12gKgTyzC6kjKHynArIFvZv+O8+WW3MkzEVrgzaYNulgtylz/ijxNMBCQ4a3nk/vxBJcdlq5C30u1zRCx1jnE4oEvzc7+zsR6yQtrraBHVJF+zG4efNlGUy87/08VLb3OqE77kfimk7+wc0aHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298245; c=relaxed/simple;
	bh=Ak42HIwgeEH4DyPlzeg42twhBvMY328BsqJJAvJ56z8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbO2IXq/m9zr0OZtt0nCIOF+M+9npyVzK4dBWCJzu6axDcfQAfHVC9kgz1r5WwoG5+5WgFOivjq32C0UAQbXe6dmQCd5ztqtB3/pY9x3pfycnhrdsj/EUvQCnpqsKRj7fiWhkxrN/JrzmLIkW51b49StkbGg3bHYfId7ONfUGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fgR7uXqJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fgR7uXqJ"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e72224c395so56363401fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719298242; x=1719903042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyOWEJ3RHrELUq33jeWpDKHaK+Gt6P4Gj6fOnObAdFU=;
        b=fgR7uXqJjY0jzd4k8JYUNDfPpqzQtr/vBHE1FTyVKVTsMJurKUzUzwSflnT0d7pl7P
         F0hCbsOZO1NKyQ01wjwbVIIz1gi7yJ5a9/soxRUQhSRVmUhhoiwGaP0YQAMWZv6fGOuv
         2p2nxnnh3uITGSUA63MQPMuI3kxrFu4/FU3hfRLDBQzE6Rg56VuXJO1Cn4n30JnWgRoh
         OSHLxzd0fZWYvZA9KgcbzIiN0R/ae1V+mQJMFSOX7EtLNH94TIgrqWS4OuaLeMesB4T/
         +RpNc2nNzlt1Ezqgv5qC6wqS1aEXY35yh5c5nEzx8JIljsCNAnnxlyM+5KsdMG+Cc009
         RXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298242; x=1719903042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TyOWEJ3RHrELUq33jeWpDKHaK+Gt6P4Gj6fOnObAdFU=;
        b=iv6K53sn2EcatO6ZFlLHx9yszvBrLG4cEQB+6xJueKp9blrTJtVD98m8osCLq+X5mi
         ylQo+Pwjf/0VVnWkV8nuFIEaZqfonn9fvzXXALt+idAjyBZsyrHRUhbXLUgGEaNYdTrl
         YM08WcjGrgZEmnDOQOqFpjAznM43mkkfB5YM7Cg3WdCYIS4/CdtnEhUxu41VfM/txkHg
         seMqteHA4xNmDjzhG1AiQKmewUVil7z1BV2GjraDSmtL8NzeZRn8z0UvLeLJ45cVwVHv
         thw+0oSa3R35ioiTMtHhszbKb8SYQSZ0RZniwtrRZpfg+tZqnA7shPWiy4Ci4csv35/R
         FTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVThp3ZZEe5eIabGi2HyAqbswuETpLomatvavJYZY4jrjOO2NXJt1oK1LIWDBNgeNqkwy1BSGp7dlJBdMYHqB6IJdMhcDSpri89ulPEUj5S
X-Gm-Message-State: AOJu0Yy0+GUmcNOIdQYo8eHnXNOIH5Tflm4T7qXlKUy6YPyp6W9kNWV/
	xE6cE0sk1Onr010WrUFGsJkfKlYZrsDAFTotaj+wH6EkL/68b34axM2J2g82BNAAbqPdUdnsONQ
	d2Fuow9/qwiSFdusE+9/Mpo+Wqpk3bD5xhlBl0w==
X-Google-Smtp-Source: AGHT+IGMKuOXH6xILN8PhK7FRckdDUIeSH0949RCCJGULK07SEfVSyU2Yf41ezKCYinzxxTPtsijiHjooK3Q3WrTV9E=
X-Received: by 2002:a2e:b1ca:0:b0:2ec:5258:e890 with SMTP id
 38308e7fff4ca-2ec5b2e90b3mr36514221fa.44.1719298241674; Mon, 24 Jun 2024
 23:50:41 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jun 2024 23:50:40 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl> <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
 <CAMRc=MeYy8MgBVbwmrR1Rd9oQMz1tUb+uL4eFJWTL7EOsRXxjg@mail.gmail.com> <CAA8EJpqz7wPSyn0ybDWKwBKkp+rWVPbTgjbKuG6VHWm24MCusA@mail.gmail.com>
Date: Mon, 24 Jun 2024 23:50:40 -0700
Message-ID: <CAMRc=MeX6crenUhC1dqp08W+ss5YksUaaemr4PFFM95SHeED2g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 23:19:55 +0200, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> said:
> On Mon, 24 Jun 2024 at 23:47, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Mon, Jun 24, 2024 at 10:17=E2=80=AFPM Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>> >
>> > On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
>> > >
>> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> > >
>> > > We unnecessarily fallthrough the case for QCA6390 when initializing =
the
>> > > device and hit the condition where - due to the lack of the enable-g=
pio
>> > > - we disable power management despite using the power sequencer. We =
don't
>> > > need to look for clocks on this model so it makes more sense to just
>> > > register the hci device and break the switch.
>> > >
>> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> > > Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QC=
A6390")
>> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> >
>> > Is this going to break the QCA6390 as present on M.2 / PCIe cards? Or
>> > the older DT which didn't have pwrseq entries?
>> >
>>
>> Neither of these has clocks that need to be driven by linux. The only
>> user of QCA6390 Bluetooth in mainline is RB5. Bindings didn't exist
>> before so no commitment was ever made.
>
> This might make some laptop users unhappy. But anyway, restarting the
> hci0 now gives:
>
> [   24.387344] Bluetooth: hci0: setting up ROME/QCA6390
> [   24.387439] qcom_geni_serial 998000.serial: serial engine reports 0
> RX bytes in!
> [   24.554349] qcom_geni_serial 998000.serial: serial engine reports 0
> RX bytes in!
> [   24.562056] arm-smmu 15000000.iommu: Unhandled context fault:
> fsr=3D0x402, iova=3D0xfffd1080, fsynr=3D0x750013, cbfrsynra=3D0x5a3, cb=
=3D3
> [   26.914225] Bluetooth: hci0: command 0xfc00 tx timeout
> [   35.042619] Bluetooth: hci0: Reading QCA version information failed (-=
110)
> [   35.049721] Bluetooth: hci0: Retry BT power ON:0
> [   37.539492] Bluetooth: hci0: command 0xfc00 tx timeout
> [   45.539519] Bluetooth: hci0: Reading QCA version information failed (-=
110)
> [   45.546667] Bluetooth: hci0: Retry BT power ON:1
> [   48.035863] Bluetooth: hci0: command 0xfc00 tx timeout
> [   56.034783] Bluetooth: hci0: Reading QCA version information failed (-=
110)
> [   56.041901] Bluetooth: hci0: Retry BT power ON:2
> [   58.532174] Bluetooth: hci0: command 0xfc00 tx timeout
> [   66.531928] Bluetooth: hci0: Reading QCA version information failed (-=
110)
>
>

How do you reproduce it because it works fine for me:

root@qcom-armv8a:~# btmgmt --index 0 public-addr 00:11:22:33:44:55
[  429.096397] Bluetooth: MGMT ver 1.23
hci0 Set Public Address complete, options:
[  429.102024] Bluetooth: hci0: setting up ROME/QCA6390
root@qcom-armv8a:~# [  429.184052] Bluetooth: Received
HCI_IBS_WAKE_ACK in tx state 0
[  429.497264] Bluetooth: hci0: QCA Product ID   :0x00000010
[  429.502854] Bluetooth: hci0: QCA SOC Version  :0x400a0200
[  429.508412] Bluetooth: hci0: QCA ROM Version  :0x00000200
[  429.513974] Bluetooth: hci0: QCA Patch Version:0x00000d2b
[  429.519533] Bluetooth: hci0: QCA controller version 0x02000200
[  429.525534] Bluetooth: hci0: QCA Downloading qca/htbtfw20.tlv
[  430.449793] Bluetooth: hci0: QCA Downloading qca/htnv20.bin

root@qcom-armv8a:~# [  430.689052] Bluetooth: hci0: QCA setup on UART
is completed
[  430.752854] NET: Registered PF_ALG protocol family

root@qcom-armv8a:~#
root@qcom-armv8a:~# hciconfig hci0 up
[  437.505116] Bluetooth: hci0: setting up ROME/QCA6390
[  437.586969] Bluetooth: Received HCI_IBS_WAKE_ACK in tx state 0
[  437.912683] Bluetooth: hci0: QCA Product ID   :0x00000010
[  437.918286] Bluetooth: hci0: QCA SOC Version  :0x400a0200
[  437.923890] Bluetooth: hci0: QCA ROM Version  :0x00000200
[  437.929613] Bluetooth: hci0: QCA Patch Version:0x00000d2b
[  437.935184] Bluetooth: hci0: QCA controller version 0x02000200
[  437.941207] Bluetooth: hci0: QCA Downloading qca/htbtfw20.tlv
[  438.918868] Bluetooth: hci0: QCA Downloading qca/htnv20.bin
[  439.158671] Bluetooth: hci0: QCA setup on UART is completed
root@qcom-armv8a:~#
root@qcom-armv8a:~#
root@qcom-armv8a:~# hciconfig hci0 down
root@qcom-armv8a:~#
root@qcom-armv8a:~# cat /sys/kernel/debug/pwrseq
pwrseq.0:
  targets:
    target: [bluetooth] (target unit: [bluetooth-enable])
    target: [wlan] (target unit: [wlan-enable])
  units:
    unit: [regulators-enable] - enable count: 1
    unit: [clock-enable] - enable count: 1
    unit: [bluetooth-enable] - enable count: 0
      dependencies:
        [regulators-enable]
        [clock-enable]
    unit: [wlan-enable] - enable count: 1
      dependencies:
        [regulators-enable]
        [clock-enable]
root@qcom-armv8a:~#
root@qcom-armv8a:~# hciconfig hci0 up
[  454.407376] Bluetooth: hci0: setting up ROME/QCA6390
[  454.485238] Bluetooth: Received HCI_IBS_WAKE_ACK in tx state 0
[  454.813289] Bluetooth: hci0: QCA Product ID   :0x00000010
[  454.818892] Bluetooth: hci0: QCA SOC Version  :0x400a0200
[  454.824461] Bluetooth: hci0: QCA ROM Version  :0x00000200
[  454.830035] Bluetooth: hci0: QCA Patch Version:0x00000d2b
[  454.835599] Bluetooth: hci0: QCA controller version 0x02000200
[  454.841651] Bluetooth: hci0: QCA Downloading qca/htbtfw20.tlv
[  455.773967] Bluetooth: hci0: QCA Downloading qca/htnv20.bin
[  456.011213] Bluetooth: hci0: QCA setup on UART is completed

Bart
