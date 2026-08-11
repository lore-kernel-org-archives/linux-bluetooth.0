Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D485C394496
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786417116; cv=pass; b=S4I7nf0fTKlSl5Gn7zdY5YazZX0CLhM6/limEU/EkYMNHK3rmzpbMwePHF51twIZpRs74ngMZ8MVn+xrvfz7C+D8TrPRpF+JJCnH0cSgFs/Gy+v4UeOwteMi7brU/HpaBTYThHAdKcDAwhxWgOgcHSsPK5capLbFYPOEl2Vyel4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786417116; c=relaxed/simple;
	bh=6x6gP3QBLv8HDVxJAPXWou0bmRlKTHhjNgMR/w+VCyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sL3Fh/tbB+t2HxZbcBvXnek9RtbqLWIMg6fkXlCHer4Q8iCZ7rLR85fIZdKx0MQd2po3HOwEPfGjsHVu+9AAUS6ijgHbJRQhp6KlyFnjlg8WTcVycdZHFiAYJzpdUKEX6ZqvJxR4phmrFEUfCtpSXVckFuvk09LDtDDyy3MTDgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbWOHQmf; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbWOHQmf"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8111c0c7561so30697727b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 19:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786417114; cv=none;
        d=google.com; s=arc-20260327;
        b=A19qw3bkpGo9yQk85i0Fg684kxBnhiREeIe7XuVPj64wIS1XTwEoldyG38h7P0oZQj
         h9ld/wF5oq2KIBWGu5RyKCIylSttZFou1343hTDtdYtIXVbjSTdPYNOgQOADT/GFbSTQ
         FK5CF75AM0xyxoLBPzW0Uw7QImnAB8sQfBmstg0xqLXa4xD7tWkqtdbjbC4Jcl7Ik0HH
         omExLrjDQIXmQvrPmNQM2/eJ4fXlbmpEegtjBxOkIHQuIiIx8r8xJtE1Ytr6cvAqlacF
         E/qSCalUdL38RMgi5gyOaxCswD5Kfuygp1Ru54i/KXDGbPyXtgbPiGssXrv/mkLGrxR8
         NJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OpmAzuW10eYPh162aa/x3N2gEMNyWYJ4HXqebfRrYNE=;
        fh=vsVSX7vy2mRkvrimpPQccBu9ZdjRd4MgIzevdUIuGQA=;
        b=Ea2GYm+5CwGjNQyVBpYIxnpaMDLsbORzcyV71wnwLMo/rjSXh7PpjPeJ6p5Na+IM0r
         Em0llaZ1M7GZABybBgJ16ylZTCS6w49xPQvC1WZKW06c+OCXVuuUE7eY7cln+bsBV6MV
         Q3Py4hWcgFgftBkxdAV9AtV6DXIOpYhGvgmDoewViBbVzuVk5C3zb46bN0yAw+3ImzGu
         mrRb5EFSHVzFbRI3pNvA/vOdM0qob3VnIYjcO3EXoH1CEnnxBYriAG1Ygs4vjpSWXGoK
         t0HiLTHuDnVuGWgbWMOUow3cmfh9glxoUQYFbpL4gJmvhqaiBsnDsk19CNZwpnMv9eVD
         hwkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786417114; x=1787021914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OpmAzuW10eYPh162aa/x3N2gEMNyWYJ4HXqebfRrYNE=;
        b=nbWOHQmfP6vmthTM4eEpEw+vwX8fYRFnLrbMsiI7LEPELBw1QDeT1NYdynDhPc6Ml3
         Q6oTU0ZWDueEViXHzA9L5dnZvXVRnoKUMFzqmnmbvgHaoWmwlvvM601OgHQqXFTU7LD0
         Htxa4yREuD9z8rcdxReTHRDuhwm1l5+wcK8YxbtYKF74uiA/lOt4drWaBxJy0qaSMAGp
         tmzy2WHls1i9RC5a4Hej6Kz33RNki4YjsI9fuHq0cjECrFo0whCjZNmWnunFRIpbRFgN
         cQ9IYlswM0hPJF3VbfMz87Da4ULwZrKf2LXi9dxI7uYmJYmS2Uljpv3S8Geq4EcwjnEe
         rPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786417114; x=1787021914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OpmAzuW10eYPh162aa/x3N2gEMNyWYJ4HXqebfRrYNE=;
        b=fWp5l4CehU/MPPiR6Xrr2GCsoT2aU93d1Itf5IgOz/cqRUi7nxqwyux0WxQCApLgj8
         Tyv0UoMT/oqZ3xEyeWFE09WHddxeNBUG3i/WP+jCFnUEr/WvYgw/MWdOQglWZMpG0IT3
         nMtwzP//+Z+/iyh5uEIs3loF7F0OZclp99D0Bk3cJLTt/ILapPN/m0lR9qSLZheljIIj
         83uRAWz6M7ofitFLLWLc4oPXYx+7Hl2Xe6bq1sHxJbzj8jg95V1Osrwpo+833d0azUKB
         U03pekKDGT78iduFZd97ifzuji+FlW2J+eFe4LY9jkb+EVuSKPMSKcaaHgY9oy0NJk9n
         JWNw==
X-Gm-Message-State: AOJu0Yz4lVXChxl6fwPm1d9edc8VN/UD97upPvtvXP4QgWJSNZ1h61FF
	4luMhVpidgYWQTylwzen/CuakE9enOVBwKBpSp1E09EfeM4rXRELsLJaGm3TaZnuJkpWMccF2Xt
	wmjJkAvQ0tzWVQyBrQCZUjczjF3la+UKeSsvw3immvw==
X-Gm-Gg: AR+sD10EJ2kzFL5Y8PVkQU7OLlxVHvH3k9hChMcQ9swIz0HiiQADzEWSqvT9QmVxe/w
	ufJ32sBaTBBOYBzW81CZaN/tGKMmCLcz3vj05rYLCDhBEEEk0mzduFiPXaY98vFnsNknSN0Q1HI
	JqdageeLlU/k7eBZmu9B2FVWdGtjaho87VlZZiFsQ7+ANOZH9B23mx0IKVr6C6TMpeLKUoLIH0k
	BP/zAy2D1/jOPPDwF9k2zpNxGtA1/KT8ndMFb+dAwHOpv8kfNQvIPvLxCSCsxlyWjir71TKs3oU
	23VgN2AhSdYnDQdHMolJ9ds8nihfeVbwZWCxun+O7kHunhv31U+wIokLUObr3M0JNnf41giFCaF
	6J2gR0IkQYY7GEIK6/bkswpIG2BUv
X-Received: by 2002:a05:690c:4508:b0:820:1251:d2b5 with SMTP id
 00721157ae682-82022758ea2mr300530697b3.31.1786417113554; Mon, 10 Aug 2026
 19:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28554782-1f3b-4537-b891-1c483a29e8c3@posteo.de>
In-Reply-To: <28554782-1f3b-4537-b891-1c483a29e8c3@posteo.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 10 Aug 2026 22:58:17 -0400
X-Gm-Features: AUfX_mwjrXfHxlVYRd29_s8KM2U6PBL5GiLBZT2orE0TnNENCVIKzazsQvt7m_k
Message-ID: <CABBYNZ+3dd4qea4LZAXiEwD3MHkiK82y5S7RFE2EQzQx5jS+Rw@mail.gmail.com>
Subject: Re: [BUG] Bluetooth: WCN6855 10ab:9309 stops reporting ISO TX
 completions during BAP LC3
To: Jonas Zunker <jonas-zunker@posteo.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Aug 10, 2026 at 6:22=E2=80=AFPM Jonas Zunker <jonas-zunker@posteo.d=
e> wrote:
>
> Hello,
>
>    I am seeing a Bluetooth LE Audio/BAP failure with a Qualcomm WCN6855
>    controller and Sony WH-1000XM6 headphones.
>
>    BAP negotiation succeeds and the audio profile appears active, but no
> sound is
>    heard. The attached btmon capture indicates that the controller stops
> returning
>    HCI ISO transmit completions.
>
>    Observed sequence
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    1. The sink and source ASE QoS configurations are accepted.
>    2. The Enable operation succeeds for both ASEs.
>    3. The connected isochronous stream is established successfully as CIS
>       handle 4.
>    4. Both host-to-controller and controller-to-host ISO data paths are
> configured
>       successfully.
>    5. The sink and source ASEs both reach the Streaming state.
>    6. The host submits four 120-byte HCI ISO packets on CIS handle 4.
>    7. No Number Of Completed Packets event is received for CIS handle 4.
>    8. Number Of Completed Packets events for ACL handle 3 continue normal=
ly.
>    9. No further ISO audio packets are submitted, although application
> playback
>       remains active.
>
>    The final ISO packets in the attached capture are:
>
>        < LE-CIS: Handle 4 SN 0 ... slen 120
>        < LE-CIS: Handle 4 SN 1 ... slen 120
>        < LE-CIS: Handle 4 SN 2 ... slen 120
>        < LE-CIS: Handle 4 SN 3 ... slen 120
>
>    There is no completion event for CIS handle 4 after these packets.
>
>    This appears to exhaust the four initial HCI ISO transmit credits.
> The host
>    cannot submit more audio because the controller does not replenish tho=
se
>    credits.
>
>    PipeWire/WirePlumber also reports:
>
>        spa.bluez5.iso: Missing completion reports for packet ...
>        Bluetooth adapter firmware bug?
>
>    After approximately 20 seconds, the kernel reports:
>
>        Bluetooth: hci0: link tx timeout
>        Bluetooth: hci0: killing stalled connection <headset-address>
>
>    I am not attaching my complete system journal. The kernel messages
> above were
>    selected manually from the local logs.
>
>    Hardware
>    =3D=3D=3D=3D=3D=3D=3D=3D
>
>    - Bluetooth controller: Qualcomm WCN6855
>    - USB ID: 10ab:9309
>    - Kernel drivers: btusb / btqca
>    - Firmware patch file: qca/rampatch_usb_00130201.bin
>    - NVM file: qca/nvm_usb_00130201_gf.bin
>    - QCA ROM version: 0x130201
>    - QCA patch build: 0x994d
>    - QCA firmware build: 0x38e6
>    - Headset: Sony WH-1000XM6
>
>    Software
>    =3D=3D=3D=3D=3D=3D=3D=3D
>
>    - Distribution: Fedora 44
>    - Kernel: 7.1.7-200.fc44.x86_64
>    - Fedora BlueZ: bluez-5.87-3.fc44.x86_64
>    - Upstream BlueZ: latest master, locally built
>    - PipeWire: 1.6.8-1.fc44.x86_64
>    - WirePlumber: 0.5.14-1.fc44.x86_64
>    - linux-firmware: 20260622-1.fc44.noarch
>
>    The issue reproduces with both:
>
>    1. The unmodified Fedora bluez-5.87-3.fc44 package.
>    2. A locally built version of the latest upstream BlueZ master tree.
>
>    The same four-packet ISO TX stall occurs with both versions.
> Therefore, the
>    failure does not appear to depend on my local BlueZ diagnostic changes=
.
>
>    The attached capture was recorded while using the upstream build. I
> separately
>    reproduced the same behavior with the unmodified Fedora BlueZ package.
>
>    Reproduction
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    1. Run either the Fedora-provided BlueZ daemon or an unmodified build
> of the
>       latest upstream BlueZ master.
>    2. Pair and connect the Sony WH-1000XM6 over LE.
>    3. Select the XM6 BAP/LC3 audio profile in GNOME sound settings.
>    4. Start audio playback.
>    5. BAP setup succeeds and both ASEs reach Streaming.
>    6. No sound is heard.
>    7. btmon records four outgoing ISO packets on CIS handle 4.
>    8. No completion reports for CIS handle 4 follow.
>    9. The connection eventually hits the kernel TX timeout.
>
>    Completely removing and pairing the headset again does not change the
> result.
>
>    Expected result
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    The controller should report completion of transmitted ISO packets
> for CIS
>    handle 4, allowing the host to replenish its ISO transmit credits and
> continue
>    sending LC3 audio.
>
>    Actual result
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    The controller accepts four ISO packets but provides no completion
> reports for
>    CIS handle 4. Audio transmission then stops, and the connection
> eventually
>    times out.
>
>    Regression status
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    I initially observed working LE Audio with the Fedora-provided stack,
> but I have
>    not yet isolated a specific kernel or firmware version where the behav=
ior
>    changed. I am therefore not marking this as a confirmed regression.
>
>    LLM disclosure
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>    I used an LLM assistant to help analyze the btmon capture and draft
> this report.
>    The capture and reproduction results come from my own system. I
> reviewed the
>    technical claims and am responsible for the submitted report.
>
>    Please let me know if a longer btmon capture, controller information,
> or a
>    comparison against another kernel would be useful.
>
>    Regards,
>    Jonas

Sounds like a firmware bug, I wouldn't be surprised if the firmware
doesn't expect the audio to be transmitted over HCI. Anyway, without
the Number of Completed Packets events the stack stops transmitting as
soon as it detects the buffer is exhausted, so the packets are
considered in flight and never complete. You may want to try to
contact the driver author or the person who submitted the firmware to
linux-firmware, perhaps Qualcomm will need to provide a different
firmware for Linux, one that does allow the audio to be transmitted
over HCI.

--=20
Luiz Augusto von Dentz
