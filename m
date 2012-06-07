Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jun 2012 16:43:43 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: vishal agarwal <vishal.bluez@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Behaviour when LTK is generated as a slave
Message-ID: <20120607194343.GA10551@echo>
References: <CA+_sZW_d7hZFvko1eaJJeDsV+QBohx12jgUoGwe=Uu9gCCpZEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+_sZW_d7hZFvko1eaJJeDsV+QBohx12jgUoGwe=Uu9gCCpZEQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On 11:08 Thu 07 Jun, vishal agarwal wrote:
> Hi Vinicius,
> 
> In file mgmtops.c in function mgmt_new_ltk, function bonding_complete
> is called only if ev->key.master is true.
> It means that as a slave when LTK is generated bonding_complete
> function will not be called. Is it intended? If so please help me in
> understanding this behaviour.

Yes, it is intended. The purpose of that "master" field is to inform the
"direction" of the key.

For now, that we can only assume the Master role of LE connections, that check
may be kept simple as that. When we are able to support LE single mode
adapters (I don't know if it makes sense) that check may need some 
re-thinking.

> 
> Thanks
> Vishal


Cheers,
-- 
Vinicius
