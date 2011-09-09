Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Sep 2011 15:46:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] avrcp: get/set three-byte company-id
Message-ID: <20110909124645.GA26822@dell.ger.corp.intel.com>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1315523690-11195-4-git-send-email-lucas.demarchi@profusion.mobi>
 <20110909104123.GA23711@dell.ger.corp.intel.com>
 <11E07DE5941E41239E3CE07CF9712B64@freqoneremote>
 <20110909123517.GA26219@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110909123517.GA26219@dell.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 09, 2011, Johan Hedberg wrote:
> On Fri, Sep 09, 2011, David Stockwell wrote:
> > A short cut: the output is a contiguous array of uint_8, so masking
> > with 0xFF should be unnecessary.  Would this be required for non-x86
> > (including x86_64) architectures?
> 
> Firstly, please don't top-post on this mailing list.
> 
> If you don't do "& 0xff" and the value you're trying to assign to cid[n]
> is greater than 0xff isn't the result of the integer overflow that
> follows essentially the same as if you had done "% (0xff + 1)" (which is
> not what you want in this case).

Actually those two operations result in the same value (I even did a
quick test program for this). So you're right :)

Johan
