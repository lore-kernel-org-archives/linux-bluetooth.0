Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050922BAC9
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067506; cv=none; b=A6kQwxz5LKAh4epeu6zZfccS3DnTbWPAM57YiZyelJH294sYci4hrofnlVYUfQ0q1fQWU+k/PDMHU1kHzmcm8qD9C+iefEeaWv5fIVw8D0wrQ4PdK7T+znSYaqh8clFMZK2ZnUQagwydOSsR8BqeGnrVuhg4o2AJ4c3n6vCrCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067506; c=relaxed/simple;
	bh=pgym8+JZ7YkXXKQfkrE4/rBEyVR5PC0LFtkPgF7ojC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQvM8M6dJgqqXdklYhKsXJL7X4egV2JAgOxjKOWGQUMlsUUtyrRN9Qfw0kNCNQPav7voCktwfPtMz664u+Rwq9s8ItsvLq2DCZEQo9ho1NuOnd183kY3xjd3K09TLBornDmw5QhKpfyeXd+74mOR4AiW/GrMzIa0Q1ESIzpR3ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.62])
	by sina.com (10.185.250.23) with ESMTP
	id 67898BE800006B30; Thu, 17 Jan 2025 06:44:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2537328913369
X-SMAIL-UIID: 52293ADD92A543DD8F5004813059B7ED-20250117-064459-1
From: Hillf Danton <hdanton@sina.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: hci_core: sync hci rx and cmd sync work
Date: Fri, 17 Jan 2025 06:44:46 +0800
Message-ID: <20250116224448.1933-1-hdanton@sina.com>
In-Reply-To: <CABBYNZ+99rvMrDs_j8niLtef537t7VFrEVY4NHdymW8wgnBNdQ@mail.gmail.com>
References: <677b9c97.050a0220.a40f5.0003.GAE@google.com> <tencent_E7941CEA8AEEA2CC0879BA6C2C2C956E2C0A@qq.com> <CABBYNZK8M9RAh3jeXLs1+=s4rYW=EzJnt1HXD0XNjKCQmMjPeA@mail.gmail.com> <20250116104240.1898-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 16 Jan 2025 10:31:03 -0500 Luiz Augusto von Dentz
> On Thu, Jan 16, 2025 at 5:42 AM Hillf Danton <hdanton@sina.com> wrote:
> >
> > This does not work because conn can be freed before bumping refcnt up,
> > and bumpup alone does not help l2cap_send_cmd() in case conn->hchan has been
> > cleared in l2cap_conn_del().
> 
> Well then perhaps we can use hdev lock just to protect l2cap_data:
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 27b4c4a2ba1f..00ef61609d49 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7466,14 +7466,33 @@ static void l2cap_recv_reset(struct l2cap_conn *conn)
>         conn->rx_len = 0;
>  }
> 
> +static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
> +{
> +       BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
> +
> +       if (!kref_get_unless_zero(&c->ref))
> +               return NULL;
> +
> +       return c;
> +}
> +
>  void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  {
> -       struct l2cap_conn *conn = hcon->l2cap_data;
> +       struct l2cap_conn *conn;
>         int len;
> 
> +       /* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
> +       hci_dev_lock(hcon->hdev);
> +
> +       conn = hcon->l2cap_data;
> +
>         if (!conn)
>                 conn = l2cap_conn_add(hcon);
> 
> +       conn = l2cap_conn_hold_unless_zero(conn);
> +
> +       hci_dev_unlock(hcon->hdev);
> +
This does not work either because after releasing lock bumpup alone can
not prevent conn->hchan from being cleared.
