Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1252668586.8931.71.camel@violet>
References: <5c11eae40909101215n438f77c5sbcd289d0b1f77c5f@mail.gmail.com>
	 <5c11eae40909101231w18b66f7p13832fc60819c856@mail.gmail.com>
	 <1252612666.30957.42.camel@localhost.localdomain>
	 <1252668586.8931.71.camel@violet>
Date: Fri, 11 Sep 2009 17:01:04 -0300
Message-ID: <6b53b1990909111301n75541108n2cf9328cd81bad64@mail.gmail.com>
Subject: Re: Fwd: HDP profile support
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Chris Robinson <cckrobinson@gmail.com>
Cc: ngh@isomerica.net, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Fri, Sep 11, 2009 at 8:29 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Nathan,
>
>> > Is there currently a timetable in place for adding the HDP profile to
>> > Bluez? =A0I'm doing some concept work for an Android device and one of
>> > the Bluetooth requirements is to support the HDP profile.
>>
>> Full HDP support (especially on the Android platform) requires a few
>> supporting features that haven't quite made the mainline of development
>> yet. =A0It is possible--I did so earlier this summer--and the situation
>> has improved drastically due the efforts of various people.
>>
>> The first step is to get L2CAP enhanced retransmission and streaming
>> mode support in your kernel. =A0Gustavo Padovan worked on this over the
>> summer for a Google Summer of Code project. =A0He has done an excellent
>> job taking my initial patches, extending the functionality and cleanly
>> integrating them into the bluetooth-testing kernel.
>
> they will be in 2.6.32 btw.

The code will be merged, but it isn't completely done. I'm still
working on the last missing features for Enhanced Retransmission and
Streaming modes. See the roadmap at the end of my last blog post[1].
If you wanna test it remember to set enable_ertm param to 1 on l2cap module=
.

[1] http://padovan.org/blog/2009/08/bluez-status-update-into-the-l2cap-laye=
r/

>
>> >From there, HDP depends upon the Bluetooth Multi-Channel Adaptation
>> Protocol. =A0This provides an additional control channel layered on top =
of
>> L2CAP sockets. =A0Additionally, some simple SDP work is required (which
>> can use BlueZ's existing SDP services).
>
> The part of MCAP and HDP needs to be done similar to how we did AVDTP
> and AVRCP and thus as a plugin for bluetoothd. Mainly because I assume
> it mostly interact with other system components. So a concept similar to
> obexd is not feasible.
>
>> As for implementation upon Android, there's a bit more work. =A0The
>> Android kernel (on the Cupcake/Donut branches at least) already includes
>> basic L2CAP statically linked into the kernel. =A0This causes conflicts
>> when attempting to load a module with Enhanced L2CAP support built in.
>> In order to do so, I've had to build my own kernel and system images,
>> and then flash them to a development phone. =A0If you go this way, you'l=
l
>> have to backport the applicable patches onto the 2.6.29 kernel used in
>> Donut. =A0I've never even tried to backport to the 2.6.27 kernel in
>> Cupcake.
>
> Backporting them to 2.6.29 is kinda hard and also a pretty stupid
> endeavorer. I would have to check, but most likely we are talking about
> 100 or more patches that would need backporting. If Google would finally
> get their act together and polish and merge patches upstream there would
> have been no problem in just taking a newer upstream kernel.
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Gustavo F. Padovan
http://padovan.org
