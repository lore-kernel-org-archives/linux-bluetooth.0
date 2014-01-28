Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v3 0/4] Regression fixes for rfcomm/tty.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140128083154.GA29060@sottospazio.it>
Date: Tue, 28 Jan 2014 04:08:58 -0800
Cc: Alexander Holler <holler@ahsoftware.de>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	peter@hurleysoftware.com,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
	stable@vger.kernel.org
Message-Id: <AF7651E9-AAC4-43F8-9117-7CFFB4F542FF@holtmann.org>
References: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it> <53C8DDF7-94EA-4E01-A2A9-C366F9F85530@holtmann.org> <52DCDF84.1040902@ahsoftware.de> <E0DDC796-EECF-46B6-8EDF-801CF8EFD456@holtmann.org> <20140128083154.GA29060@sottospazio.it>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

>>>> all 4 patches have been applied to bluetooth-next tree.
>>> 
>>> Maybe a bit late, but I've just seen they miss a Cc: stable@vger.kernel.org to automatically end up in 3.12 and 3.13 too.
>> 
>> we can always promote them to stable. On Purpose I wanted them to cycle through bluetooth-next for a while to make sure they do not cause any other regressions.
>> 
> 
> Unfortunately it seems I overlooked the fact that rfcomm_dev_activate() is
> called with the port->mutex held. So patches 2/3/4 cause a regression I missed
> because I didn't turn on the appropriate debug options (circular locking
> dependency, a bug report already appeared on this list).
> 
> I'm afraid this all stems from my partial knowledge of the tty_port code and
> unfortunately I don't know how to solve the problem right now.
> 
> I think it's better to revert those patches for the moment.

can we get this fixed instead. If I revert them, I have a different issue. So I am trading one bug for another one.

Regards

Marcel

