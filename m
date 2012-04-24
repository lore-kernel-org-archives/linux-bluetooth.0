Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <05a501cd21a3$083836a0$18a8a3e0$@ytram.com>
References: <CAB7rCTiu18D8h611avpWqP9fD2STaWMErN7bSv-af-7yvraQaw@mail.gmail.com>
	<1335035377.16897.340.camel@aeonflux>
	<CAB7rCTgxpeXiMqz8__GEzEekkCb79yU--TEq6N=qZMuyuR+SoQ@mail.gmail.com>
	<1335042808.16897.350.camel@aeonflux>
	<CAB7rCThjFzL7Ji=eVf_KSrn-DxytG7qdoXb+zf5o+Rgx5JhkXA@mail.gmail.com>
	<1335125337.16897.357.camel@aeonflux>
	<CAB7rCTgLNv=BUznKMN3hU3NM_7odUsoELC2LZGYFwX6Xqawg5Q@mail.gmail.com>
	<1335130524.16897.365.camel@aeonflux>
	<20120422222246.GA27438@x220.P-661HNU-F1>
	<1335164553.16897.371.camel@aeonflux>
	<20120423091402.GA5758@x220>
	<1335174046.16897.374.camel@aeonflux>
	<05a501cd21a3$083836a0$18a8a3e0$@ytram.com>
Date: Mon, 23 Apr 2012 19:36:49 -0500
Message-ID: <CAB7rCTjkUwp5ETBmypRFw+qbf+Se4mUxJ3sXnUjj+_jQVTKYfQ@mail.gmail.com>
Subject: Re: PTS / linkkey issue
From: Mike <puffy.taco@gmail.com>
To: wyrles@ytram.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

>> > I don't think it's a good idea to mix the security level
>> > (MITM/no-MITM) requirement with the permanence requirement
>> > (no-bonding/bonding). Those really are and should remain as orthogonal
>> > requirements. Even though OPP is the only profile we know that it's
>> > natural to use no-bonding for there may well be use cases where you
>> > want a secure connection for sensitive data but want to forget about
>> > the security relationship once the connection is gone.
>> >
>> > I also think this is what the core spec intends since you've got the
>> > option of no-bonding with MITM and no-bonding without MITM. Even the
>> > table (5.7, page 1671) that defines the security levels talks nothing
>> > about the permanence of the link key but only about authenticated vs
>> > unauthenticated and MITM vs no MITM. Mixing the no-bonding stuff into
>> > the security level would then also confuse anyone thinking that our
>> > security levels are mappings to how the core spec defines them to be.
>>
>> fair point. Let them get the PTS fixed.
>>
>> However we could add an extra option to the security field that would ma=
ke
>> it depend on the pairing setting. This is all still speculation since we=
 have no
>> idea if it would not break GAP qualification.
>>
>> Regards
>>
>> Marcel
>
>
> Hi All -
>
> Out of curiosity, what is the PIXIT value TSPX_delete_link_key set to?

Not 100% sure since I'm not the one running PTS.  From what I've been
told (and have a trace of), if the value is FALSE, we can hardly even
run the tests because the tests expect the other side to authenticate
against that key, which it won't.  If it is TRUE, we pass most of the
tests.

> From the discussion that has been going on here, I think it should set to=
 FALSE in all of the profiles where you want the bonding to persist.

Ideally, yes, but BlueZ is deleting the link key because of the "No
Bonding" type.  From what the BlueZ developers say, this is the
correct behavior.  Unless that is refuted, it is PTS that must change.

> As you might guess from its name: TSPX_delete_link_key set to TRUE will d=
elete the stored link key at the start of a test case. In other words, dele=
te the bonding. TSPX_delete_link_key set to FALSE will leave the stored lin=
k key in place and use it during the authentication process -- that is, usi=
ng the existing bonding.
>
> There are some issues with selecting the proper security mode and I/O Cap=
abilities. Part of it >>> seems <<< to be related to the security module in=
 our host stack ignoring the security configuration we send down from the t=
est cases. ("Seems" because it feels that way to me but I have no hard evid=
ence.)
>
> For the issues that have been reported, some combination of TSPX_delete_l=
ink_key is a workaround. Sometimes it works best to set it one way, sometim=
es the other.
>
> At times, setting it to TRUE to trigger a pairing process and then settin=
g it to FALSE works best.
>
> Because of the available workaround, the issues that Mike mentioned earli=
er have not been given a high priority. A general review/repair of the secu=
rity management situation is on my list of projects for later for this year=
. It may get bumped up in priority due to some other work I am doing where =
I need "fine granularity" control over the security configuration.
>
>
> So, in summary, play with TSPX_delete_link_key and see if that helps. I k=
now that it's not a satisfying solution, I >>> personally <<< don't like it=
 either. But, a workaround is a workaround until something better comes alo=
ng :-).

We have, only partially helps.  I'll know tomorrow if the CreateDevice
workaround is effective.  It may be.  If not, the only real solution
to passing TP/OOR/BV-02-I is for PTS to request "General Bonding".

Thanks,
Mike
