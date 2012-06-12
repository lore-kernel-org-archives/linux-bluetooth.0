Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v4ASw0AepxgAC7Mw1LANdA24MrSpmLxy7znpuw3C_mS1w@mail.gmail.com>
References: <1339419310-4777-1-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v4ASw0AepxgAC7Mw1LANdA24MrSpmLxy7znpuw3C_mS1w@mail.gmail.com>
Date: Tue, 12 Jun 2012 14:59:07 +0300
Message-ID: <CABBYNZJyEsx63G_A6nPTF+ot58S9TTQCMR05oS4i2=0m5V73Kg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio: Separate profile specific fields from media_transport
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Jun 11, 2012 at 6:16 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>> +       if (transport->destroy != NULL)
>> +               transport->destroy(transport);
>
> IMO it would be better to pass transport->data here and eliminate
> "transport->data" assignment above in the destroy functions.

That was my idea, but since destroy_headset need access to the device
it was just simpler to just pass the transport itself. Not a big deal
IMO since this in the same file, but I guess I will just store the
device inside the headset_transport.

-- 
Luiz Augusto von Dentz
