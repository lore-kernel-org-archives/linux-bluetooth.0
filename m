Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18615B102;
	Fri,  6 Dec 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452163; cv=none; b=o+mKHgAKQD6LpTjhd0BpPhDu8sFstd+3+/wvVpDEY6KNkhqMtBz8QM5VuA5rUYsxWEOt4E5yj9EcZUkdfV0Ewyg8iuGXh5479o3IyJ2qBRDBkniOI7PT/vjKQvU3Y5dUkUCeQpqZ2Hp9AT6p4IAtL02YhHA4JhprzT8N/IduUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452163; c=relaxed/simple;
	bh=dZRT2fcSHjnMoU6qnGBH964/9Ps4VyIHK7kAxlb3RMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML5GcSluAsgEjdxoMxWyBYolKPMPD6u4sWu4CeMqC8lLVzbD3DgTJ1HBK+MbR6rGW4rRFhfDlWxMgrjxE0hIqCbbjaQXL8lxjp+KnXnVD5GtIFAVjxJWiy5fcPDjnTlVtCkPn6FoyRacNaU8P84jrTJyGJ7rS3bb3F6zJ/t3cTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km/OYkIZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km/OYkIZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1164669a91.0;
        Thu, 05 Dec 2024 18:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733452161; x=1734056961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTd3s3aluN78Fp6JU1KrhtNeKWaky7LzzZMIynAmPTU=;
        b=Km/OYkIZaudL12kvx3f36bXxRMECb3KIIe0FxnyiEe1Z3yU0RcanhZklT/ueD7XGoY
         I4w4jGf09NWFdKejRcpeTiYNfbqyatc5l8YuQKZiExDxZQJhPtOUdg00CLvhoi8sEO0X
         ORvo+4SggPUmVbZ1uR0/B184eseKHl4IvVfh7JEkm8WyDxFtNcZIbCN1m5go1vYkDPyx
         AVp+mYDchjoRMgjB+YBVU8hMWT0ERT4P+kd6Phm2fwY5ofllGa/6sY2lX/Z0Idj4iZDN
         GVznJPcfLUokhAY8/GYCQ1rB9jQMmNJrRZu3OTbCUTNpSuvVbbgW9zs4arEhWFjruy6b
         9Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733452161; x=1734056961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTd3s3aluN78Fp6JU1KrhtNeKWaky7LzzZMIynAmPTU=;
        b=ix08x3cz3rvS4NnD5YuFFqT2o2dhjO9L6Lsj8LavmLjOtkNEDptuhXIwf0q90sUdYi
         Tad7xARxfYj6966FrwFDAAvq7vkg54HI/FpBiqztdzNuZ677DbukSKDzNTWf7Cdwdo2C
         N0HX4p7X5TGWfgzegWRf+VVMvDb2JV/ScXzH/jh0fsuRn/3d+AEYdcJCuM2UTxHVB9FB
         p4D90qagYyfZRM3v0JDwENkhhX8Bnp2D7pca4nDYznKvoHlrhjgcti+zinSYLcTJAnnT
         u4sW0UtxamifEwMwHg1p3uxO64gRvDJ4UiDOqEidCkT0cNQPbvXHZc8swglNoHtmKek9
         sujg==
X-Forwarded-Encrypted: i=1; AJvYcCUdua8/+nSDZUnthzHqjV0I/fHwcVDjR/l7QFxLcnTBqmav6aBWYcm73sYpDMBL0cL9AhfZC+TJyrfTUua89iw=@vger.kernel.org, AJvYcCWrqOPllJq8k/t4JvPIp1qSjN9/iWxSDIirKhs59WpzPanH6P02GVsD+uKez0uV61oe31W5KlkbY+AppYsr@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuDg0A7VkQiMQ8yJhF7dwvzaw7bF1H7yinghY7OJQn9CD5BIZ
	6uyHYVXnxjcCLBWng+wPpdRp4q+kglDh1sJxfncW3AQ/YazXaVU4
X-Gm-Gg: ASbGnctMpmINvtHQiiB+Qxzf3iFyaLDKHByMuf526Ja3QQfklMhYCNl2Pm3MTh3PceT
	0RUIfhHNdyppSKM+rtB2Vz3Puh1WenToBvZlbn260AK1M6gaAdNjwIZqX/fZ0izkqmjQKl4t1Kw
	Cg1KKITAzD6tZTZgHVyg7nXwjjhuhCnPMexaqXC2wzxCk08FYpRl2xrestyXKUDZqPQyIsE5hf3
	NQkhZqF3I4uqJLHj9BiaAD21f6pVrH5dFvQAdDe4Idl1TxtM3dRDGmCLeqczBZRGyqhn/D202XS
	QCbDMDHd
X-Google-Smtp-Source: AGHT+IENADZamiqnBlD27UzquN0EcS+uEssM9SmnMSUyaY3tEGzNq20fxMu9PeMax023yYnyI0hAAA==
X-Received: by 2002:a17:90b:254b:b0:2ee:fd53:2b03 with SMTP id 98e67ed59e1d1-2ef6aadb46dmr2207449a91.25.1733452161282;
        Thu, 05 Dec 2024 18:29:21 -0800 (PST)
Received: from amdora.. (c-76-146-136-228.hsd1.wa.comcast.net. [76.146.136.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eeffcdd432sm3180613a91.2.2024.12.05.18.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 18:29:20 -0800 (PST)
From: John Glotzer <jglotzer@gmail.com>
To: sergio.callegari@gmail.com
Cc: Aaron.Hou@mediatek.com,
	Chris.Lu@mediatek.com,
	Deren.Wu@mediatek.com,
	Hao.Qin@mediatek.com,
	Sean.Wang@mediatek.com,
	jglotzer@gmail.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	luiz.dentz@gmail.com,
	marc.payne@mdpsys.co.uk,
	marcel@holtmann.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	steve.lee@mediatek.com,
	tiwai@suse.de
Subject: Re: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And Hibernate
Date: Thu,  5 Dec 2024 18:29:19 -0800
Message-ID: <20241206022919.183292-1-jglotzer@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <ad78ad62-ebd2-40d7-8a6d-623ae947584c@gmail.com>
References: <ad78ad62-ebd2-40d7-8a6d-623ae947584c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sergio,

My apologies, I neglected to mention that my setup is PCI, and not USB.

It's an AMD Ryzen 5 7600 CPU on a PRO B650M-A Wifi motherboard. For completeness OS is Fedora 40
with any kernel starting with 6.11.x.

    $ lspci | grep MEDIATEK
    0c:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter

    $lshw -C Network
       ...
      *-network
           description: Wireless interface
           product: MT7922 802.11ax PCI Express Wireless Network Adapter
           vendor: MEDIATEK Corp.
           physical id: 0
           bus info: pci@0000:0c:00.0
           logical name: wlp12s0
           version: 00
           serial: 0e:80:32:35:2c:9b
           width: 64 bits
           clock: 33MHz
           capabilities: bus_master cap_list ethernet physical wireless
           configuration: broadcast=yes driver=mt7921e driverversion=6.11.10-200.fc40.x86_64 firmware=____000000-20240716163327
           ip=192.168.139.211 latency=0 link=yes multicast=yes wireless=IEEE 802.11
           resources: iomemory:fc0-fbf irq:103 memory:fcf0300000-fcf03fffff memory:f6c00000-f6c07fff

What I am struggling to understand is given how easy this issue is to reproduce -  an AMD CPU, Mediatek MT7922 wifi/bluetooth chip,
and a 6.11 kernel, you suspend, and then wake up, kernel panics -  I would have thought that the interested parties would
make this a priority.

I think that a logical first step would be for SW owners to confirm (or deny) the anomalous behavior.

Thanks,

John

