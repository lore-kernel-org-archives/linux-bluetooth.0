Return-Path: <cyrus@holtmann.org>
Message-ID: <4AA13234.5060909@charter.net>
Date: Fri, 04 Sep 2009 11:28:52 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@nokia.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [4.48] SDP Discovery not reset on error
References: <4AA08357.7050903@charter.net> <20090904063104.GA23278@jh-x301>
In-Reply-To: <20090904063104.GA23278@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> Hi Peter,
>
>   
> You might want to take a hcidump output of the second connect failure,
> i.e. run "hcidump -XV" as root while trying to connect. It would also be
> interesting to know if this is reproducable with later BlueZ versions like
> 4.52. I tried to do a few quick tests with it but was unable to reproduce
> the issue.
>
> Johan
>
>   
Thanks, Johan. It hadn't occurred to me that the host controller might 
be in the inconsistent state in this situation.  I'll work on that.

I hadn't moved to 4.52 yet because I'm still trying to track down what I 
think is a race condition in avdtp.

~Peter
