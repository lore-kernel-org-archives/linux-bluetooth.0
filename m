Return-Path: <cyrus@holtmann.org>
Date: Sun, 15 Mar 2009 23:20:09 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bea Lam <bea.lam@trolltech.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add "Class" property to org.bluez.Adapter
Message-ID: <20090316022009.GA30455@jh-x301>
References: <49ADD4C8.8040705@trolltech.com> <1236200642.6670.13.camel@localhost.localdomain> <49AF1BB6.7070104@trolltech.com> <20090312150947.GA10037@jh-x301> <49BDADA8.4030909@trolltech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49BDADA8.4030909@trolltech.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bea,

On Mon, Mar 16, 2009, Bea Lam wrote:
> Here's the formatted patch, without the unnecessary
> update_ext_inquiry_response() call.

Thanks! The patch is now pushed upstream. Unfortunately you just missed
the 4.33 release (Marcel already tagged it) so your patch will go into
4.34.

Johan
