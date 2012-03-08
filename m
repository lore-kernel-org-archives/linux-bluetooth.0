Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPHSBCnoTp_YAJayhRB4xt7ZdZOuTD9MdqkWrDN_MYAvCOVFEw@mail.gmail.com>
References: <CAPHSBCnoTp_YAJayhRB4xt7ZdZOuTD9MdqkWrDN_MYAvCOVFEw@mail.gmail.com>
Date: Thu, 8 Mar 2012 12:39:20 +0200
Message-ID: <CABBYNZKu2uk46yxhcfMWFAmpHh1oa=5OiEjqJnjor_N7cHGmjw@mail.gmail.com>
Subject: Re: AVRCP 1.3 support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Rohit Sharma <rohitsharmaddun@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 8, 2012 at 9:01 AM, Rohit Sharma <rohitsharmaddun@gmail.com> wrote:
> Based on the following blog, Is this supported in pulseAudio currently
> which version of player or pulseAudio i should be using for handling
> this.
> http://jprvita.wordpress.com/

Not exactly, it is preferable to implement MediaPlayer interface
directly in the player if possible so the latency is better since
round trips in D-Bus can be quite expensive.

> The proposed approach to implement this project is to have PulseAudio
> intermediating data exchange between media players and bluetoothd. For
> each audio stream going to a bluetooth audio sink it would listen to
> TrackChange and StatusChange signals coming from the application
> generating the stream going to that device and send this information
> to the remote peer through AVRCP calling a method exposed on
> bluetoothd’s org.bluez.Control interface. This integration could
> latter be extended for basic player controls, having PulseAudio to
> listen to bluetoothd signals and call methods on media players MPRIS
> interfaces to trigger the matching action. Also, a similar approach
> could be modeled for adding content browsing capability, as defined by
> AVRCP 1.4 specification.

Some things like absolute volume control might need to be integrated
directly with PulseAudio, but the media browsing really don't belong
to audio server, in fact it may not even belong to the player itself
since it could be just a filesystem or a generic database that could
be accessed directly but since the spec map it per player he are going
to probably have this inside the MediaPlayer.

-- 
Luiz Augusto von Dentz
