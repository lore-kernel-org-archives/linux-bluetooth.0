Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 11:52:37 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 08/11] Bluetooth: Remove the link key if LE pairing fails
Message-ID: <20110822145236.GB15726@piper>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313798895-8705-9-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313798895-8705-9-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21:08 Fri 19 Aug, Vinicius Costa Gomes wrote:
> If the pairing attempt fails, remove the link key.
> 
> In the case that the link key wasn't found by the remote device, force
> pairing to happen again. This is the correct behaviour when one of the
> devices "forgot" its keys.
> 

This specific commit has some possible security implications, please
ignore it.


Cheers,
-- 
Vinicius
