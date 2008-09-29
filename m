Return-Path: <cyrus@holtmann.org>
Message-ID: <9bd2f8970809290947l51182d4u1ddd951dd8f321c5@mail.gmail.com>
Date: Tue, 30 Sep 2008 01:47:12 +0900
From: "Emmet Hikory" <persia@ubuntu.com>
Sender: emmet.hikory@gmail.com
To: "Bastien Nocera" <hadess@hadess.net>
Subject: Re: [PATCH] Make bluetooth-properties fit on smaller displays
Cc: Mario_Limonciello@dell.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1222701730.3311.76.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <FA7963CC89065B49AED46A6F797F0FA6F28694@AUSX3MPC128.aus.amer.dell.com>
	 <1222679240.1825.14.camel@violet.holtmann.net>
	 <1222679724.3311.53.camel@cookie.hadess.net>
	 <FA7963CC89065B49AED46A6F797F0FA6F28698@AUSX3MPC128.aus.amer.dell.com>
	 <1222701730.3311.76.camel@cookie.hadess.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 30, 2008 at 12:22 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2008-09-29 at 10:05 -0500, Mario_Limonciello@Dell.com wrote:
>> Hi Bastien & Marcel:
>>
>> Here's the screenshots as requested:
>>
>> Old: http://imagebin.org/27644
>>
>> New: http://imagebin.org/27643
>>
>> A lot of these MID devices don't have screens bigger than 1024x600
>> (some 800x600 depending on their aspect ratio).  This change really
>> just reorganizes the GUI so that both laptops and MID devices can use
>> the same layout.  I'm attaching an updated patch relative to 1.6.
>
> Both versions would fit on both those screens. What's wrong with leaving
> it as is? In the worst case, I'd move the contextual buttons to the side
> of the treeview, instead of underneath, and add labels to those buttons.

    Good day.  I adapted the suggested patch for this from one
previously shipped in Ubuntu by Michael Frey and Loic Minier.

    My actual test screens were 1024x600 (intel driver) and 800x600
(vesa driver), running under the hildon-desktop environment.  If I'm
running in clean GNOME@96DPI, the default looks OK, but there is only
space for two or three devices.  If I'm running under hildon-desktop,
there's only space for one device.  As one of these screens is
actually 247 DPI, running at 96 DPI tends to make everything nearly
unreadably small.  Note that I've also tested with GNOME+devilspie, to
force maximisation, which created a bit more space, but not hugely
more space.

    In practice, I use a keyboard, headset, communication to a yet
smaller portable device, and communication to my laptop.  I'd like to
add a mouse, GPS device, and printer.  I'm experimenting with a
"bluetooth handset" for making VoIP calls, which would be a separate
audio device for ekiga/empathy.  As a result, my device listing easily
exceeds the limits imposed by the vertical layout on a small screen.
Whlie this may be an exceptional case, I think "mouse, keyboard,
headset, phone, printer" isn't an unreasonable list of accessories,
even for a regular laptop user.

    One possible solution would be to write a separate hildon front
end, which is probably the best solution for 640x480 or 800x480, but
for 800x600 and 1024x600, the use case for using themed GNOME with
higher DPI hinting is strong enough that having a separate front-end
seems confusing.

    Mind you, I don't want to limit the experience on high-resolution
low-DPI screens, and will admit that I don't have the equipment to
properly test this use case.  If the consensus is that it the result
of moving the device listing to the right creates an unpleasant
experience for these users, then perhaps it is not a sensible default.

-- 
Emmet HIKORY
