Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
Message-ID: <20050424164810.GA12143@externe.net>
References: <1114345112.10706.64.camel@pegasus> <20050424134746.GA31151@externe.net> <20050424181947.4a2f1656.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050424181947.4a2f1656.henryk@ploetzli.ch>
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
Date: Sun, 24 Apr 2005 12:48:10 -0400

On Sunday, 24 April 2005 at 18:19:47 (+0200), Henryk Pl=F6tz wrote:
> My 0.02EUR: There is a problem here. Mayank turned up a very valid poin=
t
> in his "a2play code not according to the specifications" posting: Havin=
g
> the SBC encoding decoupled from the AVDTP negotiation is not a good
> thing. One of the primary problems of the current pipe approach (and
> expecting applications to stream SBC into a socket/device/whatever is
> not different in this regard) is that the format of the SBC stream
> (sample rate, channel mode, etc.) will have to depend on the
> capabilities of the receiver, but there is no feedback to the encoder
> about that.

Maybe the supported encodings/frequencies/etc. could be advertised in
a separate file? The player would open it first, then send the sbc
in one of the supported format

> And also coupling /dev/a2dpN tightly to SBC format would make it even
> harder (or impossible) to support other audio formats as A2DP does.

That was just a suggestion on the system behaviour - I mean having a
device supporting a format. You could as well have
/dev/a2dp0_sbc_someformat /dev/a2dp0_sbc_someotherformat etc. and try
to open them until once doesn't return an error.

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
