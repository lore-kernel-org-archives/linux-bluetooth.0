Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135C10F1;
	Wed,  8 Apr 2026 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609573; cv=none; b=oJ1dqeTkwOvbnqCUBRuxCqPa3y/Wgq06/W4AhmSFv9W57h8pv+DuGu1ntTup0bssnMiLC/5KGZgfb+NjRUdP+s6YhI3qk0qWbITv1DoX+p37RPSNyNYwzs/TOYAxnEdDkdI1JJj0B62u05jxYXsStV+Dm9wMQ2JsjSe8ZY5fgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609573; c=relaxed/simple;
	bh=0js1rdBopGmgR7zeyerklFPULHvnrLuaLB86OTOhrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5i2GoQj6b8HwchpSNo4QhGgQPDKLF4CryeikV5MFEN//Z9X4vIXsD0yQjl8B0gK0KFHM1iVMxI8n1mt3OrG5fbj7ehxxmcd9wIVtcqqkkpTzAR0hQO4pPHCVOOYU4AVLvSuUpb6WQ99Y+BpdydW2WqBuvXd4tsKMWkL9pCTGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from reply.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowABXAW3fptVpzS+TDA--.59973S2;
	Wed, 08 Apr 2026 08:52:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] Bluetooth: BNEP: validate control header bytes before reading them
Date: Wed, 8 Apr 2026 09:15:01 +0800
Message-ID: <20260408091501.1-bnep-reply-pengpeng@iscas.ac.cn>
In-Reply-To: <20260404101002.2-bnep-pengpeng@iscas.ac.cn>
References: <20260404101002.2-bnep-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXAW3fptVpzS+TDA--.59973S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFykJF4furWxGrWDur48JFb_yoW8Jw15pF
	43KFWkKF4DXr18Aa92van5XayS9F48tFsxJFn8ury2kay3JryruFZ7GFWj9w4jqF1Sg3y0
	yr10v3yfZryDAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhvttUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Paul,

Thanks for the review.

The Date/Received mismatch is on me. I resent from a locally generated
patch file and preserved its original Date header, so the SMTP receive
time ended up being newer than the message Date. I will correct that on
the next resend.

I do not have a polished userspace reproducer prepared yet, but the bug
can be triggered with short malformed BNEP payloads passed to
bnep_rx_frame().

The minimal cases are:

  1. 0x01  (or 0x81)

     This is a 1-byte BNEP_CONTROL frame. After the initial skb_pull(skb, 1),
     skb->len becomes 0, but the current code still does

         ctrl_type = *(u8 *)skb->data;

  2. 0x81 0x01

     This is BNEP_CONTROL | BNEP_EXT_HEADER with ctrl_type
     BNEP_SETUP_CONN_REQ. Later, in the control-message pull path,
     the code reads

         *(u8 *)(skb->data + 1)

     for the length byte, even though only the ctrl byte is present.

  3. 0x81 0x03   or   0x81 0x05

     These are BNEP_FILTER_NET_TYPE_SET / BNEP_FILTER_MULTI_ADDR_SET.
     Later the code reads

         *(u16 *)(skb->data + 1)

     for the 16-bit length field, even though that field is absent.

So the issue is reproducible with truncated control skb payloads before
any valid length byte / 16-bit length field is available.

If useful, I can also turn one of the above cases into a small standalone
reproducer for the receive path.

Thanks,
Pengpeng


