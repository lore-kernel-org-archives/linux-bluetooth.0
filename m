Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 6 Aug 2018 23:42:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: martin.blumenstingl@googlemail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: btrtl: split the device initialization into
 smaller parts
Message-ID: <20180806204257.hqrwgufmu6ukq2sj@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Martin Blumenstingl,

The patch 26503ad25de8: "Bluetooth: btrtl: split the device
initialization into smaller parts" from Aug 2, 2018, leads to the
following static checker warning:

	drivers/bluetooth/btrtl.c:592 btrtl_initialize()
	warn: passing zero to 'ERR_PTR'

drivers/bluetooth/btrtl.c
   559          btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
   560                                            &btrtl_dev->fw_data);
   561          if (btrtl_dev->fw_len < 0) {
   562                  rtl_dev_err(hdev, "firmware file %s not found\n",
   563                              btrtl_dev->ic_info->fw_name);
   564                  ret = btrtl_dev->fw_len;
   565                  goto err_free;
   566          }
   567  
   568          if (btrtl_dev->ic_info->cfg_name) {
   569                  if (postfix) {
   570                          snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
   571                                   btrtl_dev->ic_info->cfg_name, postfix);
   572                  } else {
   573                          snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
   574                                   btrtl_dev->ic_info->cfg_name);
   575                  }
   576                  btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
   577                                                     &btrtl_dev->cfg_data);
   578                  if (btrtl_dev->ic_info->config_needed &&
   579                      btrtl_dev->cfg_len <= 0) {
                            ^^^^^^^^^^^^^^^^^^^^^^^
Assume btrtl_dev->cfg_len == 0

   580                          rtl_dev_err(hdev, "mandatory config file %s not found\n",
   581                                      btrtl_dev->ic_info->cfg_name);
   582                          ret = btrtl_dev->cfg_len;
   583                          goto err_free;
   584                  }
   585          }
   586  
   587          return btrtl_dev;
   588  
   589  err_free:
   590          btrtl_free(btrtl_dev);
   591  err_alloc:
   592          return ERR_PTR(ret);
                               ^^^
Then we would end up returning ERR_PTR(0) which is NULL and would result
in a NULL dereference in the error pointer.

   593  }

regards,
dan carpenter
