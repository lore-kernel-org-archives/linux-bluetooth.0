Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 28 Sep 2010 19:58:25 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Will Woods <wwoods@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	kernel@lists.fedoraproject.org
Subject: Re: bluetooth: add support for btusb devices in recent MacBook Pros
Message-ID: <20100928225825.GA8354@vigoh>
References: <1284757761-11994-1-git-send-email-wwoods@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284757761-11994-1-git-send-email-wwoods@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Will,

* Will Woods <wwoods@redhat.com> [2010-09-17 17:09:19 -0400]:

> These two patches add support for the USB bluetooth controllers found
> in recent MacBook Pro systems. In both cases the device class is
> ff (vend.) rather than the usual e0. The iMac11,1 has the same 
> problem and is handled with an explicit USB_DEVICE() entry, so 
> these two devices are handled the same way.

We already have these patches, yours are a duplicate. Thanks anyway. ;)

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
