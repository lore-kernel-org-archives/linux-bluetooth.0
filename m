Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cbf0aec904111913205a053965@mail.gmail.com>
References: <418DB442.2050801@uen.org> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus> <419DB6E1.8000203@xmission.com>
	 <1100864484.7213.19.camel@pegasus> <419E20C3.7@xmission.com>
	 <1100883199.7213.27.camel@pegasus> <1100885959.7213.31.camel@pegasus>
	 <1100897144.7213.63.camel@pegasus>
	 <cbf0aec904111913205a053965@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100900024.7213.79.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 Nov 2004 22:33:44 +0100

Hi Henryk,

> > and I figured out what the extra RFCOMM channel 1 on my Aiptek headphone
> > does. You can simply stream the SBC files over it. The attached program
> > will do this for you, but actually it only works on streams with two
> > channels. I don't know what to change to support all test SBC files.
> 
> Excellent!
> 
> I know I did try this as the first thing when I discovered that
> channel (using rfcomm bind ..., rfcomm connect ... and cat foo.sbc >
> /dev/rfcomm0) but obviously didn't try hard enough. Your rcplay does
> work with mono files for me just fine.

I think the problem with the other approach (I also tried it) was that
the underlaying frame size is different if you connect through a TTY. I
stuck it at 330 bytes which is a DH5 minus protocol overhead.

The test files 01, 03, 05 don't work for me.

> From a rough test (I didn't compare the sound output to the reference
> decoder, just listened at it) I'd say my headphones play back the
> first 10 SBC test streams well, with the notable exception of number
> 7. So it seems that being a mono file doesn't prevent playback this
> way generically.

Do you also use the Aiptek or the BlueTake one. The Aiptek is very old
and maybe the decoder in my headphone has a bug.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
