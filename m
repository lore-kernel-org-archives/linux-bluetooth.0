Return-Path: <cyrus@holtmann.org>
Message-ID: <1344937850.2733.2.camel@novo.hadess.net>
Subject: Re: [PATCH] input: Implement idle timeout for fakehid
From: Bastien Nocera <hadess@hadess.net>
To: Jeff Hansen <x@jeffhansen.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 14 Aug 2012 10:50:50 +0100
In-Reply-To: <50293C10.2000305@jeffhansen.com>
References: <50293C10.2000305@jeffhansen.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-08-13 at 11:40 -0600, Jeff Hansen wrote:
> (bump)
> 
> The batteries on my BD remote would die in a few days without this
> patch.  The idle timeout needs to be enforced for fakehid devices as
> well as normal HID devices.

Except that the timeout is disabled by default for HID devices. I posted
a patch that requires a little bit of work to get pushed last month or
so.

