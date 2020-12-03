Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BEFC64E7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4695F21D91
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 12:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgLCMyF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:54:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:12387 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgLCMyF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 07:54:05 -0500
IronPort-SDR: wOgqlXnhDdZ6rOPg0wR4uZCMsg8lTpDjDYIBgkiOgtc+b/L4IUp+7TsaezlyLYKkB+01aYoi0r
 +QAGs8QwqjNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="234791326"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="gz'50?scan'50,208,50";a="234791326"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 04:53:21 -0800
IronPort-SDR: Ao8Xwd02qZiv8CC681ebi4cmtWA/Y5bDNrU54BG+U+65BdCFjHLXHlX0esAfvYs9fvCj8/3A/a
 d7Zi5Tk0KMxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="gz'50?scan'50,208,50";a="368386716"
Received: from lkp-server01.sh.intel.com (HELO c4fb854e61c6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2020 04:53:19 -0800
Received: from kbuild by c4fb854e61c6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kko6o-0000Em-DO; Thu, 03 Dec 2020 12:53:18 +0000
Date:   Thu, 3 Dec 2020 20:52:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     kbuild-all@lists.01.org, Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: btusb: Add workaround for remote-wakeup
 issues with Barrot 8041a02 fake CSR controllers
Message-ID: <202012032059.EKBRnriM-lkp@intel.com>
References: <20201203110944.49307-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20201203110944.49307-2-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

I love your patch! Yet something to improve:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on v5.10-rc6 next-20201203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/Bluetooth-btusb-Add-workaround-for-remote-wakeup-issues-with-Barrot-8041a02-fake-CSR-controllers/20201203-191712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: arm-randconfig-r032-20201203 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8dd4bd66a9bd4a811d7389743b7495719c6e4de3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hans-de-Goede/Bluetooth-btusb-Add-workaround-for-remote-wakeup-issues-with-Barrot-8041a02-fake-CSR-controllers/20201203-191712
        git checkout 8dd4bd66a9bd4a811d7389743b7495719c6e4de3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/bluetooth/btusb.c: In function 'btusb_setup_csr':
>> drivers/bluetooth/btusb.c:1893:7: error: 'bcdDevice' undeclared (first use in this function); did you mean 'device'?
    1893 |   if (bcdDevice == 0x8891 &&
         |       ^~~~~~~~~
         |       device
   drivers/bluetooth/btusb.c:1893:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/bluetooth/btusb.c:1899:22: error: 'data' undeclared (first use in this function); did you mean '_data'?
    1899 |    pm_runtime_allow(&data->udev->dev);
         |                      ^~~~
         |                      _data

vim +1893 drivers/bluetooth/btusb.c

  1788	
  1789	static int btusb_setup_csr(struct hci_dev *hdev)
  1790	{
  1791		struct hci_rp_read_local_version *rp;
  1792		struct sk_buff *skb;
  1793		bool is_fake = false;
  1794		int ret;
  1795	
  1796		BT_DBG("%s", hdev->name);
  1797	
  1798		skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
  1799				     HCI_INIT_TIMEOUT);
  1800		if (IS_ERR(skb)) {
  1801			int err = PTR_ERR(skb);
  1802			bt_dev_err(hdev, "CSR: Local version failed (%d)", err);
  1803			return err;
  1804		}
  1805	
  1806		if (skb->len != sizeof(struct hci_rp_read_local_version)) {
  1807			bt_dev_err(hdev, "CSR: Local version length mismatch");
  1808			kfree_skb(skb);
  1809			return -EIO;
  1810		}
  1811	
  1812		rp = (struct hci_rp_read_local_version *)skb->data;
  1813	
  1814		/* Detect a wide host of Chinese controllers that aren't CSR.
  1815		 *
  1816		 * Known fake bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
  1817		 *
  1818		 * The main thing they have in common is that these are really popular low-cost
  1819		 * options that support newer Bluetooth versions but rely on heavy VID/PID
  1820		 * squatting of this poor old Bluetooth 1.1 device. Even sold as such.
  1821		 *
  1822		 * We detect actual CSR devices by checking that the HCI manufacturer code
  1823		 * is Cambridge Silicon Radio (10) and ensuring that LMP sub-version and
  1824		 * HCI rev values always match. As they both store the firmware number.
  1825		 */
  1826		if (le16_to_cpu(rp->manufacturer) != 10 ||
  1827		    le16_to_cpu(rp->hci_rev) != le16_to_cpu(rp->lmp_subver))
  1828			is_fake = true;
  1829	
  1830		/* Known legit CSR firmware build numbers and their supported BT versions:
  1831		 * - 1.1 (0x1) -> 0x0073, 0x020d, 0x033c, 0x034e
  1832		 * - 1.2 (0x2) ->                 0x04d9, 0x0529
  1833		 * - 2.0 (0x3) ->         0x07a6, 0x07ad, 0x0c5c
  1834		 * - 2.1 (0x4) ->         0x149c, 0x1735, 0x1899 (0x1899 is a BlueCore4-External)
  1835		 * - 4.0 (0x6) ->         0x1d86, 0x2031, 0x22bb
  1836		 *
  1837		 * e.g. Real CSR dongles with LMP subversion 0x73 are old enough that
  1838		 *      support BT 1.1 only; so it's a dead giveaway when some
  1839		 *      third-party BT 4.0 dongle reuses it.
  1840		 */
  1841		else if (le16_to_cpu(rp->lmp_subver) <= 0x034e &&
  1842			 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_1_1)
  1843			is_fake = true;
  1844	
  1845		else if (le16_to_cpu(rp->lmp_subver) <= 0x0529 &&
  1846			 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_1_2)
  1847			is_fake = true;
  1848	
  1849		else if (le16_to_cpu(rp->lmp_subver) <= 0x0c5c &&
  1850			 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_2_0)
  1851			is_fake = true;
  1852	
  1853		else if (le16_to_cpu(rp->lmp_subver) <= 0x1899 &&
  1854			 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_2_1)
  1855			is_fake = true;
  1856	
  1857		else if (le16_to_cpu(rp->lmp_subver) <= 0x22bb &&
  1858			 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_4_0)
  1859			is_fake = true;
  1860	
  1861		if (is_fake) {
  1862			bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds...");
  1863	
  1864			/* Generally these clones have big discrepancies between
  1865			 * advertised features and what's actually supported.
  1866			 * Probably will need to be expanded in the future;
  1867			 * without these the controller will lock up.
  1868			 */
  1869			set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
  1870			set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
  1871	
  1872			/* Clear the reset quirk since this is not an actual
  1873			 * early Bluetooth 1.1 device from CSR.
  1874			 */
  1875			clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
  1876			clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
  1877	
  1878			/*
  1879			 * Special workaround for clones with a Barrot 8041a02 chip,
  1880			 * these clones are really messed-up:
  1881			 * 1. Their bulk rx endpoint will never report any data unless
  1882			 * the device was suspended at least once (yes really).
  1883			 * 2. They will not wakeup when autosuspended and receiving data
  1884			 * on their bulk rx endpoint from e.g. a keyboard or mouse
  1885			 * (IOW remote-wakeup support is broken for the bulk endpoint).
  1886			 *
  1887			 * To fix 1. enable runtime-suspend, force-suspend the
  1888			 * hci and then wake-it up by disabling runtime-suspend.
  1889			 *
  1890			 * To fix 2. clear the hci's can_wake flag, this way the hci
  1891			 * will still be autosuspended when it is not open.
  1892			 */
> 1893			if (bcdDevice == 0x8891 &&
  1894			    le16_to_cpu(rp->lmp_subver) == 0x1012 &&
  1895			    le16_to_cpu(rp->hci_rev) == 0x0810 &&
  1896			    le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_4_0) {
  1897				bt_dev_warn(hdev, "CSR: detected a fake CSR dongle using a Barrot 8041a02 chip, this chip is very buggy and may have issues\n");
  1898	
> 1899				pm_runtime_allow(&data->udev->dev);
  1900	
  1901				ret = pm_runtime_suspend(&data->udev->dev);
  1902				if (ret >= 0)
  1903					msleep(200);
  1904				else
  1905					bt_dev_err(hdev, "Failed to suspend the device for Barrot 8041a02 receive-issue workaround\n");
  1906	
  1907				pm_runtime_forbid(&data->udev->dev);
  1908	
  1909				device_set_wakeup_capable(&data->udev->dev, false);
  1910				/* Re-enable autosuspend if this was requested */
  1911				if (enable_autosuspend)
  1912					usb_enable_autosuspend(data->udev);
  1913			}
  1914		}
  1915	
  1916		kfree_skb(skb);
  1917	
  1918		return 0;
  1919	}
  1920	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICOTVyF8AAy5jb25maWcAlFxLc+O4rt7Pr1DNbM5ZdB8/knRSt7KgJcriWBLVIv1INip3
ou5xTRL3dZyZ7n9/AeoFSlTO3KmaTgzwAZIg8AGE89svv3ns7Xx83p8PD/unp5/et/KlPO3P
5aP39fBU/o8XSC+V2uOB0B+hcXx4efvxn/3p2bv8OJ18nHw4Pcy8VXl6KZ88//jy9fDtDXof
ji+//PaLL9NQLAvfLzY8V0KmheY7ffsr9P7whON8+PbyVu6/HD58e3jw/rX0/X97Nx/nHye/
kq5CFcC4/dmQlt1wtzeT+WTSMOKgpc/mFxPzXztOzNJly56Q4SOmCqaSYim17CYhDJHGIuUd
S+Sfi63MV0CBJf7mLc1+PXmv5fnte7foRS5XPC1gzSrJSO9U6IKnm4LlILFIhL6dz2CUZl6Z
ZCLmsE9Ke4dX7+V4xoHbJUqfxc0qfv2160cZBVtr6ei8WAvYIsVijV1rYsQ2vFjxPOVxsbwX
RFLKie8T5ubs7sd6yDHGBTBawcnUVOQ+HwV4j7+7dyzYEmU44oWjS8BDto61OSaySw05kkqn
LOG3v/7r5fhS/rttoO7URmRESzOpxK5IPq/5mujOlmk/KnrEteKxWFAR2RouG5XOKBoonvf6
9uX15+u5fO4UbclTngvf6GWWywUZmbJUJLfjnCLmGx7TE8sD4KlCbYucK54G7r5+RFUGKYFM
mEhtmhKJq1ERCZ6z3I/u6MRpAPpfN4C2dsdQ5j4PCh3lnAUiXXZclbFc8bpHu5NU1oAv1stQ
2WpUvjx6x6+9vXWtNIHzF7V4+XAzfLiBK9jDVKvGMOjDc3l6dR1ZdF9k0EsGwqfCphI5AiZw
aCb8QONZ6Jz5K2vlfU61SYOBndcnEssID7jQIgHr4dybwTq67lnOeZJpmCB1ydywNzJep5rl
d1SomvlON19Cr2Y3/Wz9H71//dM7gzjeHkR7Pe/Pr97+4eH49nI+vHzr9ncjcuidrQvmmzGq
7Wpn1sJf9dgOKRyD4Gnb+ojbZs/SGFsV4G30uVLI1+OcYjO3hGNqpTTTynlemRLOM/oHu2N2
MffXnhoqJMh+VwCPCgIfC74DPXUdkaoa0+49Ei7DjFHfEAdrQFoH3EVHxeatePWK7ZXYPm4h
0hmZUKyqX+jqxCoCC9JT+d6dVn4Etsbc7EYL1cMf5ePbU3nyvpb789upfDXkWiYHt72ky1yu
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
fwRbAQA=

--tKW2IUtsqtDRztdT--
