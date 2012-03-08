Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 7 Mar 2012 23:01:30 -0800
Message-ID: <CAPHSBCnoTp_YAJayhRB4xt7ZdZOuTD9MdqkWrDN_MYAvCOVFEw@mail.gmail.com>
Subject: AVRCP 1.3 support
From: Rohit Sharma <rohitsharmaddun@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

For AVRCP 1.3 support in current bluez, this is supported using
org.bluez.Media Interface in which a player registers with bluez using
RegisterPlayer DBus methods.
Have a query how the bluez will be identifying the player and respond
the correct metadata or attributes.

Based on the following blog, Is this supported in pulseAudio currently
which version of player or pulseAudio i should be using for handling
this.
http://jprvita.wordpress.com/

The proposed approach to implement this project is to have PulseAudio
intermediating data exchange between media players and bluetoothd. For
each audio stream going to a bluetooth audio sink it would listen to
TrackChange and StatusChange signals coming from the application
generating the stream going to that device and send this information
to the remote peer through AVRCP calling a method exposed on
bluetoothd’s org.bluez.Control interface. This integration could
latter be extended for basic player controls, having PulseAudio to
listen to bluetoothd signals and call methods on media players MPRIS
interfaces to trigger the matching action. Also, a similar approach
could be modeled for adding content browsing capability, as defined by
AVRCP 1.4 specification.

Thanks & Regards
Rohit Sharma
