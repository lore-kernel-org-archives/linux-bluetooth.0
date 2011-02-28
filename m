Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Feb 2011 13:33:25 +0100
From: Daniel Wagner <wagi@monom.org>
To: Franz Glauber <franzec05@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [pulseaudio-discuss] Problems trying to connecf HFP device
Message-ID: <20110228123325.GA10016@candlejack.bmw-carit.intra>
References: <AANLkTim_XfH9jTQLhCVtf4BJd8BJ9pV_2FQzqfOJO6kR@mail.gmail.com>
 <AANLkTik0vPSbwA5G2u7u_c+aZ_3BZaggVyjMftQ-5Cgp@mail.gmail.com>
 <AANLkTikmZfN_A=fyv0=CENCOvPEv5yb+DOXTObptqvUC@mail.gmail.com>
 <ij9edt$65n$2@dough.gmane.org>
 <AANLkTimLrD7HFA4Wz4sdwYJsJSLQ1FkYqm0JHTJucMWN@mail.gmail.com>
 <AANLkTimwLmR5L5H=jeKi7HT2f5b_TTtUt_67TqGGgopT@mail.gmail.com>
 <AANLkTikSZyxKst=3=JRBg1E7a4pW2rUXwjV4n53BL4wT@mail.gmail.com>
 <AANLkTinMEH4utheRXZPjh0v-+ms8zPvEXDurvxwQBO6S@mail.gmail.com>
 <AANLkTi=mgDqXjSBNahtXEWbJ+Cj6K3pbfmAT=TJUjPoo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=mgDqXjSBNahtXEWbJ+Cj6K3pbfmAT=TJUjPoo@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Franz,

On Mon, Feb 28, 2011 at 08:05:25AM -0300, Franz Glauber wrote:
> I got a dump with hcitool, the last line was after the delay. I got
> latest 4.89 bluez and kernel 2.6.36-r5. Any ideas?

What is your exact problem? Just the other day, I got HFP (audio
gateway) working on my computer. The main problem was that I had to
tell PulseAudio to loopback the audio stream to the audio
card. Otherwise, PulseAudio would suspend the BT audio streams which
resulted in a SCO disconnect.

HTH,
daniel
