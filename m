Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 15:36:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC BlueZ 0/1] On demand LE link encryption/authentication
Message-ID: <20120503123623.GA11300@x220.ger.corp.intel.com>
References: <1335542725-8806-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335542725-8806-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Apr 27, 2012, Anderson Lizardo wrote:
> This patch adds support in BlueZ for only increasing security level of the LE
> link when the ATT request fails with "Insufficient Encryption" or "Insufficient
> Authentication". This mechanism is described on Core Specification page 1837
> ("3.2.5 Attribute Permissions") and 1876 ("4 Security Considerations"). This
> allows for very low latency connections when encryption is not required.
> 
> On a related topic, we would like to propose changing how LE Security
> Modes/Levels are mapped to BlueZ/kernel security levels. Currently, for LE the
> kernel does the following mapping:
> 
> * seclevel SDP (0): not used by LE. Effectively should work like LOW.
> * seclevel LOW (1): no authentication and no encryption (LE Security Mode 1
>   Level 1)
> * seclevel MEDIUM (2): Unauthenticated pairing with encryption (LE Security
>   Mode 1 Level 2), uses Just Works pairing algorithm
> * seclevel HIGH (3): Authenticated pairing with encryption (LE Security Mode 1
>   Level 3), uses Passkey Entry pairing algorithm
> 
> There is no support for LE Security Mode 2. Our proposal is to:
> 
> 1) Rename SDP level to NONE. It will mean "no authentication and no encryption"
>    for LE, for BR/EDR it will be unchanged.
> 2) use LOW for "Unauthenticated pairing with encryption"
> 3) use MEDIUM for "Authenticated pairing with encryption"
> 4) HIGH becomes unused for LE (maybe mapping to MEDIUM?)
> 
> We believe this would align better with BR/EDR and with the definition of LE
> Security Mode 2. Thoughts?

MEDIUM for BR/EDR means unauthenticated so your rewritten definition
wouldn't match that anymore. Regarding security level 0 (SDP/NONE) the
specification says:

"Permitted only for SDP and service data sent via either L2CAP fixed
signaling channels or the L2CAP connectionless channel to PSMs that
correspond to service class UUIDs which are allowed to utilize Level 0."

Based on that I do think the s/SDP/NONE/ rename could make sense and
would be applicable to LE which uses a fixed CID. However in that case
there wouldn't really be any practical difference between NONE and LOW
for LE. MEDIUM would still map unauthenticated and HIGH to authenticated.

Johan
