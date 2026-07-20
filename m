Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CB2DB780;
	Mon, 20 Jul 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578840; cv=none; b=NdJPFiC+q1bExxDm1m3QIvKpQoYNubQWWMrcq31ygTA8dUcnOCeBPY/cNfIedcFt1GRz/XY+Ee0eXhYqVG2xV4VgsdsCkgYg/kzugDtNC/PZ9DwsCdFM4M/CBGZ69guqwnWpoL/5WJXBKYGqnWswgeULshVzplqWXgDEQun77QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578840; c=relaxed/simple;
	bh=fpz1+rcB1LNf4yN86IWTHLxYLOHTTk00rO5GL1KwabU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svZnfYyxcEiLS1otiW7FnuR3ueNVBGEQCaFReJEQLBczqOJ4YGvHMzv4zHhYbkAybcnlMl4RwJtwt1m9g3rPof63cREyH3Hq6mhhYj7DWIYl/LFLqvQWGTyTelB+wpQ9TwXRtEuZFqmeI1BmxWNJZKoyBi8NVSP3MoIa6QIOZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIFif9Xi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIFif9Xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE741F000E9;
	Mon, 20 Jul 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578839;
	bh=2HuEw70t9e39yDTgfl3yLY5tatWTbA4/wRDHQI1mQys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iIFif9Xic+uINd9XcU2ojSzAmFWj/7AcfLKDZS5QntaNjTH0ivXpWSlWdmDSFjdNL
	 BDmL28pwOnbmhPzh7yfQ1ps0UJP51/Avth/LWEuHaBowneweXzt5L2s6cGt1kSImhG
	 qsK2gtGjfjWlsq5XcD30oEoJgWN0z+Y1Lw1aDXVuEz9KqJvvDXzsE8A8ZiWgbf6OuJ
	 Y6cLFBWE3zqzwjZjJuperdsohtHsSyOZ+K7bnOnPSZtOte5RKMfLKe+tyGLuya8HlU
	 QpX9HN05CjwJFsm1TlObk5S9W8RPIe5YdZ2P52Vad4ei0cg5JBSg8x/cXFpL533NaX
	 ze1SKvYtqmnsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2939244CA;
	Mon, 20 Jul 2026 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: validate Realtek vendor event length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457880938.4151939.12864032373120218164.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 20:20:09 +0000
References: <20260720114717.60749-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260720114717.60749-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jul 2026 19:47:17 +0800 you wrote:
> btusb_recv_event_realtek() reads the event code at data[0] and the Realtek
> subevent code at data[2] before deciding whether to consume a vendor event
> as a coredump.
> 
> For example, the two-byte event ff 00 contains a complete vendor-event
> header declaring zero parameters. The old classifier still reads a
> nonexistent third byte and can misclassify the event as a coredump if the
> adjacent byte is 0x34.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: validate Realtek vendor event length
    https://git.kernel.org/bluetooth/bluetooth-next/c/891916abe16f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


