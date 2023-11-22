Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B5112;
	Wed, 22 Nov 2023 02:37:06 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C2BF12014A;
	Wed, 22 Nov 2023 11:37:04 +0100 (CET)
Date: Wed, 22 Nov 2023 11:37:00 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tim Jiang <quic_tjiang@quicinc.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: qca: add support for QCA2066
Message-ID: <ZV3ZzNx2B+Lzvlnt@francesco-nb.int.toradex.com>
References: <20230912093957.3334273-1-quic_tjiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912093957.3334273-1-quic_tjiang@quicinc.com>

Hello Tim,

On Tue, Sep 12, 2023 at 05:39:57PM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and NVM downloading.
> as the RF performance of QCA2066 SOC chip from different foundries may
> vary. Therefore we use different NVM to configure them based on board ID.

Will this change enable using QCA2066 BT over USB?

Francesco

