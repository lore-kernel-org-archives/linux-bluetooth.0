Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344141450.2083.30.camel@aeonflux>
References: <1343995640-19784-1-git-send-email-frederic.danis@linux.intel.com>
	<1343995640-19784-2-git-send-email-frederic.danis@linux.intel.com>
	<1344141450.2083.30.camel@aeonflux>
Date: Mon, 6 Aug 2012 23:30:31 +0300
Message-ID: <CABBYNZ+95Zx32T_Soz8Nms3reNcGpa3FsiyZpxS5zNzdsXhVvA@mail.gmail.com>
Subject: Re: [PATCH v17 01/15] doc: Add telephony interface documents
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?= <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Aug 5, 2012 at 7:37 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> +org.bluez.TelephonyAgent using this new interface. This will setup a SDP record
>> +for the profile and a RFCOMM server listening for incoming connection.
>> +
>> +When a new device is connected, NewConnection method of TelephonyAgent is
>> +called. The telephony agent should reply to it after proper communication
>> +establishment (directly for HSP or after SLC setup completes for HFP).
>
> We need to describe on how HFP 1.6 with wideband speech is handled as
> well.

I need to look in detail when the audio configuration is done in HFP
1.6, in any case a the transport object can be used to signal wideband
speech which PulseAudio should be able to catch and setup sbc
encoder/decoder, iirc the parameters are fixed so there is no need to
negotiate parameters with the endpoint as in A2DP so oFono only need
to know if the transport is capable of wideband speech or not.

>> +Interaction with the audio component (i.e. PulseAudio) will be done through the
>> +MediaTransport object (passed to telephony agent during NewConnection call).
>
> This is the one thing that is really unclear to me. How does this
> actually help. The MediaTransport and TelephonyAgent should be
> independent.

They are mostly independent, oFono will never really acquire or
anything like that, but there are some AT commands (+VGS,+VGM) that
does notify PA about volume gain changes and as I said above it could
be useful to notify about wideband speech in the same way.

-- 
Luiz Augusto von Dentz
