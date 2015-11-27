Return-Path: <andrei.emeltchenko.news@gmail.com>
Date: Fri, 27 Nov 2015 14:40:02 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/2] btproxy: Add three-wire (h5) protocol initial support
Message-ID: <20151127124000.GB26866@comms.fi.intel.com>
References: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1448551424-18448-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <4E34A599-0424-4005-B228-DE830E6906E6@holtmann.org>
 <20151127103038.GA26866@comms.fi.intel.com>
 <F5FF8776-8359-4906-80C5-88B57E4CF898@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F5FF8776-8359-4906-80C5-88B57E4CF898@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Nov 27, 2015 at 04:25:30AM -0800, Marcel Holtmann wrote:
> >>> 
> >>> #define BTPROTO_HCI	1
> >>> -struct sockaddr_hci {
> >>> -	sa_family_t	hci_family;
> >>> -	unsigned short	hci_dev;
> >>> -	unsigned short  hci_channel;
> >>> -};
> >>> #define HCI_CHANNEL_USER	1
> >> 
> >> please do not do this.
> > 
> > Why? I added #include "lib/hci.h" where this structure defined, why do
> > we need redefined it again? It was defined 3 times.
> 
> we want to get rid of using libbluetooth over and over again. We need to start somewhere. And I have no idea on what you would gain from including lib/hci.h in this case.

I get packet types definitions from lib/hci.h. But since this would be
moved to h5.c this is not important anymore. I'll remove this chunk.

> >> 
> >>> +
> >>> +struct h5_pkt {
> >>> +	uint16_t len;
> >>> +	uint8_t data[0];
> >>> +};
> >> 
> >> I think using get_unaligned_le16 to get the length would be a lot simpler.
> > 
> > Sorry, do not get this, how can we use get_unaligned_le16() ?
> 
> len = get_unaligned_le16(buf)

This is just my packet, no need for le16 here. I can use of course just
uint8_t array and use first two bytes for length.

Best regards 
Andrei Emeltchenko 

> data = buf + 2
> 
> Regards
> 
> Marcel
> 
