Return-Path: <cyrus@holtmann.org>
Message-ID: <F05E1DCFC982471192B260934AA7449A@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Cc: "BlueZ devel list" <linux-bluetooth@vger.kernel.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
References: <201108201753.32608.dstockwell@frequency-one.com> <20110822103632.GC9949@dell> <76D0096D2AE844EC9E2A4834E474AE0B@freqoneremote> <CAMOw1v7U3p99h+WA8U-Hp_fb37jZDsv+i--TSKAViyB-stAZ7Q@mail.gmail.com> <165376978.336156.1314031379433.JavaMail.open-xchange@oxusltgw02.schlund.de> <CAMOw1v6YJAn_p=5S6reDGeX2NdM5kP_XjAT_2wGj0SXV7MuO7A@mail.gmail.com>
In-Reply-To: <CAMOw1v6YJAn_p=5S6reDGeX2NdM5kP_XjAT_2wGj0SXV7MuO7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Corrected metadata: Playing Time
Date: Mon, 22 Aug 2011 22:02:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas, (back to the lame client):
-----Original Message----- 
From: Lucas De Marchi
>
> Wondering what you mean by "PDU-continuation pending", though.  Does it 
> have
>
> to do with AVRCP-level RequestContinuingResponse (and Abort)?  Or
> AVCTP-layer
>
> fragmentation?


AVRCP-level RequestContinuingResponse (and Abort)

+++++

Yes, I know about that one, and am not sure it is really necessary.  And, I 
think it is a bit messy to support since you also have to make sure that 
only metadata is processed between CT and TG, but at the same time allow for 
passthroughs.

As you know from the spec, an AV/C packet can be up to 512 bytes long. 
There are only seven possible Metadata attributes, of which three are 
number-strings (only a few bytes each).  Even if all seven 
attributes/elements are set, there are 56 bytes of element headers, the 
two-byte AVCTP header, the 10-byte AVRCP (PDU) header, etc.

This leaves at least 400 bytes of metadata, divided across the track title, 
the artist name, the album name, and the genre. For most popular music, 
these are kept as short as possible (so customers/fans can remember them), 
so a typical track name, is much less than 40 bytes (satellite radio only 
transmits 16 bytes).  Same with the artist name, etc.

I suggest a good way to handle this is to guarantee that the elements are 
not pathologically long, limiting each to 80 bytes or so.  Or maybe, as we 
scan the metadata, keep a counter to make sure that, in aggregate, we do not 
exceed the 512-byte limit.

The bigger issue for the future is AVCTP-level fragmentation, which becomes 
an issue if either MTU drops below the default 672 bytes (noisy environment, 
weak signal, etc.), or we implement 1.4 with browsing.  If/when we go in 
that direction, we will probably need to layer the handling of AVCTP and 
AVRCP.  I have code ready for that, but needs some cleanup and testing.

Cheers,
David

regards,
Lucas De Marchi 

