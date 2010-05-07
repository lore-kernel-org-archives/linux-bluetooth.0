Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed api (ver 0.2)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <201005071203.23882.jcaden@libresoft.es>
Date: Fri, 7 May 2010 10:46:28 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2541510E-4912-4AEB-AEFB-83F4339EC3FA@signove.com>
References: <201005051255.09394.jcaden@libresoft.es> <3CCD92AC-1578-4E78-AEE8-80AEE73511EB@signove.com> <201005071203.23882.jcaden@libresoft.es>
To: jcaden@libresoft.es
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> "Forcing" a source to specify the MDEP IDs here, even if not publishing the
>> record, makes checks easier further.
> 
> Not sure about that. Note that when you don't publish a SDP record, nobody 
> could connect to you, so you won't receive data channel connections request, 
> so you don't need to check if the mdeps are in use or not.

Indeed, you are right; from spec point of view I am not forced to define MDEP IDs beforehand (my old habits of TCP/IP, having ports both sides, sometimes overwhelm me :)

The actual argument is higher level: whether should we *force* the application to specify the MDEP IDs / data types beforehand (as I "voted", with "my" API) or not (as you "voted").

This is the point we need more opinions, from people in the list :)


>> Perhaps you tried to accomodate the notion that a data channel ID
>> "survives" even if the device disappearrs for a short moment?
> 
> Also this, remember that MCAP allow temporal disconnections to reestablish 
> them in future connections to save state.

Ok, I need to see whether BlueZ keeps the device objects in D-BUS tree after disconnection of if it removees it immediately. If it keeps the object, the sessions should be there as sub-paths (to be consistent with HdpSession being a part of adapter path.). If it doesn't, indeed they need to go somewhere else.