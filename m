Return-Path: <bmidgley@xmission.com>
Message-ID: <41A4C6A8.2080508@xmission.com>
Date: Wed, 24 Nov 2004 10:36:40 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC packer done, kind of
References: <20041123014732.3a03b10e.henryk@ploetzli.ch>	 <1101191260.26578.43.camel@pegasus>	 <20041123074829.7f978ce7.henryk@ploetzli.ch>	 <1101201897.26578.54.camel@pegasus>	 <20041123204901.776fe240.henryk@ploetzli.ch>	 <1101243809.27351.18.camel@pegasus>	 <20041124042114.5e1fee94.henryk@ploetzli.ch>	 <1101272477.27351.67.camel@pegasus>  <41A43E8A.8030602@xmission.com> <1101307146.27351.104.camel@pegasus>
In-Reply-To: <1101307146.27351.104.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

a2play in cvs w/NONSPECAUDIO should behave for you like it did when it 
was last working for you. i disabled all the new stuff (it didn't help 
or hurt the bluetake).

that's really too bad the framing didn't fix things for yours like it 
did the bluetake. they are totally out of spec. that doesn't bode well 
for interoperating with the other headsets out there.

brad

Marcel Holtmann wrote:
> Hi Brad,
> 
> 
>>>	sbcenc <au-file> | rcplay <bdaddr> -
>>
>>a2play will also accept '-' for stdin now. you should try it to see if 
>>my latest change makes it work for your headset.
> 
> 
> the latest CVS version of a2play is broken for me in both modes and it
> makes also no difference between standard input or if the SBC frames are
> read from a file.
> 
> 
>>the mailing lists are slow lately, eh?
> 
> 
> This happens some times. Ask the Sourceforge guys, because they may
> changed hardware again and spooled all our mails. Or another virus is on
> its move and overloads their severs.
> 
> Regards
> 
> Marcel
> 
> 
