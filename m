Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1540612452.128426.1453474550259.JavaMail.yahoo@mail.yahoo.com>
References: <1540612452.128426.1453474550259.JavaMail.yahoo.ref@mail.yahoo.com>
	<1540612452.128426.1453474550259.JavaMail.yahoo@mail.yahoo.com>
Date: Mon, 25 Jan 2016 13:30:25 +0200
Message-ID: <CABBYNZJnsd5B7cWPqsaHsF=RCxL6_BSjZYFvv_tL-euP_BUkYw@mail.gmail.com>
Subject: Re: A2DP AAC streaming Decoder
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hong-Rong Lin <physicist96@yahoo.com.tw>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jan 22, 2016 at 4:55 PM, Hong-Rong Lin <physicist96@yahoo.com.tw> wrote:
> Hi All,
> I would like to decode AAC payload from A2DP packets, and feed AAC data into AAC audio decoder to output audio, ie, Bluetooth speaker function supporting AAC streaming.
> I have found there are sbc_decode() source code in pulseaudio-2.1, but I cannot find aac_decode().
> Could all of you tell me how to get the aac_decode() source code and related application in the internet? Thanks a lot.

I don't think AAC is royalty-free so you probably need to get a
license first, you could use a Open Source implementation like ffmpeg
but that doesn't mean you will be able to distribute it (see
https://en.wikipedia.org/wiki/Advanced_Audio_Coding#Licensing_and_patents).

*OPUS would probably be much easier to be supported by pulseaudio
since it royalty-free (see: https://www.opus-codec.org/license/)

-- 
Luiz Augusto von Dentz
