Return-Path: <julia.lawall@lip6.fr>
Date: Sat, 5 May 2018 22:05:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
cc: linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
    hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org, marcel@holtmann.org,
    johan.hedberg@gmail.com, kbuild-all@01.org
Subject: Re: [PATCH v4 2/3] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990. (fwd)
Message-ID: <alpine.DEB.2.20.1805052204410.2553@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Perhaps line 1349 is indented too much?

julia

---------- Forwarded message ----------
Date: Sun, 6 May 2018 03:41:52 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v4 2/3] Bluetooth: hci_qca: Add support for Qualcomm
    Bluetooth chip wcn3990.

CC: kbuild-all@01.org
In-Reply-To: <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
References: <1525448106-18616-3-git-send-email-bgodavar@codeaurora.org>
TO: Balakrishna Godavarthi <bgodavar@codeaurora.org>
CC: marcel@holtmann.org, johan.hedberg@gmail.com
CC: linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org, hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org, Balakrishna Godavarthi <bgodavar@codeaurora.org>

Hi Balakrishna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on next-20180504]
[cannot apply to bluetooth/master v4.17-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Balakrishna-Godavarthi/dt-bindings-net-bluetooth-Add-device-tree-bindings-for-QTI-chip-wcn3990/20180506-004430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/bluetooth/hci_qca.c:1347:3-53: code aligned with following code on line 1349

# https://github.com/0day-ci/linux/commit/1bab29c5dbe1faa3bf9a0955b41be7eb097db842
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 1bab29c5dbe1faa3bf9a0955b41be7eb097db842
vim +1347 drivers/bluetooth/hci_qca.c

1bab29c5 Balakrishna Godavarthi 2018-05-04  1307
1bab29c5 Balakrishna Godavarthi 2018-05-04  1308  int btqca_power_setup(bool on)
1bab29c5 Balakrishna Godavarthi 2018-05-04  1309  {
1bab29c5 Balakrishna Godavarthi 2018-05-04  1310  	int ret = 0;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1311  	int i;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1312  	struct btqca_vreg *vregs;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1313
1bab29c5 Balakrishna Godavarthi 2018-05-04  1314  	if (!qca || !qca->vreg_data || !qca->vreg_bulk)
1bab29c5 Balakrishna Godavarthi 2018-05-04  1315  		return -EINVAL;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1316  	vregs = qca->vreg_data->vregs;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1317
1bab29c5 Balakrishna Godavarthi 2018-05-04  1318  	BT_DBG("on: %d", on);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1319  	/* turn on if regualtors are off */
1bab29c5 Balakrishna Godavarthi 2018-05-04  1320  	if (on == true && qca->vreg_status == false) {
1bab29c5 Balakrishna Godavarthi 2018-05-04  1321  		qca->vreg_status = true;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1322  		for (i = 0; ret == 0 && i < qca->vreg_data->num_vregs; i++) {
1bab29c5 Balakrishna Godavarthi 2018-05-04  1323  			regulator_set_voltage(qca->vreg_bulk[i].consumer,
1bab29c5 Balakrishna Godavarthi 2018-05-04  1324  					      vregs[i].min_v,
1bab29c5 Balakrishna Godavarthi 2018-05-04  1325  					      vregs[i].max_v);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1326
1bab29c5 Balakrishna Godavarthi 2018-05-04  1327  			if (vregs[i].load_ua)
1bab29c5 Balakrishna Godavarthi 2018-05-04  1328  				regulator_set_load(qca->vreg_bulk[i].consumer,
1bab29c5 Balakrishna Godavarthi 2018-05-04  1329  						   vregs[i].load_ua);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1330
1bab29c5 Balakrishna Godavarthi 2018-05-04  1331  			ret = regulator_enable(qca->vreg_bulk[i].consumer);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1332  	}
1bab29c5 Balakrishna Godavarthi 2018-05-04  1333  	} else if (on == false && qca->vreg_status == true) {
1bab29c5 Balakrishna Godavarthi 2018-05-04  1334  		qca->vreg_status = false;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1335  		/* turn of regualtor in reverse order */
1bab29c5 Balakrishna Godavarthi 2018-05-04  1336  		btqca_disable_regulators(qca->vreg_data->num_vregs, vregs);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1337  	}
1bab29c5 Balakrishna Godavarthi 2018-05-04  1338
1bab29c5 Balakrishna Godavarthi 2018-05-04  1339  	/* regulatos fails to enable */
1bab29c5 Balakrishna Godavarthi 2018-05-04  1340  	if (ret) {
1bab29c5 Balakrishna Godavarthi 2018-05-04  1341  		qca->vreg_status = false;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1342  		BT_ERR("failed to enable regualtor:%s", vregs[i].name);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1343  		/* set regulator voltage and load to zero */
1bab29c5 Balakrishna Godavarthi 2018-05-04  1344  		regulator_set_voltage(qca->vreg_bulk[i].consumer,
1bab29c5 Balakrishna Godavarthi 2018-05-04  1345  				      0, vregs[i].max_v);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1346  		if (vregs[i].load_ua)
1bab29c5 Balakrishna Godavarthi 2018-05-04 @1347  			regulator_set_load(qca->vreg_bulk[i].consumer, 0);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1348  			/* turn off regulators which are enabled */
1bab29c5 Balakrishna Godavarthi 2018-05-04 @1349  			btqca_disable_regulators(i+1, vregs);
1bab29c5 Balakrishna Godavarthi 2018-05-04  1350  	}
1bab29c5 Balakrishna Godavarthi 2018-05-04  1351
1bab29c5 Balakrishna Godavarthi 2018-05-04  1352  	return ret;
1bab29c5 Balakrishna Godavarthi 2018-05-04  1353  }
1bab29c5 Balakrishna Godavarthi 2018-05-04  1354

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
