Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 14:49:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Padding should be removed from EIR data
Message-ID: <20120426114949.GA3261@x220.ger.corp.intel.com>
References: <1335360434-28774-1-git-send-email-vishal.agarwal@stericsson.com>
 <20120426105717.GA1573@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120426105717.GA1573@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Thu, Apr 26, 2012, Johan Hedberg wrote:
> > +static inline size_t eir_get_padding_offset(u8 *eir, size_t eir_len)
> 
> I'm not completely sure about this name. Would eir_significant_len()
> sound better? The core spec uses the terminology "significant part" and
> non-significant part" to refer to this so I thought reusing that might
> make it clearer what we're dealing with.

I changed my mind: let's just call it eir_get_length(). And to make it
more clear call the input parameters data and data_len.

Johan
