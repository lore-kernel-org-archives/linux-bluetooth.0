Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327964619.2125.14.camel@sirocco.config>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
	<1327952977.1955.160.camel@aeonflux>
	<1327953929.2400.80.camel@novo.hadess.net>
	<CA+bD78jkORzLP-M+bGqFMkp9vHmBXW+LgLnFGhLczn92Rk2XXA@mail.gmail.com>
	<1327962821.2125.4.camel@sirocco.config>
	<CA+bD78hQcBm5-94RHNSPXUsM1kAD8pYJ5Yu=-jPv8T=iedr6bA@mail.gmail.com>
	<1327964619.2125.14.camel@sirocco.config>
Date: Mon, 30 Jan 2012 15:10:18 -0800
Message-ID: <CA+bD78hTvaf92zy0t2xSMO2uoM+xL73XopxrvGbR5uW+6Uc3pw@mail.gmail.com>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Scott James Remnant <scott@netsplit.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	keybuk@chromium.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 30, 2012 at 3:03 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Em Mon, 2012-01-30 =E0s 14:35 -0800, Scott James Remnant escreveu:
>> On Mon, Jan 30, 2012 at 2:33 PM, Bastien Nocera <hadess@hadess.net> wrot=
e:
>> > Em Mon, 2012-01-30 =E0s 13:42 -0800, Scott James Remnant escreveu:
>> >> > The PIN length hint is also ignored in the current code:
>> >> > + =A0 =A0 =A0 <device type=3D"audio" oui=3D"00:1A:80:" name=3D"CMT-=
DH5BT"
>> >> pin=3D"max:4"/>
>> >> >
>> >> Because that's a UI restriction, no?
>> >>
>> >> I didn't put any PIN-generation code here, because I'm not entirely
>> >> sure what the UI for "generate random PIN' should look like or which
>> >> spec you're following.
>> >
>> > It means that a generated PIN shouldn't have more than 4 digits for it
>> > to work with this device.
>> >
>> What generated PIN? Which spec/profile says you have to generate a PIN
>> for this device?
>
> It's recommended that the UIs try to generate PINs for the users, rather
> than relying on them entering random numbers.
>
Recommended where? Can you point at least at the correct document?

The only recommendation I'm aware of is in the HID profile, which
would not apply here, and strangely you don't use this max: form for
keyboards which would be the only devices they applied to.


The description matches the HID profile behavior I've sumitted as a
separate set of CLs.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen? =A0Are you going round the twist?
