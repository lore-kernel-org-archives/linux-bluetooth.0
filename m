Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: ATT/GATT shared code (Re: [PATCH BlueZ v3 06/16] attrib: Change g_attrib_set_destroy_function return type)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_MNgzqquKHCtrDPjU3OaaLba6zb=kwCjUnUm-qNccevpw@mail.gmail.com>
Date: Fri, 3 May 2013 07:55:09 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <AE3F5471-8387-4451-A851-47E5FAAB4521@holtmann.org>
References: <CAJdJm_MNgzqquKHCtrDPjU3OaaLba6zb=kwCjUnUm-qNccevpw@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> I also like to see ATT and GATT being implemented as src/shared/ under LGPL so we can be easily share it in the future. I already have some (unpublished) code for src/shared/att.[ch] and src/shared/gatt.[ch] already, but I think what we first need to do is to figure out how we handle clients and servers from the kernel side. Especially with the background of the kernel auto-connecting LE channels in the future.
> 
> We have been working recently on cleaning up GATT/ATT code and
> implementing unit tests for it (as you can see from our latest patches
> in BlueZ). Is this unpublished code based on existing code, or
> something written from scratch? If the latter, I think we should not
> spend time on cleaning up existing GATT code.

it is from scratch code and also possible throw away code. It does nothing useful so far. However one think became pretty clear, the current gattrib needs massive cleanups. Not just a little bit. Especially when it comes to where GATT server is located and where GATT client.

I want to be able to create unit tests that simulate PTS and also extra unit tests that test the raw ATT protocol and GATT procedures. That is the basic goal here.

Regards

Marcel

