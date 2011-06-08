Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 16:24:05 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Rename _busy_wq to _l2cap_wq
In-Reply-To: <20110606173153.GA30641@joana>
Message-ID: <alpine.DEB.2.02.1106081612210.5280@mathewm-linux>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org> <1307143270-2655-2-git-send-email-mathewm@codeaurora.org> <20110606173153.GA30641@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Mon, 6 Jun 2011, Gustavo F. Padovan wrote:

> * Mat Martineau <mathewm@codeaurora.org> [2011-06-03 16:21:08 -0700]:
>
>> This workqueue will be used for general L2CAP work, not just dealing
>> with "busy" frames.
>
> which general L2CAP work are we talking about?

I'll update the commit message and resubmit, but to immediately 
answer your question:

* ERTM tx queue callbacks (patch 3/4 in this series)
* ERTM timers (ack, retrans, monitor) that can utilize proper locking.
* Updating the ERTM tx queue after an AMP channel move and L2CAP 
reconfiguration
* Moving various AMP-related work out of interrupt context


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

