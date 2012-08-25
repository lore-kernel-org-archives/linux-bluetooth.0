Return-Path: <cyrus@holtmann.org>
From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Sat, 25 Aug 2012 20:35:43 +0200
To: Shea Levy <shea@shealevy.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for Apple vendor-specific devices
Message-ID: <20120825183543.GA4517@polaris.bitmath.org>
References: <1345915686-3915-1-git-send-email-rydberg@euromail.se>
 <50390B54.4040706@shealevy.com>
 <20120825174342.GA4057@polaris.bitmath.org>
 <5039179D.6010909@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5039179D.6010909@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I'm getting a build error due to lack of
> USB_VENDOR_AND_INTERFACE_INFO macro when patching 3.5.2 with that
> patch. Which kernel tree should I patch with this patch to test?

The macro is in the pipe to 3.5.x, probably only a couple of days
away. The patch is for 3.6, as stated, meaning it applies on top of
Linus's tree.

Henrik
