Return-Path: <cyrus@holtmann.org>
Message-ID: <83EA6ECBBD0D44FFB9F5CBB90B58E540@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Johan Hedberg" <johan.hedberg@gmail.com>
Cc: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>,
	<linux-bluetooth@vger.kernel.org>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi> <1315523690-11195-4-git-send-email-lucas.demarchi@profusion.mobi> <20110909104123.GA23711@dell.ger.corp.intel.com> <11E07DE5941E41239E3CE07CF9712B64@freqoneremote> <20110909123517.GA26219@dell.ger.corp.intel.com>
In-Reply-To: <20110909123517.GA26219@dell.ger.corp.intel.com>
Subject: Re: [PATCH 3/5] avrcp: get/set three-byte company-id
Date: Fri, 9 Sep 2011 18:19:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

-----Original Message----- 
From: Johan Hedberg
Sent: Friday, September 09, 2011 7:35 AM
To: David Stockwell
Cc: Lucas De Marchi ; linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] avrcp: get/set three-byte company-id

Hi David,

On Fri, Sep 09, 2011, David Stockwell wrote:
> A short cut: the output is a contiguous array of uint_8, so masking
> with 0xFF should be unnecessary.  Would this be required for non-x86
> (including x86_64) architectures?

Firstly, please don't top-post on this mailing list.

+++++ Sorry...I am quite entrenched in the .Net world by day, so I forgot. 
Then did not send an apology afterwards.

If you don't do "& 0xff" and the value you're trying to assign to cid[n]
is greater than 0xff isn't the result of the integer overflow that
follows essentially the same as if you had done "% (0xff + 1)" (which is
not what you want in this case).

+++++ I saw the rest of the discussion...cheers.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

