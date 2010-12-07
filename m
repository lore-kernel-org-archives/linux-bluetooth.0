Return-Path: <cyrus@holtmann.org>
From: <tim.howes@accenture.com>
To: <linux-bluetooth@vger.kernel.org>
Date: Tue, 7 Dec 2010 11:22:42 +0100
Subject: RE: [RFC] AVRCP 1.4 : Design proposal for future on Target Role
Message-ID: <1AFE20D16950C745A2A83986B72E8748011F5775C175@EMEXM3131.dir.svc.accenture.com>
References: <AANLkTikzecKtx3ib-03n3f8_2u4KF0Y+PSmEJgccEg-i@mail.gmail.com><AANLkTi=_1qAiH9o_4eBy66OQ9=ba=4GuatVBVtcJG5=x@mail.gmail.com> <AANLkTin+K_AYeF9+t0qWWFRJrW5uv9OM4DGY8a2Aaaek@mail.gmail.com>
In-Reply-To: <AANLkTin+K_AYeF9+t0qWWFRJrW5uv9OM4DGY8a2Aaaek@mail.gmail.com>
Content-Type: text/plain;
	charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shivendra,

> AVRCP 1.4
> ==========
> 
> - Add SDP record for AVRCP 1.4 to inform CT of the version and features
>   supported by target.
> 
>   Priority: Medium
>   Complexity: C1

One extra issue here is that the SDP record needs to vary according to the players running: if the AVRCP layer statically set the AVRCP version in the SDP record to be 1.4, AND the player(s) was a legacy pre-1.4 application that did not know about browsing then the device integrator would have compliance issues.

So I believe there is a need for an API that the player would set if it can support mandatory v.1.4 target features.  If the API is not called (eg by backwards compatibility) then the SDP record would continue to publish version 1.3.

This may increase your complexity value.

> 		As per spec section 6.6.1     GetElementAttributes
> 		As per spec section 6.10.4.3    GetItemAttributes

Note that by overall spec design these are very similar.  Indeed, according to 6.10.4.3, AVRCP 1.4 CTs shall only use GIA when communicating with 1.4 TGs - GEA is effectively deprecated (of course a 1.4 TG may see a GEA from a legacy CT).  I believe it would assist media players if these operations were multiplexed through one API to hide their underlying differences.  It would be annoying for players to have to implement two callbacks to process these two similar operations.

This may change (decrease?) your complexity for these.


Cheers

Tim


This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
