Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111013165526.0dbbe0fc@notabene.brown>
References: <20111013165526.0dbbe0fc@notabene.brown>
Date: Thu, 13 Oct 2011 10:39:22 +0300
Message-ID: <CABBYNZJs4zXqhPkSV6HUbLzFk7_-cuf-+kVgmw+A0hcMRCXLxw@mail.gmail.com>
Subject: Re: Help understanding Agent 'capabilities'.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: NeilBrown <neilb@suse.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Neil,

On Thu, Oct 13, 2011 at 8:55 AM, NeilBrown <neilb@suse.de> wrote:
>
> Hi,
>  I've been trying enhance my understanding of bluetooth and as part of that
>  I have been experimenting with simple-agent to create pairing between two
>  Linux hosts (a phone and a laptop as it happens).
>
>  My understanding of Secure Simple Pairing is that there are a number of
>  authentication mechanism and that the "best" would be chosen based on the
>  that capabilities given to the agent.
>
>  So if both devices tell the monitor "DisplayYesNo", it would not be able to
>  do Passkey entry and would choose Numeric comparison.
>  So both agents would get RequestConfirmation call backs.
>
>  But I cannot make that happen.
>
>  No matter what capability I give to simple-agent, one of them asks me for a
>  pass key, then the other one does, and they have to match.  i.e. they both
>  get RequestPinCode.
>  So they seem to be assuming at least one device has a keyboard (the first
>  could generate a number in the agent and display it I guess).
>
>  Is there something else I have to change to force it to use Numeric
>  comparison (or even 'just works') authentication?  Is this documented
>  somewhere?
>
>  I'm using 4.88 on one system and 4.96 on the other.

For SSP you need both controllers to be >= 2.1, if you are seeing
pincode requests then probably one or both controller are using legacy
pairing.

-- 
Luiz Augusto von Dentz
