Return-Path: <cyrus@holtmann.org>
Date: Sun, 26 Jul 2015 21:54:42 -0700 (PDT)
Message-Id: <20150726.215442.695531626290691136.davem@davemloft.net>
To: johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth 2015-07-23
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150723151722.GA20850@t440s.ger.corp.intel.com>
References: <20150723151722.GA20850@t440s.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Thu, 23 Jul 2015 18:17:22 +0300

> Here's another one-patch pull request for 4.2 which targets a potential
> NULL pointer dereference in the LE Security Manager code that can be
> triggered by using older user space tools. The issue has been there
> since 4.0 so there's the appropriate "Cc: stable" in place.
> 
> Let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
