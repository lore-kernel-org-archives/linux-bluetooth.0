Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7E90DB69-1056-4706-9531-BA4D12199A27@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	<1311623405-31108-12-git-send-email-andre.guedes@openbossa.org>
	<1312984225.3373.118.camel@aeonflux>
	<CAJdJm_PWZzbLvLyrr7NyXgemd_GcWH4A9=F5w93cN9qHHb_dig@mail.gmail.com>
	<1312989466.3373.126.camel@aeonflux>
	<7E90DB69-1056-4706-9531-BA4D12199A27@openbossa.org>
Date: Wed, 10 Aug 2011 16:58:42 -0400
Message-ID: <CAJdJm_Mg4e1bLqYFmQxSctWT6y+GMg2xtJLwavtYoM5yWYJPcw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] Bluetooth: Add 'eir_len' param to mgmt_device_found()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 10, 2011 at 3:51 PM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> The advertising report event has the 'Length' field to inform the
> 'Data' field length, so I believe it has a variable length.
> According to its description, the 'Length' field may vary from 0x00
> to 0x1F (31) bytes.

You are right. Although the section 11 gives the impression the size
is always 31, this is not what happens on actual hardware, which
usually sends only the significant bytes (and the length is know from
the "Length" field.

> The only drawback I see so far is copying extra ~200 bytes each time
> we get a advertising report data.

I agree. If this event is being sent on each adv. data report event,
it will be more than 6 times the amount of data (with non-significant
bytes containing only zeroes) sent to userspace.

Now one idea: if we guarantee that the EIR/Adv. data field will always
be the last one, can we assume all remaining bytes on the event are
EIR/Adv info? I.e. the equivalent in C of:

struct device_found {
    bdaddr_t addr;
    uint8_t class_of_device[3];
    int8_t rssi;
    uint8_t eir[];
};

Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
