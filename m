Return-Path: <thierry.escande@linaro.org>
Subject: Re: [PATCH v6 0/3] Bluetooth: hci_qca: Add serdev support
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, David Brown
 <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180328095133.14343-1-thierry.escande@linaro.org>
Message-ID: <71ca3339-2670-5c04-0457-8c1fd6cdf7f1@linaro.org>
Date: Thu, 29 Mar 2018 19:56:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180328095133.14343-1-thierry.escande@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 28/03/2018 11:51, Thierry Escande wrote:
> Hi,
> 
> This patchset enables the Qualcomm BT controller QCA6174 node in the
> device tree of the db820c board. This allows the bluetooth chipset to
> be probed and registered against the hci layer by using the serdev
> framework.
> 
> This patchset also contains the documentation for the compatible
> string "qcom,qca6174-bt" related to this chipset.
> 
> v6:
> - Move pinctrl properties into subnodes
> - fix binding documentation
> 
> v5:
> - Rename 'bt-disable-n' gpio as 'enable'
> 
> v4:
> - Fix dt binding documentation
> - Address some other issues in patch #3
> 
> v3:
> - Address comments for patch #3 (details in patch)
> 
> v2:
> - Fix author email
> 
> Thierry Escande (3):
>    arm64: dts: apq8096-db820c: enable bluetooth node
>    dt-bindings: net: bluetooth: Add qualcomm-bluetooth
>    Bluetooth: hci_qca: Add serdev support
> 
>   .../devicetree/bindings/net/qualcomm-bluetooth.txt |  34 +++++++
>   arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  26 +++++
>   .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  21 ++++
>   arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  33 +++++++
>   arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 ++
>   drivers/bluetooth/Kconfig                          |   1 +
>   drivers/bluetooth/hci_qca.c                        | 109 ++++++++++++++++++++-
>   7 files changed, 232 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> 

Please hold this patchset as a v7 is coming soon.

Regards,
Thierry
