Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E4199EB4
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371962; cv=none; b=MVO2OR+ythgpRgLUe2dHkVB9LxSujOaDklQ+gdE/mxE/DLNbcp8teGdRvk4c/hcTdKsmVmXF+yMZBFAO9GX3RSnFlT5z+00mboxVJ/kRd1pslN/YoKjB/w3n7a3cFfzpETkgYvFl9ViFh9ZqIjx28KSPyGdXC1gDM2HuvTpKNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371962; c=relaxed/simple;
	bh=SwFBwBIvoXU2RBsJI+u4fqOerMpUc8/ZRMR6yScOJXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk61+iJvRtlL4Li4znGxkNeps4pcOB8aA8Y96ofSvOazVO/jzzti8o0+I3yHLHiLVf+Tfn7JWyX8FWvKNMNDgFgpZOVibE7rh5XyR7HZ4GRi5AOLDZ/5WW5gVzcgPizN/YRLcHUjfjuMXA3mC3CbQoJfk83rD1gbQ5x8UjMA/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiY1byey; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiY1byey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730371959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV7sOo6UpzuMwB4bSnPkKngFzqbItuEk4sjaHJSnab4=;
	b=DiY1byeyqxwzTR4gzg/XD/s/p/1+M+cnp9QlPTaRKudrM/DTPmVcmH308gJuJgGEMaQnPB
	7a4ELY7GcbYcOVpafEK0GgK+5UYhd546opED7b1eLBlZV3W+LTHR/6YREjHJPuTeBVBidC
	T/7X7IcfGYd7gAstBN3gZYXAI5O+hv8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-xIXSQ75TN-uDB-mw2uXBYg-1; Thu, 31 Oct 2024 06:52:37 -0400
X-MC-Unique: xIXSQ75TN-uDB-mw2uXBYg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539eaa0561bso598616e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 03:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371956; x=1730976756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV7sOo6UpzuMwB4bSnPkKngFzqbItuEk4sjaHJSnab4=;
        b=bqqcZfFUNKnu5tsSYO6C2xOc0gs9NbV1l4uQjptLykJUed3H4s4CKLMV9+TriA5V63
         ve4SpyMDjHXnCxc43ncLolNCoGTX8erJ0YhC0tUsWdXFbNINRF51KZ10j8MqAJKxCzo9
         DirzYOqc6qFz8SXNKXGJEcwtABWnw4AV+TXu+a56OLN1MzAPLcOEAjHdlDajL0+5A5C6
         ZuRuzj+QCxLWDzIdcKhJ1zhgzksCJaGo8rwwnwNIBWlj4FKreTiwea9BK2Uzv0AcF/3I
         I0kn6LfXSex8W8+3LzI/j/0aAjstwVHQHkZaChKN/+qiZ/LDn4PqcAnBIcZNpsyIYfYL
         mWHQ==
X-Gm-Message-State: AOJu0Yyi/iIZIgcre5u85qV6xwbWljfLf22mxcwPAtzx8dB7BMi5+q/o
	Fqg2O0tplNtNbRkZU/YiXcqqPUfCdGg82b5BnI0b1r6Ex9Xl7WBok9gNejdAEVD5gxxPkdJwVMl
	/NHY0qJIDmqWpA092s+g31o5cgRqJnSgF3ntqGQbMBESAgOCfQQjiPBA5bowfhGEVOg==
X-Received: by 2002:ac2:4c41:0:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53b348cf0c0mr9561680e87.14.1730371955932;
        Thu, 31 Oct 2024 03:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPlkn+SJXy7w6iV3YfSGvZYFvBYxL/Zq1Ot5wHRbcZsYQnie+vd2gCyjPL4AYwHUczW0kRzw==
X-Received: by 2002:ac2:4c41:0:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53b348cf0c0mr9561661e87.14.1730371955465;
        Thu, 31 Oct 2024 03:52:35 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5abfb1sm22089285e9.9.2024.10.31.03.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:52:35 -0700 (PDT)
Message-ID: <1c19403a-e192-44bf-9158-9ac132174c40@redhat.com>
Date: Thu, 31 Oct 2024 11:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-10-30
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20241030192205.38298-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030192205.38298-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 20:22, Luiz Augusto von Dentz wrote:
> The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:
> 
>   Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30
> 
> for you to fetch changes up to 1e67d8641813f1876a42eeb4f532487b8a7fb0a8:
> 
>   Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs (2024-10-30 14:49:09 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci: fix null-ptr-deref in hci_read_supported_codecs
> 
> ----------------------------------------------------------------
> Sungwoo Kim (1):
>       Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

FTR, there is a small buglet with the tag area in this commit (empty
line between fixes and SoB tag). Given we are still digesting last week
pw, I think is better to avoid rebase and repost, but please double
check such things in the future.

Thanks,

Paolo

