Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB2BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C10420672
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgF2TlO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:41:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:58002 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733156AbgF2Tk7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:59 -0400
IronPort-SDR: mBBnbRmX4AtMHes0UyAdHPm/qsJ3lntG+rREcDtxjC+Y8TyNjGjLVnOmsp0Wc344IlPhViolxI
 Ccng8HCXhk/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211094001"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="gz'50?scan'50,208,50";a="211094001"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 10:25:59 -0700
IronPort-SDR: b1Df5lK3nr8Or8iljUjh/4GeA3qvGiGdGmYh5SV1+juCNDTOHB55mrVEokVJ5RE33SKwMh/X1A
 RF/0yDSpyZ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="gz'50?scan'50,208,50";a="318630148"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2020 10:25:56 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpxXY-00015o-6A; Mon, 29 Jun 2020 17:25:56 +0000
Date:   Tue, 30 Jun 2020 01:25:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
Message-ID: <202006300137.VvBRKD56%lkp@intel.com>
References: <a36966dd-677a-916c-9a03-c82b4e980652@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <a36966dd-677a-916c-9a03-c82b4e980652@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ismael,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master v5.8-rc3 next-20200629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ismael-Ferreras-Morezuelas/Bluetooth-btusb-Fix-and-detect-most-of-the-Chinese-Bluetooth-controllers/20200624-083108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: parisc-randconfig-s032-20200629 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C= CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/bluetooth/btusb.c:1788:37: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1789:37: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:1790:49: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btusb.c:2306:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2306:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2306:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2306:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2315:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2315:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2315:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2315:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2316:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2316:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2316:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2316:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2317:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2317:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2317:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2317:25: sparse: sparse: cast to restricted __le16

vim +1788 drivers/bluetooth/btusb.c

  1718	
  1719	static int btusb_setup_csr(struct hci_dev *hdev)
  1720	{
  1721		struct btusb_data *data = hci_get_drvdata(hdev);
  1722		struct usb_device *udev = data->udev;
  1723		struct hci_rp_read_local_version *rp;
  1724		struct sk_buff *skb;
  1725	
  1726		BT_DBG("%s", hdev->name);
  1727	
  1728		skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
  1729				     HCI_INIT_TIMEOUT);
  1730		if (IS_ERR(skb)) {
  1731			int err = PTR_ERR(skb);
  1732			bt_dev_err(hdev, "CSR: Local version failed (%d)", err);
  1733			return err;
  1734		}
  1735	
  1736		if (skb->len != sizeof(struct hci_rp_read_local_version)) {
  1737			bt_dev_err(hdev, "CSR: Local version length mismatch");
  1738			kfree_skb(skb);
  1739			return -EIO;
  1740		}
  1741	
  1742		rp = (struct hci_rp_read_local_version *)skb->data;
  1743	
  1744		/* Of interest to fine-tune the logic in the future */
  1745		bt_dev_info(hdev, "CSR: New controller detected; bcdDevice=%#x, HCI manufacturer=%u, HCI rev=%#x, LMP subver=%#x",
  1746			    le16_to_cpu(udev->descriptor.bcdDevice),
  1747			    le16_to_cpu(rp->manufacturer),
  1748			    le16_to_cpu(rp->hci_rev),
  1749			    le16_to_cpu(rp->lmp_subver));
  1750	
  1751		/* Detect a wide host of Chinese controllers that rely on heavy VID/PID
  1752		 * squatting of this poor old Bluetooth 1.1 device. As if that wasn't
  1753		 * enough there are actually three classes of controllers reusing
  1754		 * the same 0A12:0001 VID/PID:
  1755		 *
  1756		 * * Old CSR Bluetooth 1.1 devices (BlueCore?):
  1757		 *   HCI_QUIRK_SIMULTANEOUS_DISCOVERY
  1758		 *   HCI_QUIRK_RESET_ON_CLOSE
  1759		 *
  1760		 * * New CSR Bluetooth devices based on CSR8510 (BlueSoleil?):
  1761		 *   HCI_QUIRK_BROKEN_STORED_LINK_KEY
  1762		 *
  1763		 * * Unbranded CSR clone:
  1764		 *   Their HCI chip uses a different manufacturer number;
  1765		 *   sourced from various vendors. Most common ones are:
  1766		 *     - Broadcom Corporation (15)
  1767		 *     - Mitel Semiconductor (16)
  1768		 *
  1769		 *   No quirks, varies depending on the real manufacturer.
  1770		 *
  1771		 * We detect actual CSR devices by checking that the HDI manufacturer code
  1772		 * is Cambridge Silicon Radio (10) and ensuring that LMP sub-version and
  1773		 * the HID values will always match. The full list of newer bcdDevices
  1774		 * is documented in the official driver .inf files.
  1775		 *
  1776		 * Because diagnosing all this has been very tricky in the past, with the
  1777		 * original bug being reported in 2013, and left unsolved until 2020, let's
  1778		 * report the chip type to potentially have a better coverage and reports.
  1779		 */
  1780		if (le16_to_cpu(rp->manufacturer) == 10 &&
  1781		    le16_to_cpu(rp->hci_rev) == le16_to_cpu(rp->lmp_subver)) {
  1782			/* Only apply the reset quirk on actual, early Bluetooth 1.1 devices
  1783			 * from CSR. Old firmware would otherwise execute USB reset
  1784			 */
  1785			if (le16_to_cpu(udev->descriptor.bcdDevice) < 0x117)
  1786				set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
  1787	
> 1788			if (udev->descriptor.idVendor  == 0x0a12 &&
  1789			    udev->descriptor.idProduct == 0x0001) {
  1790				switch (udev->descriptor.bcdDevice) {
  1791				case 0x0100:
  1792				case 0x0134:
  1793				case 0x1915:
  1794				case 0x1958:
  1795				case 0x2520:
  1796				case 0x3164:
  1797				case 0x4839:
  1798				case 0x5276:
  1799				case 0x7558:
  1800				case 0x8891:
  1801					/* These newer CSR controllers have all a broken
  1802					 * stored link key handling, so just disable it.
  1803					 */
  1804					set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
  1805					bt_dev_info(hdev, "CSR: Modern CSR controller type detected");
  1806					break;
  1807				default:
  1808					/* Only apply this quirk to actual, old CSR devices */
  1809					set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
  1810					bt_dev_info(hdev, "CSR: Old CSR controller type detected");
  1811				}
  1812			}
  1813		} else {
  1814			bt_dev_info(hdev, "CSR: Unbranded CSR clone detected; adding workaround");
  1815		}
  1816	
  1817		kfree_skb(skb);
  1818	
  1819		return 0;
  1820	}
  1821	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
5P3cfwGQmt92wNQBAA==

--ibTvN161/egqYuK8--
