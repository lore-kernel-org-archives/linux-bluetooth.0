Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Aug 2011 14:08:39 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/12] Add messages to the mgmt interface to handle
 SMP key storage
Message-ID: <20110831170839.GA27900@samus.indt.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313799128-8842-2-git-send-email-vinicius.gomes@openbossa.org>
 <20110831080706.GA5861@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110831080706.GA5861@dell.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11:07 Wed 31 Aug, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Fri, Aug 19, 2011, Vinicius Costa Gomes wrote:
> > +Load SMP Keys Command
> > +=====================
> > +
> > +	Command Code:		0x001F
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Debug Keys (1 Octet)
> > +				Key Count (2 Octets)
> > +				Key1 {
> > +					Address (6 Octets)
> > +					Type (1 Octet)
> > +					PIN_Length (1 Octet)
> 
> Isn't the PIN Length completely irrelevant here since the "Passkey
> Entry" pairing method of SSP always requires a 6-digit passkey?

_If_ the Passkey Entry method is used. If Just Works is used, PIN Length
will be zero, and as Carles pointed out, if OOB is used it should be
something else.

> 
> > +					Value (16 Octets)
> > +					[
> > +						Encryption Size (1 Octet)
> > +						Enc. Diversifier (2 Octets)
> > +						Random Number (8 Octets)
> > +					] || [
> > +						Address Type (1 Octet)
> > +					]
> 
> Having unions within mgmt messages starts to push their complexity over
> the level that I feel comfortable with. Would it make sense to instead
> have separate "Load LTKs" and "Load IRKs" commands (though you'd then
> need to have two separate "New LTK" and "New IRK" events too).

Glad that this discussion is happening, as it was not an easy decision
and I made a compromise in favor of adding less messages to the mgmt
protocol (less API) and less lines of code in exchange of adding 
(debatably[1]) more complexity.

One point in favor of this union is that for most the time (if not all) 
userspace doesn't need to know what is inside that union, userspace
will only be storing those keys. 

And there's one more key type, the Connection Signature Resolving Key,
CSRK, used to sign commands, this key type doesn't have any associated
data with it. So it will mean six more messages.

[1] IMHO using new messages will mean just about moving the switch statement
that selects what to do in each key type case nearer to the protocol
level, the complexity will be almost the same, with just more repeated
code.

> 
> Btw, what exactly do you need the Address Type for in the case of IRKs
> and why don't you need it in the case of LTKs?

I am just exporting all the information that I receive from the SMP
messages. That address type is the address type of the _resolved_
address not the address type that was used in the connection that
was used for exchange the keys.

Having the address type along with the LTK would be useful if I could
use it for reconnections, but that's another problem.

> 
> Johan


Cheers,
-- 
Vinicius
