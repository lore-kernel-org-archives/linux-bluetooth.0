Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cbf0aec904111913065c4f8e25@mail.gmail.com>
References: <418DB442.2050801@uen.org> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus>
	 <cbf0aec904111910383520ec7f@mail.gmail.com>
	 <1100890600.7213.36.camel@pegasus>
	 <cbf0aec904111913065c4f8e25@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100899434.7213.72.camel@pegasus>
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
Date: Fri, 19 Nov 2004 22:23:54 +0100

Hi Henryk,

> > number of subbands etc. The SBC defines a lot, but not all of them can
> > be supported when we want to integrate it into ALSA. For the sink all
> > are mandatory, but for the source only some of them.
> 
> Hmm, since we're dealing with a software and have quite some
> computational power the encoder will probably support any possible
> configuration. I'd just take the values from Table 4.7 on page 22 of
> the A2DP spec as a set of reasonable default values where the only
> choice left is middle vs. high quality.

from my current knowledge of ALSA we can set the frequency and the
number of channels. So supporting all 4 frequencies and mono (1 channel)
and joint stereo (2 channels) from the interface point of view is a
reasonable way? Should we really do joint stereo instead of stereo?

Any thoughts about this are welcome.

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
