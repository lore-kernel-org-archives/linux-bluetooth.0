Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Mar 2011 14:16:43 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: accessing Link key within the Bluetooth module
Message-ID: <20110322171643.GA2202@joana>
References: <4D870E6F.4050502@Atheros.com>
 <20110321134833.GA8819@jh-x301>
 <4D8825C7.1000904@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D8825C7.1000904@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

* Suraj Sumangala <suraj@Atheros.com> [2011-03-22 09:59:59 +0530]:

> Hi Johan,
> 
> On 3/21/2011 7:18 PM, Johan Hedberg wrote:
> > Hi Suraj,
> >
> > That list only gets populated if you've enabled the management interface
> > (enable_mgmt=1 module option) and have a matching user space version
> > with management interface support.
> 
> Thanks,
> The link key is required for creating an AMP connection.
> 
> Does it make sense to depend the AMP module on the "enable_mgmt" feature?

Yes, but does not use enable_mgmt in your code.

-- 
Gustavo F. Padovan
http://profusion.mobi
