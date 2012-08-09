Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50238B05.4030203@linux.intel.com>
References: <1343995640-19784-1-git-send-email-frederic.danis@linux.intel.com>
	<1343995640-19784-2-git-send-email-frederic.danis@linux.intel.com>
	<1344141450.2083.30.camel@aeonflux>
	<CABBYNZ+95Zx32T_Soz8Nms3reNcGpa3FsiyZpxS5zNzdsXhVvA@mail.gmail.com>
	<50238B05.4030203@linux.intel.com>
Date: Thu, 9 Aug 2012 17:42:24 +0300
Message-ID: <CABBYNZ+gQEC8iUMwUXO25TSXYFsktAjS083hXXH09Ec3DnDFzA@mail.gmail.com>
Subject: Re: [PATCH v17 01/15] doc: Add telephony interface documents
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Thu, Aug 9, 2012 at 1:03 PM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
>> They are mostly independent, oFono will never really acquire or
>> anything like that, but there are some AT commands (+VGS,+VGM) that
>> does notify PA about volume gain changes and as I said above it could
>> be useful to notify about wideband speech in the same way.
>>
>
> It is also possible that telephony agent implements a TelephonyClient
> interface for each connection, object which should be returned by
> NewConnection method.

You should return the properties as well to avoid another round trip
to get the properties of the client. Btw this requires yet another
object and interface that increases the complexity of the solution.

> In this case BlueZ will listen to properties changes on this interface (like
> for remote volume change) or call SetProperty (when receiving volume change
> from PulseAudio).
>
> As MediaTransport may change during wideband speech HFP session, due to
> codec re-negotiation, this architecture may simplify media transport code.

I don't think we need to do the codec negotiation on acquire, it
actually doesn't work since the transport cannot be reconfigured with
another codec as by design the endpoints can only have 1 codec, so I
suggest having the list of available codecs be given upfront in
NewConnection then you actually negotiate the codec before responding.
If the remote device attempts to change the codec oFono then can check
if the codec is available in the list of available codecs given on
NewConnection, if it find a match then it accepts and emit a signal of
codec changes that triggers a new transport to be configured.

Btw, Im not sure if this is really productive to discuss before we
even have this working with 1.5, IMO is easier to do things step by
step and the first step should be to get HFP 1.5 working as the
current upstream does then we think about 1.6 and other profiles such
as DUN and SAP.

-- 
Luiz Augusto von Dentz
