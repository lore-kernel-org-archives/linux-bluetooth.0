Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BD2F28F9;
	Wed, 22 Oct 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165371; cv=pass; b=pwbbLNngSM3SiCm/VzuIwt5ZS2Jmas3uLuH4ArKKVRdH9z2i7NmipCokdhrq9xrwe1jlTU32SGGzn0CH6OHHCwPsEcSIYD0y18OOo0cSExtcUDE5cIGAJpOCVUxrL1xtsa+KHBbl/tpcngUB+WF9vy8JZpDlfeA3iyJB/ACoTwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165371; c=relaxed/simple;
	bh=fbsOZjeBYURUQ8AcI4lPHwYdOIM1BWMlppGkd/GOeW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYnxSFJWat+Mx/43XinR3tYu0TV2fnIFmmT9yfpY2TPeBO7LKqOsvSr16c15U8y86DOmjiD93pN7vSRTpmqGMo77JyRJrooZe+k5VUUPbR7KVKtoq1sS832PFaytOyGY/x99q9CTG9pVEwO8CIjWdL4x45CBaQ33YdIc0qy2fBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=x3lly1v+; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=m8vvGjNZ; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="x3lly1v+";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="m8vvGjNZ"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-l4b2.prod.antispam.mailspamprotection.com; s=arckey; t=1761165368;
	 b=oeY5N5kEo494i0J7JyVfXen57GDUnHQRIRqyF83SJMp2iQXmEmao4+IF7Y1yGPC6jstRFnKTPi
	  TIxxdv0JcYqYpEERDr0eJsCdR9sckwiLSAnKnXk2fPeMtdaigDWMVArIGEiJ64YqtiF2Tt4aYv
	  SPP/e3kMELr+uLO/pFl2ELwuafVC/IKjRwQ1TW4jiy8pkdzmReDSZRx4ogl6l5fOHnX56//6Cr
	  vEzd0uxWNcAkx3QP0PXn1mwZ0w42rTVhIKKgGmWKEyQ/vE/11qbnpVm7/iN8R1IbpwfXY8F0V+
	  fzke7aYzorC7Wgfjh6D5czJ+DgWVLT7pJLUuco3vzmNYDA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-l4b2.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-l4b2.prod.antispam.mailspamprotection.com; s=arckey; t=1761165368;
	bh=fbsOZjeBYURUQ8AcI4lPHwYdOIM1BWMlppGkd/GOeW0=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=mGr7pKF0T+6QjyjO5PgtRA0JBqf4zBukBT1oLf7EJInbFjklFe0lQkCidX/mE8PdfMKIepw+c9
	  0LKZxxPariOClz7BDQY9I7okPEJuCUenmJLSthVJM+pAYCGed9fFYvHJ8B9ANNHUrvF6V/pej2
	  z2hqemvzNfasf4ePsHWakfg5MqXhCK13LYxbMVwBWNM0GHYUTxW4I4eIirHSg/8QikCeTC9iYj
	  /CYBT7CV+k+28EqlAkC8YiwscB1AJWp3/lmny8Z8WGii9dhMMB4hGXwFmVLKiRux34s0eZODKN
	  uBIfuQBn//gvMSs9NBFEklWmKaA8WknrT4KJJaVneiXM7w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=lVS4OAOudeNzjAVGx56iDpMXSXUm+qb99UVz5KIYAmw=; b=x3lly1v+lTPlURfMZ4ZZ+kQXGB
	AlRuE9kZ+MKMeRollQoOlYfI2esV+YU4fOJGLDSbAfnttolddNfUj1YWUHdR82VaOvF1Fb7VnwKz/
	K9vRSKbGsncF2jxRFA/Bma0S6LG+0uS6EqdwXuHt1fuSJAMMUIk2ezWGDHbQnvwPiMg8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-l4b2.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBfYr-00000002w5u-1c8s;
	Wed, 22 Oct 2025 20:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=lVS4OAOudeNzjAVGx56iDpMXSXUm+qb99UVz5KIYAmw=; b=m8vvGjNZ4MjKrg1+iQuB5W6+Jt
	XndvmxR5ucuvJv/kO4gbQ+9vFHiCk/QLi2DHWGKaTgnpxc46d1JmPdjrXhw1NYfzXlauRzwpjhxs7
	KXKhzNjyVBegDyBYH1ky0eaPqCn6hF1lgbv1r+38YTMGHdtiC+KcF4/gfLbm9vxppUr0=;
Received: from [95.239.58.48] (port=61520 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBfYa-00000000D8T-1f1i;
	Wed, 22 Oct 2025 20:35:40 +0000
From: Francesco Valla <francesco@valla.it>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [BUG] Erratic behavior in btnxpuart on v6.18-rc2 - and a possible
 solution
Date: Wed, 22 Oct 2025 22:35:36 +0200
Message-ID: <1982590.7Z3S40VBb9@fedora.fritz.box>
In-Reply-To: <aPkCZ8l4-5ffyiAe@mozart.vkv.me>
References:
 <6837167.ZASKD2KPVS@fedora.fritz.box> <2569250.XAFRqVoOGU@fedora.fritz.box>
 <aPkCZ8l4-5ffyiAe@mozart.vkv.me>
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
X-SGantispam-id: a32a237380d66adf6c0adef78a170338
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vBfYr-00000002w5u-1c8s-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-l4b2.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Wednesday, 22 October 2025 at 18:12:23 Calvin Owens <calvin@wbinvd.org> wrote:
> On Wednesday 10/22 at 00:07 +0200, Francesco Valla wrote:
> > On Tuesday, 21 October 2025 at 23:29:59 Calvin Owens <calvin@wbinvd.org> wrote:
> > > On Tuesday 10/21 at 14:20 -0700, Calvin Owens wrote:
> > > > On Tuesday 10/21 at 22:53 +0200, Francesco Valla wrote:
> > > > > Hello,
> > > > > 
> > > > > while testing Bluetooth on my NXP i.MX93 FRDM, which is equipped with an IW612
> > > > > Bluetooth chipset from NXP, I encountered an erratic bug during initialization.
> > > > > 
> > > > > While the firmware download always completed without errors, subsequent HCI
> > > > > communication would fail most of the time with:
> > > > > 
> > > > >     Frame reassembly failed (-84)
> > > > > 
> > > > > After some debug, I found the culprit to be this patch that was integrated as
> > > > > part of the current (v6.18) cycle:
> > > > > 
> > > > >     93f06f8f0daf Bluetooth: remove duplicate h4_recv_buf() in header [1]
> > > > > 
> > > > > The reason is simple: the h4_recv_buf() function from hci_h4.c, which is now
> > > > > used instead the "duplicated" one in the (now removed) h4_recv_buf.h, assumes
> > > > > that the private drvdata for the input struct hci_dev is a pointer to a
> > > > > struct hci_uart, but that's not the case for the btnxpuart driver. In this
> > > > > case, the information about padding and alignment are pretty random and
> > > > > depend on the content of the data that was incorrectly casted as a
> > > > > struct hci_uart.
> > > > > 
> > > > > The bug should impact also the other platforms that were touched by the
> > > > > same patch. 
> > > > 
> > > > Hi Francesco,
> > > > 
> > > > Thanks for investigating, this makes sense to me.
> > > > 
> > > > Funny enough, I specifically tested this on btnxpuart and saw no
> > > > problems. I suppose some kconfig difference or some other innocuous
> > > > patch moved structure fields around such that it triggered for you?
> > > > Not that it really matters...
> > > > 
> > > > > For the time being, I'd then propose to revert the commit.
> > > > 
> > > > Adding back all the duplicate code is not the right way forward, IMHO.
> > > > There must be some way to "mask" the problematic behavior for the
> > > > drivers which stash the different structure in drvdata, right?
> > > 
> > > Actually, the right approach is probably to tweak these drivers to do
> > > what the Intel driver does:
> > > 
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bluetooth/hci_intel.c#n869
> > > 
> > >     static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> > >     {
> > >             struct hci_uart *hu = hci_get_drvdata(hdev);
> > >             struct intel_data *intel = hu->priv;
> > > 
> > > I'll spin that up unless I hear better from anyone else :)
> > >
> > 
> > Hi, thanks for the quick response!
> > 
> > That was my first thought, but the Intel driver actually _uses_ the hci_uart
> > structure, while btnxpuart and such would only piggy-back on it to be able to
> > use h4_recv_buf() (and struct hci_uart is huge!).
> 
> Why is that a problem? Certainly, nobody is going to mind the extra
> bytes with that monstrosity hanging around :)
> 

You have a point there.

> > One possible solution would be to define an "inner" __h4_recv_buf() function
> > that accepts alignment and padding as arguments, and use that directly on
> > drivers that don't use struct hci_uart (PoC attached - I don't like the
> > __h4_recv_buf name but I don't really know how it should be called).
> 
> I don't feel super strongly about it, but IMHO the whole thing is easier
> to understand if we just put the data the core function expects where it
> expects it. I haven't had enough coffee yet, but I think
> zero-initializing hu is sufficient...
> 
> Something like this, only compile tested:
> ---8<---
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [PATCH] Working bugfix for bt cleanup, only for btnxpuart for now
> 
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/bluetooth/btnxpuart.c | 74 +++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index d5153fed0518..cf464515c855 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -212,6 +212,7 @@ struct btnxpuart_dev {
>  	struct ps_data psdata;
>  	struct btnxpuart_data *nxp_data;
>  	struct reset_control *pdn;
> +	struct hci_uart hu;
>  };
>  
>  #define NXP_V1_FW_REQ_PKT	0xa5
> @@ -363,6 +364,12 @@ union nxp_set_bd_addr_payload {
>  
>  static u8 crc8_table[CRC8_TABLE_SIZE];
>  
> +static struct btnxpuart_dev *hci_get_nxpdev(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	return hu->priv;
> +}
> +
>  /* Default configurations */
>  #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
>  #define DEFAULT_PS_MODE		PS_MODE_ENABLE
> @@ -373,7 +380,7 @@ static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
>  					void *param,
>  					bool resp)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	struct sk_buff *skb = NULL;
>  
> @@ -426,7 +433,7 @@ static void ps_cancel_timer(struct btnxpuart_dev *nxpdev)
>  
>  static void ps_control(struct hci_dev *hdev, u8 ps_state)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	int status = 0;
>  
> @@ -483,7 +490,7 @@ static void ps_timeout_func(struct timer_list *t)
>  {
>  	struct ps_data *data = timer_container_of(data, t, ps_timer);
>  	struct hci_dev *hdev = data->hdev;
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  
>  	if (test_bit(BTNXPUART_TX_STATE_ACTIVE, &nxpdev->tx_state)) {
>  		ps_start_timer(nxpdev);
> @@ -502,7 +509,7 @@ static irqreturn_t ps_host_wakeup_irq_handler(int irq, void *priv)
>  }
>  static int ps_setup(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct serdev_device *serdev = nxpdev->serdev;
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	int ret;
> @@ -597,7 +604,7 @@ static void ps_cleanup(struct btnxpuart_dev *nxpdev)
>  
>  static int send_ps_cmd(struct hci_dev *hdev, void *data)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	struct psmode_cmd_payload pcmd;
>  	struct sk_buff *skb;
> @@ -636,7 +643,7 @@ static int send_ps_cmd(struct hci_dev *hdev, void *data)
>  
>  static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	struct wakeup_cmd_payload pcmd;
>  	struct sk_buff *skb;
> @@ -682,7 +689,7 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
>  
>  static void ps_init(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	u8 default_h2c_wakeup_mode = DEFAULT_H2C_WAKEUP_MODE;
>  
> @@ -732,7 +739,7 @@ static void ps_init(struct hci_dev *hdev)
>  /* NXP Firmware Download Feature */
>  static int nxp_download_firmware(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	int err = 0;
>  
>  	nxpdev->fw_dnld_v1_offset = 0;
> @@ -782,7 +789,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
>  
>  static void nxp_send_ack(u8 ack, struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	u8 ack_nak[2];
>  	int len = 1;
>  
> @@ -796,7 +803,7 @@ static void nxp_send_ack(u8 ack, struct hci_dev *hdev)
>  
>  static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct nxp_bootloader_cmd nxp_cmd5;
>  	struct uart_config uart_config;
>  	u32 clkdivaddr = CLKDIVADDR - nxpdev->boot_reg_offset;
> @@ -846,7 +853,7 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
>  
>  static bool nxp_fw_change_timeout(struct hci_dev *hdev, u16 req_len)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct nxp_bootloader_cmd nxp_cmd7;
>  
>  	if (req_len != sizeof(nxp_cmd7))
> @@ -899,7 +906,7 @@ static bool process_boot_signature(struct btnxpuart_dev *nxpdev)
>  static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name,
>  				const char *fw_name_old)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	const char *fw_name_dt;
>  	int err = 0;
>  
> @@ -931,7 +938,7 @@ static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name,
>  /* for legacy chipsets with V1 bootloader */
>  static int nxp_recv_chip_ver_v1(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct v1_start_ind *req;
>  	__u16 chip_id;
>  
> @@ -956,7 +963,7 @@ static int nxp_recv_chip_ver_v1(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct btnxpuart_data *nxp_data = nxpdev->nxp_data;
>  	struct v1_data_req *req;
>  	__u16 len;
> @@ -1065,7 +1072,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
>  static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
>  					 u8 loader_ver)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	char *fw_name = NULL;
>  
>  	switch (chipid) {
> @@ -1139,7 +1146,7 @@ static char *nxp_get_old_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid,
>  static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	struct v3_start_ind *req = skb_pull_data(skb, sizeof(*req));
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	const char *fw_name;
>  	const char *fw_name_old;
>  	u16 chip_id;
> @@ -1163,7 +1170,7 @@ static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_req *req)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	__u32 offset = __le32_to_cpu(req->offset);
>  	__u16 err = __le16_to_cpu(req->error);
>  	union nxp_v3_rx_timeout_nak_u timeout_nak_buf;
> @@ -1191,7 +1198,7 @@ static void nxp_handle_fw_download_error(struct hci_dev *hdev, struct v3_data_re
>  
>  static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct v3_data_req *req;
>  	__u16 len = 0;
>  	__u16 err = 0;
> @@ -1277,7 +1284,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	__le32 new_baudrate = __cpu_to_le32(nxpdev->new_baudrate);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	struct sk_buff *skb;
> @@ -1362,7 +1369,7 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
>  	struct hci_acl_hdr *acl_hdr = (struct hci_acl_hdr *)skb_pull_data(skb,
>  									  sizeof(*acl_hdr));
>  	struct nxp_fw_dump_hdr *fw_dump_hdr = (struct nxp_fw_dump_hdr *)skb->data;
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	__u16 seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
>  	__u16 buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
>  	int err;
> @@ -1439,7 +1446,7 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  /* NXP protocol */
>  static int nxp_setup(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct serdev_device *serdev = nxpdev->serdev;
>  	char device_string[30];
>  	char event_string[50];
> @@ -1475,7 +1482,7 @@ static int nxp_setup(struct hci_dev *hdev)
>  
>  static int nxp_post_init(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  
>  	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
> @@ -1491,7 +1498,7 @@ static int nxp_post_init(struct hci_dev *hdev)
>  
>  static void nxp_hw_err(struct hci_dev *hdev, u8 code)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  
>  	switch (code) {
>  	case BTNXPUART_IR_HW_ERR:
> @@ -1505,7 +1512,7 @@ static void nxp_hw_err(struct hci_dev *hdev, u8 code)
>  
>  static int nxp_shutdown(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct sk_buff *skb;
>  	u8 pcmd = 0;
>  
> @@ -1529,7 +1536,7 @@ static int nxp_shutdown(struct hci_dev *hdev)
>  
>  static bool nxp_wakeup(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  
>  	if (psdata->c2h_wakeupmode != BT_HOST_WAKEUP_METHOD_NONE)
> @@ -1540,7 +1547,7 @@ static bool nxp_wakeup(struct hci_dev *hdev)
>  
>  static void nxp_reset(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  
>  	if (!ind_reset_in_progress(nxpdev) && !fw_dump_in_progress(nxpdev)) {
>  		bt_dev_dbg(hdev, "CMD Timeout detected. Resetting.");
> @@ -1550,7 +1557,7 @@ static void nxp_reset(struct hci_dev *hdev)
>  
>  static int btnxpuart_queue_skb(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  
>  	/* Prepend skb with frame type */
>  	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> @@ -1561,7 +1568,7 @@ static int btnxpuart_queue_skb(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct ps_data *psdata = &nxpdev->psdata;
>  	struct hci_command_hdr *hdr;
>  	struct psmode_cmd_payload ps_parm;
> @@ -1693,7 +1700,7 @@ static void btnxpuart_tx_work(struct work_struct *work)
>  
>  static int btnxpuart_open(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	int err = 0;
>  
>  	err = serdev_device_open(nxpdev->serdev);
> @@ -1708,7 +1715,7 @@ static int btnxpuart_open(struct hci_dev *hdev)
>  
>  static int btnxpuart_close(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  
>  	serdev_device_close(nxpdev->serdev);
>  	skb_queue_purge(&nxpdev->txq);
> @@ -1722,7 +1729,7 @@ static int btnxpuart_close(struct hci_dev *hdev)
>  
>  static int btnxpuart_flush(struct hci_dev *hdev)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  
>  	/* Flush any pending characters */
>  	serdev_device_write_flush(nxpdev->serdev);
> @@ -1784,7 +1791,7 @@ static const struct serdev_device_ops btnxpuart_client_ops = {
>  
>  static void nxp_coredump_notify(struct hci_dev *hdev, int state)
>  {
> -	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	struct btnxpuart_dev *nxpdev = hci_get_nxpdev(hdev);
>  	struct serdev_device *serdev = nxpdev->serdev;
>  	char device_string[30];
>  	char event_string[50];
> @@ -1877,7 +1884,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  	nxpdev->hdev = hdev;
>  
>  	hdev->bus = HCI_UART;
> -	hci_set_drvdata(hdev, nxpdev);
> +	hci_set_drvdata(hdev, &nxpdev->hu);
> +	nxpdev->hu.priv = nxpdev;
>  
>  	hdev->manufacturer = MANUFACTURER_NXP;
>  	hdev->open  = btnxpuart_open;
> 

I tested this on my i.MX93 FRDM and I confirm it's working. Can't say that I
like it, but...

Regards,
Francesco



