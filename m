Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="N4Io8k09";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="KKDN1LaU"
X-Greylist: delayed 958 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 18:10:09 PST
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B60812A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 18:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B98SRU3PtAJWZTRiFPrGF4tLQjv8NRANvvKuI4GzDB8=; t=1701395649; x=1703987649; 
	b=N4Io8k09n9ODIxE/dbvsNaCJyyQKSqbEGHimYfyX3tpR2FlqD4fR0JMBhzDjXMtMas7qTZTLOgp
	0KhK1COxM1HaqeM41tqMwsRWfJ9ph7Dwa5AhZg8YvTJmdLomVig+mApVtLl81248jgJ5Ge8eFTP5E
	HWf9yW7sDwpLJITKtrSzpw5dEN3v0NFhiXSxagiP8s5VbILHhyI9Cq0S3LECRcsoStmSoPxonLLZ5
	cC6vM9prj7pe6fG64LiNID4mntXq7PFKz9pcsE6eXs3qO6oY6g7Ty2a7xI/VsTFPT+0o93CI/8D9g
	kbBjZ79Nfp2XHXBP07Mg/EuYnWRBH4ZOJ9Fw==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	Subject:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B98SRU3PtAJWZTRiFPrGF4tLQjv8NRANvvKuI4GzDB8=; t=1701395649; x=1703987649; 
	b=KKDN1LaUqM45wkI1VY2bPRNI3WiNhR+FPwhDlcfL3frgjXDyYGmzXBAwIHitvWRQAJvarS0e9QW
	4lp0xXrNzAw==;
Message-ID: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
Date: Thu, 30 Nov 2023 20:54:09 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greetings -

With mainline kernel 6.6.2+ (and 6.1.63, etc), bluetooth is inoperative 
(reports "opcode 0x0c03 failed") on my motherboard's bluetooth adapter 
(Intel chipset).  Details below.

I reported this in a comment tacked onto bugzilla #218142, but got no 
response, so posting here as a possibly new issue.

Details, original email:
----------------------------------------------------------------------
I have a regression going from mainline kernel 6.1.62 to 6.1.63, and 
also from kernel 6.6.1 to 6.6.2; I can bisect if patch authors can't 
locate the relevant commit.  In the most recent kernels mentioned, 
bluetooth won't function.

Hardware: ASRock "X470 Taichi" motherboard - on board chipset.
lsusb: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth.
dmesg: Bluetooth: hci0: Legacy ROM 2.x revision 5.0 build 25 week 20 2015
        Bluetooth: hci0: Intel Bluetooth firmware file:
          intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
        Bluetooth: hci0: Intel BT fw patch 0x43 completed & activated
bluez: Version 5.70, bluez firmware version 1.2
Linux kernel firmware: 20231117_7124ce3

On a working kernel (such as 6.6.1), in addition to the dmesg output 
above, we have this:
dmesg: Bluetooth: MGMT ver 1.22
        Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)

On a failed kernel (such as 6.6.2), instead of the good output above, we 
have:
dmesg: Bluetooth: hci0: Opcode 0x0c03 failed: -110
        Bluetooth: hci0: Opcode 0x0c03 failed: -110
        ...
repeats several times as bluez attempts to communicate with hci0.
----------------------------------------------------------------------

Since that email was sent, kernel firmware has been updated to 
20231128_aae6052, and kernels 6.1.64 and 6.6.3 have been tried with no 
change observed.

Kris
