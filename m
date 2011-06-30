Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 18:24:19 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] Bluetooth: Check earlier for L2CAP ERTM frames to
 drop
Message-ID: <20110630212419.GF25602@joana>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
 <1309383324-12002-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309383324-12002-2-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2011-06-29 14:35:19 -0700]:

> Even when the received tx_seq is expected, the frame still needs to be
> dropped if the TX window is exceeded or the receiver is in the local
> busy state.

The check doesn't mean that TX window is exceeded, it means that we have an
invalid tx_seq and connection should be closed. I don't see the point in
moving the expected check to after this one.
About the local busy check. Is it worth to drop expected frames when on local
busy? What are the advantages/disadvantages? Drop will trigger SREJ while
Store will press the buffer. Do you have measures to prove this?

	Gustavo
