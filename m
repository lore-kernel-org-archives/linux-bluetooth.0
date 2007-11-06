Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300711060110u77ea7c7bl7e378f125a48cd4f@mail.gmail.com>
Date: Tue, 6 Nov 2007 02:10:13 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <C041389043587644A5B9F3006A412D76043B42@eevsbs.EEV.local>
MIME-Version: 1.0
References: <C041389043587644A5B9F3006A412D76043B42@eevsbs.EEV.local>
Subject: Re: [Bluez-devel] a2dp support for multiple headphones through
	multiple dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Tom

A lot of this was just thinking aloud. We would be using dbus paths to
refer to devices, not indexes for example. Some better docs of the
current and future api are in bluez-utils/hcid/dbus-*.txt

Brad

On 11/5/07, Tom McKaige <tmckaige@eeventures.net> wrote:
>
>
> Hi everyone,
>
> I am new to both linux and BLUEZ...
> I am interested in the feasibility of getting multiple A2DP headsets play=
ing
> audio through multiple USB->BT dongles simultaneously.  From the below two
> references I am confused if this is a "future wish" or already implemented
> feature in the current 3.22.  I highlighted in red the source of my
> confusion.
>
> If this feature is already implemented can someone give me a quick example
> of how to set up asound.conf and asoundrc so that I can get audio to
> multiple headsets. I don't require any more than a one to one headphone to
> dongle relationship.
>
> If its not already done what would be a sufficient bounty for this?
>
> Thanks in advance
> Tom
>
> http://wiki.bluez.org/wiki/Audio
> FROM the section 'Control socket API"
>
>
> "Plugz does not have any way to handle multiple independent headsets. We
> should at least make a design that doesn't prevent multiple headsets. The
> dbus interface allows us to be specific about what headset we want to
> connect or which headset has connected itself. The dbus api will probably
> also need to pass an index for talking to that headset along with connect=
ion
> events. It would usually be 0 (meaning the only set connected) but it cou=
ld
> be 1, 2, 3. We'd have to set up device entries in asound.conf for all the=
se,
> eg: bluetooth (aka bluetooth0), bluetooth1, bluetooth2. These would have =
an
> index parameter set to the right value."
>
>
> asound.conf =B6
>
> We will have to put a bunch of entries in here that applications can be
> pointed at, 0 in the examples is to signify the first/only device, ie
> device_index=3D0. could also have alsa entries for 1, 2, 3
>
> voice, aka voice0 (audio_preference=3Dvoice; will use sco and/or wired)
> hifi, aka hifi0 (audio_preference=3Dhifi; will use a2dp or wired for outp=
ut,
> wired mic)
> auto, aka auto0 (audio_preference=3Dauto; autodetect profile)
> loud, aka loud0 (alternate_speaker_device=3Ddefault; will
> send sound, eg ringer, to any headset too)
> any, aka any0 (audio_preference=3Dnone; always prefer a2dp, sco, then wir=
ed)
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>


-- =

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
