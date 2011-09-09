Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Sep 2011 13:41:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	David Stockwell <dstockwell@frequency-one.com>
Subject: Re: [PATCH 3/5] avrcp: get/set three-byte company-id
Message-ID: <20110909104123.GA23711@dell.ger.corp.intel.com>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1315523690-11195-4-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315523690-11195-4-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 08, 2011, Lucas De Marchi wrote:
> +static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
> +{
> +	cid[0] = cid_in >> 16;
> +	cid[1] = cid_in >> 8;
> +	cid[2] = cid_in;
> +}

You seem to have forgotten the "& 0xff" part here. Other than that I
didn't seen any obvious issues in the patch set.

Johan
