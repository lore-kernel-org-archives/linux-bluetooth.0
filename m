Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201008030930.45330.santoscadenas@gmail.com>
References: <1280130927-4137-1-git-send-email-santoscadenas@gmail.com>
	<1280130927-4137-2-git-send-email-santoscadenas@gmail.com>
	<AANLkTin1khXOxvZTdazRYFbb3VZCf39YFYaZnwa3cbmN@mail.gmail.com>
	<201008030930.45330.santoscadenas@gmail.com>
Date: Tue, 3 Aug 2010 12:00:07 +0300
Message-ID: <AANLkTi=iNPgNJaUpUK2v=whbWs_nzCpwq5TUbbDKk-7H@mail.gmail.com>
Subject: Re: [PATCH] Notify to device drivers when the SDP records change
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 3, 2010 at 10:30 AM, José Antonio Santos Cadenas
<santoscadenas@gmail.com> wrote:
> Hi Luiz,
>
> El Monday 02 August 2010 16:39:18 Luiz Augusto von Dentz escribió:
>> Hi,
>>
>> On Mon, Jul 26, 2010 at 10:55 AM, Jose Antonio Santos Cadenas
>>
>> <santoscadenas@gmail.com> wrote:
>> > When the remote SDP records that make a driver to be loaded change
>> > (added, remove, or updated) And the driver is not going to be
>> > removed, a notification is sent to the device driver. This
>> > notification is optional annnd does not fail  if the driver does
>> > not implemment it.
>>
>> How this is supposed to work?
>
> This tries to be a generic way to update the remote services. When we planned
> the HDP API some weeks ago in Recife, we decided that we need a way to update
> the services that a device offers (this implies to make some calls to the
> HealtAgent). Marcel and Johan tell me that it will be better to implement it
> in a generic way using a generic update services. May be I misunderstood
> something or this is not the best way to do this, but that's the objective.
> The objective is to provide an API to the user that notifies them about new
> health services.
>
> Can you see better ways to do this? We are open to any new ideas.
>
>
>> If does seems to me that you guys are
>> planning to keep polling the services records to update the drivers
>> which IMO is not a good idea, DiscoverServices is not meant to update
>> the drivers either it is basically a replacement to sdptool to so
>> application can do it over dbus.
>
> Of course I am not trying to poll remote SDP nor having it cached. Just
> offering a way to update services for the user.
>
>
>> Also if you take a closer look in the
>> plugins that use rfcomm channel, which can be changed at any point,
>> they basically fetch the record when attempting to connect, avdtp also
>> work in a similar way, we have to do the discover + get capabilities
>> every time we want to connect to a sink/source since there is no way
>> to keep this information updated locally.
>
> Of course, every time that you are going to connect is when you check the
> remote record. In the HDP implementation is doing the same way.
>
>>
>> In the other hand, this can be useful for LE which we can subscribe to
>> changes, but for sdp I don't see the point.
>
> For HDP is also useful in SDP, because the device can update services and the
> device driver will not receive any notification. This way we are offering a
> way to update it when the user wants. This is almost the same than making a
> service discovery and notify a new UUID discovered, but also notifying the
> changes in the records.

But you must do the discover every time you want to connect, as you
state there is no notification for SDP, so updating the drivers
doesn't guarantee anything. Application should not know about this,
they basically want to connect and bluetoothd has to figure out which
sink/source do match for them.

So IMO this has to be done similar to a2dp/avdtp, prior to connect
discover the endpoints and them proceed with the connection attempt,
the stored records are just a hint of what the remote device supports.

-- 
Luiz Augusto von Dentz
Computer Engineer
