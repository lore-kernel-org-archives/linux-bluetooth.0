Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2 00/18] Rework HIDP Module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
Date: Tue, 2 Apr 2013 09:38:36 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>
Message-Id: <14D61081-B665-4A03-840C-52CB64ECB1C4@holtmann.org>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This is my second attempt to get these patches merged. I added 4 more fixes at
> the end and removed the patches that were already merged by Gustavo.
> 
> This fixes a lot of issues with the HIDP layer. It is currently nearly
> impossible to use HIDP devices. Every attempt (except the first) to connect a
> device results in an oops or panic for me.
> 
> I haven't found a way to fix this easily, so I decided to rewrite the session
> handling of HIDP.

I am generally fine with these patches after a quick read-through. However I am not 100% sure that hci_conn_user is the right approach.

So my question is if we really want to base this of the ACL link itself and not base this around L2CAP directly. Every L2CAP connection implies a hci_conn in the end. Would it be hard to have something like l2cap_user instead of hci_conn_user?

Regards

Marcel

