Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Subject: Re: SBC big endian issues?
Date: Sat, 17 Jan 2009 20:10:04 +0200
Cc: "ext Marcel Holtmann" <marcel@holtmann.org>,
        "ext Brad Midgley" <bmidgley@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <200901051015.20512.siarhei.siamashka@nokia.com> <200901161923.04676.siarhei.siamashka@nokia.com> <2d5a2c100901161402t65173745xd6f83e90a2057ffb@mail.gmail.com>
In-Reply-To: <2d5a2c100901161402t65173745xd6f83e90a2057ffb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901172010.05061.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Saturday 17 January 2009 00:02:09 ext Luiz Augusto von Dentz wrote:
> Hi Siarhei,
>
> It seems gstreamer does have G_BYTE_ORDER, so you probably don't need
> those #ifdef. I also notice some unnecessary white spaces in the of a
> line.

Hi,

I did not verify that patch thoroughly (I only checked that it compiles) and
also seems like I somehow forgot to pass it through 'checkpatch.pl'. Thanks
for a good catch.

Regarding G_BYTE_ORDER, you are probably right.  I'm not very familiar with
gstreamer yet, so somebody else could probably fix this stuff much faster
than me.

In any case, it probably makes sense to relay all the endian conversion
related things to gstreamer and ALSA, and use only native byte order in SBC.
This will simplify the code a bit and will make optimizing it easier.

I'm quite worried about big endian systems, but I have plans to buy a PS3 home
in about a month timeframe unless something extraordinary happens  :)


Best regards,
Siarhei Siamashka
