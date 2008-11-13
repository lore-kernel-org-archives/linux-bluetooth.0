Return-Path: <cyrus@holtmann.org>
Message-ID: <491BF605.4020203@sspaeth.de>
Date: Thu, 13 Nov 2008 10:40:21 +0100
From: Sebastian Spaeth <sebastian@sspaeth.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-gnome wizard deficiencies make it mostly useless
References: <491AB358.9000209@SSpaeth.de> <1226518197.15397.11.camel@snoogens.fab.redhat.com>
In-Reply-To: <1226518197.15397.11.camel@snoogens.fab.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> You didn't cause a ruckus, people that don't actually read the comments
> did.
:-)

> Mice, tablets, keyboards, headsets, hands-free, phones work. Only GPS
> devices and mice, and headsets that don't use '0000' as the PIN codes
> don't work.

-Nahh, if you read some of the descriptions in the downstream Ubuntu bug
there are many devices that fail: the Ubuntu bug lists gps, headsets,
keyboards, modems, printer as failing, so currently it's more than a few
devices.

-A whole range of headsets seems to compute a fixed PIN based on their
serial number, so hardcoding wouldn't work at all.

-For some devices the random PIN seems generated on the device: "[my]
bluetooth headset generates a random PIN code each time it is put in
pairing mode (has an LCD display)"

> We know about that problem. I have a patch in my tree for your
> particular GPS device, I'm still waiting for you to file a bug with the
> details spelled out.

This GPS device is a no-brand thing that is 2 years old and probably not
even sold anymore. Is it really worth adding special cases for such
niche products? I'd rather this were done in a way that helped all those
devices rather than just mine. (But yes, I'll file a bug on my device,
thanks :-))

> I didn't say it was a bad idea to allow users to enter a fixed PIN, I
> said it would be a bad idea to replace random PINs altogether with
> user-provided PINs.

Sorry, I understood your "Because if we don't force users to use random
PIN codes, they'll always enter
the same "easy" PIN codes." as 'don't ever allow people to enter
nonrandom codes'. But I am happy that this was a misunderstanding.

>> I see 2 solutions and I would like input in what bluez-gnome devs think:
>> 1) Try to pair with random PIN if that fails try "0000", "1234", "1111".
>> This would at least cover about 90% of all devices and only special case
>> the rest.
> That wouldn't work, a lot of devices will get out of pairing mode after
> an unsuccesful pairing.

OK this is not feasible then. I'll happily admit I don't know a lot
about bluetooth, I just want it to get to work :-)

> My solution would be to have a button at the bottom of the device
> selection page called "PIN options" (or similar). The button would popup
> a dialogue with options:
> [X] Automatic PIN selection
> 
> [ ] Force a random PIN number
> 
> [ ] Use fixed PIN code:
>         [X] '0000' (most headsets, mice and GPS devices)
>         [ ] '1111'
>         [ ] '1234'
>         [ ] Custom: ___________

This would work just as well for me. I don't think the selection of
"0000" "1111" "1234" is needed, it makes the dialog quite wordy and
long. Why not just:

 [X] Automatic PIN selection
 [ ] Force a random PIN number
 [ ] Use fixed PIN code: ___________
     (many devices use 0000 or 1234)

I don't really get the difference between "automatic" and "force
random". I take it that automatic would include the special casing as is
done now, while random would only ever do random numbers?

I'd just go for:

 [X] Random PIN
 [ ] Use fixed PIN code: ___________ (prepopulate with 0000?)

and don't try to keep a list of special cases in code. Yes it does mean
that everyone needs to enter "0000" the first time the use their headset
but it makes things easy and transparent.

Will your solution work for above mentioned headsets that generate a PIN
on the headset and display it there?

> Wording is obviously up for discussion. The code is probably an
> afternoon's work for somebody comfortable with GTK+, maybe a bit longer
> to get Marcel happy with it ;)

I've never done anything GTK beyond following the GTK tutorials and my C
is quite rusty by now. If you want me to, I could try my luck, but I'd
rather if someone more proficient went for it first :-).

spaetz
