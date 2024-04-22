Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFC1803E;
	Mon, 22 Apr 2024 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764488; cv=none; b=ASXX1tuhSC4NXCqC0nwWOfWbD4ibI4YWdftAvuImggPxU4FPh4TlZeN2idH902M4dyofub6qtDOmaIcxcG+g2j25yen8kWXqTiM1UZR/RB6utrUQmXdzI+JFc7tOEu9YJurzx6PKppI0WnaHwD3xR45QHtn0DUXB/B5Z01OksGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764488; c=relaxed/simple;
	bh=imI26xf4m4Jtllc2Vny5xo+4IdfqTMdFeXQyDKzPris=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUelkMX52N9UgR8/7Hd9g/8ICfPH/o9jbWqPdOmg1nuBFGJAnYvTktkosOC5VkLo03AKTcBveokjGx1sW1rU3JDgtUL/dFkQRuI/hf6gcF+Gk+kXQOKMbCPsZC5SJXTbjUXunGmdYNAEA9JKRbPOkVEOr7I9cpUVV5e7MBlDWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=g4OvUo55; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="g4OvUo55"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=DH3LdkNy9I7uksd96iAXb3ILFLD4dkEOSXfczznuJjU=;
	t=1713764486; x=1714196486; b=g4OvUo550YmNMXTS1Kze5f27VKi/E/fNV+GIG96+Xkul/fy
	DlWpZWb7PnZPYLmf7xSpx+4P2QSNigavAM88HA2Z5PXqUFAOYf5Wy5/OLvxPWWD1gc9h0pS+9nIhE
	Ja6QwM/xbbJsK8BB4lt7Tz0w74WZ1YD2p/dXE9Hm/cENhMVATZwn7FRDpgxxZeBiUSsZR1gtjRU9d
	EZA0+PR5d9r/mTM1oZVSEZMqIp7jQYn7yj+0WERQuB5Drq97bLRb+OSXeB6SAcw72jKKpyoWea4ti
	gb89TJwXBNL+Gs29h6hy9kpjTES9O7Meb1XmFcCqPmzJ34+NqRaD2nU5rYj/fkFw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rymQc-00075I-MN; Mon, 22 Apr 2024 07:41:22 +0200
Message-ID: <e723ec51-a1de-4d4d-870f-34c9427fffb9@leemhuis.info>
Date: Mon, 22 Apr 2024 07:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev
References: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
 <8eeb980a-f04a-4e94-8065-25566cfef4dd@molgen.mpg.de>
 <CADRbXaD5Fsy0dxjrVG2JAn1PA36hpoTe6=23=zbhx8NWNf_9mg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CADRbXaD5Fsy0dxjrVG2JAn1PA36hpoTe6=23=zbhx8NWNf_9mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713764486;a74dce71;
X-HE-SMSGID: 1rymQc-00075I-MN

On 22.04.24 01:17, Jeremy Lainé wrote:
> 
> On Sun, Apr 21, 2024 at 11:01 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>> Would you be so kind to go the extra mail, and bisect the commit between
>> 6.1.82 and 6.1.83 [1]?
>>
> 
> Thanks for the link to the instructions, here's the bisect log:

Thx! Did you also test if mainline (e.g. 6.9-rc5) is affected? Without
this we won't know if this is something the stable team or the regular
bluetooth developers have to handle.

Ciao, Thorsten

> git bisect start
> # status: waiting for both good and bad commits
> # good: [d7543167affd372819a94879b8b1e8b9b12547d9] Linux 6.1.82
> git bisect good d7543167affd372819a94879b8b1e8b9b12547d9
> # status: waiting for bad commit, 1 good commit known
> # bad: [e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1] Linux 6.1.83
> git bisect bad e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1
> # bad: [440e278cb53b8dd6627c32e84950350083c39d35] net: kcm: fix
> incorrect parameter validation in the kcm_getsockopt) function
> git bisect bad 440e278cb53b8dd6627c32e84950350083c39d35
> # good: [a4116bd6ee5e1c1b65a61ed9221657615a2f45bf] arm64: dts:
> imx8mm-kontron: Disable pull resistors for SD card signals on BL OSM-S
> board
> git bisect good a4116bd6ee5e1c1b65a61ed9221657615a2f45bf
> # good: [e16c33dd9967b7f20987bf653acc4f605836127b] net: mctp: copy skb
> ext data when fragmenting
> git bisect good e16c33dd9967b7f20987bf653acc4f605836127b
> # bad: [6083089ab00631617f9eac678df3ab050a9d837a] Bluetooth: hci_conn:
> Consolidate code for aborting connections
> git bisect bad 6083089ab00631617f9eac678df3ab050a9d837a
> # good: [934212a623cbab851848b6de377eb476718c3e4c] SUNRPC: fix some
> memleaks in gssx_dec_option_array
> git bisect good 934212a623cbab851848b6de377eb476718c3e4c
> # good: [8499af0616cf76e6cbe811107e3f5b33bd472041] igb: Fix missing
> time sync events
> git bisect good 8499af0616cf76e6cbe811107e3f5b33bd472041
> # good: [653a17a99d752ffde175d4bc96154f2a3642f400] Bluetooth: Remove
> superfluous call to hci_conn_check_pending()
> git bisect good 653a17a99d752ffde175d4bc96154f2a3642f400
> # good: [1023de27cd1d0d692e70fe6d6d5cee9fff9b9c84] Bluetooth: Cancel
> sync command before suspend and power off
> git bisect good 1023de27cd1d0d692e70fe6d6d5cee9fff9b9c84
> # good: [ac7a47aaa7944efc94e4fc23cc438b7bd9cc222c] Bluetooth:
> hci_sync: Only allow hci_cmd_sync_queue if running
> git bisect good ac7a47aaa7944efc94e4fc23cc438b7bd9cc222c
> # first bad commit: [6083089ab00631617f9eac678df3ab050a9d837a]
> Bluetooth: hci_conn: Consolidate code for aborting connections
> 
> 
>> You can pipe the output through `scripts/decodecode` and it should show
>> more information.
> 
> This was the output of running the dmesg snippet through `scripts/decodecode`:
> 
> All code
> ========
>    0:   fe                      (bad)
>    1:   ff 0f                   decl   (%rdi)
>    3:   0b 48 89                or     -0x77(%rax),%ecx
>    6:   f2 48 89 fe             repnz mov %rdi,%rsi
>    a:   48 c7 c7 48 18 7a 9f    mov    $0xffffffff9f7a1848,%rdi
>   11:   e8 14 a1 fe ff          call   0xfffffffffffea12a
>   16:   0f 0b                   ud2
>   18:   48 89 fe                mov    %rdi,%rsi
>   1b:   48 89 ca                mov    %rcx,%rdx
>   1e:   48 c7 c7 10 18 7a 9f    mov    $0xffffffff9f7a1810,%rdi
>   25:   e8 00 a1 fe ff          call   0xfffffffffffea12a
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   48 89 fe                mov    %rdi,%rsi
>   2f:   48 c7 c7 d8 17 7a 9f    mov    $0xffffffff9f7a17d8,%rdi
>   36:   e8 ef a0 fe ff          call   0xfffffffffffea12a
>   3b:   0f 0b                   ud2
>   3d:   48 89 fe                mov    %rdi,%rsi
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   0f 0b                   ud2
>    2:   48 89 fe                mov    %rdi,%rsi
>    5:   48 c7 c7 d8 17 7a 9f    mov    $0xffffffff9f7a17d8,%rdi
>    c:   e8 ef a0 fe ff          call   0xfffffffffffea100
>   11:   0f 0b                   ud2
>   13:   48 89 fe                mov    %rdi,%rsi
> 
> Best regards,
> Jeremy
> 
> 
