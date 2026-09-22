Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FD4D794D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070963; cv=none; b=ihzdT+Gig+6tOASSsgSkmP0P1uwCe1I+iXu6buVcO1ZOyxehinc3TpzjgHXB6RV6JTmrELdvmd1SCf8S4X52Xg7eM0RtQgKjGtgF+wKhM5s9X7brTrr341I/1XQ6zuqmtMFaEeY0RNrxiw/dS1cogFSYcxna4Wpbm/FiMazVBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070963; c=relaxed/simple;
	bh=vhtBOq46+vxnVMew6tqDj9pw32mqh2c/pNpj9HCWF5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haYVzvlZ3BXdZ6bMFVyWm68l9btliC8kuxplQCju5eqUBj1mVUZ0CMHvlOwqIuLB9kGuu7HOQEmK/IgJn2TaB3P4JT7Lr6rpYD9+mv6RDi4Ji2vbPxduo6yCkreebWUhABuNOTHmHzz0xdBK7XaqQzCM2KyAZmiCriEajMDSzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EzWbXEjH; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EzWbXEjH"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso27287165e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790070960; x=1790675760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GovoQhgpkFSxI/w16iH1Xm3iicrwAlkN1B9IHqCNx44=;
        b=EzWbXEjHED8CPODT/5NP46rKxo3ggWN1EUNgzvlub7kzfVKirtjRRlbe/+XsWzenLY
         N8v5PATcnHpDVALjG6OOeq2AZe5paIevguOKYuAcLvMRdRw0ZXCMcrceyyZEdSMZ+Nfp
         6T7vm2QroUq9NAzaB2H6jFLMzbctmRjL0+Un8KoGvjCsdLX5tPnNHIon3Y5JFe9xIlpj
         negzdjpA2SKvJpu0PN3aQs1PHecSLCSQ8ScRjEfLmhvmBBydXBHMa/btyxFui6DZK+30
         ox0TD0n6i5giJ1gZhEqG7tSeMu40XqafDQ3H1WZ7z7E76DI5g/eqwHADY6LrRceSXcTi
         ndgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070960; x=1790675760;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GovoQhgpkFSxI/w16iH1Xm3iicrwAlkN1B9IHqCNx44=;
        b=uHOn6KbsEriRMs4j7R6ku+OvvO6TMT0XWPiVnDFKa4ADdS+r2ga4b5Au+jPXEhI+i1
         LIGyfd8LDbgegW8w7m0Dg9bo81OqwD6EomaJ2LeWzwvxi3tpIMIs6YvUjtrd6HlD2dZB
         PVU7ucprk3/X5l2IeHmO5zNf6lCZME6M99UZzwukVDwCMOReV725LPtJuwGTwFbUPxfi
         eBbrOV2MOgbqJi1+FHPieMpuKavGdo1kHe7Ztwd51JspY8RKrq2N/YkUOoKNoqcQKgnZ
         aFCgiYrtJ3Fw64FV7Y9I0FEirv6ZFXV6NmwQ0+J8HZqvGofRnvR0zsDQsoGLkJUxXDPx
         Wuuw==
X-Forwarded-Encrypted: i=1; AKwUvByneISsr+886hq3jf0+kGHRrIio/9R8uNP0oGJ8fC7HxjL8kpzr2Agmhl+pCR37hMq+PiVB8J911P6bxM2p0PY=@vger.kernel.org
X-Gm-Message-State: AFuF++kbcLibbk4U/kgHLw/EGrBN4jJKVJgmWCbJLhSgeigE1XpS/zz9
	A6/Pew3KB7wtFtcGXY/XuhQpfr6THLeF8SKtx3Iyfbb4sAorhMrEit8LlutXsucoeCY=
X-Gm-Gg: AYBFou3qlfjI4YHsenb55ptohdn0UAitktjwzeIsEnxV3dwPMHtPvMXG2lZYempRAXj
	lNvERX7yNUjR02bReHt4vItrsYGl+V8V9+cYhEZWvsP7tcPaiQnmik/3T4KERjLOoWTItXGarkL
	J2CJurYT5mg432rW+14ih5kxz5FrTe3wr63ucGiFhSekkKqev/WiihgeDB5fL+Tp7hGSiStonyv
	0NufhMO20UsNCS+1SBkYvH/SRO6bCPnRYKnJl7wdmU+P7FeOv5B7PdizojuJCZtFGE7jg3Jq4pi
	6G+Tfs/xkbTFkZwDawxiwpf79/EkJENK6jHAVAecRe9MeXNsCC0if9P+2jiPTsLE7j+Qf1S1ycg
	wmgiJ7Co2LU6FgEARahTE4f4368xo5SETc6X5TVsZT1zhr3z9XG8NDaOsEwCIs4JAhn7Z+WJYRw
	o43SxOSZ5cdoICKeVikjr10BHjK776JjvW1nReFrKZXn//heFzht1BZgzzcKd7ME6tEId9K1QFg
	TXTmh5sOx4+pV6vQeD5AjIrbA96XocPR/JN1HEt
X-Received: by 2002:a05:600c:8b61:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-49fc5749edemr209696075e9.31.1790070960066;
        Tue, 22 Sep 2026 02:56:00 -0700 (PDT)
Received: from ?IPV6:2001:a61:13f0:9e01:9a7c:db93:afba:8f7f? ([2001:a61:13f0:9e01:9a7c:db93:afba:8f7f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaa4e47csm78584305e9.1.2026.09.22.02.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:55:59 -0700 (PDT)
Message-ID: <38d2639a-d5a3-4d01-ab86-8aa7e2fe75a7@suse.com>
Date: Tue, 22 Sep 2026 11:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: restore powered-off Intel
 adapters
To: Sean Rhodes <sean@starlabs.systems>, linux-bluetooth@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Xu Yang <xu.yang_2@nxp.com>, Kees Cook <kees@kernel.org>,
 linux-usb@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <cover.1789679980.git.sean@starlabs.systems>
 <479fdb2638f34ccb02f35a40a34fcdc7cc41ccdf.1789679981.git.sean@starlabs.systems>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <479fdb2638f34ccb02f35a40a34fcdc7cc41ccdf.1789679981.git.sean@starlabs.systems>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.26 23:19, Sean Rhodes wrote:

Hi,

> Tested on a Star Labs Lite Mk IV with Intel 8087:0aaa. Three Bluetooth
> off/on cycles reached ACPI D3cold, restored the same hci0 without a USB
> disconnect, and discovery found nearby devices after resume.

Have you tested this with a different device and S4?

> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>   drivers/bluetooth/btusb_main.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 

[..]
>   #ifdef CONFIG_DEV_COREDUMP
>   static void btusb_coredump(struct device *dev)
>   {
> @@ -5093,6 +5125,7 @@ static struct usb_driver btusb_driver = {
>   	.disconnect	= btusb_disconnect,
>   	.suspend	= pm_ptr(btusb_suspend),
>   	.resume		= pm_ptr(btusb_resume),
> +	.reset_resume	= pm_ptr(btusb_reset_resume),

What happens to a connection if a lot of data has been lost?

	Regards
		Oliver



