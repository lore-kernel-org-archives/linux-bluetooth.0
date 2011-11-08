Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Nov 2011 18:16:48 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -v2 1/2] Bluetooth: Rename l2cap_check_security()
Message-ID: <20111108211648.GA16286@samus.indt.org>
References: <1320786686-1599-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320786686-1599-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 19:11 Tue 08 Nov, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> rename to l2cap_chan_check_security() to make it consistent with other
> l2cap_exported functions. This function will be exported in a later
> commit.

Minor nitpick, I think the last sentence is not true anymore.


Cheers,
-- 
Vinicius
