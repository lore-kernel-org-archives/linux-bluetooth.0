Return-Path: <thierry.escande@linaro.org>
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Bluetooth: hci_qca: Add serdev support
Date: Wed, 14 Mar 2018 16:55:11 +0100
Message-Id: <20180314155514.3374-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patchset enables the Qualcomm BT controller QCA6174 node in the
device tree of the db820c board. This allows the bluetooth chipset to
be probed and registered against the hci layer by using the serdev
framework.

This patchset also contains the documentation for the compatible
string "qcom,qca6174-bt" related to this chipset.

v4:
- Fix dt binding documentation
- Address some other issues in patch #3

v3:
- Address comments for patch #3 (details in patch)

v2:
- Fix author email

Thierry Escande (3):
  arm64: dts: apq8096-db820c: enable bluetooth node
  dt-bindings: net: bluetooth: Add qualcomm-bluetooth
  Bluetooth: hci_qca: Add serdev support

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  34 +++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  14 +++
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  17 ++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  32 ++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 ++
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/hci_qca.c                        | 109 ++++++++++++++++++++-
 7 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

-- 
2.14.1
