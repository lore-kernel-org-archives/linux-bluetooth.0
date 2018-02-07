Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [bug report] missing bounds check reading firmware
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180206125222.GB9445@mwanda>
Date: Wed, 7 Feb 2018 09:39:57 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <04435BCC-1EBD-451F-B733-0924ED3BE895@holtmann.org>
References: <20180206125222.GB9445@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> This looks like it only has a small impact...
> 
> 	drivers/bluetooth/bt3c_cs.c:491 bt3c_load_firmware()
> 	warn: overflowed symbol reused:  'size'
> 
> drivers/bluetooth/bt3c_cs.c
>   467          /* Load */
>   468          while (count) {
>   469                  if (ptr[0] != 'S') {
>   470                          BT_ERR("Bad address in firmware");
>   471                          err = -EFAULT;
>   472                          goto error;
>   473                  }
>   474  
>   475                  memset(b, 0, sizeof(b));
>   476                  memcpy(b, ptr + 2, 2);
>   477                  if (kstrtoul(b, 16, &size) < 0)
>                                             ^^^^
> Smatch marks this as untrusted

can you send us a patch fixing these issues?

Regards

Marcel

