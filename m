Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2661038
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHMTXy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 15:23:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:5498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhHMTXw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 15:23:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="213766468"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="gz'50?scan'50,208,50";a="213766468"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 12:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="gz'50?scan'50,208,50";a="528670389"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2021 12:23:20 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEclz-000O38-R7; Fri, 13 Aug 2021 19:23:19 +0000
Date:   Sat, 14 Aug 2021 03:22:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joseph Hwang <josephsih@chromium.org>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     kbuild-all@lists.01.org,
        chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/5] Bluetooth: refactor set_exp_feature with a
 feature table
Message-ID: <202108140352.ntv3OkcY-lkp@intel.com>
References: <20210814005024.v8.3.Ibd93c7f71f8819d2efdfa3ee2f096319e3c44ea4@changeid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20210814005024.v8.3.Ibd93c7f71f8819d2efdfa3ee2f096319e3c44ea4@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joseph,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20210813]
[cannot apply to bluetooth/master v5.14-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Joseph-Hwang/Bluetooth-btusb-disable-Intel-link-statistics-telemetry-events/20210814-005423
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: m68k-allmodconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7a3d3d918d33f8f8796cb27e1f137c56c2afaeac
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joseph-Hwang/Bluetooth-btusb-disable-Intel-link-statistics-telemetry-events/20210814-005423
        git checkout 7a3d3d918d33f8f8796cb27e1f137c56c2afaeac
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   net/bluetooth/mgmt.c: In function 'set_exp_feature':
>> net/bluetooth/mgmt.c:4084:12: error: invalid storage class for function 'get_device_flags'
    4084 | static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4084:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    4084 | static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
         | ^~~~~~
>> net/bluetooth/mgmt.c:4134:13: error: invalid storage class for function 'device_flags_changed'
    4134 | static void device_flags_changed(struct sock *sk, struct hci_dev *hdev,
         |             ^~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4148:12: error: invalid storage class for function 'set_device_flags'
    4148 | static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4206:13: error: invalid storage class for function 'mgmt_adv_monitor_added'
    4206 | static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4236:12: error: invalid storage class for function 'read_adv_mon_features'
    4236 | static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4324:12: error: invalid storage class for function '__add_adv_patterns_monitor'
    4324 | static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4388:13: error: invalid storage class for function 'parse_adv_monitor_rssi'
    4388 | static void parse_adv_monitor_rssi(struct adv_monitor *m,
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4413:11: error: invalid storage class for function 'parse_adv_monitor_pattern'
    4413 | static u8 parse_adv_monitor_pattern(struct adv_monitor *m, u8 pattern_count,
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4444:12: error: invalid storage class for function 'add_adv_patterns_monitor'
    4444 | static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4481:12: error: invalid storage class for function 'add_adv_patterns_monitor_rssi'
    4481 | static int add_adv_patterns_monitor_rssi(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4549:12: error: invalid storage class for function 'remove_adv_monitor'
    4549 | static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4614:13: error: invalid storage class for function 'read_local_oob_data_complete'
    4614 | static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4673:12: error: invalid storage class for function 'read_local_oob_data'
    4673 | static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4724:12: error: invalid storage class for function 'add_remote_oob_data'
    4724 | static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4832:12: error: invalid storage class for function 'remove_remote_oob_data'
    4832 | static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4899:13: error: invalid storage class for function 'discovery_type_is_valid'
    4899 | static bool discovery_type_is_valid(struct hci_dev *hdev, uint8_t type,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4926:12: error: invalid storage class for function 'start_discovery_internal'
    4926 | static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:4994:12: error: invalid storage class for function 'start_discovery'
    4994 | static int start_discovery(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~
>> net/bluetooth/mgmt.c:5001:12: error: invalid storage class for function 'start_limited_discovery'
    5001 | static int start_limited_discovery(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5009:12: error: invalid storage class for function 'service_discovery_cmd_complete'
    5009 | static int service_discovery_cmd_complete(struct mgmt_pending_cmd *cmd,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5016:12: error: invalid storage class for function 'start_service_discovery'
    5016 | static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5148:12: error: invalid storage class for function 'stop_discovery'
    5148 | static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5190:12: error: invalid storage class for function 'confirm_name'
    5190 | static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~
   net/bluetooth/mgmt.c:5232:12: error: invalid storage class for function 'block_device'
    5232 | static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~
   net/bluetooth/mgmt.c:5268:12: error: invalid storage class for function 'unblock_device'
    5268 | static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5304:12: error: invalid storage class for function 'set_device_id'
    5304 | static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5339:13: error: invalid storage class for function 'enable_advertising_instance'
    5339 | static void enable_advertising_instance(struct hci_dev *hdev, u8 status,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5345:13: error: invalid storage class for function 'set_advertising_complete'
    5345 | static void set_advertising_complete(struct hci_dev *hdev, u8 status,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5419:12: error: invalid storage class for function 'set_advertising'
    5419 | static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5538:12: error: invalid storage class for function 'set_static_address'
    5538 | static int set_static_address(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5582:12: error: invalid storage class for function 'set_scan_params'
    5582 | static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5639:13: error: invalid storage class for function 'fast_connectable_complete'
    5639 | static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5673:12: error: invalid storage class for function 'set_fast_connectable'
    5673 | static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5738:13: error: invalid storage class for function 'set_bredr_complete'
    5738 | static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
         |             ^~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5770:12: error: invalid storage class for function 'set_bredr'
    5770 | static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
         |            ^~~~~~~~~
   net/bluetooth/mgmt.c:5882:13: error: invalid storage class for function 'sc_enable_complete'
    5882 | static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
         |             ^~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:5927:12: error: invalid storage class for function 'set_secure_conn'
    5927 | static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6015:12: error: invalid storage class for function 'set_debug_keys'
    6015 | static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6062:12: error: invalid storage class for function 'set_privacy'
    6062 | static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
         |            ^~~~~~~~~~~
   net/bluetooth/mgmt.c:6119:13: error: invalid storage class for function 'irk_is_valid'
    6119 | static bool irk_is_valid(struct mgmt_irk_info *irk)
         |             ^~~~~~~~~~~~
   net/bluetooth/mgmt.c:6135:12: error: invalid storage class for function 'load_irks'
    6135 | static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
         |            ^~~~~~~~~
   net/bluetooth/mgmt.c:6206:13: error: invalid storage class for function 'ltk_is_valid'
    6206 | static bool ltk_is_valid(struct mgmt_ltk_info *key)
         |             ^~~~~~~~~~~~
   net/bluetooth/mgmt.c:6225:12: error: invalid storage class for function 'load_long_term_keys'
    6225 | static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
         |            ^~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6321:12: error: invalid storage class for function 'conn_info_cmd_complete'
    6321 | static int conn_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6348:13: error: invalid storage class for function 'conn_info_refresh_complete'
    6348 | static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6402:12: error: invalid storage class for function 'get_conn_info'
    6402 | static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6523:12: error: invalid storage class for function 'clock_info_cmd_complete'
    6523 | static int clock_info_cmd_complete(struct mgmt_pending_cmd *cmd, u8 status)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6559:13: error: invalid storage class for function 'get_clock_info_complete'
    6559 | static void get_clock_info_complete(struct hci_dev *hdev, u8 status, u16 opcode)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6591:12: error: invalid storage class for function 'get_clock_info'
    6591 | static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
         |            ^~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6667:13: error: invalid storage class for function 'is_connected'
    6667 | static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
         |             ^~~~~~~~~~~~
   net/bluetooth/mgmt.c:6685:12: error: invalid storage class for function 'hci_conn_params_set'
    6685 | static int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr,
         |            ^~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt.c:6729:13: error: invalid storage class for function 'device_added'
    6729 | static void device_added(struct sock *sk, struct hci_dev *hdev,


vim +/get_device_flags +4084 net/bluetooth/mgmt.c

4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4083  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17 @4084  static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4085  			    u16 data_len)
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4086  {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4087  	struct mgmt_cp_get_device_flags *cp = data;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4088  	struct mgmt_rp_get_device_flags rp;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4089  	struct bdaddr_list_with_flags *br_params;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4090  	struct hci_conn_params *params;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4091  	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4092  	u32 current_flags = 0;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4093  	u8 status = MGMT_STATUS_INVALID_PARAMS;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4094  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4095  	bt_dev_dbg(hdev, "Get device flags %pMR (type 0x%x)\n",
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4096  		   &cp->addr.bdaddr, cp->addr.type);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4097  
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4098  	hci_dev_lock(hdev);
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4099  
02ce2c2c24024a Tedd Ho-Jeong An       2021-05-26  4100  	memset(&rp, 0, sizeof(rp));
02ce2c2c24024a Tedd Ho-Jeong An       2021-05-26  4101  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4102  	if (cp->addr.type == BDADDR_BREDR) {
3d4f9c00492b4e Archie Pusaka          2021-06-04  4103  		br_params = hci_bdaddr_list_lookup_with_flags(&hdev->accept_list,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4104  							      &cp->addr.bdaddr,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4105  							      cp->addr.type);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4106  		if (!br_params)
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4107  			goto done;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4108  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4109  		current_flags = br_params->current_flags;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4110  	} else {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4111  		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4112  						le_addr_type(cp->addr.type));
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4113  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4114  		if (!params)
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4115  			goto done;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4116  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4117  		current_flags = params->current_flags;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4118  	}
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4119  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4120  	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4121  	rp.addr.type = cp->addr.type;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4122  	rp.supported_flags = cpu_to_le32(supported_flags);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4123  	rp.current_flags = cpu_to_le32(current_flags);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4124  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4125  	status = MGMT_STATUS_SUCCESS;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4126  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4127  done:
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4128  	hci_dev_unlock(hdev);
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4129  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4130  	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_DEVICE_FLAGS, status,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4131  				&rp, sizeof(rp));
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4132  }
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4133  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17 @4134  static void device_flags_changed(struct sock *sk, struct hci_dev *hdev,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4135  				 bdaddr_t *bdaddr, u8 bdaddr_type,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4136  				 u32 supported_flags, u32 current_flags)
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4137  {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4138  	struct mgmt_ev_device_flags_changed ev;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4139  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4140  	bacpy(&ev.addr.bdaddr, bdaddr);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4141  	ev.addr.type = bdaddr_type;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4142  	ev.supported_flags = cpu_to_le32(supported_flags);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4143  	ev.current_flags = cpu_to_le32(current_flags);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4144  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4145  	mgmt_event(MGMT_EV_DEVICE_FLAGS_CHANGED, hdev, &ev, sizeof(ev), sk);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4146  }
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4147  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17 @4148  static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4149  			    u16 len)
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4150  {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4151  	struct mgmt_cp_set_device_flags *cp = data;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4152  	struct bdaddr_list_with_flags *br_params;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4153  	struct hci_conn_params *params;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4154  	u8 status = MGMT_STATUS_INVALID_PARAMS;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4155  	u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4156  	u32 current_flags = __le32_to_cpu(cp->current_flags);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4157  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4158  	bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4159  		   &cp->addr.bdaddr, cp->addr.type,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4160  		   __le32_to_cpu(current_flags));
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4161  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4162  	if ((supported_flags | current_flags) != supported_flags) {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4163  		bt_dev_warn(hdev, "Bad flag given (0x%x) vs supported (0x%0x)",
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4164  			    current_flags, supported_flags);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4165  		goto done;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4166  	}
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4167  
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4168  	hci_dev_lock(hdev);
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4169  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4170  	if (cp->addr.type == BDADDR_BREDR) {
3d4f9c00492b4e Archie Pusaka          2021-06-04  4171  		br_params = hci_bdaddr_list_lookup_with_flags(&hdev->accept_list,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4172  							      &cp->addr.bdaddr,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4173  							      cp->addr.type);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4174  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4175  		if (br_params) {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4176  			br_params->current_flags = current_flags;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4177  			status = MGMT_STATUS_SUCCESS;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4178  		} else {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4179  			bt_dev_warn(hdev, "No such BR/EDR device %pMR (0x%x)",
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4180  				    &cp->addr.bdaddr, cp->addr.type);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4181  		}
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4182  	} else {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4183  		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4184  						le_addr_type(cp->addr.type));
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4185  		if (params) {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4186  			params->current_flags = current_flags;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4187  			status = MGMT_STATUS_SUCCESS;
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4188  		} else {
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4189  			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4190  				    &cp->addr.bdaddr,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4191  				    le_addr_type(cp->addr.type));
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4192  		}
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4193  	}
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4194  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4195  done:
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4196  	hci_dev_unlock(hdev);
3ca33e3fb4f919 Abhishek Pandit-Subedi 2020-06-19  4197  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4198  	if (status == MGMT_STATUS_SUCCESS)
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4199  		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4200  				     supported_flags, current_flags);
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4201  
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4202  	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_FLAGS, status,
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4203  				 &cp->addr, sizeof(cp->addr));
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4204  }
4c54bf2b093bb2 Abhishek Pandit-Subedi 2020-06-17  4205  
b52729f27b1e39 Miao-chen Chou         2020-06-17 @4206  static void mgmt_adv_monitor_added(struct sock *sk, struct hci_dev *hdev,
b52729f27b1e39 Miao-chen Chou         2020-06-17  4207  				   u16 handle)
b52729f27b1e39 Miao-chen Chou         2020-06-17  4208  {
b52729f27b1e39 Miao-chen Chou         2020-06-17  4209  	struct mgmt_ev_adv_monitor_added ev;
b52729f27b1e39 Miao-chen Chou         2020-06-17  4210  
b52729f27b1e39 Miao-chen Chou         2020-06-17  4211  	ev.monitor_handle = cpu_to_le16(handle);
b52729f27b1e39 Miao-chen Chou         2020-06-17  4212  
b52729f27b1e39 Miao-chen Chou         2020-06-17  4213  	mgmt_event(MGMT_EV_ADV_MONITOR_ADDED, hdev, &ev, sizeof(ev), sk);
b52729f27b1e39 Miao-chen Chou         2020-06-17  4214  }
b52729f27b1e39 Miao-chen Chou         2020-06-17  4215  
66bd095ab5d408 Archie Pusaka          2021-01-22  4216  void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle)
cdde92e230719f Miao-chen Chou         2020-06-17  4217  {
66bd095ab5d408 Archie Pusaka          2021-01-22  4218  	struct mgmt_ev_adv_monitor_removed ev;
66bd095ab5d408 Archie Pusaka          2021-01-22  4219  	struct mgmt_pending_cmd *cmd;
66bd095ab5d408 Archie Pusaka          2021-01-22  4220  	struct sock *sk_skip = NULL;
66bd095ab5d408 Archie Pusaka          2021-01-22  4221  	struct mgmt_cp_remove_adv_monitor *cp;
66bd095ab5d408 Archie Pusaka          2021-01-22  4222  
66bd095ab5d408 Archie Pusaka          2021-01-22  4223  	cmd = pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev);
66bd095ab5d408 Archie Pusaka          2021-01-22  4224  	if (cmd) {
66bd095ab5d408 Archie Pusaka          2021-01-22  4225  		cp = cmd->param;
66bd095ab5d408 Archie Pusaka          2021-01-22  4226  
66bd095ab5d408 Archie Pusaka          2021-01-22  4227  		if (cp->monitor_handle)
66bd095ab5d408 Archie Pusaka          2021-01-22  4228  			sk_skip = cmd->sk;
66bd095ab5d408 Archie Pusaka          2021-01-22  4229  	}
cdde92e230719f Miao-chen Chou         2020-06-17  4230  
cdde92e230719f Miao-chen Chou         2020-06-17  4231  	ev.monitor_handle = cpu_to_le16(handle);
cdde92e230719f Miao-chen Chou         2020-06-17  4232  
66bd095ab5d408 Archie Pusaka          2021-01-22  4233  	mgmt_event(MGMT_EV_ADV_MONITOR_REMOVED, hdev, &ev, sizeof(ev), sk_skip);
cdde92e230719f Miao-chen Chou         2020-06-17  4234  }
cdde92e230719f Miao-chen Chou         2020-06-17  4235  
e5e1e7fd470ccf Miao-chen Chou         2020-06-17 @4236  static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4237  				 void *data, u16 len)
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4238  {
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4239  	struct adv_monitor *monitor = NULL;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4240  	struct mgmt_rp_read_adv_monitor_features *rp = NULL;
cafd472a10ff3b Peilin Ye              2020-09-09  4241  	int handle, err;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4242  	size_t rp_size = 0;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4243  	__u32 supported = 0;
a2a4dedf88ab2f Archie Pusaka          2021-01-22  4244  	__u32 enabled = 0;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4245  	__u16 num_handles = 0;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4246  	__u16 handles[HCI_MAX_ADV_MONITOR_NUM_HANDLES];
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4247  
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4248  	BT_DBG("request for %s", hdev->name);
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4249  
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4250  	hci_dev_lock(hdev);
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4251  
a2a4dedf88ab2f Archie Pusaka          2021-01-22  4252  	if (msft_monitor_supported(hdev))
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4253  		supported |= MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4254  
a2a4dedf88ab2f Archie Pusaka          2021-01-22  4255  	idr_for_each_entry(&hdev->adv_monitors_idr, monitor, handle)
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4256  		handles[num_handles++] = monitor->handle;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4257  
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4258  	hci_dev_unlock(hdev);
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4259  
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4260  	rp_size = sizeof(*rp) + (num_handles * sizeof(u16));
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4261  	rp = kmalloc(rp_size, GFP_KERNEL);
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4262  	if (!rp)
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4263  		return -ENOMEM;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4264  
a2a4dedf88ab2f Archie Pusaka          2021-01-22  4265  	/* All supported features are currently enabled */
a2a4dedf88ab2f Archie Pusaka          2021-01-22  4266  	enabled = supported;
a2a4dedf88ab2f Archie Pusaka          2021-01-22  4267  
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4268  	rp->supported_features = cpu_to_le32(supported);
a2a4dedf88ab2f Archie Pusaka          2021-01-22  4269  	rp->enabled_features = cpu_to_le32(enabled);
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4270  	rp->max_num_handles = cpu_to_le16(HCI_MAX_ADV_MONITOR_NUM_HANDLES);
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4271  	rp->max_num_patterns = HCI_MAX_ADV_MONITOR_NUM_PATTERNS;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4272  	rp->num_handles = cpu_to_le16(num_handles);
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4273  	if (num_handles)
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4274  		memcpy(&rp->handles, &handles, (num_handles * sizeof(u16)));
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4275  
cafd472a10ff3b Peilin Ye              2020-09-09  4276  	err = mgmt_cmd_complete(sk, hdev->id,
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4277  				MGMT_OP_READ_ADV_MONITOR_FEATURES,
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4278  				MGMT_STATUS_SUCCESS, rp, rp_size);
cafd472a10ff3b Peilin Ye              2020-09-09  4279  
cafd472a10ff3b Peilin Ye              2020-09-09  4280  	kfree(rp);
cafd472a10ff3b Peilin Ye              2020-09-09  4281  
cafd472a10ff3b Peilin Ye              2020-09-09  4282  	return err;
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4283  }
e5e1e7fd470ccf Miao-chen Chou         2020-06-17  4284  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
V5FZPZiuL2zK/w9liEuAENgDAA==

--k1lZvvs/B4yU6o8G--
