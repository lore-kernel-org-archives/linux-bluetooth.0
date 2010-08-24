Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 02:15:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: angelab@codeaurora.org
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix error reporting for SDP Requests
Message-ID: <20100824231558.GA11168@jh-x301>
References: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
 <1282688488.6841.34.camel@localhost.localdomain>
 <f5a72626c821919cb059a7efc6e7fb9f.squirrel@www.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f5a72626c821919cb059a7efc6e7fb9f.squirrel@www.codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Angela,

On Tue, Aug 24, 2010, angelab@codeaurora.org wrote:
> Section 4.4 of the Bluetooth Corev2.1 spec, states that the error code
> shall be 0x04 when an invalid PDU size is received. BlueZ is returning
> error code 0x03 for the following:
> TP/SERVER/SS/BI-01-C  [PATCH 1/4]
> TP/SERVER/SA/BI-03-C  [PATCH 2/4]
> TP/SERVER/SSA/BI-02-C [PATCH 3/4]
> 
> For this test case I sent a bad search attribute request where the max
> amount Of Attribute Data to return is 0, but blueZ fails to respond with
> an error code. The "max amount of attribute data" field has to be set to a
> minimum size of 0x0007 for the request to be valid.
> TP/SERVER/SA/BI-02-C [PATCH 4/4]

Ok, so it sounds like you're using your own test system for this? I
don't think Marcel was referring to what the spec says but what the BITE
tester test vectors require in practice. So far there haven't been any
issues with the BITE with respect to this. Of course it's good to not
just pass with the BITE but to also be consistent with the spec, and so
these patches seem like a good idea. However, could you resend them with
the test case reference in each commit message as well as any other
relevant info like the section in the core spec? Thanks.

Johan
