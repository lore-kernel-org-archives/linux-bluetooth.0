Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Sep 2010 10:15:33 +0000
From: Jarek Poplawski <jarkao2@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcel@holtmann.org, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: Possible regression with skb_clone() in 2.6.36
Message-ID: <20100910101533.GA21844@ff.dom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283988727-1456-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

On 2010-09-09 01:32, Gustavo F. Padovan wrote:
> I've been experiencing some problems when running the L2CAP Streaming mode in
> 2.6.36. The system quickly runs in an Out Of Memory condition and crash. That
> wasn't happening before, so I think we may have a regression here (I didn't
> find where yet). The crash log is below.
> 
> The following patch does not fix the regression, but shows that removing the
> skb_clone() call from l2cap_streaming_send() we workaround the problem. The
> patch is good anyway because it saves memory and time.
> 
> By now I have no idea on how to fix this.

My suggestion is to check the length of conn->data_q in hci_send_acl()
while this happens, and maybe try to set some limit here.

Jarek P.
