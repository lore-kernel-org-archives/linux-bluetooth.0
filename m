Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D7346FA0
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819681; cv=pass; b=LgO7XeR/vyPDTs+XLiG3QCpkWtZyujh/rH+o1fwjJzcAqIMLl2MgPN64QayiThB3CxTK26mOL3zbGexuuytm1GK1h34N+sp+dQDq8d4mnPl2lbusky50BL/JIVe3QgidIp4JyL2byQYBH+uhadSze8ZCYs8nPoVe5sL8SKkGPeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819681; c=relaxed/simple;
	bh=MIkb7mvIZlaqYYZ/y+kR/XNZYgzq3tbhvYmXmH84ARs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsoR3897Z6jSp3HbNandWkzQIo4AOfzvnDL7Bm6Y383iyBYP9DHjGtJqC+urFq3nN7dWVwARzTwjX5Xyg5WRuD6gcd9iZT9rXSJpRw+ngDzy6woGBfaWMHtPR7HAVJCIBk175JmnRDKIxKJcIjtz51lRWmXxcUmicXfK/Zd5t4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF1DP4Ca; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF1DP4Ca"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-414ffb4c0a0so3811334fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 09:54:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772819679; cv=none;
        d=google.com; s=arc-20240605;
        b=BQwbOjMk08015mcUG8W8hXpr8VBHCF0zReK1PwM/1zY8KwvtLS92WYm2x9uPQ6Idw2
         h07udDF8I7HtpiOw15IukCYRdBSq1HEoxJqGAgHE2EIBMwaasWRmbTz2bYrAIjv74Evq
         8R3RGcrOo8ZOKuCT20sz8l5nDXQ9kGwHFEyMWVwL19r5ELjsxM0X5K5Y1lMmXjxgYFoU
         Oq+dwxA2pojIb98Pxg86yTAhgbXblLpLn+AQjlo775QfUZZCBlj274sbxdyubQF2qok3
         pO6M9Ja/73MgqHReckxno3W3CPM6XoeGLnN4qPO18rcWMtvOS7SKgRZGA+psRaIBRF65
         lCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W6sdCUo0IjklaWo48pE1+jfJJQzLwrCbtzBqYFV60yg=;
        fh=qUOyp7TJ0ob0ZhVsCpKWFNuOSLzsvyI5QvlJKxWqiUo=;
        b=ifsmTWLRrTgP3JRAMG7Asbx9+dO3G1LaZFTwaIxOylLkZjuWfUy9CsSFS+hzdTnYls
         unhXIO0mqZiSiMQIGZ51Qe2S0WgokbkWqF+x7HIUK/MwSl7FNexKGIZ8xkOFltayuas9
         Mlvj3KM6TJbjTYW0wLlgiFderOJhJr8Wbxp5TzL6BPbCd5Zp7l/eaB7jrNiWIpmbd3X9
         LsgbYmGwQzpm/J5Hr2Xe2QB+fto3DbKhQacHQElz595G7bc31NOybn+7J2weJyci+seV
         0+VWf+1K13msevSpPXVAY4vf2NWCVRgd5xJivG7qsfgexzaGeIs2dA1F8zGIkGY2WtlI
         0TQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772819679; x=1773424479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W6sdCUo0IjklaWo48pE1+jfJJQzLwrCbtzBqYFV60yg=;
        b=cF1DP4CaKhC0K2A7M/cLcrWZJyl10oHptuSY1CF6uLG6FQj0ZEaLu4Z8fis+g2juhF
         cyzfYppckSIRj9+TZzimFRmsxxtsPOOH67CDLamVCTID1R7AEncLT4IH8jHgVURAvmJt
         eIrFGOXlOgBhHbf1O7gR0QAbETur+KluCAyCvmi5I8UTvCXQjW+S2+TusMDjI9y70n1U
         8zh7n435aF327n6evdqcrzeqYIS765Pqsb0mlipeKZnQ23BTFrtv/uMvk1nAj3yRQ8xX
         KUtOsgVnfckpNu0eKkPNOi1LKd7XFlhcWaJ44FoBcHlyfpGew2TbzXYT7GatcmeKaDIP
         nD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772819679; x=1773424479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6sdCUo0IjklaWo48pE1+jfJJQzLwrCbtzBqYFV60yg=;
        b=rpo+fphuOXGOUHbLpUX2JY6iTN+PdoMSvpTtthpboUqf8kM72isskWxKwX+kgJNTza
         lqugmT0AP0l+FMSCscYtxDELX5VVNH9W5P39z2D5BAMZR+f5SB/2EWyNrYrN2RIIyKyR
         nFL+YP/ZMTcovobjM+9Q+Bf4bO6HA4P4dz/e3q7M0hPuZ2nt02kZUACcmJUhTYkbZ7Wi
         0A3W3r5gfCeWZ1iP7ozUK5eRmjrWz6HZaX2JmxOmKlRtEZ6gYViNsadCtesIc/E1PHGA
         wxH6QfynZp+2UIfiPdR91MKh8QRUAdttxi+68sNkXjM5x75b35FfH31VM3M908DE4rcq
         bF7w==
X-Gm-Message-State: AOJu0YzSan1zn7WdukyAaiksY8tfP9XWguH/1w8IiAUY4Uc5k5/w9WgZ
	9fp4rWWnbMRznNi/ZA6XWPp74m9GiirANS6ARvWsL234h1c0bZS6skvS5F6K93zsrSuU7ia/bGE
	mwGVhHIigudJKYy1g5B+i2WGVpWiPfIQ=
X-Gm-Gg: ATEYQzzWh97vHiodRetF22bzGYzdkYlLkjfUYeeEH4u7z+KPcldK00ITYkbue9qGQH7
	FRXi709Lwc/2jyjtIdMCYMz90FbchRjP3+mIbsJIkPBJsGSa6gef1M4N092IQcmleXF8jifTiwc
	lKOn4vyRfsq9AinbOSYzXbXB0vs2hzpk/8MSxw/IHVWQ8jC4j0JJ5zpPImq07FbdDFmJ6u2LUr6
	yWIywgUMrkgyLDKpmmflr0gSV+OAJQqWfZAkzDKYahmAC+RL8R4KBzwImWImOjSuo9JuFY89Ymj
	Okuw5XsJeDIWH05AesLEt4KUnl9mwBW2w8gk67mCrOzeCyYEHeX8Yhu2Dg==
X-Received: by 2002:a05:6870:648e:b0:3ec:2fc8:97a2 with SMTP id
 586e51a60fabf-416e3ef22cfmr1668869fac.19.1772819679068; Fri, 06 Mar 2026
 09:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302233756.910702-1-dajid.morel@volvo.com>
 <CABBYNZJtZZ7mHJinJY9ZfhfHbYUC9aEmoRx9ACz5R4HSwepyFg@mail.gmail.com>
 <CAM8DPm26RVUJbgA+Lutqshu+ZqkVtNaVrKdG-k1WdE0rcSe0dQ@mail.gmail.com>
 <CABBYNZKxUJUtZTNe0+ot1JmNDyLzf3x-TyN+TqPz-o5xMmx=6A@mail.gmail.com>
 <CAM8DPm24s+2raquaofgPoroTMECGdKeba7pnDz5X64wN66yjiw@mail.gmail.com>
 <CABBYNZKaNmSPbCpJ-GKu2eSrgd_GcOOWkekHW0OMK8WMLESYWQ@mail.gmail.com>
 <CAM8DPm20Sm1t_NMoWQFZtkmdaiL1ALs8SFMqxe-QtT5wjbp6xA@mail.gmail.com>
 <CABBYNZKmu3b2h2NyhhV7CwmB=h1R9uAe0HXDCP73iAvqzy7AYA@mail.gmail.com>
 <CAM8DPm2z-6xUm3SyFJ9umn4=o9bBov6PhKV0TEDCBc14eMFSew@mail.gmail.com> <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
In-Reply-To: <CABBYNZJZWkEy2D4WW8ODMoU-ZmsT1aN0LccOzdsCxuKnFZHnuA@mail.gmail.com>
From: Dajid Morel <dajidp.morel@gmail.com>
Date: Fri, 6 Mar 2026 18:54:27 +0100
X-Gm-Features: AaiRm52uNUT0YG9OikD8uzep3hpBkE4AGqsrANo6GsKEWwkDBcpF1PSaHHsPwjc
Message-ID: <CAM8DPm1fWn7jovVPgcBrApy_czP0TbnBi=oUZmhjMqDkORv2bw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Increase LE connection timeout for
 industrial sensors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Dajid MOREL <dajid.morel@volvo.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 3, 2026 at 10:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> You mean https://github.com/bluez/bluetooth-next/commit/a56a1138cbd85e4d565356199d60e1cb94e5a77a
> that was posted 3 days ago in this thread?
> That in theory should have been backported.

Hi Luiz,

ubuntu@builder:~/bluetooth-next$ grep -nB 2 "HCI_CMD_TIMEOUT"
net/bluetooth/hci_sync.c | grep "HCI_OP_LE_ADD_TO_ACCEPT_LIST"
2511:    err = __hci_cmd_sync_status(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST,
2512:                                sizeof(cp), &cp, HCI_CMD_TIMEOUT);

As shown above, the preparatory command HCI_OP_LE_ADD_TO_ACCEPT_LIST is still
hardcoded to HCI_CMD_TIMEOUT (2s). In the 5.15 LTS kernel (and bluetooth-next),
this command is part of the mandatory sequence before the connection is even
attempted.

ubuntu@builder:~/bluetooth-next$ sed -n '2850,2855p' net/bluetooth/hci_sync.c
for (i = 0; i < n; ++i) {
err = hci_le_add_accept_list_sync(hdev, &params[i],
&num_entries);

Even if the final HCI_OP_LE_CREATE_CONN is decoupled (line 6673), the state
machine fails at line 2511 because our industrial sensors (TE M5600) have a
5-second advertising interval. The controller times out before the device is
even added to the accept list.
