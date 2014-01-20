Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v3 0/4] Regression fixes for rfcomm/tty.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <52DCDF84.1040902@ahsoftware.de>
Date: Mon, 20 Jan 2014 09:37:14 -0800
Cc: Gianluca Anzolin <gianluca@sottospazio.it>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	peter@hurleysoftware.com,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
	stable@vger.kernel.org
Message-Id: <E0DDC796-EECF-46B6-8EDF-801CF8EFD456@holtmann.org>
References: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it> <53C8DDF7-94EA-4E01-A2A9-C366F9F85530@holtmann.org> <52DCDF84.1040902@ahsoftware.de>
To: Alexander Holler <holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>> all 4 patches have been applied to bluetooth-next tree.
> 
> Maybe a bit late, but I've just seen they miss a Cc: stable@vger.kernel.org to automatically end up in 3.12 and 3.13 too.

we can always promote them to stable. On Purpose I wanted them to cycle through bluetooth-next for a while to make sure they do not cause any other regressions.

Regards

Marcel

