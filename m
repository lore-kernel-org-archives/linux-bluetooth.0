Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E7C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F6E610C8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbhIBPd5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 11:33:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50741 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345811AbhIBPd4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 11:33:56 -0400
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 182FWpif084576;
        Fri, 3 Sep 2021 00:32:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 03 Sep 2021 00:32:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 182FWoM0084564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Sep 2021 00:32:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Help needed in patching CVE-2021-3640
To:     LinMa <linma@zju.edu.cn>, linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <15f5a46.b79d9.17ba6802ccd.Coremail.linma@zju.edu.cn>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c998d16d-f45a-8be4-2898-9e94509cb2ea@i-love.sakura.ne.jp>
Date:   Fri, 3 Sep 2021 00:32:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <15f5a46.b79d9.17ba6802ccd.Coremail.linma@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2021/09/02 21:33, LinMa wrote:
> Hello there,
> 
> There is one bug (CVE-2021-3640: https://www.openwall.com/lists/oss-security/2021/07/22/1) that is similar to the recently fixed CVE-2021-3573.
> 
> The key point here is that the sco_conn_del() function can be called when syscalls like sco_sendmsg() is undergoing.

Since hdev->lock is held when sco_conn_del() is called,

 3 locks held by poc/6686:
  #0: ffff8880158690e0 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close+0x44/0x6a0 [bluetooth]
  #1: ffff888015868080 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_do_close+0x1ac/0x6a0 [bluetooth]
  #2: ffffffffa0630030 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_hash_flush+0x6f/0x140 [bluetooth]

I guess that holding hdev->lock when sco_send_frame() is called would avoid use-after-free.

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d9a4e88dacbb..f5339bfba4a5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -727,10 +727,17 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
-	if (sk->sk_state == BT_CONNECTED)
-		err = sco_send_frame(sk, msg, len);
-	else
-		err = -ENOTCONN;
+	err = -ENOTCONN;
+	if (sk->sk_state == BT_CONNECTED) {
+		struct hci_dev *hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+
+		if (hdev) {
+			hci_dev_lock(hdev);
+			err = sco_send_frame(sk, msg, len);
+			hci_dev_unlock(hdev);
+			hci_dev_put(hdev);
+		}
+	}
 
 	release_sock(sk);
 	return err;

But I'm not happy with calling hci_get_route() every time.
Can we cache the hdev found upon sco_connect() ?
