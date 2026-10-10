Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16137BE7A;
	Sat, 10 Oct 2026 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.31.198.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791647495; cv=none; b=jeGblwwZ5QfjsvxLYRhPcsFWmhSiTUnnuPb7cJ0IFsD1yiV2WPKOyKOlR01kq6//r8QFKRShOR30ZXJPXnPszZ6+CPxVSL8S8TsU1FF/Izl4ALpcfJGfbSrFE1chwcSkxEbTyEI9k6uDkPZ0kzfMPBUbs5J8i3uBrU9wXrpDlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791647495; c=relaxed/simple;
	bh=a/P9f0Gzyx2LkeJKxwMRZZIaj39UH8UPmUMMcTsFTu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCojmKmfj0GxlThmd8BKfAv6svtdOVF2Rdutl8iSIN2bewEBHwoNG7Tnjc2X1cGHmG1Tw/KqkqUUFiZTUn8TCdvZ9OnZFrCCPwPggsiY+u+OWv+jHkzKt3EXPQbGRysRg2knf+Mtax5n64JACH/1N8jIMVQwIg/eYyFhs8bbFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minlexx.ru; spf=none smtp.mailfrom=minlexx.ru; dkim=pass (1024-bit key) header.d=minlexx.ru header.i=@minlexx.ru header.b=Xyw2xZFe; arc=none smtp.client-ip=31.31.198.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minlexx.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=minlexx.ru header.i=@minlexx.ru header.b="Xyw2xZFe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru;
	s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5TETcDpT9jJYHrDDuoaxTIS0rVC9hKg+2tr5mYKW4B4=; b=Xyw2xZFe5W/LPsxFHenJW9JP0B
	tlBMRqEbeicOqu/GoyTR4CesOjZag8fsKvdWv8/RhoMXuSYxtmRilAQy6IeAXf5EaJK+l4o8QscaB
	sqTKttJk1I9g/bAXAyZhDzAWh/bkiIZdi7sTJUEc5wVXDgsCuX088bp+UAZAW3VLeDlg=;
Received: 
	by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(envelope-from <alexeymin@minlexx.ru>)
	id 1xFZM4-00000009JuA-0Qf0;
	Sat, 10 Oct 2026 18:51:24 +0300
Message-ID: <a1220e52-eaa3-4224-b149-47a5d34708f6@minlexx.ru>
Date: Sat, 10 Oct 2026 18:51:23 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: msft: Ignore vendor events shorter than the
 event prefix
To: "Adrian.Nguyen-Qualgo" <thenguyen1024@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261010140806.65929-1-nguyen.ndt@qualgo.net>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20261010140806.65929-1-nguyen.ndt@qualgo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.2026 17:08, Adrian.Nguyen-Qualgo wrote:
> From: Adrian Nguyen <thenguyen1024@gmail.com>
> 
> msft_vendor_evt() is called for every HCI vendor event. When the
> controller defines an MSFT event prefix, it pulls the prefix with
> msft_skb_pull(), which logs "Malformed MSFT vendor event" when the
> event is too short. A vendor event shorter than the prefix cannot be
> an MSFT event, though, so it is reported as malformed for nothing.
> Before commit 3368aa357f3b ("Bluetooth: msft: Handle MSFT Monitor
> Device Event") such events were dropped silently.
> 
> A WCN3990 logs this 20 times at every boot, while btqca downloads its
> firmware and the controller answers each segment with a short QCA
> vendor event.
> 
> Return quietly when the event is shorter than the prefix. Events that
> match the prefix but are cut short still get reported.
> 
> Fixes: 3368aa357f3b ("Bluetooth: msft: Handle MSFT Monitor Device Event")
> Assisted-by: LLM
> Signed-off-by: Adrian Nguyen <thenguyen1024@gmail.com>
> 

Hi!
I've indeed seen lots of messages like these:

  Bluetooth: hci0: Malformed MSFT vendor event: 0x00

using WCN3990 bluetooth, with this patch I see none.

Tested-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

--
Regards,
Alexey Minnekhanov
