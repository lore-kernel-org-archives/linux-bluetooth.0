Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BAA1527B4;
	Thu,  3 Oct 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973964; cv=none; b=mrEDAYiS6/gv+J8/mX4+9/WiQnj/u0RSFsbG2s3f9HPrT2q2FdRk2v3B96k+gr4kq9ZBdQOsCCIv8UJdqX4iLshUoafrxMLj2E4qeIRC8f4SZk6+gsPO2uhc2/+eHsGhjhKhKJNLMyPpgodTj+4ls9QxXl/ccNbwDm9LjIt9AIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973964; c=relaxed/simple;
	bh=TT5hyo8P9xB4I74Z99Xi7KjdTLVHYZ/Ow0Q856OZbOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL020/NLDIGO1kXTjKxvBOZSnYxLcpqZRypSpgSHdqJduXZkEM7v3D19ysxYOeWx40x7ikTlHxUe3+oO/PLP/Is77EpvwSbjUiMwy8f7GfM9DVV0Cqu6SbbVQriUHQ0JFm7TRuptQQaOhERmM9ImJZLp308esQ4Uu0vlPGcKF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RyoQ5qxw; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RyoQ5qxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=y7bZ/ZoDlTNd7MJdssOu3Ri2ZdMJ22HYsJD2RsYxNo0=;
	b=RyoQ5qxwZcmPO1TgqMaxhR/ks+gTW0X5y3dqN5dhTPtB7JHUdrmAdpkoislc6d
	kziQ5Rc+dne4jw7pY77BncyriQFeNwFi0IHtX4boiseanqPnk9ElsZePRzsw6qKq
	RDOSGxIJHeX+QeFnOWnj3D2n/8+KS/m43Rygbutda6OVw=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD33wQ6yv5mJOQ9Aw--.10151S2;
	Fri, 04 Oct 2024 00:45:46 +0800 (CST)
Date: Fri, 4 Oct 2024 00:45:46 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 set_powered_sync
Message-ID: <Zv7KOuMKKHrLTvfw@fedora>
References: <Zv67JUPfzgQp7Kgf@fedora>
 <66fec4aa.050a0220.9ec68.004b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fec4aa.050a0220.9ec68.004b.GAE@google.com>
X-CM-TRANSID:_____wD33wQ6yv5mJOQ9Aw--.10151S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW5uF1UKF43Kw47Cr18Grg_yoWDAFg_uw
	1Yva4fGrWUXFy5JF42grZrur4fAFnxKr1xWw1SqFWUWas8Ga1UJr4UXFn3Zr13uas7AF17
	CrsxCFyfXw48KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRknY3UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRBtamb+xz0hDwAAse

#syz test

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5533e6f561b3..20d0793d3832 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -325,9 +325,11 @@ static void hci_cmd_sync_work(struct work_struct *work)
 			int err;
 
 			hci_req_sync_lock(hdev);
-			err = entry->func(hdev, entry->data);
-			if (entry->destroy)
-				entry->destroy(hdev, entry->data, err);
+			if (entry->data) {
+				err = entry->func(hdev, entry->data);
+				if (entry->destroy)
+					entry->destroy(hdev, entry->data, err);
+			}
 			hci_req_sync_unlock(hdev);
 		}
 
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 0115f783bde8..eccc51bfaf2e 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -307,6 +307,7 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
 	sock_put(cmd->sk);
 	kfree(cmd->param);
 	kfree(cmd);
+	cmd = NULL;
 }
 
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)

-- 
Best,
Qianqiang Liu

