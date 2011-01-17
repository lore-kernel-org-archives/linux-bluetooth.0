Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1AFE20D16950C745A2A83986B72E8748011F5775C175@EMEXM3131.dir.svc.accenture.com>
References: <AANLkTikzecKtx3ib-03n3f8_2u4KF0Y+PSmEJgccEg-i@mail.gmail.com>
	<AANLkTi=_1qAiH9o_4eBy66OQ9=ba=4GuatVBVtcJG5=x@mail.gmail.com>
	<AANLkTin+K_AYeF9+t0qWWFRJrW5uv9OM4DGY8a2Aaaek@mail.gmail.com>
	<1AFE20D16950C745A2A83986B72E8748011F5775C175@EMEXM3131.dir.svc.accenture.com>
Date: Mon, 17 Jan 2011 12:22:35 +0530
Message-ID: <AANLkTi=U=KXN=zRNJCrNBo6eofch-F5w3Hbf1G9QOT9u@mail.gmail.com>
Subject: Re: [RFC] AVRCP 1.4 : Design proposal for future on Target Role
From: santhosh aj <ajsant@gmail.com>
To: tim.howes@accenture.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 7, 2010 at 3:52 PM, <tim.howes@accenture.com> wrote:
>
> Hi Shivendra,
>
> > AVRCP 1.4
> > ==========
> >
> > - Add SDP record for AVRCP 1.4 to inform CT of the version and features
> >   supported by target.
> >
> >   Priority: Medium
> >   Complexity: C1
>
> One extra issue here is that the SDP record needs to vary according to the players running: if the AVRCP layer statically set the AVRCP version in the SDP record to be 1.4, AND the player(s) was a legacy pre-1.4 application that did not know about browsing then the device integrator would have compliance issues.
>
> So I believe there is a need for an API that the player would set if it can support mandatory v.1.4 target features.  If the API is not called (eg by backwards compatibility) then the SDP record would continue to publish version 1.3.

As I understand from AVRCP Spec 1.4 section 6.10.2.1 SDP record is
used as to indicate what the avrcp profile implementation is capable
of supporting. The Player Feature Bitmask provides information on the
capabilities of specific player. So Even if you Publish 1.4 SDP
Record, depending on the player/s registed the capability is exposed.

>
> This may increase your complexity value.
>
> >               As per spec section 6.6.1     GetElementAttributes
> >               As per spec section 6.10.4.3    GetItemAttributes
>
> Note that by overall spec design these are very similar.  Indeed, according to 6.10.4.3, AVRCP 1.4 CTs shall only use GIA when communicating with 1.4 TGs - GEA is effectively deprecated (of course a 1.4 TG may see a GEA from a legacy CT).  I believe it would assist media players if these operations were multiplexed through one API to hide their underlying differences.  It would be annoying for players to have to implement two callbacks to process these two similar operations.
>
> This may change (decrease?) your complexity for these.
>
>
> Cheers
>
> Tim
>
>
> This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Regards
Santhosh AJ
