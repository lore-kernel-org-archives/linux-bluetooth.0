Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 18:21:09 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: LE supported host configuration using management
Message-ID: <20110616212109.GE2594@joana>
References: <BANLkTi=9F=3gXcPte3NF-XA21C=Dkv04kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTi=9F=3gXcPte3NF-XA21C=Dkv04kw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2011-06-16 17:52:01 -0300]:

> Hi,
> 
> We need a way to set the LE supported(host) bit using the management
> interface. The question is: create a new command for this purpose only
> or there are other adapter initialization settings planned to be
> implemented? We could create a generic message passing all settings
> once.
> 
> Even if the controller supports LE, we need a way to disable LE. The
> current interleaved discovery implementation checks the if the
> controller LE bit only, a correct implementation should check both:
> controller and host bits. BlueZ has an option "EnableLE" in main.conf
> used to control if the LE supported host bit should be set or not.
> 
> SPEC page 915 describe how this Write_LE_Host_Support command works.

I think it could be a new command. MGMT_OP_LE_SUPPORT.

And dont we also need the send a Read_LE_Host_Support on the LE adapter init
sequence?

	Gustavo
