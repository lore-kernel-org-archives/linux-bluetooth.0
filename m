Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 6/7] Bluetooth: Fix ReqSeq value on sending I-frames
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1254199349-19713-6-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-4-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-5-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-6-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 21:59:59 -0700
Message-Id: <1254200399.2659.77.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> ReqSeq shall be set to BufferSeq instead of ExpectedTxSeq. BufferSeq gives
> real notion of txWindow at sending side (the side sending that I-frame).
> It is incremented only when I-frames are pulled by reassembly function.

more explanation in plain English.

Regards

Marcel


