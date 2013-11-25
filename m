Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384867785.2027.36.camel@nuvo>
References: <1384864264.2027.22.camel@nuvo>
	<1384867785.2027.36.camel@nuvo>
Date: Mon, 25 Nov 2013 13:41:17 -0800
Message-ID: <CAHZ1yCkDAsvFQSsB=nj8hgCCy+NBDXJaRTCq7HLkkPCi2-VMdA@mail.gmail.com>
Subject: Re: autopair corner cases
From: Scott James Remnant <keybuk@google.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Alex Deymo <deymo@chromium.org>,
	Scott James Remnant <scott@netsplit.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 19, 2013 at 5:29 AM, Bastien Nocera <hadess@hadess.net> wrote:

> 6) I have a "TomTom Remote" that shows up as a keyboard and uses "0000"
> as its PIN. The problem is that, as per the code in autopair.c we'll
> first show a random pincode then quickly fall back to using "0000":
>> /* For keyboards rejecting the first random code
>>  * in less than 500ms, try a fixed code. */
>
> How does ChromeOS present this? Does it wait half a second before
> showing the pincode to enter? Because flashing an unusable pincode on
> the screen before succeeding pairing is pretty rubbish in my opinion...
>

This is at least slightly better than OS X, which would display the
random PIN, and then fail pairing - require you to try again, find the
"Advanced" button, set it to one of three or four user-nonsensical
options, and then enter 0000

I'm not saying we can't do better, of course, I'm just saying that we
can do worse :p


A half-second flash of a 6-digit PIN before falling back to a
four-digit one at least works in all of the corner cases - including
this one.

We actually collect logs via metrics of the devices this happens for,
right now we only know of one keyboard that this gets triggered for (a
Motorola Android Keyboard that's no longer on sale) - the TomTom
Remote makes two - I guess nobody's paired a Chromebook with one yet.


I'm way open to ideas for improving the experience here, just as long
as we keep the "works in the common and corner cases" part ;-)

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
