Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BE2690D1;
	Tue, 21 Oct 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084455; cv=pass; b=Nb49Z0wGTFjCkOVpATnDEZEoVG0+OR4v+UfTxdWHGQoq933n41TGEokEvTXoZUxxTvyaRwoGRqW00c0ZZPmEpOxLaMHu4mxJHABU5hxVRIju+hQ91/3a96gJmZMPMkkpIKs5Bz8G9wCoQ9FCifUeiTXK2OLdXobtWz31OQB5BwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084455; c=relaxed/simple;
	bh=z8lTYmn/IjleiyKM3+XordSbBa5Pmo7yUKfsFcwffCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocueWwxy5pzuEIusVKOIJkXRahvqU4KH0H4RIyUuSgjCjYPMB9O+L5MQozwK5xsS5kWap1ePKfgDPMkWEWySeVdFmb6cOkuRJlS4i8WAtlTdfpoCzM/2ROx42Z5ctj2yxTMBbHBDxPU42RGAEUAm5T8Mn/1zANyxtcVBepZftT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Yu/uGOfa; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=nP4cWOwF; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Yu/uGOfa";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="nP4cWOwF"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-qjnz.prod.antispam.mailspamprotection.com; s=arckey; t=1761084453;
	 b=vixKUkUrm6fxCu+uyjiYiCfaJkxaBA3oubjnRi8A+700vZGUvTt943r04p0k+cb1wr6zKEDUH6
	  xYzJDr6nYAvrbNbXdky0YGDKHFWTkOAuh3foUVf5+3OgqMO4nF33K7DPAnNBkEPtKrN9R906Gy
	  6+fHosCcqt3IkZvTKfVLM8N5i5bqBAAoM6260EndDrfmTeK4GPivlI7DLLE39C8vbIGhZIGfgj
	  ++TH+VBtxMrhWaOcBTA5u0qT6yv+2St+j8xteOh0bH/HwBRPefE8ub1UvSFWkzxW714TARDz1u
	  dd95wT0ukf7vV/EBaAghaIIk1jRzEuobj3DKjKYzhau2Yw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-qjnz.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-qjnz.prod.antispam.mailspamprotection.com; s=arckey; t=1761084453;
	bh=z8lTYmn/IjleiyKM3+XordSbBa5Pmo7yUKfsFcwffCg=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=v2U1U1MbBGVfo8LL4/DnmbWP2sHyZGQwplIA1HqEUdq8DtAt6sFK4TgKoeRwM5Tkj1pQ/z8vvB
	  WBefqSwZskohHPgVhkkSVwRykxuMMnPs+g2BA9sDeLPMcdYAU9POP/0Foix9DGGf8Z3t+dLTbg
	  vgTKeyRgGocUCqTXb0FfRC75pS3zqdJXtqARObzpCngW9upYgtk3yyoypBboN0tek3enAUKwTs
	  uAtsTteASTaAwxze5Sq4ybASlJRemALRgGRdzjv2ZzlmisDnmkNu0DkQ87FHRmoc+Dh1Yd991I
	  ul85+1lnjSGXg27MNytMWm4PIUANs2M6uncDgPZBvFCNwg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=EPZOChOksZI5m9+TlSbFkGPQEFsrhm2ZHMS2Z33YhXc=; b=Yu/uGOfaoX5qXm6T447Ff9QzYi
	db+QJbI44qrbOwPKFOhc4gahNvFPOvGUZMW4ma3SQgyEjgRWQD5ZzF2akWi8SlrHUnhdbT9hMmF5W
	eEsVd9tvfEwmO2TaBcnh1m89ltcfSO/J88Rs1MPu24zUa0LSyWJOF9o4TZPXt/BtOdlM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-qjnz.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBKVq-00000005w9w-2xHW;
	Tue, 21 Oct 2025 22:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=EPZOChOksZI5m9+TlSbFkGPQEFsrhm2ZHMS2Z33YhXc=; b=nP4cWOwFctK573Zdz4YS5fQNd4
	XOqvj6fKkRcIAHu7eR6nAAYQC+nJUvegGhE9CIVk1pOvnXI1VvMyikpZH+0lLjkklqkV61PkgL/ys
	gMmynQS6YCEnteF5db1Rm7tMZ9RSNEaMkqhNgDCtGnL5lBDGS1mdgUqmP8MKQxTLF8CE=;
Received: from [95.239.58.48] (port=60623 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBKVa-00000000PRL-4C5j;
	Tue, 21 Oct 2025 22:07:11 +0000
From: Francesco Valla <francesco@valla.it>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a possible
 solution
Date: Wed, 22 Oct 2025 00:07:10 +0200
Message-ID: <2569250.XAFRqVoOGU@fedora.fritz.box>
In-Reply-To: <aPf7Vz5K6P7frdlf@mozart.vkv.me>
References:
 <6837167.ZASKD2KPVS@fedora.fritz.box> <aPf5DZVYrc2YAXXT@mozart.vkv.me>
 <aPf7Vz5K6P7frdlf@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c8993f67c266e8dbc9b7c02c1db19444
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vBKVq-00000005w9w-2xHW-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-qjnz.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Tuesday, 21 October 2025 at 23:29:59 Calvin Owens <calvin@wbinvd.org> wrote:
> On Tuesday 10/21 at 14:20 -0700, Calvin Owens wrote:
> > On Tuesday 10/21 at 22:53 +0200, Francesco Valla wrote:
> > > Hello,
> > > 
> > > while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
> > > Bluetooth chipset from NXP, I encountered an erratic bug during initialization.
> > > 
> > > While the firmware download always completed without errors, subsequent HCI
> > > communication would fail most of the time with:
> > > 
> > >     Frame reassembly failed (-84)
> > > 
> > > After some debug, I found the culprit to be this patch that was integrated as
> > > part of the current (v6.18) cycle:
> > > 
> > >     93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]
> > > 
> > > The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
> > > used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
> > > that the private drvdata for the input struct hci_dev is a pointer to a
> > > struct hci_uart, but that's not the case for the btnxpuart driver. In this
> > > case, the information about padding and alignment are pretty random and
> > > depend on the content of the data that was incorrectly casted as a
> > > struct hci_uart.
> > > 
> > > The bug should impact also the other platforms that were touched by the
> > > same patch. 
> > 
> > Hi Francesco,
> > 
> > Thanks for investigating, this makes sense to me.
> > 
> > Funny enough, I specifically tested this on btnxpuart and saw no
> > problems. I suppose some kconfig difference or some other innocuous
> > patch moved structure fields around such that it triggered for you?
> > Not that it really matters...
> > 
> > > For the time being, I'd then propose to revert the commit.
> > 
> > Adding back all the duplicate code is not the right way forward, IMHO.
> > There must be some way to "mask" the problematic behavior for the
> > drivers which stash the different structure in drvdata, right?
> 
> Actually, the right approach is probably to tweak these drivers to do
> what the Intel driver does:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bluetooth/hci_intel.c#n869
> 
>     static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>     {
>             struct hci_uart *hu = hci_get_drvdata(hdev);
>             struct intel_data *intel = hu->priv;
> 
> I'll spin that up unless I hear better from anyone else :)
>

Hi, thanks for the quick response!

That was my first thought, but the Intel driver actually _uses_ the hci_uart
structure, while btnxpuart and such would only piggy-back on it to be able to
use h4_recv_buf() (and struct hci_uart is huge!).

One possible solution would be to define an "inner" __h4_recv_buf() function
that accepts alignment and padding as arguments, and use that directly on
drivers that don't use struct hci_uart (PoC attached - I don't like the
__h4_recv_buf name but I don't really know how it should be called).

Regards,
Francesco

---

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index d5153fed0518..02511ef1a841 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1756,8 +1756,9 @@ static size_t btnxpuart_receive_buf(struct serdev_device *serdev,
 
        ps_start_timer(nxpdev);
 
-       nxpdev->rx_skb = h4_recv_buf(nxpdev->hdev, nxpdev->rx_skb, data, count,
-                                    nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts));
+       nxpdev->rx_skb = __h4_recv_buf(nxpdev->hdev, nxpdev->rx_skb, data, count,
+                                      nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts),
+                                      0, NULL);
        if (IS_ERR(nxpdev->rx_skb)) {
                int err = PTR_ERR(nxpdev->rx_skb);
                /* Safe to ignore out-of-sync bootloader signatures */
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 9070e31a68bf..c83c266ba506 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -151,27 +151,32 @@ int __exit h4_deinit(void)
        return hci_uart_unregister_proto(&h4p);
 }
 
-struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
-                           const unsigned char *buffer, int count,
-                           const struct h4_recv_pkt *pkts, int pkts_count)
+struct sk_buff *__h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
+                             const unsigned char *buffer, int count,
+                             const struct h4_recv_pkt *pkts, int pkts_count,
+                             u8 alignment, u8 *padding)
 {
-       struct hci_uart *hu = hci_get_drvdata(hdev);
-       u8 alignment = hu->alignment ? hu->alignment : 1;
-
        /* Check for error from previous call */
        if (IS_ERR(skb))
                skb = NULL;
 
+       if (alignment == 0)
+               alignment = 1;
+
+       WARN_ON_ONCE(alignment > 1 && !padding);
+
        while (count) {
                int i, len;
 
                /* remove padding bytes from buffer */
-               for (; hu->padding && count > 0; hu->padding--) {
-                       count--;
-                       buffer++;
+               if (padding) {
+                       for (; *padding && count > 0; *padding = *padding - 1) {
+                               count--;
+                               buffer++;
+                       }
+                       if (!count)
+                               break;
                }
-               if (!count)
-                       break;
 
                if (!skb) {
                        for (i = 0; i < pkts_count; i++) {
@@ -252,16 +257,20 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
                        }
 
                        if (!dlen) {
-                               hu->padding = (skb->len + 1) % alignment;
-                               hu->padding = (alignment - hu->padding) % alignment;
+                               if (padding) {
+                                       *padding = (skb->len + 1) % alignment;
+                                       *padding = (alignment - *padding) % alignment;
+                               }
 
                                /* No more data, complete frame */
                                (&pkts[i])->recv(hdev, skb);
                                skb = NULL;
                        }
                } else {
-                       hu->padding = (skb->len + 1) % alignment;
-                       hu->padding = (alignment - hu->padding) % alignment;
+                       if (padding) {
+                               *padding = (skb->len + 1) % alignment;
+                               *padding = (alignment - *padding) % alignment;
+                       }
 
                        /* Complete frame */
                        (&pkts[i])->recv(hdev, skb);
@@ -271,4 +280,16 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 
        return skb;
 }
+EXPORT_SYMBOL_GPL(__h4_recv_buf);
+
+struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
+                           const unsigned char *buffer, int count,
+                           const struct h4_recv_pkt *pkts, int pkts_count)
+{
+       struct hci_uart *hu = hci_get_drvdata(hdev);
+       u8 alignment = hu->alignment ? hu->alignment : 1;
+
+       return __h4_recv_buf(hdev, skb, buffer, count, pkts, pkts_count,
+                            alignment, &hu->padding);
+}
 EXPORT_SYMBOL_GPL(h4_recv_buf);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index cbbe79b241ce..0b61ee953fa4 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -162,6 +162,11 @@ struct h4_recv_pkt {
 int h4_init(void);
 int h4_deinit(void);
 
+struct sk_buff *__h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
+                             const unsigned char *buffer, int count,
+                             const struct h4_recv_pkt *pkts, int pkts_count,
+                             u8 alignment, u8 *padding);
+
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
                            const unsigned char *buffer, int count,
                            const struct h4_recv_pkt *pkts, int pkts_count);




