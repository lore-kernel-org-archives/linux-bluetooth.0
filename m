Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAF2EFD9B
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789794430; cv=none; b=vDQ3RK0t8J7XqGQBr+AjHXY6u0qDq6RleoPgc+p4Itp6zcIZsld9ZU1M2NzvXQswZ52jutn1CGbb0L1ZTBXDZqcQjoRkqt4WAkZG1u1rD7Nrgmu5d+NeFoQYF/M2EkglV9DhoMrtI6nZQwVoAnYOiiOyG5oiUtb9n4/UCPsP2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789794430; c=relaxed/simple;
	bh=1lJFp65dyucxfTRthu86KzEdmgUdsIZ+ilUtY/4kcsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSsdSkVsVdIoDUvFymgmkIQTx8rdZRL/gppWOAdUSkRMekGY9qjhapmF3CKZA52cwHZheaOQVpBBiA3L/3BbF313Bk39dGtiIA6OK9Vji6Awm7MVCvf0HdkCvWrQCMom/6UxP6KdXlxBPH1kK/KQqmQtt0cLRYy9vOMSDnvOQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKhy+iFy; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKhy+iFy"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so5319395e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789794427; x=1790399227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mg9dmCDO5JoQUdIolTVLs/Eijss7UmXUTE6zrnoHluI=;
        b=UKhy+iFyst7HRbiF11uP1Go0I4I4O9nhSQdE9QPzfZzja0Qi4v56yC0YJUCJOWjrBR
         Vixutw+UHh2sugjqOpE4vxzmBHDaN6qGkV9ZuEiab5zuhQagAme01gGRGpN+55lXyREX
         aSUv3kX7Fjzxl1n59nM2PoRYWHUzqJC+HhWkpV1ZnzlDN5DzXhKyLbzXNKisMu4TKFTw
         ETNlzfPlvCapzlWX18VNFs4crMbpKtRZlJQYZtfICGRgZ5VJP0DTahwLrxaIhFuVqtGG
         5hOvPUSiyrXVPtTjrhMSNAa00AsSr5c/sMZDPpqa6+7QDjU4k4+7iBABVYqUCAYthjeY
         9vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789794427; x=1790399227;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mg9dmCDO5JoQUdIolTVLs/Eijss7UmXUTE6zrnoHluI=;
        b=HAbw9ZBtsUxay4gibcAMCtEIu06zUqmGVzpW11NuImVyANoiCXJFXg5hUNtOkbyHHg
         eYiyCSm5OHi8HNr4feiF3yCs/Ej8UFF3r5Cro7ONBS0jz+b1uWLw5hIYUGk0k2WZFTqU
         RH+j6Jd5iUkKSZid+aIAO4bd9wDqoj7ZUMC1KD+74LP40Hx5AGNKv/wF9wz1kQwrIJmr
         OGbla8/eiRhnDMJ6qjqZ+nx1JqMzG1wSSSjx6yOFTBZMmaNfaR0krWAjCd5Ec2XPA3hO
         ZrHERoGvam436o3cmSwSRJLFGGcpasNimTEx6QhtK8E7+H4IBvTHf0WkgKWMsgf1mflV
         aKnw==
X-Gm-Message-State: AFuF++nNIKt9Q87lo+b00lCFm+2IIxw/+VgsQuM2KcRL7qtOuOMscVFg
	aG+7RruB8z8ABGfwb1WtNjhVFMPKgDXx9Ts3Ye2tsuhqXnK9yViIMHQ4
X-Gm-Gg: AYBFou1I419yTlOfm2ECynlqRURk24n6QCCMCfyNYGQUd7w55hBsJYxeskTF2vqce1i
	dG25AzfLZZkWP8a5o9hZLYGJkl7GKUdVgVl+EpQETwEJPfBYBYSL3My/Jn2pRNJXpvlEcoFdpVr
	tGXxhC/6n1qgAbhXuNNNrFwpUxxP0h4irYH6++foq/vdFaQB2FZ9k1ULf834Ipj76QcuiNbbHfJ
	rFt6t26CBsqXg6sqX68AyW8Av4mJ91uDNHPS1YJrTlTuMjADeyfK3yTn18B3HERHNOH7OuA2ma6
	z1hSylrpxqPBXFkvIOXwLX9Oom5Ae8rPkod/5qqlVvfE/6nCJe38ExwdgJ3G9P2YXDOE3er84nj
	6QKzlLXGw5Ik45DanJiP2DqNKn6u0+kQrTmdbtCTM4bPZudQjTY+9fgDJd5BoWhzYfsbHN9RC2S
	pFGXQGQkkOV9oAm6rMXIVVcA/dfK423AWn3iq0D9CISSt2yrw7XrabcN3HbPoWDzcIzPs=
X-Received: by 2002:a05:600c:1990:b0:49f:c1fd:60e1 with SMTP id 5b1f17b1804b1-49fc500c5c8mr72628455e9.15.1789794426476;
        Fri, 18 Sep 2026 22:07:06 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd115d78sm42377075e9.14.2026.09.18.22.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 22:07:05 -0700 (PDT)
Date: Sat, 19 Sep 2026 08:07:01 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
Message-ID: <aq4YdQS3RhUEIm9z@stanley.mountain>
References: <aqw8ShHyjdZhPc4U@stanley.mountain>
 <aqw8zNc6tXeaNPNV@stanley.mountain>
 <74e197ab-7bb7-46c8-9485-70ba64b4b552@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e197ab-7bb7-46c8-9485-70ba64b4b552@oss.qualcomm.com>

On Sat, Sep 19, 2026 at 10:36:37AM +0800, Zijun Hu wrote:
> On 9/18/2026 3:17 AM, Dan Carpenter wrote:
> > See also:
> > 
> > drivers/bluetooth/btusb_qcom.c:2931 btusb_qcom_shutdown_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> > drivers/bluetooth/btusb_qcom.c:2947 btusb_qcom_shutdown_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> > drivers/bluetooth/btusb_qcom.c:3562 btusb_post_download_unified_bt() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> > drivers/bluetooth/btusb_qcom.c:3977 btusb_qcom_setup_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> 
> Thanks for the report.
> 
> But All reported cases are false positives: __hci_reset_sync() always returns
> 0 or a negative errno, *never* a positive value.

The return values come from here.

net/bluetooth/hci_sync.c
   256  int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
   257                               const void *param, u8 event, u32 timeout,
   258                               struct sock *sk)
   259  {
   260          struct sk_buff *skb;
   261          u8 status;
   262  
   263          skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
   264  
   265          /* If command return a status event, skb will be set to -ENODATA */
   266          if (skb == ERR_PTR(-ENODATA))
   267                  return 0;
                        ^^^^^^^^

Zero, sure.

   268  
   269          if (IS_ERR(skb)) {
   270                  if (!event)
   271                          bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
   272                                     PTR_ERR(skb));
   273                  return PTR_ERR(skb);
                        ^^^^^^^^^^^^^^^^^^^
Error pointer.  Fine.

   274          }
   275  
   276          status = skb->data[0];
   277  
   278          kfree_skb(skb);
   279  
   280          return status;
                ^^^^^^^^^^^^^
But this seems like it could be a positive...

   281  }

regards,
dan carpenter

