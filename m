Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 11:46:51 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Subject: Re: [RFCv1 17/20] Bluetooth: Ignore BR/EDR packet size constraints
 when fragmenting for AMP
Message-ID: <20121001084649.GM10053@aemeltch-MOBL1>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
 <1347387691-5285-18-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347387691-5285-18-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 11, 2012 at 11:21:28AM -0700, Mat Martineau wrote:
> When operating over BR/EDR, ERTM accounts for the maximum over-the-air
> packet size when setting the PDU size.  AMP controllers do not use the
> same over-the-air packets, so the PDU size should only be based on the
> HCI MTU of the AMP controller.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

Best regards 
Andrei Emeltchenko 
