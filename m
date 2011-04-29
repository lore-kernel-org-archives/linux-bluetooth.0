Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110429175625.GA29649@jh-x301>
References: <1304030070-6575-1-git-send-email-claudio.takahasi@openbossa.org>
	<1304030070-6575-2-git-send-email-claudio.takahasi@openbossa.org>
	<BANLkTimm=CVbBrLEPWf8Q0BgvtMmZaxNBg@mail.gmail.com>
	<BANLkTin=vjdpnB3v9-AfXwPjvGV+F1wP4Q@mail.gmail.com>
	<20110429175625.GA29649@jh-x301>
Date: Fri, 29 Apr 2011 14:41:47 -0400
Message-ID: <BANLkTi=dTXOX+vcCnDt0Z4f9X5hRbyi7bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Remove wrong checking for legacy devices
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Apr 29, 2011 at 1:56 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> BTW: why this information needs to be exposed through the DeviceFound() signal?
>> It is not used internally in the adapter.c source.
>
> It's useful for pairing UIs. If a device is expected to produce legacy
> pairing when calling CreatePairedDevice the UI can ask the user for the
> PIN *before* calling CreatePairedDevice and thereby eliminate the risk of
> user response timeout locally.

Maybe this is useful do be documented on doc/device-api.txt? The
LegacyPairing only mentions "This property is useful in the
Adapter.DeviceFound signal to anticipate whether legacy or simple
pairing will occur.", but it is not mentioned *why* the API user might
want to detect legacy pairing devices.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
