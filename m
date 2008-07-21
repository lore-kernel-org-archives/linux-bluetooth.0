Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670807211353u49afeb71gc7aa02ce15b684a@mail.gmail.com>
Date: Mon, 21 Jul 2008 21:53:34 +0100
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-users] hciconfig hci0 reset bug
Cc: "Dave Young" <hidave.darkstar@gmail.com>,
	"BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <9CBA2065-DBBE-4342-BF35-2C24BDF829C5@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_125058_26301511.1216673614502"
References: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com>
	 <a8e1da0803021721m3145bc7fpd896760d4bed7d97@mail.gmail.com>
	 <a8e1da0803021724h654f65ceif24b2035dc94a5ec@mail.gmail.com>
	 <5eee8c670803030335v49536053j136b8b46addb8129@mail.gmail.com>
	 <5eee8c670803031419k10c8e625p447f8f98ac27dcb9@mail.gmail.com>
	 <5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com>
	 <a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com>
	 <5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com>
	 <a8e1da0803211729l1fdfeeb5ie22c70652bc1e76a@mail.gmail.com>
	 <9CBA2065-DBBE-4342-BF35-2C24BDF829C5@holtmann.org>
List-ID: <bluez-users.lists.sourceforge.net>

------=_Part_125058_26301511.1216673614502
Content-Type: multipart/alternative;
	boundary="----=_Part_125059_16487363.1216673614502"

------=_Part_125059_16487363.1216673614502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

I keep reading kernel developers saying that we should be persistent, so I'm
following up on this, has any progress been made regarding the following
issue?

This one's a bit of an old one, regarding bluetooth adapters after a certain
build number to require a reset command every boot before they'll work
properly, I've attached a previous discussion as a reminder to the issue.

If there's anything I can do (non-code writing though), please let me know,
I'll be glad to help get this sorted.

Alexander Deriziotis

On 26/03/2008, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Dave,
>
>  I've been looking around to see if I could figure out the build id where
>>> the
>>> dongles started shipping with the correct HCI_Reset. I think I may have
>>> found something.
>>>
>>
>> Thanks a lot.
>>
>> Marcel, I think it's what you want.  I would like to file a patch.
>>
>
> yes, but I already got it via CSR internals. They have always been helpful
> when it comes to BlueZ. CSR is an open source friendly company. I didn't
> have time to actually produce that patch since we have to turn the whole
> logic around.
>
> Regards
>
> Marcel
>
>

------=_Part_125059_16487363.1216673614502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>I keep reading kernel developers saying that we should be persistent, so I&#39;m following up on this, has any progress been made regarding the following issue?<br><br>This one&#39;s a bit of an old one, regarding bluetooth adapters after a certain build number to require a reset command every boot before they&#39;ll work properly, I&#39;ve attached a previous discussion as a reminder to the issue.<br>
<br>If there&#39;s anything I can do (non-code writing though), please let me know, I&#39;ll be glad to help get this sorted.<br><br>Alexander Deriziotis<br><br><div><span class="gmail_quote">On 26/03/2008, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Dave,<span class="q"><br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

I&#39;ve been looking around to see if I could figure out the build id where the<br>
dongles started shipping with the correct HCI_Reset. I think I may have<br>
found something.<br>
</blockquote>
<br>
Thanks a lot.<br>
<br>
Marcel, I think it&#39;s what you want. &nbsp;I would like to file a patch.<br>
</blockquote>
<br></span>
yes, but I already got it via CSR internals. They have always been helpful when it comes to BlueZ. CSR is an open source friendly company. I didn&#39;t have time to actually produce that patch since we have to turn the whole logic around.<br>

<br>
Regards<br><span class="sg">
<br>
Marcel<br>
<br>
</span></blockquote></div><br>

------=_Part_125059_16487363.1216673614502--

------=_Part_125058_26301511.1216673614502
Content-Type: text/html; name="Google Mail - hciconfig hci0 reset bug.html"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fixjsg9d
Content-Disposition: attachment;
 filename="Google Mail - hciconfig hci0 reset bug.html"

PGh0bWwgbGFuZz0iZW4tR0IiPjxoZWFkPiAgIDxtZXRhIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hh
cnNldD1VVEYtOCIgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIj4gPHRpdGxlPkdvb2dsZSBNYWls
IC0gaGNpY29uZmlnIGhjaTAgcmVzZXQgYnVnPC90aXRsZT4gPHN0eWxlIHR5cGU9InRleHQvY3Nz
Ij4KYm9keSwgdGR7Zm9udC1mYW1pbHk6YXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6ODAlfSBh
OmxpbmssIGE6YWN0aXZlLCBhOnZpc2l0ZWR7Y29sb3I6IzAwMDBDQ30gaW1ne2JvcmRlcjowfQo8
L3N0eWxlPiA8c2NyaXB0PgpmdW5jdGlvbiBQcmludCgpe2RvY3VtZW50LmJvZHkub2Zmc2V0SGVp
Z2h0O3dpbmRvdy5wcmludCgpfQo8L3NjcmlwdD4gPC9oZWFkPjxib2R5IG9ubG9hZD0iUHJpbnQo
KSI+IDx0YWJsZSB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNw
YWNpbmc9IjAiPiA8dGJvZHk+PHRyPiA8dGQgd2lkdGg9IjE0MyI+IDxpbWcgc3JjPSJHb29nbGUl
MjBNYWlsJTIwLSUyMGhjaWNvbmZpZyUyMGhjaTAlMjByZXNldCUyMGJ1Z19maWxlcy9nb29nbGVt
YWlsLmdpZiIgYWx0PSJHb29nbGUgTWFpbCIgd2lkdGg9IjE0MyIgaGVpZ2h0PSI1OSI+IDwvdGQ+
IDx0ZCBhbGlnbj0icmlnaHQiPiA8Zm9udCBzaXplPSItMSI+PGI+IE9keXNzZXVzIEZsYXBwaW5n
dG9uICZsdDtkZXJpemlvdGlzQGdtYWlsLmNvbSZndDsgPC9iPjwvZm9udD48L3RkPiA8L3RyPiA8
L3Rib2R5PjwvdGFibGU+IDxocj4gPGZvbnQgc2l6ZT0iKzIiPiA8Yj5oY2ljb25maWcgaGNpMCBy
ZXNldCBidWc8L2I+PC9mb250Pjxicj4gPGhyPiA8dGFibGUgd2lkdGg9IjEwMCUiIGJvcmRlcj0i
MCIgY2VsbHBhZGRpbmc9IjAiIGNlbGxzcGFjaW5nPSIwIj4gPHRib2R5Pjx0cj4gPHRkPiA8Zm9u
dCBzaXplPSItMSI+PGI+IFBldGVyIFN0ZXBoZW5zb24gJmx0O3B3c0Bjc3IuY29tJmd0OyA8L2I+
PC9mb250PiA8L3RkPiA8dGQgYWxpZ249InJpZ2h0Ij4gPGZvbnQgc2l6ZT0iLTEiPjxiPiAyNiBN
YXJjaCAyMDA4IDEzOjUwIDwvYj48L2ZvbnQ+IDwvdGQ+PC90cj48dHI+IDx0ZCBjb2xzcGFuPSIy
Ij4gPGZvbnQgc2l6ZT0iLTEiPiA8ZGl2PlJlcGx5LVRvOiBCbHVlWiB1c2VycyAmbHQ7Ymx1ZXot
dXNlcnNAbGlzdHMuc291cmNlZm9yZ2UubmV0Jmd0OzwvZGl2PiA8ZGl2PiBUbzogQmx1ZVogdXNl
cnMgJmx0O2JsdWV6LXVzZXJzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldCZndDs8L2Rpdj4gPC9mb250
PiA8L3RkPjwvdHI+PHRyPiA8dGQgY29sc3Bhbj0iMiI+IDx0YWJsZSB3aWR0aD0iMTAwJSIgYm9y
ZGVyPSIwIiBjZWxscGFkZGluZz0iMTIiIGNlbGxzcGFjaW5nPSIwIj4gPHRib2R5Pjx0cj4gPHRk
PiA8Zm9udCBzaXplPSItMSI+T24gVGh1LCAyMCBNYXIgMjAwOCAxNzoxOToyMiArMDAwMDxicj4K
PGZvbnQgY29sb3I9IiM1NTAwNTUiPiJPZHlzc2V1cyBGbGFwcGluZ3RvbiIgJmx0OzxhIG9uY2xp
Y2s9InJldHVybiB0b3AuanMuT3BlbkV4dExpbmsod2luZG93LGV2ZW50LHRoaXMpIiBocmVmPSJt
YWlsdG86ZGVyaXppb3Rpc0BnbWFpbC5jb20iPmRlcml6aW90aXNAZ21haWwuY29tPC9hPiZndDsg
d3JvdGU6PGJyPgomZ3Q7Li4uPGJyPgo8L2ZvbnQ+PGZvbnQgY29sb3I9IiM1NTAwNTUiPiZndDsg
U28sIGlmIEknbSByZWFkaW5nIHRoaXMgY29ycmVjdGx5LCB5b3Ugc2hvdWxkIGlzc3VlIHRoZSBy
ZXNldCBmb3IgYWxsPGJyPgomZ3Q7IENTUi1iYXNlZCBkb25nbGVzIHdpdGggYnVpbGQgaWQgJmd0
OyAxMTguPGJyPgomZ3Q7PGJyPgomZ3Q7IEFtIEkgb24gdGhlIHJpZ2h0IHRyYWNrIGhlcmU/IERv
ZXMgdGhpcyBpbmZvcm1hdGlvbiBsb29rIGFjY3VyYXRlIHRvIHlvdTxicj4KJmd0OyBndXlzPzxi
cj4KPGJyPgo8L2ZvbnQ+VGhpcyBpcyBiYXNpY2FsbHkgY29ycmVjdCBpbiB0aGF0IHRoZSBmaXgg
YXBwZWFyZWQgaW4gZmlybXdhcmUgYXJvdW5kIHRoZW48YnI+Cih0aGUgaW50ZXJuYWwgbG9nIHNh
eXMgMTE3LCBidXQgcG9zc2libHkgdGhhdCB3YXMgbmV2ZXIgcmVsZWFzZWQtLS1JJ3ZlPGJyPgpj
b25maW5lZCBteSBzZWFyY2ggdG8gdGhlIGRldmVsb3BtZW50IHNpZGUpLjxicj4KPGJyPgpIb3dl
dmVyLCBpdCdzIG5vdCB0aGF0IHNpbXBsZSBpbiB0aGF0IHJlbGVhc2VzIG9mIGVhcmxpZXIgZmly
bXdhcmUgYnJhbmNoZXM8YnI+CndlcmUgc3RpbGwgYmVpbmcgbWFkZSBmb3Igc29tZSB0aW1lLiAm
bmJzcDtPdXIgSUQgbnVtYmVycyBpbmNyZWFzZSBtb25vdG9uaWNhbGx5PGJyPgpzbyB0aGVzZSB3
b3VsZCBoYXZlIGxhdGVyIG51bWJlcnMuICZuYnNwO0kgaGF2ZW4ndCBkb25lIGFuIGV4aGF1c3Rp
dmUgc2VhcmNoOzxicj4KbW9zdGx5IHRoZXNlIHJlbGVhc2VzIGhhZCBMMkNBUCArIFJGQ09NTSBv
biBjaGlwIGZvciBlbWJlZGRlZCBhcHBsaWNhdGlvbnMsPGJyPgpzbyB5b3Ugd291bGRuJ3QgY2Fy
ZSBhYm91dCB0aGVtLiAmbmJzcDtJIGRvbid0IHNlZSBhbnkgZXZpZGVuY2Ugb2YgYSBsYXRlciBI
Q0k8YnI+CnJlbGVhc2UgYmFzZWQgb24gdGhlIG9sZCBjb2RlLCBvZmZoYW5kIChidXQgZG9uJ3Qg
dGFrZSB0aGlzIGFzIGdvc3BlbCkuPGJyPgo8YnI+CklmIHlvdSB3YW50IHRvIGJlIHF1aXRlIHN1
cmUgbm90IHRvIHBpY2sgdXAgYSBidWlsZCB3aGljaCBkaWRuJ3QgaGF2ZSB0aGU8YnI+CmZpeCBm
b3IgcmVzZXQsIHlvdSBjb3VsZCByZXN0cmljdCB0aGUgY2hhbmdlIHRvIEJsdWVDb3JlIDIgYW5k
IGxhdGVyIGNoaXBzPGJyPgp1c2luZyB0aGUgImJjZ2V0IGNoaXB2ZXIiIGNhbGwuICZuYnNwO1Ro
ZSBlYXJseSBicmFuY2hlcyB3aXRob3V0IHRoZSBmaXg8YnI+Cm9ubHkgZXZlciByYW4gb24gQmx1
ZUNvcmUgMTogdGhlIGZpeCB3YXMgbWFkZSBpbiBtYWpvciByZWxlYXNlIDEyIGFuZDxicj4KQmx1
ZUNvcmUgMiBmaXJzdCByYW4gb24gbWFqb3IgcmVsZWFzZSAxNC48YnI+Cjxicj4KLS08YnI+ClBl
dGVyIFN0ZXBoZW5zb24gJmx0OzxhIG9uY2xpY2s9InJldHVybiB0b3AuanMuT3BlbkV4dExpbmso
d2luZG93LGV2ZW50LHRoaXMpIiBocmVmPSJtYWlsdG86cHdzQGNzci5jb20iPnB3c0Bjc3IuY29t
PC9hPiZndDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDtTb2Z0d2FyZSBFbmdpbmVlcjxicj4KQ1NSIFBMQywgQ2h1cmNoaWxsIEhv
dXNlLCBDYW1icmlkZ2UgQnVzaW5lc3MgUGFyaywgQ293bGV5IFJvYWQ8YnI+CkNhbWJyaWRnZSwg
Q0I0IDBXWiwgVUsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7CiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7VGVsOiArNDQgKDAp
MTIyMyA2OTIwNzA8YnI+Cjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS0tLS0tLS0tLS08YnI+CkNoZWNr
IG91dCB0aGUgbmV3IFNvdXJjZUZvcmdlLm5ldCBNYXJrZXRwbGFjZS48YnI+Ckl0J3MgdGhlIGJl
c3QgcGxhY2UgdG8gYnV5IG9yIHNlbGwgc2VydmljZXMgZm9yPGJyPgpqdXN0IGFib3V0IGFueXRo
aW5nIE9wZW4gU291cmNlLjxicj4KPGEgb25jbGljaz0icmV0dXJuIHRvcC5qcy5PcGVuRXh0TGlu
ayh3aW5kb3csZXZlbnQsdGhpcykiIGhyZWY9Imh0dHA6Ly9hZC5kb3VibGVjbGljay5uZXQvY2xr
OzE2NDIxNjIzOTsxMzUwMzAzODt3P2h0dHA6Ly9zZi5uZXQvbWFya2V0cGxhY2UiIHRhcmdldD0i
X2JsYW5rIj5odHRwOi8vYWQuZG91YmxlY2xpY2submV0L2Nsazs8d2JyPjE2NDIxNjIzOTsxMzUw
MzAzODt3P2h0dHA6Ly88d2JyPnNmLm5ldC9tYXJrZXRwbGFjZTwvYT48YnI+CjwvZm9udD48ZGl2
IHN0eWxlPSJwYWRkaW5nOiA1cHggMHB0OyI+PGZvbnQgc2l6ZT0iLTEiPjxmb250IHNpemU9IjEi
IGNvbG9yPSIjODg4ODg4Ij5bUXVvdGVkIHRleHQgaGlkZGVuXTwvZm9udD48L2ZvbnQ+PC9kaXY+
PGZvbnQgc2l6ZT0iLTEiPjwvZm9udD4gPC90ZD48L3RyPjwvdGJvZHk+PC90YWJsZT4gPC90ZD48
L3RyPjwvdGJvZHk+PC90YWJsZT4gPGhyPiAgPC9ib2R5PjwvaHRtbD4=
------=_Part_125058_26301511.1216673614502--
