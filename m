Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 18:37:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2 v2] client: Fix not propagating GError in
 session API functions
Message-ID: <20120426153741.GA9715@x220.P-661HNU-F1>
References: <1335453065-12641-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335453065-12641-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Apr 26, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The errors should be properly forward to the caller and not just convert
> to generic error.
> ---
> v2: Fix returning errno instead of boolean

Both patches have been applied. Thanks.

Johan
