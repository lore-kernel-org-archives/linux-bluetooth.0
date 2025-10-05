Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCBD74040;
	Sun,  5 Oct 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759655548; cv=none; b=oKX3PiIG8SK4d1sqTxshGrAqaugD+cS6foDYqKd23GJU2v7zrz1ueRMQvhzCFmh0AxP1/5kqgHbofRfKNmHJ/6igZ+LUjFDfG+fVLj/3RmF7BZR05XYoeN3KBWituLI5wuh++sTiaoVYeeLkLKkh7GCBvcwSx0jwIA3Tv2gP/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759655548; c=relaxed/simple;
	bh=cp/WEM8v3vxRWSNXoRp8Fwrnj8DXhf8ZjY7a3Xm8wQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pSCAQT7znk22x2EMfHdouQHi6Vpm/oGqz3NrkW2wXMkPViMDJeEY1MSMHZMRLqu/9lToY1BYmL0lu5IAgl6FCKk7Q+Ebn7Edn1gDcOY72z4+aHNElSLEiD1XZHdE6Ck5VVGEBnHGoODdTVCDHgjy4mXlTfoe6aTN20xymg8XfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5dc55e4b.dip0.t-ipconnect.de [93.197.94.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B9D336028F370;
	Sun, 05 Oct 2025 11:12:10 +0200 (CEST)
Message-ID: <72f869f4-8320-4bdb-a7ba-714e46928a69@molgen.mpg.de>
Date: Sun, 5 Oct 2025 11:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 2b89/6275 for
 RTL8761BUV
To: Chingbin Li <liqb365@163.com>
References: <aOIyJOnP55mmZUut@9950x-Ubunbu-24-04-dev>
Content-Language: en-US
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aOIyJOnP55mmZUut@9950x-Ubunbu-24-04-dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chingbin,


Thank you for your patch.

Am 05.10.25 um 10:53 schrieb Chingbin Li:
>  From 5676b7b1029c11ec99b119a3b56945ba8a766c0a Mon Sep 17 00:00:00 2001
> From: Chingbin Li <liqb365@163.com>
> Date: Sun, 5 Oct 2025 16:28:28 +0800
> Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV

Having these additional lines is incorrect. Please use `git send-email` 
or b4 to submit your patch.

[…]


Kind regards,

Paul
