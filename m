Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111114215226.GA21254@fusion.localdomain>
References: <1321272680-16286-1-git-send-email-sancane@gmail.com>
	<1321272680-16286-2-git-send-email-sancane@gmail.com>
	<1321272680-16286-3-git-send-email-sancane@gmail.com>
	<20111114215226.GA21254@fusion.localdomain>
Date: Tue, 15 Nov 2011 11:06:40 +0100
Message-ID: <CACLukz+DpjJjqHYxt+3P3JBY0CBDFujESgw_oEdNuBnj4Y8F1g@mail.gmail.com>
Subject: Re: [PATCH 2/6] Parse final measurement indication
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2011/11/14 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Mon, Nov 14, 2011, Santiago Carot-Nemesio wrote:
>> +     dict_append_entry(&dict, "Exponent", DBUS_TYPE_INT16, &m->exp);
>> +     dict_append_entry(&dict, "Mantissa", DBUS_TYPE_INT32, &m->mant);
>
> Could you remind me why we have this kind of encoding in the D-Bus
> interface instead of using the native DBUS_TYPE_DOUBLE? Using
> DBUS_TYPE_DOUBLE seems like the obvious & clean approach from an API
> standpoint so there should be good reasons for not using it.
>

As far as I remember, the reason why we did that in this way is
because health devices through GATT use IEEE-11073 32-bit FLOAT types,
so in order to keep the thermometer transcodable[1] through the API we
thought the esier way could be by providing its value representation
in their exponent/magnitude components.  IEEE-11073 32-bit FLOAT type
has special values to indicate special circumstances so we thought
that it could be better for applications to provide the exp/mantissa
values to make easier for them to detect this kind of issues instead
of comparing floating point numbers directly, wich is more tricky.
Furthermomre, most of the transcoder applications will need to know
expnonet and mantissa values to generate APDUs in an
ISO/IEEE-11073-20601 eco-system, so we thought that it would be easier
for both non-IEEE11073 and transcoder applications to get the FLOAT
value through their exp/mantissa represenation rather than to get
exp/mantissa values from the FLOAT value directly.

Those are some of the reason we were talking about... of course,
suggestion are always welcome.

[1] Personal Health Devices Transcoding Whitepaper
https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=238300

Regards.
Santiago
