Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B493A6EF8
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572370; cv=pass; b=eIgvaiwcfpT9nblz2XFtCTOTmLa85Yy7XgO1suCL9iwFd7YDs4/QdNhZFucLvP134p/TtnmS+cTCfXlbYzD72iLhjnyf3zEQeEDWwxrgmaQvqceg/G0lNS8et9oiFc+12S5GbVqjEY1yLYgbiM7/Pc7+rVIvc93uxED3xRGac3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572370; c=relaxed/simple;
	bh=2QKkg8OUp2rhgQXdbtpaydKoMzgyuBSRiPmlSl0khSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvyspoQ8FIINlr9eQJPT3K321GCS3b2vxhllOH8T7miW+quTR17Gpiixfsczg6v3ZkeQmdmgA4RGtwZ4hl4FHXb9VA9Rzy/WxB9LS5tV3UiQKEBbpXIQVTepl61YQqnLCQDqU5COGqaPJQsrRk9WFVu9JanibG2Z2ekgrigwRQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkUHcIeU; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkUHcIeU"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so5938070d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 13:12:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772572368; cv=none;
        d=google.com; s=arc-20240605;
        b=dVDfhyzyXNmOFB8mEKbP9iNS11cnf05672kD0fWp89VrsXwG5KFhMvu9PIzx+Ak65B
         gk0aCL53v5gNoEDN0i7cPoqksVsTOxrp8QauSHH+WEcdefZCpbcI4R8R69KkWNJTBv5S
         alrtcOqOl6PGmKNG/2xeIvKJOdSDhkqFwBGwXLGImeQ7rVh4fxvmZN2msQB6h1JjGhQ6
         kM6hNDexbOpzjkkKF7F7wG4HF6rF0aHN1LHWDC709CxYl4r64d0kElZ3Ebpy9S5EIgMs
         7vZEVY0McOE56wDj7qEjoeWkyshwfEXZfEMYunW2gTI6hRCF48yBHTY7k2yx8uT3rKBT
         wYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2QKkg8OUp2rhgQXdbtpaydKoMzgyuBSRiPmlSl0khSo=;
        fh=KXcOb5vphlZLN1D9IwLcOrc/UM2jVmDyJWWf/pmWc4g=;
        b=RKsAZyua+GT25wg7SVZb6RiJj2Yd0Rx15XEeMMbalMazeMQt6eQms09LxOW5AarAoj
         RyOcIsH/h4QbNIxE4XWi5hwrCM58L0yEtRQ8YDobSi9Tdf4mIwtew1ArG0c8GIo6vpWP
         8VrOLOl/oGcciS6pA4LI84Q1kifxT1U+oAM50oDZek+3hb2OPaVPorT6NEVGCIzARHY2
         KJ8yMllSSY31PR1wvBPSbKy/zw8y0vEkzLT69O2tSD+EQB/NToWKmaEAhoNhbTEL0XUY
         OAdNw3+bOLKEhYm7Lr/Kaa3UfsCoqtHWbtot/StsFv8W4iWnD0S4ikckgyCtATJOAtwb
         0JNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772572368; x=1773177168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QKkg8OUp2rhgQXdbtpaydKoMzgyuBSRiPmlSl0khSo=;
        b=mkUHcIeUSLdYmcArckVJjibYH2lqGwn0zJj1NWA8QjVMNk/X8lWy8NoiuNaKnOH9cu
         JQ44RdNc/hofmCCXSi3yrN72TRsr6nskGCbeBYOD6kJGyjnG4bUGH7aNDcJjXcO9cDTg
         bosz/tiNFIu7+CoM8bXFhczui8n/xxIOpCMCboE7qgQk1TUdBzL8DdsB4ulRMSEu2ZR/
         mk0/bp9jDnZtpiY1dwruYDCbHFWfZksfds+S6DWrU3YS0g0oOCc+FPWo/wbEKIOLr2Hr
         Qaz6exaHPw0QD4D6OpL4E0a0M7SohB7hmZsQ62516vv1OIJ6IaigJM43D0XbbhOj9Zt9
         ZA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572368; x=1773177168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QKkg8OUp2rhgQXdbtpaydKoMzgyuBSRiPmlSl0khSo=;
        b=s5oK4lr1E9pvrXG6a30Nmk+bb1t/O/ifnKOJ7HhUHzs+OCC4JyeYihvBACA5DbHFP3
         ZHMYlaa8iTiKfqL48ZfjUb+J29LOj0H2p1RU0llWl2h+8KRNITaXJrLwA8UeewsHtk2+
         eOj/gw5T2eKoYUkarXE1hQrFDWL9A8e/SuCH26Ea8oJlVY4ju0Xj5bBlNSHwmeZK8S6o
         gBP7D5jlMvSg3kNjZBUW2+FhZ4JyJTiaf3FNfiqsJoyHEgrL2rJdquqONT/WhP9oRXhb
         hFsoyo4pD6R4n3sFZucQlvHuUzBwueegQHyX0kgSa//gLKn14vCZOU2QgriB59WsGOKT
         4tzg==
X-Gm-Message-State: AOJu0YxIFeAV85F7ooyWRqTbquTysbtJLWCDSzMEM+ff540tRCK3Tmmc
	KO+srYPEJeNsAJke8NS5GI02vtctll3mX1j8ZwzJqe1Iay3EtTYLJnDbwaUa0+2D2j0vRT/R2CE
	/mmfZnJiRlRNnle/wB3EHD5oY4PUXGWXuCgzc
X-Gm-Gg: ATEYQzwEACGUtNmumUNPaaMuj/uH9CNTW9Nmyc/+yYSHJMXBQFvslagJpttXUloA+Na
	3LVxtmTHf8m9QA6HLjWMiBX8MKhaWVv1ucCMG70CUzMRvrY1+gKq7ivuUC5RXDd85DQ6BXW+Y3F
	uetkHj0iVf8M0JhWHBXSdVbi12gC8oqQLKl6KLoevIYc08RVFqaVtsNTgDBh29IWpvBAga7b4LU
	9mz73IIKXqh5T2DnAHTEfw4eS7xUkzTzUeilzr+h7VOR1dGXfUfeWDmFXELs5JyD91foUX2pn2I
	jo5nJin6Bs38C0kvlX3IjZPZWMlhKxPLfIeRDW35vGO9/qHQ7UauOG+qkKPCfp/WPwMaaQ==
X-Received: by 2002:a05:690e:4143:b0:64c:c616:c349 with SMTP id
 956f58d0204a3-64cc616cb39mr11058439d50.31.1772572368021; Tue, 03 Mar 2026
 13:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
 <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
 <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com> <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
In-Reply-To: <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Mar 2026 16:12:36 -0500
X-Gm-Features: AaiRm522y0Lk_AhTwlGtGCeyjqkMkWX110M2GK0jWhYJoIE3wD8InUaIVgYHbq4
Message-ID: <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Dajid Morel <dajidp.morel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dajid,

On Tue, Mar 3, 2026 at 3:31=E2=80=AFPM Dajid Morel <dajidp.morel@gmail.com>=
 wrote:
>
> On Tue, Mar 3, 2026 at 8:26 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > That is waiting 40 seconds as expected, so I'm not sure what is
> > causing it to time out in 2 seconds but that is definitely the
> > expected behavior.
>
> Hi Luiz,
>
> Thank you for providing those logs. Seeing the 40.5-second delta in
> your environment is very insightful and confirms that the standard
> stack should wait much longer than what I am observing.
>
> I have finally identified the root cause of the 2-second abort in my
> setup. My environment uses industrial TE Connectivity M5600 sensors,
> which are designed for ultra-low power consumption with a long
> advertising interval of 5 seconds.
>
> After auditing the kernel source, I found that HCI_CMD_TIMEOUT is
> hardcoded to 2.0 seconds (#define HCI_CMD_TIMEOUT
> msecs_to_jiffies(2000)).
>
> When the kernel issues HCI_OP_LE_CREATE_CONN, the local controller
> (Broadcom on RPi4 or Rockchip on Rock 4 C+) must wait for the next
> advertisement from the sensor to proceed with the connection. Since
> the M5600 only wakes up every 5s, the 2-second HCI_CMD_TIMEOUT
> systematically triggers before the controller can receive the
> advertisement and acknowledge the command completion. This leads to an
> immediate abort, even if the sensor is physically next to a high-gain
> antenna (9.4dBi).
>
> This explains why my v4 patch (forcing conn_timeout to 20s) worked as
> a side-effect: it kept the connection structure alive just long enough
> to bypass the immediate impact of the HCI command timeout, but it was
> architecturally the wrong target.
>
> I officially withdraw this patch series.
>
> However, this 2-second hardcoded limit for HCI_CMD_TIMEOUT seems
> fundamentally incompatible with many industrial low-duty-cycle
> sensors. Many developers on various forums resort to kernel hacks to
> bypass this.
>
> Would you consider a patch that either:
> 1. Increases HCI_CMD_TIMEOUT globally to 5 or 10 seconds?
> 2. Or makes the LE connection command timeout specifically
> configurable via the Management API or main.conf?
>
> I would like to work on a cleaner solution that accommodates these
> low-power industrial sleep cycles without breaking existing tools.

What kernel version are you seeing this behavior? We no longer use
HCI_CMD_TIMEOUT for HCI_OP_LE_CREATE_CONN:

https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_sync.=
c#L6673

It was changed some 4 years back, so it quite an old change even for
stable kernel:

https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565356199d60=
e1cb94e5a77a
