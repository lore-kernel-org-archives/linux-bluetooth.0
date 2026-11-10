Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285003;
	b=HJAgqWyYk5g3e+Iz5LIVK0XrBgLLorGHWXbXKz1Bf+qvMusEB6XElOYAUpdO2KsOXRV2
	 JlSsnZFfP50DRclXzxoQPY+Kn+JyPmqj/Xb/1hu6VAGEs7VOE9Z0ZiN3O8INniclXoBY3
	 L6iQN18qQ63hYN8Z+5+yF3GkAKHL03O66Z06TxT0LnPUXV7iEzZxG/2Dxf4Fqn5SD0P0K
	 DGaOIe5TYZC//vFPlR14Ns5CLDMovsHcCKDYkFFlD8LddOHpm+IASd5jBJfTgyPjugkZW
	 xD0HYGPYVyWAb8vMkyRcvMjJpEgVyawpQ2KHx7WOmMYFf58VBbra+lml3YB1/IFvPtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6C4Hx+d91lAlBeJL9YUS6/bLXYWsvtNC9yUrV7CQ+/A=;
	b=ZSmvT60479E+rkzad3yTYuSjyizvHOMj13LX/3UiXdqnr/tqt4ogYPwPBvPRI4Aexb9u
	 DWglG9ubzfcnkmUwDH/sFNmf15OI+HR+bKEKE6/gnMPwT5UsBnp0QJa3GQiOXHqHd2Chg
	 9VWQWCvVb9OLf1z4kay1KwisGQgr/Wg/JtuWsJjhJEICH8guH3+3lYDamJ1m64zx2X04o
	 4Hq/dAy3jBgOvVuA/u2T6MR2nDeuZuopKmPhUf01/l4hMWBq1fRqTuglNrlU3wdfYQBW/
	 lKacgWqDnJZ6sCAAX4t1SkJMVAiMbKHtEedyBmPc4BJYFz2yoN0Z1PEuL095A/dReKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKMimoi2;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E7606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 04:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 989E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKMimoi2
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53639b8903bso20606791cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 20:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285001; x=1794889801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6C4Hx+d91lAlBeJL9YUS6/bLXYWsvtNC9yUrV7CQ+/A=;
        b=qKMimoi2WwX+SyhMQxEZ/A8E7WOVc4jK6OM/paMrW9cxqwQKtdUaEzopcFxUdfmjoo
         yNLSNWzb/qnzfuGpBNJvSS/7kSCxqaZZmiYJik80BFqptkdukXkK6DnKieeMGzXc9Uho
         ncHtTawsMd0nkoIbZYzF8YPxsenWvUQBoHxzoPs+fl6RaSErbHyTJJ55X6xqg6qx9fg1
         7ZJSULe3zJA5/0h55py4WiBqqLjw6hgVYXV0dOeS1N1myr/g0HxiaIAQulMcJayJiG3u
         3P82hnMrO4nYgQ6bwtIyhW+mzgAHh6Ep4TNWqd4egv+suOX/k02bJABGnTrX4d+Jb45R
         49bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285001; x=1794889801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6C4Hx+d91lAlBeJL9YUS6/bLXYWsvtNC9yUrV7CQ+/A=;
        b=FTvgja6n9zMqsmbOoReZKNifeY9RuFyBd6DOqOHImMxVv3MoaAcoZASkNI0KL4ZfZ8
         5xVrS4qQ7aXvTBxJIGTJHwYpv+72QVT3AF4c0ozmqRJhhPadPe8Po78Yl12aAV62p4O4
         UwlWLanu3mnRZLAoKJ9uPr5sdr7m/b5lwWNFIahZOsJ1tALpmevBd3i7rvSThOFxmCsR
         sWber4X1FcXD6cUUEuLoe4+NHYpVXBtzmuov8rNevBVjBUqcfu93CxixS3dUWvgq4AOZ
         KIdX6OpgBDkUiazR1I+iF03TfVvqdV5DSuzo08R7aPxaPkfIo9cZnjKzcbAClQe5PWTa
         w7+Q==
X-Gm-Message-State: APuU4Z/RjFFugxzgdboHyPE1C0tMg8NM4risOdJ1JMBv3NqjpGtW4EVX
	RBadHNuGlKa8EQIENyam4uzDKdhkUT8tE/mxw8T4CrHBRn/ySjQLFuo=
X-Gm-Gg: AYBFou0Q9d0IvCzHaDBI47xBxSxVvuxD6n3LujQHysPBgLdI4F1DDQNQfp6B1afne4W
	olX7NNJIPJxJGoWkaQ6rRS3NAZw1ybp5nbWBqkLqJcbAKAt+Qey2s4HxNbubLTN5mg9TpJbiZSh
	LLe9hlrUKuIpD0x0l2t5fWgvf7fKnYb67+Zwoq0SCh+9C+5a4lUMD/HdjtXhv4nGoakVD5F8aOh
	xRSllsjxkzFWxH4NAP+H7y9G7WvMxm4sgcjRE8Dj+vZGArClWvuGJHMJA6TRf4EL4t/EFOWrLu+
	4geIYcMTLkloEzKGlUwR+CUzRRDzyPD/6MJEXQYkBm2jxgsrcG9SogiT6rD1CW1wfwDOWiWJ8VB
	f/Pfu5N4tO+TtMrd81cbVv89MdxKazaA5iBvgyN+7quhG+B4z+dyv12RV34WbgRFRk8SvRX11fb
	Ll45DsHvQHQSmsq92ToC5yPFSf3c6DE2lR3+BI1HK3Nf5qvYqw/tqlPhShQpFKvV1gkYDBsC1Ub
	QPyKP4+vR2+1dHPClrB1TcUa9sNG1q74IyR04124b4LH1LAUhIbHhGsOQzkem+xiyxq/qJwTpuG
	lJ8hz+EpcgPKAAT25Uk6c31OvZ55dN+SClqBl+hBhdtHyoizQznPeyxs7VKBcLZwBHhmDlnWxr5
	1yZPrRmKjyzfy2vjvVlYqytCGOS/NGbu1NbEzI3EI5kNRtjotixroIvfj6JO1bjpZ
X-Received: by 2002:a05:622a:1e11:b0:547:d087:543d with SMTP id d75a77b69052e-5551667e38cmr23347151cf.3.1794285001514;
        Mon, 09 Nov 2026 20:30:01 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555065e4ad7sm14643351cf.0.2026.11.09.20.30.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:00 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] Bluetooth: btsdio: disable the TX work on removal
Date: Mon,  9 Nov 2026 23:29:59 -0500
Message-ID: <20261110042959.56583-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btsdio_remove() cancels data->work before hci_unregister_dev() stops
the HCI command and TX workers. They can still call btsdio_send_frame()
and queue it again, allowing it to run after hci_free_dev() or release
of the devm-allocated driver data.

Use disable_work_sync() to drain the work and reject later queueing.
Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: 73f7b171b7c0 ("Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/bluetooth/btsdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index a194fc85abfb..680965e74bcc 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -350,7 +350,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
-	cancel_work_sync(&data->work);
+	disable_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

