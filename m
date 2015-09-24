Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Sep 2015 22:49:58 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Alexander Aring <alex.aring@gmail.com>
Cc: kbuild-all@01.org, Marcel Holtmann <marcel@holtmann.org>,
	Stefan Schmidt <stefan@osg.samsung.com>,
	linux-bluetooth@vger.kernel.org
Subject: [bluetooth:master 24/36]
 drivers/net/ieee802154/mrf24j40.c:1039:50-51: Unneeded semicolon
Message-ID: <201509242257.1bW5hSPp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   e88ab30d3669f08e94e66e7f926713be93af97fc
commit: f1d781272231dc4d1cdfdce13ad3e6f3f96b7ec0 [24/36] mrf24j40: add cca mode support


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ieee802154/mrf24j40.c:1039:50-51: Unneeded semicolon

vim +1039 drivers/net/ieee802154/mrf24j40.c

  1023		spi_message_add_tail(&devrec->irq_trx, &devrec->irq_msg);
  1024	}
  1025	
  1026	static void  mrf24j40_phy_setup(struct mrf24j40 *devrec)
  1027	{
  1028		ieee802154_random_extended_addr(&devrec->hw->phy->perm_extended_addr);
  1029		devrec->hw->phy->current_channel = 11;
  1030	
  1031		/* mrf24j40 supports max_minbe 0 - 3 */
  1032		devrec->hw->phy->supported.max_minbe = 3;
  1033		/* datasheet doesn't say anything about max_be, but we have min_be
  1034		 * So we assume the max_be default.
  1035		 */
  1036		devrec->hw->phy->supported.min_maxbe = 5;
  1037		devrec->hw->phy->supported.max_maxbe = 5;
  1038	
> 1039		devrec->hw->phy->cca.mode = NL802154_CCA_CARRIER;;
  1040		devrec->hw->phy->supported.cca_modes = BIT(NL802154_CCA_ENERGY) |
  1041						       BIT(NL802154_CCA_CARRIER) |
  1042						       BIT(NL802154_CCA_ENERGY_CARRIER);
  1043		devrec->hw->phy->supported.cca_opts = BIT(NL802154_CCA_OPT_ENERGY_CARRIER_AND);
  1044	}
  1045	
  1046	static int mrf24j40_probe(struct spi_device *spi)
  1047	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
