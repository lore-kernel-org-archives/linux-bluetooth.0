Return-Path: <cyrus@holtmann.org>
Subject: Re: Broken SDP parsing?
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
	 <1236523586.16880.141.camel@cookie.hadess.net>
	 <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 09 Mar 2009 14:14:00 +0000
Message-Id: <1236608040.16880.1580.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-03-09 at 10:08 -0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Sun, Mar 8, 2009 at 11:46 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Fri, 2009-03-06 at 01:00 +0000, Bastien Nocera wrote:
> >> Heya,
> >>
> > <snip>
> >> The first 2 chars in the IEEE1284 ID are supposed to be the length of
> >> the string. This should enable me to make the CUPS backend's discovery
> >> work again.
> >
> > This isn't quite enough it seems.
> >
> > >From DiscoverDevices on org.bluez.Device:
> >        <attribute id="0x0300">
> >                <text value="" />
> >        </attribute>
> >
> It may happen that bluetoothd and sdptool doesn't really share the sdp
> xml parsing code. So perhaps we need to replicated your fix on
> bluetoothd too or just make bluetoothd to use what you have done for
> sdptool.

Both use the code in common/sdp-xml.[ch] and convert_sdp_record_to_xml()
in particular, which is why it makes no sense to me...

I double-checked by adding some debug to convert_raw_data_to_xml() and
the string for the attribute I'm interested in is empty, so it must be a
problem parsing the raw data from the device, or there's something that
strips this value somewhere in bluetoothd...

