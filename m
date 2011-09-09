Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B499F5909CB43EAA30894396D6AAD68@freqoneremote>
References: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi> <4B499F5909CB43EAA30894396D6AAD68@freqoneremote>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 9 Sep 2011 10:29:47 -0300
Message-ID: <CAMOw1v4sPndKk6A12phG-HDTX7cuL7w_Z_WGGwkEsvGRL_WNQA@mail.gmail.com>
Subject: Re: [PATCH hcidump] avrcp: fix name of metadata field
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Sep 9, 2011 at 9:22 AM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> That's fair.  For what it's worth, would this be better as an enum?

Please, don't top-post.

The avrcp parser in hcidump was done entirely with defines... I don't
see any point in changing that.

Lucas De Marchi
