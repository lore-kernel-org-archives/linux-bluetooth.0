Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Jun 2011 14:55:58 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: keithp@keithp.com, padovan@profusion.mobi, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression caused by "Bluetooth: Map sec_level to link key
 requirements"
Message-ID: <20110610055558.GA1832@dell>
References: <yunboy7a2so.fsf@aiko.keithp.com>
 <99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
 <20110609083345.GA2894@dell.ccr.corp.intel.com>
 <yuny61b3pnm.fsf@aiko.keithp.com>
 <99B09243E1A5DA4898CDD8B700111448175AA2DE98@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448175AA2DE98@EXMB04.eu.tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 09, 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
> >I re-pair'ed using a manually entered a 16 digit pin, but now 
> >DUN setup doesn't succeed at all.
> 
> Did you try to remove all stored link keys and start again?
> If you already have a pincode which is insecure you have to remove it manually.
> 
> Try 'hciconfig hciX noauth noencrypt ' before.
> 
> Check syslog and switch debug on in the kernel first.

So I just realized that the BITE tests were only done for mgmtops.c and
not hciops.c. One critical difference is that conn->key_type will not be
set (or actually set to 0xff) for connections which happen after the
initial pairing has occurred. We're right now testing a one-line patch
which might fix the issue. Luiz will send it soon if it turns out to
work fine.

Johan
