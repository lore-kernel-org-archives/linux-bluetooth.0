Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FE57175CCE23E5419899C1B0CFA26FAD13F022D7B5@EXMBXSD.dm.solekai.com>
References: <p2ld6c61fb91004151917x2a93d5dfr2ef1e6c2d01819a0@mail.gmail.com>
	 <FE57175CCE23E5419899C1B0CFA26FAD13F022D7B5@EXMBXSD.dm.solekai.com>
Date: Fri, 16 Apr 2010 13:44:30 -0400
Message-ID: <s2wd6c61fb91004161044ica7bcdfao566a3e4b00e2f4c3@mail.gmail.com>
Subject: Re: what is needed for SSP mode
From: Ronny Pau <ronnypau@gmail.com>
To: "Gunn, Brian" <bgunn@solekai.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> Now, I would like to switch on SSP mode, where I have issued
>> "hciconfig hci0 sppmode 1" and verify that it is indeed on using
>> "hciconfig hci0 sppmode".  However, if I attempt to connect with my
>> cellphone, I get a connection failure. Have I missed something?
>
> I've tried too and have the same problem with SSP mode.  I think it may work with "NoInputNoOutput" mode, but I couldn't get "DisplayYesNo" to work with a 6 digit decimal number.
>
> (Then again, I am not using the very latest release, though I didn't see any changes to SSP lately.)
>
> Brian
>
>

I am trying to implement the Passkey Entry mode, do I need to do
something with passkey-agent?  How will that impact compatibility with
2.0's 4-digit passkey?

Please help.
