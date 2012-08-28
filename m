Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Aug 2012 10:30:04 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix redundant NULL checks in
 convert_raw_attr_to_xml_func
Message-ID: <20120828173004.GA4928@x220.sheraton.com>
References: <1346160796-23277-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346160796-23277-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Aug 28, 2012, Szymon Janc wrote:
> Param data can't be NULL and was already dereferenced before check.
> 
> ---
>  src/sdp-xml.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Both patches have been applied. Thanks.

Johan
