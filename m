Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 May 2012 10:22:05 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [PATCH] Bluetooth: Initialize the transmit queue for L2CAP
 streaming mode
Message-ID: <20120515072203.GA31087@aemeltch-MOBL1>
References: <1337032167-30454-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337032167-30454-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Mon, May 14, 2012 at 02:49:27PM -0700, Mat Martineau wrote:
> Commit 105bdf9ec19e729bacdb33861c74fcf3eb39eb37 introduced a
> regression in L2CAP streaming mode due to rearranged initialization
> code that is shared between ERTM and streaming mode.  This change
> makes sure the transmit queue is initialized in both modes.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>

This one I did not test yet.

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

Best regards 
Andrei Emeltchenko 


