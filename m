Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E74476E55D15D942BA0FF3CDAD73606F041FEA@FMSMSX102.amr.corp.intel.com>
References: <E74476E55D15D942BA0FF3CDAD73606F041FEA@FMSMSX102.amr.corp.intel.com>
Date: Mon, 13 Feb 2012 14:35:31 +0200
Message-ID: <CABBYNZ++wSC8b=HOygi1adpAHCjSDnLbx9ED6DqKVFG8tcNXQg@mail.gmail.com>
Subject: Re: SDP Discovery collsion with Som Laptops
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Mohanan, Rajmohan" <rajmohan.mohanan@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Feb 13, 2012 at 12:38 PM, Mohanan, Rajmohan
<rajmohan.mohanan@intel.com> wrote:
> Hi
> With Lenovo T500laptop,
>  whenever after bonding Lenovo T500 is initiating a SDP search Request which collides our SDP request(from Bluez we are initiator we are starting SDP query immediately and if we are responder we are delaying for 2 seconds for starting SDP query).
>
>
> For solving this IOP issue I have made a change that if we are initiator also we will delay for 1 second and starting SDP query after bonding.

Why not check whether we are master or not? So the master has priority
to do the sdp right away and if we found we are slave then we fallback
to reverse service discover. This should avoid an extra 1 sec when
pairing normally, since this is not exactly an usual case where both
sides init an sdp simultaneously.

It is not clear what stack are you running in T500? Is it pairing
being triggered simultaneously in both sides?

Btw, I sugegst you to take a look at git format-patch + git send-email
for sending patches, just google it in doubt this is the preferable
format since we can review your patches inline.

-- 
Luiz Augusto von Dentz
