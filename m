Return-Path: <robherring2@gmail.com>
Date: Tue, 12 Dec 2017 14:09:31 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: Add optional nvmem BD address
 bindings to ti,wlink-st
Message-ID: <20171212200931.mnlmdwimu4ldmzin@rob-hp-laptop>
References: <1512701860-8321-1-git-send-email-david@lechnology.com>
 <1512701860-8321-3-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512701860-8321-3-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 07, 2017 at 08:57:39PM -0600, David Lechner wrote:
> This adds optional nvmem consumer properties to the ti,wlink-st device tree
> bindings to allow specifying the BD address.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes:
> * Renamed "mac-address" to "bd-address"
> * Fixed typos in example
> * Specify byte order of "bd-address"
> 
>  Documentation/devicetree/bindings/net/ti,wilink-st.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
