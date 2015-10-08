Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Oct 2015 08:37:57 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: can't find the patch of "Bluetooth: Delay check for conn->smp in
 smp_conn_security()" in the smp.c file of bluetooth-next
Message-ID: <20151008053757.GB22761@t440s.P-661HNU-F1>
References: <2CF57A644018A745B8FE029C7223E16E11AC18F5@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E11AC18F5@SHSMSX104.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zheng Wu,

On Thu, Oct 08, 2015, Zheng, Wu wrote:
> The patch of "Bluetooth: Delay check for conn->smp in
> smp_conn_security()" can fix an issue of 6lowpan over bluetooth le.
> 
> However, at current, the patch can't be found in bluetooth-next.git.
> 
> Why is it removed? 

It was moved to the bluetooth.git stable tree since we wanted it into
the 4.3 Linux kernel release. It'll come back to bluetooth-next.git the
next time we rebase our tree against net-next.git.

Johan
