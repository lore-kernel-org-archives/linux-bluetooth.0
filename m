Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Sep 2009 12:55:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: HFP - A2DP in BlueZ
Message-ID: <20090918095544.GA28136@jh-x301>
References: <4AB353D8.70909@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AB353D8.70909@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sasikiran,

First of all, could you try to fix your email quoting. I found it quite
confusing to see my own text unquoted in your email.

On Fri, Sep 18, 2009, Sasikiran Maddula wrote:
> Your saying it works fine with the pavucontrol tool and pulseaudio. I am
> using pulseaudio 0.9.14 version. Whether it is sufficient to have the
> bluetooth profile switching. If I need to upgrade what version is the
> best suitable and suggest me on how to upgrade.

You'll need at least pulseaudio 0.9.15 but 0.9.17 would probably give you
the best results.

> Also whether pavucontrol is linked with the package for pulseaudio or it
> is separate. You mentioned that with the help of pavucontrol tool your
> able to do profile switching somewhat better. But I do not see any
> options in pavucontrol useful for bluetooth perspective. Could you guide
> me with more details.

Once you have Bluetooth audio working with pulseaudio you'll see what I
mean (there will be controls for toggling the profile as well as which
streams should go to the headset).

> Also you mentioned that the player I am using must be telephony aware
> directly or through some other component. Do you have any idea of any
> player which has that kind of facility.

No.

Johan
