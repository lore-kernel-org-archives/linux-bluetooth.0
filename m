Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F83F413A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724327; cv=none; b=iC/u+FeMpMfo1b+b/vd0QaiMxA4a+Ho5jKC3XpKgR6q5UsP2MoUqHqf0s+l/kvB1gASvD6A2wlnf1tWFVEkQW9I94eBWQ2b4Y5/mfRKiap1pgPUr2O/RXtmo8wK0XDFYBwZE9nAOY/1HvYbwhCZlKtzOQZICqp2UrWMNELvP09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724327; c=relaxed/simple;
	bh=i2RC0ZahWc6BT54sQObMfgmogxlCrwhJnvZ5nRfEofs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwM6X0Dv38jqZ9dL/trlsA5eJKXo5rHXDVK+Ckdn4f2k3De1TnCo7N99Rq6v55AZ77TW7s56TXP/5L2uUBlXMCbpyAeYqlD9IvpFlUebsmqeC8/0SAPzMQ08ZMgy5YRSKdWfrSRGC7PwEOnQCTi/myATFJ0DQeA68Ce7DPqlDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ATCTMk7u; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ATCTMk7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1778724323;
	bh=vVTKMxOVL3MPocSHvOj+BJLLfEPgwEZ/4S2tPlUm8aU=;
	h=From:Subject:Date:Message-ID;
	b=ATCTMk7u9SI5bCcJssAuuB9NQmExuDhGPREsapNeKWrKNhD96u1ws1X3g4LKWH0EL
	 6VLUnZS4o+s4680WtA9hqYL5M64n2FBXm3mD0WAKcUs4jSTbYqLEqsp+pGMN5OUmzi
	 B6zLApeYZ11DkpXpfITu65fUOMxJHMhcV75PJaSM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A052DBA00000B28; Thu, 14 May 2026 10:04:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4248606685266
X-SMAIL-UIID: 3547F36E4A574AAE8FC7DB59C10132BA-20260514-100444-1
From: Hillf Danton <hdanton@sina.com>
To: Heitor Alves de Siqueira <halves@igalia.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Gustavo Padovan <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
Subject: Re: [PATCH] Bluetooth: hci_core: Don't queue tx_work while draining workqueue
Date: Thu, 14 May 2026 10:04:42 +0800
Message-ID: <20260514020446.639-1-hdanton@sina.com>
In-Reply-To: <20260513-hci_send-v1-1-ae3eef758280@igalia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 15:55:23 -0300 Heitor Alves de Siqueira wrote:
> Syzbot reported a warning when L2CAP calls queue_work() on the hdev
> workqueue while it's being drained. This can happen during device reset or
> close paths for hci_send_acl(), hci_send_sco() and hci_send_iso().
> 
> The workqueue is drained in hci_dev_do_reset() and in hci_dev_close_sync():
>   - hci_dev_close_sync() clears the HCI_UP bit before draining
>   - hci_dev_do_reset() sets HCI_CMD_DRAIN_WORKQUEUE before draining
> 
> Add these checks before queuing tx_work, and free the SKB if it's not
> queued for transmission.
> 
> Fixes: 3eff45eaf817 ("Bluetooth: convert tx_task to workqueue")
> Reported-by: syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=97721dd81f792e838ba0
> Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
> ---
>  net/bluetooth/hci_core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c46c1236ebfa..5d5f8ad7d1a8 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3278,6 +3278,12 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
>  
>  	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
>  
> +	if (!test_bit(HCI_UP, &hdev->flags) ||
> +	    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
> +		kfree_skb(skb);
> +		return;
> +	}
> +
>  	hci_queue_acl(chan, &chan->data_q, skb, flags);
>  
>  	queue_work(hdev->workqueue, &hdev->tx_work);
>
What you add is not enough, go and see how HCI_CMD_DRAIN_WORKQUEUE is
checked in hci_cmd_work(), and in hci_dev_do_reset() for why.
