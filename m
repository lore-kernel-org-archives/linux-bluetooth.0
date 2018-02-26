Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 26 Feb 2018 10:48:47 +0800
From: kbuild test robot <lkp@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH 07/11] Bluetooth: Implement Get PHY Configuration mgmt
 command
Message-ID: <201802261002.hyfLPYAc%fengguang.wu@intel.com>
References: <1519384128-2016-10-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519384128-2016-10-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jaganath-Kanakkassery/Ext-scan-connect-and-PHY-Configuration/20180226-060246
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   net/bluetooth/mgmt.c:3216:21: sparse: cast to restricted __le16
>> net/bluetooth/mgmt.c:3254:27: sparse: incorrect type in assignment (different base types) @@ expected unsigned short supported_phys @@ got ed] supported_phys @@
   net/bluetooth/mgmt.c:3254:27: expected unsigned short supported_phys
   net/bluetooth/mgmt.c:3254:27: got restricted __le16 <noident>
>> net/bluetooth/mgmt.c:3255:26: sparse: incorrect type in assignment (different base types) @@ expected unsigned short selected_phys @@ got ed] selected_phys @@
   net/bluetooth/mgmt.c:3255:26: expected unsigned short selected_phys
   net/bluetooth/mgmt.c:3255:26: got restricted __le16 <noident>

vim +3254 net/bluetooth/mgmt.c

  3202	
  3203	static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
  3204				  u16 len)
  3205	{
  3206		struct mgmt_cp_set_appearance *cp = data;
  3207		u16 apperance;
  3208		int err;
  3209	
  3210		BT_DBG("");
  3211	
  3212		if (!lmp_le_capable(hdev))
  3213			return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_APPEARANCE,
  3214					       MGMT_STATUS_NOT_SUPPORTED);
  3215	
> 3216		apperance = le16_to_cpu(cp->appearance);
  3217	
  3218		hci_dev_lock(hdev);
  3219	
  3220		if (hdev->appearance != apperance) {
  3221			hdev->appearance = apperance;
  3222	
  3223			if (hci_dev_test_flag(hdev, HCI_LE_ADV))
  3224				adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
  3225	
  3226			ext_info_changed(hdev, sk);
  3227		}
  3228	
  3229		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_APPEARANCE, 0, NULL,
  3230					0);
  3231	
  3232		hci_dev_unlock(hdev);
  3233	
  3234		return err;
  3235	}
  3236	
  3237	static int get_phy_configuration(struct sock *sk, struct hci_dev *hdev,
  3238					 void *data, u16 len)
  3239	{
  3240		struct mgmt_rp_get_phy_confguration rp;
  3241		u8 status;
  3242	
  3243		BT_DBG("sock %p %s", sk, hdev->name);
  3244	
  3245		status = mgmt_le_support(hdev);
  3246		if (status)
  3247			return mgmt_cmd_status(sk, hdev->id,
  3248					       MGMT_OP_GET_PHY_CONFIGURATION, status);
  3249	
  3250		hci_dev_lock(hdev);
  3251	
  3252		memset(&rp, 0, sizeof(rp));
  3253	
> 3254		rp.supported_phys = cpu_to_le16(get_supported_phys(hdev));
> 3255		rp.selected_phys = cpu_to_le16(get_selected_phys(hdev));
  3256	
  3257		hci_dev_unlock(hdev);
  3258	
  3259		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_PHY_CONFIGURATION, 0,
  3260					 &rp, sizeof(rp));
  3261	}
  3262	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
