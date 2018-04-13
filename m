Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 13 Apr 2018 22:29:11 +0800
From: kbuild test robot <lkp@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: Re: [PATCH v1 16/18] Bluetooth: Use ext adv for directed adv
Message-ID: <201804132258.WzVQyRsH%fengguang.wu@intel.com>
References: <1523531987-17140-17-git-send-email-jaganathx.kanakkassery@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523531987-17140-17-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v4.16 next-20180413]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jaganath-Kanakkassery/Extended-Adv-Scan-Connection-and-PHY-support/20180413-201735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> net/bluetooth/hci_conn.c:868:35: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [addressable] [usertype] evt_properties @@    got e] evt_properties @@
   net/bluetooth/hci_conn.c:868:35:    expected restricted __le16 [addressable] [usertype] evt_properties
   net/bluetooth/hci_conn.c:868:35:    got int

vim +868 net/bluetooth/hci_conn.c

   855	
   856	static void hci_req_directed_advertising(struct hci_request *req,
   857						 struct hci_conn *conn)
   858	{
   859		struct hci_dev *hdev = req->hdev;
   860		u8 own_addr_type;
   861		u8 enable;
   862	
   863		if (ext_adv_capable(hdev)) {
   864			struct hci_cp_le_set_ext_adv_params cp;
   865	
   866			memset(&cp, 0, sizeof(cp));
   867	
 > 868			cp.evt_properties = LE_LEGACY_ADV_DIRECT_IND;
   869			cp.own_addr_type = own_addr_type;
   870			cp.channel_map = hdev->le_adv_channel_map;
   871			cp.tx_power = 127;
   872			cp.primary_phy = HCI_ADV_PHY_1M;
   873			cp.secondary_phy = HCI_ADV_PHY_1M;
   874			cp.handle = 0; /* Use instance 0 for directed adv */
   875			cp.own_addr_type = own_addr_type;
   876			cp.peer_addr_type = conn->dst_type;
   877			bacpy(&cp.peer_addr, &conn->dst);
   878	
   879			hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
   880	
   881			__hci_req_enable_ext_advertising(req);
   882		} else {
   883			struct hci_cp_le_set_adv_param cp;
   884	
   885			/* Clear the HCI_LE_ADV bit temporarily so that the
   886			 * hci_update_random_address knows that it's safe to go ahead
   887			 * and write a new random address. The flag will be set back on
   888			 * as soon as the SET_ADV_ENABLE HCI command completes.
   889			 */
   890			hci_dev_clear_flag(hdev, HCI_LE_ADV);
   891	
   892			/* Set require_privacy to false so that the remote device has a
   893			 * chance of identifying us.
   894			 */
   895			if (hci_update_random_address(req, false, conn_use_rpa(conn),
   896						      &own_addr_type) < 0)
   897				return;
   898	
   899			memset(&cp, 0, sizeof(cp));
   900			cp.type = LE_ADV_DIRECT_IND;
   901			cp.own_address_type = own_addr_type;
   902			cp.direct_addr_type = conn->dst_type;
   903			bacpy(&cp.direct_addr, &conn->dst);
   904			cp.channel_map = hdev->le_adv_channel_map;
   905	
   906			hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
   907	
   908			enable = 0x01;
   909			hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable),
   910				    &enable);
   911		}
   912	
   913		conn->state = BT_CONNECT;
   914	}
   915	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
