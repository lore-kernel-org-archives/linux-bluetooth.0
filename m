Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: can't find the patch of "Bluetooth: Delay check for conn->smp
 in smp_conn_security()" in the smp.c file of bluetooth-next
Date: Thu, 8 Oct 2015 06:28:33 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11AC199E@SHSMSX104.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E11AC18F5@SHSMSX104.ccr.corp.intel.com>
 <20151008053757.GB22761@t440s.P-661HNU-F1>
In-Reply-To: <20151008053757.GB22761@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks.

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@intel.com] 
Sent: Thursday, October 8, 2015 1:38 PM
To: Zheng, Wu
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: can't find the patch of "Bluetooth: Delay check for conn->smp in smp_conn_security()" in the smp.c file of bluetooth-next

Hi Zheng Wu,

On Thu, Oct 08, 2015, Zheng, Wu wrote:
> The patch of "Bluetooth: Delay check for conn->smp in 
> smp_conn_security()" can fix an issue of 6lowpan over bluetooth le.
> 
> However, at current, the patch can't be found in bluetooth-next.git.
> 
> Why is it removed? 

It was moved to the bluetooth.git stable tree since we wanted it into the 4.3 Linux kernel release. It'll come back to bluetooth-next.git the next time we rebase our tree against net-next.git.

Johan
