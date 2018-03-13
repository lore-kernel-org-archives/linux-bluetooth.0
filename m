Return-Path: <bjorn.andersson@linaro.org>
Date: Tue, 13 Mar 2018 11:00:52 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: apq8096-db820c: enable bluetooth node
Message-ID: <20180313180052.GV18510@minitux>
References: <20180313164444.19881-1-thierry.escande@linaro.org>
 <20180313164444.19881-2-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313164444.19881-2-thierry.escande@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue 13 Mar 09:44 PDT 2018, Thierry Escande wrote:

> Add a new serial node for the Qualcomm BT controller QCA6174. This
> allows automatic probing and hci registration through the serdev
> framework instead of relying on the userspace helpers.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
