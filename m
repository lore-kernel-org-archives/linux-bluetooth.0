Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 4/7] Bluetooth: send ReqSeq on I-frames
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1254199349-19713-4-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-4-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 21:58:33 -0700
Message-Id: <1254200313.2659.75.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> A ERTM channel can acknowledge received I-frames by sending a I-frame with
> the proper ReqSeq value (i.e. ReqSeq is set to ExpectedTxSeq).

how does this justify for after the merge window? Explain it like I have
no idea about L2CAP ERTM.

Regards

Marcel


