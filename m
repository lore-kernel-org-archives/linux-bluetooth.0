Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/OY8l3h"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2CFAF
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 02:22:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso49623035e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702549346; x=1703154146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fp1d+CKyQPNoIjDNbR+ewORGkHeCCmM/B8Rn1Q/unhg=;
        b=x/OY8l3hWgTzbgSF9DZkun016kxaWvfpKkEJFfRmzgJf5wDJ3WQWtzmljTEkm6eED4
         /ZV1UloZZKhzuDSiYDczAC8xfclltsryt1wV2D/V0iEOdS8K3v97sX9yK9M9Xnl63mfN
         6yq6lVReRZblevsot5/ywa2Njdjkv5QYpQIuqnzXz7OnC1kQT2PzJrE3/HbogiRebMhw
         hbMX9RSKml1kGwqPqHCLqN7ujlLooqnQ7ml475n7RIEB6V727+HzGlwe628WSXsWOHMy
         wf4h0zkJwU2opBvUBW5OC7+rGZ+NsrJrkyElwAeDCcYC9ycNKBECXJ+X3VTSlRP8Cuuk
         JIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702549346; x=1703154146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp1d+CKyQPNoIjDNbR+ewORGkHeCCmM/B8Rn1Q/unhg=;
        b=er7XUqliHdZ4G9d+l4trgvG0sOuye4N2WuMRRLrNpFPAjulCLh7SKDsMGAbOqcu19I
         9UUX9lL8My8N5EgzLL27QompmZD286sGl9VPax7UdDS7Teu7hGIyCThz79Bi+LZLKTCC
         aEre/qfIRA0Y5H3UrsgJiIYosbqQpfZuthX2xfLsPKpCvM3j2xP3ZRD0mjumP+XqrmX2
         X3NfN0IewZg1IM91HSHQ2AeuL2bhzgR5lK9+klYfuOMysmKucT5CgTvqdGseNGVt8HJu
         1biE9lrgVDM8GIZDHMdPvhBnfURIP0PT6+HEAqTu9iqy16tnbh8l7bMGCu0ogBiseByn
         zXYw==
X-Gm-Message-State: AOJu0Yz/V0dk+UtLuc9ACHh69AK41Tx3zDflKTNKAYZ+lTlnr2gaNRBG
	j1lZe5g8Nl1fzGFurtP/BU9gRA==
X-Google-Smtp-Source: AGHT+IGzq9LLPmSNCTgriJpxqSqtep05s898zngmo1cC+R8cZnekkhe4Hua33rmwUJhqwgbzXz1hHw==
X-Received: by 2002:a05:600c:3ca2:b0:40c:50d5:f7a6 with SMTP id bg34-20020a05600c3ca200b0040c50d5f7a6mr2639429wmb.121.1702549345750;
        Thu, 14 Dec 2023 02:22:25 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id fm21-20020a05600c0c1500b0040c03c3289bsm24239700wmb.37.2023.12.14.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:22:25 -0800 (PST)
Date: Thu, 14 Dec 2023 13:22:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jing.cai@mediatek.com
Cc: linux-mediatek@lists.infradead.org, linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: btusb: mediatek: add MediaTek
 devcoredump support
Message-ID: <7c2608ea-1637-40f7-a84b-2e20245c00fc@moroto.mountain>
References: <b915ddee-25fb-4072-b714-e1c97460cefd@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b915ddee-25fb-4072-b714-e1c97460cefd@moroto.mountain>

Ping.  Let me add the bluetooth mailing list as well to see if anyone
knows.

regards,
dan carpenter

On Mon, Jul 03, 2023 at 04:21:32PM +0300, Dan Carpenter wrote:
> Hello Jing Cai,
> 
> The patch 872f8c253cb9: "Bluetooth: btusb: mediatek: add MediaTek
> devcoredump support" from Jun 29, 2023, leads to the following Smatch
> static checker warning:
> 
> 	drivers/bluetooth/btmtk.c:409 btmtk_process_coredump()
> 	error: double free of 'skb'
> 
> drivers/bluetooth/btmtk.c
>    381                  if (err < 0)
>    382                          break;
>    383                  data->cd_info.cnt = 0;
>    384  
>    385                  /* It is supposed coredump can be done within 5 seconds */
>    386                  schedule_delayed_work(&hdev->dump.dump_timeout,
>    387                                        msecs_to_jiffies(5000));
>    388                  fallthrough;
>    389          case HCI_DEVCOREDUMP_ACTIVE:
>    390          default:
>    391                  err = hci_devcd_append(hdev, skb);
> 
> hci_devcd_append() free skb on error
> 
>    392                  if (err < 0)
>    393                          break;
>    394                  data->cd_info.cnt++;
>    395  
>    396                  /* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
>    397                  if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
>    398                      skb->len > sizeof(MTK_COREDUMP_END) &&
>    399                      !memcmp((char *)&skb->data[skb->len - sizeof(MTK_COREDUMP_END)],
>    400                              MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - 1)) {
>    401                          bt_dev_info(hdev, "Mediatek coredump end");
>    402                          hci_devcd_complete(hdev);
>    403                  }
>    404  
>    405                  break;
>    406          }
>    407  
>    408          if (err < 0)
>    409                  kfree_skb(skb);
> 
> double free
> 
>    410  
>    411          return err;
>    412  }
> 
> regards,
> dan carpenter
> 
