Return-Path: <robherring2@gmail.com>
Date: Fri, 15 Dec 2017 17:05:58 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: add TI CC2560 Bluetooth chip
Message-ID: <20171215230558.7vngwc66y2smvdrq@rob-hp-laptop>
References: <1513124971-23717-1-git-send-email-david@lechnology.com>
 <1513124971-23717-2-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513124971-23717-2-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 12, 2017 at 06:29:30PM -0600, David Lechner wrote:
> This adds a compatible string for the Texas Instruments CC2560 Bluetooth
> chip to the existing TI WiLink shared transport bindings. These chips are
> similar enough that the same bindings work for both. The file is renamed
> to ti-bluetooth.txt to make it more generic.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt}     | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt} (78%)

Reviewed-by: Rob Herring <robh@kernel.org>
