Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Jun 2015 01:31:47 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Florian Grandel <fgrandel@gmail.com>
Cc: kbuild-all@01.org, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: [bluetooth:master 42/61] net/bluetooth/hci_core.c:2693:17-24:
 WARNING: kzalloc should be used for adv_instance, instead of kmalloc/memset
Message-ID: <201506190144.UjXTkEfA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   db25be6657a56ba2d68aae1f90d796f527f65689
commit: d2609b345ebf0547015a78588c4d7ad68c9ccf26 [42/61] Bluetooth: hci_core/mgmt: Introduce multi-adv list


coccinelle warnings: (new ones prefixed by >>)

>> net/bluetooth/hci_core.c:2693:17-24: WARNING: kzalloc should be used for adv_instance, instead of kmalloc/memset

vim +2693 net/bluetooth/hci_core.c

  2677				 u16 scan_rsp_len, u8 *scan_rsp_data,
  2678				 u16 timeout, u16 duration)
  2679	{
  2680		struct adv_info *adv_instance;
  2681	
  2682		adv_instance = hci_find_adv_instance(hdev, instance);
  2683		if (adv_instance) {
  2684			memset(adv_instance->adv_data, 0,
  2685			       sizeof(adv_instance->adv_data));
  2686			memset(adv_instance->scan_rsp_data, 0,
  2687			       sizeof(adv_instance->scan_rsp_data));
  2688		} else {
  2689			if (hdev->adv_instance_cnt >= HCI_MAX_ADV_INSTANCES ||
  2690			    instance < 1 || instance > HCI_MAX_ADV_INSTANCES)
  2691				return -EOVERFLOW;
  2692	
> 2693			adv_instance = kmalloc(sizeof(*adv_instance), GFP_KERNEL);
  2694			if (!adv_instance)
  2695				return -ENOMEM;
  2696	
  2697			memset(adv_instance, 0, sizeof(*adv_instance));
  2698			adv_instance->instance = instance;
  2699			list_add(&adv_instance->list, &hdev->adv_instances);
  2700			hdev->adv_instance_cnt++;
  2701		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
