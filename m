Return-Path: <cyrus@holtmann.org>
Message-ID: <1355256325.6074.0.camel@dellpc>
Subject: Re: hidp bug concerning ctrl_sk sock
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 11 Dec 2012 20:05:25 +0000
In-Reply-To: <1354828992.3394.7.camel@dellpc>
References: <1354828992.3394.7.camel@dellpc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-12-06 at 21:23 +0000, Karl Relton wrote:
> With reference to bug https://bugzilla.kernel.org/show_bug.cgi?id=50541
> it seems to me that the hidp driver has a problem in the hidp_session()
> function.
> 
> The sock structure pointed to by ctrl_sk is being freed from under the
> functions feet (as far as I can see), causing this function to crash.
> Shouldn't a lock_sock or sock_hold be necessary to keep the sock
> structure around until hidp_session has finished with it?
> 
> 
A bit more testing, and a bit more accurate diagnosis to report. The
ctrl_sk is being orphaned in the l2cap bluetooth driver code. The
orphaning sets the sk_wq to null, leading to the OOPS in the
wait_event_timeout() call in hidp_session.

Is there some way of marking the sock as in use so that l2cap doesn't
orphan it straight away?



