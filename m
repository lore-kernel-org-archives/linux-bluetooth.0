Return-Path: <bjorn.andersson@linaro.org>
Date: Mon, 4 Sep 2017 11:01:01 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@linaro.org>, linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3] Bluetooth: btqcomsmd: BD address setup
Message-ID: <20170904180101.GC1165@minitux>
References: <1504521784-9766-1-git-send-email-loic.poulain@linaro.org>
 <6989AC8D-D666-402E-A99E-930C0B007A9F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
In-Reply-To: <6989AC8D-D666-402E-A99E-930C0B007A9F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon 04 Sep 04:28 PDT 2017, Marcel Holtmann wrote:
[..]
> Also please don’t forget
> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt file. We
> need to document things.
> 

The qcom,wcnss-bt compatible is documented as part of
Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt

Loic, please amend this.

Regards,
Bjorn
