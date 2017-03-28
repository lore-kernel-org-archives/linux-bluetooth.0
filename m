Return-Path: <julia.lawall@lip6.fr>
Date: Tue, 28 Mar 2017 21:55:26 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Harry Morris <harrymorris12@gmail.com>
cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
    kbuild-all@01.org
Subject: [bluetooth-next:master 25/28] drivers/net/ieee802154/ca8210.c:918:9-12:
 ERROR: spi is NULL but dereferenced. (fwd)
Message-ID: <alpine.DEB.2.20.1703282153590.2345@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

If the call to dev_crit on line 917 is to do something, it should need a
valid pointer as th first argument.

Also, separating the () from the argument list with newlines does not look
like normal kernel coding style.

julia

---------- Forwarded message ----------
Date: Wed, 29 Mar 2017 00:26:36 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [bluetooth-next:master 25/28] drivers/net/ieee802154/ca8210.c:918:9-12:
     ERROR: spi is NULL but dereferenced.


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   50d1455b61a78d1f2dfca4b3366ac5925fb04838
commit: d931acd575d6a36730192756bf2cbd14c77fa1bc [25/28] ieee802154: Add CA8210 IEEE 802.15.4 device driver
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/net/ieee802154/ca8210.c:918:9-12: ERROR: spi is NULL but dereferenced.

git remote add bluetooth-next https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git remote update bluetooth-next
git checkout d931acd575d6a36730192756bf2cbd14c77fa1bc
vim +918 drivers/net/ieee802154/ca8210.c

d931acd5 Harry Morris 2017-03-28  902   * @len: length of the buffer being sent
d931acd5 Harry Morris 2017-03-28  903   *
d931acd5 Harry Morris 2017-03-28  904   * Return: 0 or linux error code
d931acd5 Harry Morris 2017-03-28  905   */
d931acd5 Harry Morris 2017-03-28  906  static int ca8210_spi_transfer(
d931acd5 Harry Morris 2017-03-28  907  	struct spi_device  *spi,
d931acd5 Harry Morris 2017-03-28  908  	const u8           *buf,
d931acd5 Harry Morris 2017-03-28  909  	size_t              len
d931acd5 Harry Morris 2017-03-28  910  )
d931acd5 Harry Morris 2017-03-28  911  {
d931acd5 Harry Morris 2017-03-28  912  	int i, status = 0;
d931acd5 Harry Morris 2017-03-28  913  	struct ca8210_priv *priv = spi_get_drvdata(spi);
d931acd5 Harry Morris 2017-03-28  914  	struct cas_control *cas_ctl;
d931acd5 Harry Morris 2017-03-28  915
d931acd5 Harry Morris 2017-03-28  916  	if (!spi) {
d931acd5 Harry Morris 2017-03-28  917  		dev_crit(
d931acd5 Harry Morris 2017-03-28 @918  			&spi->dev,
d931acd5 Harry Morris 2017-03-28  919  			"NULL spi device passed to ca8210_spi_transfer\n"
d931acd5 Harry Morris 2017-03-28  920  		);
d931acd5 Harry Morris 2017-03-28  921  		return -ENODEV;
d931acd5 Harry Morris 2017-03-28  922  	}
d931acd5 Harry Morris 2017-03-28  923
d931acd5 Harry Morris 2017-03-28  924  	reinit_completion(&priv->spi_transfer_complete);
d931acd5 Harry Morris 2017-03-28  925
d931acd5 Harry Morris 2017-03-28  926  	dev_dbg(&spi->dev, "ca8210_spi_transfer called\n");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
