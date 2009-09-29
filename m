Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/7] Bluetooth: Implement RejActioned flag
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1254199349-19713-5-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-4-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-5-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 21:59:23 -0700
Message-Id: <1254200363.2659.76.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> RejActioned is used to prevent retransmission when a entity is on the
> WAIT_F state. After send a frame with F-bit set the remote entity can
> receive I-frames again. Local L2CAP receives the F-bit and start sending
> I-frames.

same as the other one. Explain why this should be included after the
merge windows has closed.

Regards

Marcel


