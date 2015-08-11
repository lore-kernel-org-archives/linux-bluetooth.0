Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Aug 2015 14:16:58 -0700 (PDT)
Message-Id: <20150811.141658.1638018493466749703.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth 2015-08-11
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150811200406.GA6173@t440s.P-661HNU-F1>
References: <20150811200406.GA6173@t440s.P-661HNU-F1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Tue, 11 Aug 2015 23:04:06 +0300

> Here's an important regression fix for the 4.2-rc series that ensures
> user space isn't given invalid LTK values. The bug essentially prevents
> the encryption of subsequent LE connections, i.e. makes it impossible to
> pair devices over LE.
> 
> Let me know if there are any issues pulling. Thanks.

Pulled, thanks.
