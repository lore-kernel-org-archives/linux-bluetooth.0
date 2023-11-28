Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A4D41;
	Mon, 27 Nov 2023 23:31:13 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id D5DDA20378;
	Tue, 28 Nov 2023 08:31:11 +0100 (CET)
Date: Tue, 28 Nov 2023 08:31:07 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] Bluetooth: btnxpuart: remove useless assignment
Message-ID: <ZWWXOxl6XZJs2reN@francesco-nb.int.toradex.com>
References: <20231127191409.151254-1-francesco@dolcini.it>
 <20231127191409.151254-4-francesco@dolcini.it>
 <f19ac2b9-7e4c-44e8-b979-c8c4e9d627ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19ac2b9-7e4c-44e8-b979-c8c4e9d627ab@kernel.org>

On Tue, Nov 28, 2023 at 06:26:56AM +0100, Jiri Slaby wrote:
> On 27. 11. 23, 20:14, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Remove useless assignment of rx_skb to NULL in case the skb is in error,
> > this is already done in h4_recv_buf() that is executed a few lines
> > before.
> 
> In case of error, nxpdev->rx_skb contains the error, not NULL, right?
correct.

The point is that we have

  if (IS_ERR(skb))
    skb = NULL;

at the beginning of h4_recv_buf(), that is called a few lines before,
making the assignment in btnxpuart.c redundant.

Francesco

