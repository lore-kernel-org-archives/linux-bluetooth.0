Return-Path: <mka@chromium.org>
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date: Thu, 20 Sep 2018 15:34:34 -0700
Message-Id: <20180920223436.202454-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the BD address is
through the device tree. The btqcomsmd driver is an example, it can
read the BD address from the DT property 'local-bd-address'. It is
also planned to extend the hci_qca driver to support setting the BD
address through the DT.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds an API to retrieve the BD address of a device
and adapts the btqcomsmd driver to use this API.

Matthias Kaehlcke (2):
  device property: Add device_get_bd_address() and
    fwnode_get_bd_address()
  Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()

 drivers/base/property.c       | 49 +++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqcomsmd.c |  5 ++--
 include/linux/property.h      |  4 +++
 3 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog
