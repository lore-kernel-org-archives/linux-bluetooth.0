Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c1afa04d050516134921746de0@mail.gmail.com>
From: =?ISO-8859-1?Q?Jes=FAs_Cano_Navarro?= <jesuscanonavarro@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Old known, Apple BT Keyboard
In-Reply-To: <428825B8.2070103@metalan.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4901_24602911.1116276576151"
References: <c1afa04d0505151420720b5bad@mail.gmail.com> <4287C079.20208@gmx.ch>
	 <428825B8.2070103@metalan.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 16 May 2005 22:49:36 +0200

------=_Part_4901_24602911.1116276576151
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Thank you for your interest!.

My first pair of questions is:
-I don't know the whole set of tools that bluez-utils brings but i
found at least two for connexions: the hidd daemon and hcitool, both
have connexion parameters but:
1)=BFwhich is the purpose of them?, =BFfor what is every one? i couldn't
dintinguish which one should i use to connect to a device.
2)How do i debug the activity with hcidump?, run hcidump alone in a
console and work in another?, what parameters should i use?, -X -V -w
<file>?

I'm on a Debian GNU/Linux testing, Kernel 2.6.8-2-686. Compaq Deskpro
EN: Pentium 2 (Deschutes) 350, 256MB.

Thank you

2005/5/16, Andre Baron <andre@metalan.net>:
> I echo Marco, however with one caveat; I don't believe you can replace
[...]
=20
> Marco Trudel wrote:
>=20
> > If you don't ask specific questions, we can't help you... So what's
> > the current problem?
> > It sounds like the last step was that marcel requested a hcidump of
> > your failing action... So, I suggest to do so...
> >
> > regards
> > Marco
> >
> >
> > Jes=FAs Cano Navarro wrote:
> >
> >> Hi everybody,
> >>
> >> Thank you for reading this message and spending your time helping me
> >> an the others.
> >>
> >> I tried to make the Apple BT Keyboard work with my GNU/Linux and
> >> Marcel's help (thank you Marcel) but i did not have the tool "hcidump"
> >> to debug the inquiries and conexions and i was too lost in this field.
> >> Now i think (hope) i have it all and my goals are:
> >>
> >> -Make sure i have the right configuration needs for BT use.
> >> -Permanently replace the pc105 keyboard.
> >> -Configure correctly the Apple BT Keyboard.
> >>
> >> Would you please help/guide me to get it?, i would really appreciate
> >> it!.
> >>
> >> I read several people have got it with the Apple keyboard.Somebody
> >> told about writting a HOWTO, as it's becomeing an usual stuff
> >> (GNU/Linux-Bluez and BT keyboards), i would be interested in help to
> >> it.
> >>
> >> Thank you all.

Jes=FAs Cano Navarro

------=_Part_4901_24602911.1116276576151
Content-Type: application/octet-stream; name="hcid.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid.conf"

IwojIEhDSSBkYWVtb24gY29uZmlndXJhdGlvbiBmaWxlLgojCiMgJElkOiBoY2lkLmNvbmYsdiAx
LjcgMjAwNC8xMi8xMyAxNDoxNjowMyBob2x0bWFubiBFeHAgJAojCgojIEhDSWQgb3B0aW9ucwpv
cHRpb25zIHsKCSMgQXV0b21hdGljYWxseSBpbml0aWFsaXplIG5ldyBkZXZpY2VzCglhdXRvaW5p
dCB5ZXM7CgoJIyBTZWN1cml0eSBNYW5hZ2VyIG1vZGUKCSMgICBub25lIC0gU2VjdXJpdHkgbWFu
YWdlciBkaXNhYmxlZAoJIyAgIGF1dG8gLSBVc2UgbG9jYWwgUElOIGZvciBpbmNvbWluZyBjb25u
ZWN0aW9ucwoJIyAgIHVzZXIgLSBBbHdheXMgYXNrIHVzZXIgZm9yIGEgUElOCgkjCglzZWN1cml0
eSBhdXRvOwoKCSMgUGFpcmluZyBtb2RlCgkjICAgbm9uZSAgLSBQYWlyaW5nIGRpc2FibGVkCgkj
ICAgbXVsdGkgLSBBbGxvdyBwYWlyaW5nIHdpdGggYWxyZWFkeSBwYWlyZWQgZGV2aWNlcwoJIyAg
IG9uY2UgIC0gUGFpciBvbmNlIGFuZCBkZW55IHN1Y2Nlc3NpdmUgYXR0ZW1wdHMKCXBhaXJpbmcg
bXVsdGk7CgoJIyBQSU4gaGVscGVyCglwaW5faGVscGVyIC91c3IvYmluL2JsdWV6LXBpbjsKCgkj
IEQtQnVzIFBJTiBoZWxwZXIKCSNkYnVzX3Bpbl9oZWxwZXI7Cn0KCiMgRGVmYXVsdCBzZXR0aW5n
cyBmb3IgSENJIGRldmljZXMKZGV2aWNlIHsKCSMgTG9jYWwgZGV2aWNlIG5hbWUKCSMgICAlZCAt
IGRldmljZSBpZAoJIyAgICVoIC0gaG9zdCBuYW1lCgluYW1lICIlaC0lZCI7CgoJIyBMb2NhbCBk
ZXZpY2UgY2xhc3MKCWNsYXNzIDB4M2UwMTAwOwoKCSMgRGVmYXVsdCBwYWNrZXQgdHlwZQoJI3Br
dF90eXBlIERIMSxETTEsSFYxOwoKCSMgSW5xdWlyeSBhbmQgUGFnZSBzY2FuCglpc2NhbiBlbmFi
bGU7IHBzY2FuIGVuYWJsZTsKCgkjIERlZmF1bHQgbGluayBtb2RlCgkjICAgbm9uZSAgIC0gbm8g
c3BlY2lmaWMgcG9saWN5IAoJIyAgIGFjY2VwdCAtIGFsd2F5cyBhY2NlcHQgaW5jb21pbmcgY29u
bmVjdGlvbnMKCSMgICBtYXN0ZXIgLSBiZWNvbWUgbWFzdGVyIG9uIGluY29taW5nIGNvbm5lY3Rp
b25zLAoJIyAgICAgICAgICAgIGRlbnkgcm9sZSBzd2l0Y2ggb24gb3V0Z29pbmcgY29ubmVjdGlv
bnMKCWxtIGFjY2VwdDsKCgkjIERlZmF1bHQgbGluayBwb2xpY3kKCSMgICBub25lICAgIC0gbm8g
c3BlY2lmaWMgcG9saWN5CgkjICAgcnN3aXRjaCAtIGFsbG93IHJvbGUgc3dpdGNoCgkjICAgaG9s
ZCAgICAtIGFsbG93IGhvbGQgbW9kZQoJIyAgIHNuaWZmICAgLSBhbGxvdyBzbmlmZiBtb2RlCgkj
ICAgcGFyayAgICAtIGFsbG93IHBhcmsgbW9kZQoJbHAgcnN3aXRjaCxob2xkLHNuaWZmLHBhcms7
CgoJIyBBdXRoZW50aWNhdGlvbiBhbmQgRW5jcnlwdGlvbiAoU2VjdXJpdHkgTW9kZSAzKQoJI2F1
dGggZW5hYmxlOwoJI2VuY3J5cHQgZW5hYmxlOwp9Cg==
------=_Part_4901_24602911.1116276576151--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
