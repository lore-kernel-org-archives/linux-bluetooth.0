Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Oct 2009 11:25:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix memory leaks
Message-ID: <20091002092540.GA13444@jh-x301>
References: <200909251623.02240.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200909251623.02240.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 25, 2009, Steve Grubb wrote:
> I was doing some code reviews of the 4.54 release and found a few memory
> leaks. These are mostly in error paths.
> 
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>

I went ahead and pushed this patch with the few necessary fixes.

Johan
