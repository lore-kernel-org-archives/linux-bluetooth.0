Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Dec 2012 17:24:58 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: PulseAudio branch to test BlueZ master
Message-ID: <20121218202458.GA8716@samus>
References: <CANT-zCWNUkTW9pmcvuDEhaEuSxdhphYLwvQkSYz5dLvYE2ENjg@mail.gmail.com>
 <CANT-zCVXOjncycx6GSghO6T5y3TEM0FDA1Ke3W8FZSE=ZOhbVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANT-zCVXOjncycx6GSghO6T5y3TEM0FDA1Ke3W8FZSE=ZOhbVQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On 11:19 Tue 18 Dec, Mikel Astiz wrote:
> On the other hand, A2DP is not working for me any more. I think this
> might be an unrelated issue, probably a regression in BlueZ, but I
> have to do further research.
> 

This problem may have been caused by me :-) The commit "bluetooth: Add
HFP 1.6 codec ID" was buggy, and was registering the A2DP endpoint with
the wrong codec. Sorry about that. I pushed an updated version to my
fork of pulseaudio[1].


Cheers,
-- 
Vinicius

[1] git://github.com/vcgomes/pulseaudio-bluez5.git 

