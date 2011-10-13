Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 10:48:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Help understanding Agent 'capabilities'.
Message-ID: <20111013074823.GD8289@fusion.localdomain>
References: <20111013165526.0dbbe0fc@notabene.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111013165526.0dbbe0fc@notabene.brown>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neil,

On Thu, Oct 13, 2011, NeilBrown wrote:
>  I've been trying enhance my understanding of bluetooth and as part of that
>  I have been experimenting with simple-agent to create pairing between two
>  Linux hosts (a phone and a laptop as it happens).
> 
>  My understanding of Secure Simple Pairing is that there are a number of
>  authentication mechanism and that the "best" would be chosen based on the
>  that capabilities given to the agent.
> 
>  So if both devices tell the monitor "DisplayYesNo", it would not be able to
>  do Passkey entry and would choose Numeric comparison.
>  So both agents would get RequestConfirmation call backs.
> 
>  But I cannot make that happen.
> 
>  No matter what capability I give to simple-agent, one of them asks me for a
>  pass key, then the other one does, and they have to match.  i.e. they both
>  get RequestPinCode.

If you get RequestPinCode it means that at least one of the devices
isn't capable of SSP, i.e. is a pre-2.1 Bluetooth controller. In such
cases the IO capability is irrelevant (as the concept doesn't exist for
2.0 and older devices).

Johan
