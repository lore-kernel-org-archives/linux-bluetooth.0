Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 10 Nov 2010 14:07:57 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, suraj@atheros.com,
	johan.hedberg@gmail.com, joakim.xj.ceder@stericsson.com
Subject: Re: [PATCH 1/4] Sim Access Profile API
Message-ID: <20101110160757.GC3275@vigoh>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1288791271-13857-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1289367190.9615.235.camel@aeonflux>
 <99B09243E1A5DA4898CDD8B7001114480BD700C239@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480BD700C239@EXMB04.eu.tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar.Rymarkiewicz@tieto.com <Waldemar.Rymarkiewicz@tieto.com> [2010-11-10 13:12:53 +0200]:

> Hi Marcel, 
> 
> >> +		void Disable()
> >> +
> >> +			Shudown SAP server and remove the SDP record.
> >> +
> >> +			Possible errors: org.bluez.Error.Failed
> >
> >I don't like this. If you have properties then just changing 
> >the property should be enough. So a SetProperty is more appropriate.
> 
> I see another option to get rid of 'Enabled' property and leave the methods. What would you say on that?

It's not a good a idea. We have been moving everything we can to a set
property operation instead of a method call. Do that as method is add
unnecessary code to BlueZ once we already have set property there.

> 
> >> +
> >> +		void Disconnect(boolean type)
> >> +
> >> +			Disconnect SAP client from the server. 
> >The 'type'
> >> +			parameter indicates disconnection type.
> >> +
> >> +			True  - gracefull disconnection
> >> +			False - immediate disconnection
> >> +
> >> +			Possible errors: org.bluez.Error.Failed
> >
> >I don't like this style of method names at all. Using method 
> >names like GracefulDisconnect and ImmediateDisconnect would be better.
> 
> That's fine.
> 
> >However I am not sure we should differentiate here at all. We 
> >should always to the graceful disconnect. What will the 
> >immediate disconnect bring us?
> 
> That's actually intended for testing only. One of PTS test cases expects the tester to trigger immediate disconnect.
> In practce, it is only used when connection to sim card is lost, but this is obviously done internally.


So this shouldn't be in the API, no one is going to use it. You can
create something internally for the immediate disconnection that you go
and set manually inside the code. Make sure to comment in the code why
you are adding this there. That can also be a option in some of the
bluetooth config files. Let's see what others think here.

-- 
Gustavo F. Padovan
http://profusion.mobi
