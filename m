Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTjkUwp5ETBmypRFw+qbf+Se4mUxJ3sXnUjj+_jQVTKYfQ@mail.gmail.com>
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
	<CAB7rCTjkUwp5ETBmypRFw+qbf+Se4mUxJ3sXnUjj+_jQVTKYfQ@mail.gmail.com>
Date: Thu, 26 Apr 2012 12:31:40 -0500
Message-ID: <CAB7rCTg_dzXMhXqkFU-DP-Ewi_HS8Ms0CMTL8GcW7W-GrK5Lqg@mail.gmail.com>
Subject: Re: PTS / linkkey issue
From: Mike <puffy.taco@gmail.com>
To: wyrles@ytram.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 23, 2012 at 7:36 PM, Mike <puffy.taco@gmail.com> wrote:
> Hi Tom,
>
>>> > I don't think it's a good idea to mix the security level
>>> > (MITM/no-MITM) requirement with the permanence requirement
>>> > (no-bonding/bonding). Those really are and should remain as orthogona=
l
>>> > requirements. Even though OPP is the only profile we know that it's
>>> > natural to use no-bonding for there may well be use cases where you
>>> > want a secure connection for sensitive data but want to forget about
>>> > the security relationship once the connection is gone.
>>> >
>>> > I also think this is what the core spec intends since you've got the
>>> > option of no-bonding with MITM and no-bonding without MITM. Even the
>>> > table (5.7, page 1671) that defines the security levels talks nothing
>>> > about the permanence of the link key but only about authenticated vs
>>> > unauthenticated and MITM vs no MITM. Mixing the no-bonding stuff into
>>> > the security level would then also confuse anyone thinking that our
>>> > security levels are mappings to how the core spec defines them to be.
>>>
>>> fair point. Let them get the PTS fixed.
>>>
>>> However we could add an extra option to the security field that would m=
ake
>>> it depend on the pairing setting. This is all still speculation since w=
e have no
>>> idea if it would not break GAP qualification.
>>>
>>> Regards
>>>
>>> Marcel
>>
>>
>> Hi All -
>>
>> Out of curiosity, what is the PIXIT value TSPX_delete_link_key set to?
>
> Not 100% sure since I'm not the one running PTS. =A0From what I've been
> told (and have a trace of), if the value is FALSE, we can hardly even
> run the tests because the tests expect the other side to authenticate
> against that key, which it won't. =A0If it is TRUE, we pass most of the
> tests.
>
>> From the discussion that has been going on here, I think it should set t=
o FALSE in all of the profiles where you want the bonding to persist.
>
> Ideally, yes, but BlueZ is deleting the link key because of the "No
> Bonding" type. =A0From what the BlueZ developers say, this is the
> correct behavior. =A0Unless that is refuted, it is PTS that must change.
>
>> As you might guess from its name: TSPX_delete_link_key set to TRUE will =
delete the stored link key at the start of a test case. In other words, del=
ete the bonding. TSPX_delete_link_key set to FALSE will leave the stored li=
nk key in place and use it during the authentication process -- that is, us=
ing the existing bonding.
>>
>> There are some issues with selecting the proper security mode and I/O Ca=
pabilities. Part of it >>> seems <<< to be related to the security module i=
n our host stack ignoring the security configuration we send down from the =
test cases. ("Seems" because it feels that way to me but I have no hard evi=
dence.)
>>
>> For the issues that have been reported, some combination of TSPX_delete_=
link_key is a workaround. Sometimes it works best to set it one way, someti=
mes the other.
>>
>> At times, setting it to TRUE to trigger a pairing process and then setti=
ng it to FALSE works best.
>>
>> Because of the available workaround, the issues that Mike mentioned earl=
ier have not been given a high priority. A general review/repair of the sec=
urity management situation is on my list of projects for later for this yea=
r. It may get bumped up in priority due to some other work I am doing where=
 I need "fine granularity" control over the security configuration.
>>
>>
>> So, in summary, play with TSPX_delete_link_key and see if that helps. I =
know that it's not a satisfying solution, I >>> personally <<< don't like i=
t either. But, a workaround is a workaround until something better comes al=
ong :-).
>
> We have, only partially helps. =A0I'll know tomorrow if the CreateDevice
> workaround is effective. =A0It may be. =A0If not, the only real solution
> to passing TP/OOR/BV-02-I is for PTS to request "General Bonding".

So I don't have any details, but the BQE is reporting that suddenly he
can disable deleting the link key in the PIXIT and it works.  I'm
really unsure of what made it happen, but I'm pretty sure he had added
the device using the D-Bus CreateDevice API at some point.  He also
set the Trusted flag to True, but my code inspection indicates that
probably didn't do much.  It sounds like he added it using
CreateDevice and then ran DIS/BV-01 to pair.

Wish I had a better answer, but that's all I have for now.  At least
one of the reconnect test cases that need this passed, not sure if the
others have been attempted yet.

Mike
