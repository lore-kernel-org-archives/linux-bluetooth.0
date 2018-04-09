Return-Path: <robherring2@gmail.com>
Date: Mon, 9 Apr 2018 16:16:52 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: mark.rutland@arm.com, marcel@holtmann.org, johan.hedberg@gmail.com,
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] dt-bindings: net: bluetooth: Add
 mediatek-bluetooth
Message-ID: <20180409211652.etq6ylp63b7j65el@rob-hp-laptop>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <958f8a0ef0b557fdfcc02a1e86536e1f97a16e22.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <958f8a0ef0b557fdfcc02a1e86536e1f97a16e22.1522736996.git.sean.wang@mediatek.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 03, 2018 at 03:15:51PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add binding document for a SoC built-in device using MediaTek protocol.
> Which could be found on MT7622 SoC or other similar MediaTek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/net/mediatek-bluetooth.txt | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt

Reviewed-by: Rob Herring <robh@kernel.org>
