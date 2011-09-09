Return-Path: <cyrus@holtmann.org>
Message-ID: <11E07DE5941E41239E3CE07CF9712B64@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Johan Hedberg" <johan.hedberg@gmail.com>,
	"Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi> <1315523690-11195-4-git-send-email-lucas.demarchi@profusion.mobi> <20110909104123.GA23711@dell.ger.corp.intel.com>
In-Reply-To: <20110909104123.GA23711@dell.ger.corp.intel.com>
Subject: Re: [PATCH 3/5] avrcp: get/set three-byte company-id
Date: Fri, 9 Sep 2011 07:21:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A short cut: the output is a contiguous array of uint_8, so masking with 
0xFF should be unnecessary.  Would this be required for non-x86 (including 
x86_64) architectures?

DS

-----Original Message----- 
From: Johan Hedberg
Sent: Friday, September 09, 2011 5:41 AM
To: Lucas De Marchi
Cc: linux-bluetooth@vger.kernel.org ; David Stockwell
Subject: Re: [PATCH 3/5] avrcp: get/set three-byte company-id

Hi,

On Thu, Sep 08, 2011, Lucas De Marchi wrote:
> +static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
> +{
> + cid[0] = cid_in >> 16;
> + cid[1] = cid_in >> 8;
> + cid[2] = cid_in;
> +}

You seem to have forgotten the "& 0xff" part here. Other than that I
didn't seen any obvious issues in the patch set.

Johan 

