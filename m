Return-Path: <cyrus@holtmann.org>
Message-ID: <5162BADF.7010608@linux.intel.com>
Date: Mon, 08 Apr 2013 14:41:03 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com> <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com> <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org>
In-Reply-To: <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

Le 26/03/2013 21:22, Marcel Holtmann a écrit :
I find this parameter name a bit long. What about just "setting" or 
"settings" or "voice". I am open for suggestions.
>
> Also should this be part of options or the socket address structure.
>
> Another option would be to introduce a SCO_SETTINGS or SCO_VOICE socket option. With just this one parameter.
>
> Since the default value of voice setting is not 0x0000, it might make actually more sense to introduce a new socket option. Playing the memset handling would only work nicely if the default would be 0x0000, but it isn't.
>
> Regards
>
> Marcel
>

  I agree that having a separate socket option is better. IMHO, having 
it in the
sockaddr is not enough because you don't know in advance what stream is
flowing for incoming connections. It could improve the API for outgoing
connections.

My concern is how do we handle user values.
If the user do not set this option, hci_conn->settings contains 0x0000.
In this case, it is possible to start the sco connection as we have it 
today.
If the user set 0x0060 (cvsd 16 bits) or 0x0003 (transparent data), then 
it is
possible to start S3, S2, S1 or T2, T1 sequences.

For other values, IMHO, returning an error would be the way to go.

If the above is fine for you, we can discuss the naming. What about the
following ?

#define SCO_SETTINGS  0x03
struct sco_settings {
         __u16           settings;
};

Regards,
Frédéric
