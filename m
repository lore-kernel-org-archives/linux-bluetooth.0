Return-Path: <cyrus@holtmann.org>
Date: Fri, 09 Nov 2012 19:28:32 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [bluetooth:master 60/61] net/bluetooth/hci_core.c:683:19: sparse: incorrect type in assignment (different base types)
Message-ID: <509ce8e0.fhFHxG5k0tIvGjwr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   108777e09bbe7874dc5224173a1e3f3ee4ac6471
commit: c82263e2cfbf6d5c030d0e424ecc91402910e46e [60/61] Bluetooth: Add support for setting LE advertising data


sparse warnings:

+ net/bluetooth/hci_core.c:683:19: sparse: incorrect type in assignment (different base types)
net/bluetooth/hci_core.c:683:19:    expected unsigned char [unsigned] [addressable] [usertype] length
net/bluetooth/hci_core.c:683:19:    got restricted __le16 [usertype] <noident>

vim +683 net/bluetooth/hci_core.c

c82263e2 Johan Hedberg 2012-11-08  667  		goto unlock;
c82263e2 Johan Hedberg 2012-11-08  668  	}
c82263e2 Johan Hedberg 2012-11-08  669  
c82263e2 Johan Hedberg 2012-11-08  670  	memset(&cp, 0, sizeof(cp));
c82263e2 Johan Hedberg 2012-11-08  671  
c82263e2 Johan Hedberg 2012-11-08  672  	len = create_ad(hdev, cp.data);
c82263e2 Johan Hedberg 2012-11-08  673  
c82263e2 Johan Hedberg 2012-11-08  674  	if (hdev->adv_data_len == len &&
c82263e2 Johan Hedberg 2012-11-08  675  	    memcmp(cp.data, hdev->adv_data, len) == 0) {
c82263e2 Johan Hedberg 2012-11-08  676  		err = 0;
c82263e2 Johan Hedberg 2012-11-08  677  		goto unlock;
c82263e2 Johan Hedberg 2012-11-08  678  	}
c82263e2 Johan Hedberg 2012-11-08  679  
c82263e2 Johan Hedberg 2012-11-08  680  	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
c82263e2 Johan Hedberg 2012-11-08  681  	hdev->adv_data_len = len;
c82263e2 Johan Hedberg 2012-11-08  682  
c82263e2 Johan Hedberg 2012-11-08 @683  	cp.length = cpu_to_le16(len);
c82263e2 Johan Hedberg 2012-11-08  684  
c82263e2 Johan Hedberg 2012-11-08  685  	err = hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
c82263e2 Johan Hedberg 2012-11-08  686  
c82263e2 Johan Hedberg 2012-11-08  687  unlock:
c82263e2 Johan Hedberg 2012-11-08  688  	hci_dev_unlock(hdev);
c82263e2 Johan Hedberg 2012-11-08  689  
c82263e2 Johan Hedberg 2012-11-08  690  	return err;
c82263e2 Johan Hedberg 2012-11-08  691  }

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
