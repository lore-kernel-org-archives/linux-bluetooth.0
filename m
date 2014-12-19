Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] gdbus: use caller's bus name in polkit authorization check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415879499-920-1-git-send-email-hannu.mallat@jollamobile.com>
Date: Fri, 19 Dec 2014 11:15:13 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E76B9C62-EBB2-4D6F-9918-A4D85C101332@holtmann.org>
References: <1415879499-920-1-git-send-email-hannu.mallat@jollamobile.com>
To: Hannu Mallat <hannu.mallat@jollamobile.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hannu,

> Use the message sender's bus name instead of bluetooth daemon's own
> bus name in polkit authorization query.
> 
> Added the message as a parameter to GDBusSecurityFunction so that the
> sender name (and possibly other message characteristics) can be used
> for authorization.

so I wrote this code in 2009 as it seems. I can not even judge if my code is correct or your change is the correct one. It has been too long ago. You would need to convince me which one is the correct behavior when it comes to PolicyKit.

Regards

Marcel

