Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Should btmgmt be installed?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151030120053.GA10576@t440s.lan>
Date: Sat, 31 Oct 2015 13:00:29 +0900
Cc: Pacho Ramos <pacho@gentoo.org>, linux-bluetooth@vger.kernel.org
Message-Id: <574E1F38-2124-420A-970D-452A134CD192@holtmann.org>
References: <1446017598.18413.23.camel@gentoo.org> <20151030120053.GA10576@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Some people downstream is asking us to install btmgmt utility but, for
>> some reason, it looks like upstream makefile rules don't install it. Is
>> that being missed on purpose? Should Makefiles be fixed to get it
>> installed or that utility is not meant to be installed in users
>> systems?
> 
> I think this is mostly because of historical reasons. The btmgmt tool
> wasn't created for anything else except a developer testing tool
> initially. It's still supposed to be just a developer tool, but if
> people have good reasons to use it then I don't personally have anything
> against making it installable through the makefile rules. Someone should
> just send a patch for it. That said, Marcel might have a differing
> opinion on the matter (though his silence so far is promising ;)

I do not think btmgmt should be installed. It is not a tool with a stable interface nor is it useful for non-developers. The main tool for interaction should be bluetoothctl.

Also hciconfig and hcitool are not really tools that should be installed these days. They are actually harmful since they inject HCI commands. And with that btmgmt is not as bad, but still harmful since it can mess with the mgmt interface.

The one thing I really like to avoid is that btmgmt ends up in all the howto docs as some tool that someone can rely on. I do not think it is such kind of tool.

Regards

Marcel

