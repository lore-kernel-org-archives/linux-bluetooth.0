Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v4-Rik3EtFhf7Q-YP8Fu2+6TU0FjH4WkkGHqtyu4PBKpQ@mail.gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
	<1315826997-13818-2-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v4-Rik3EtFhf7Q-YP8Fu2+6TU0FjH4WkkGHqtyu4PBKpQ@mail.gmail.com>
Date: Mon, 12 Sep 2011 17:48:53 +0300
Message-ID: <CABBYNZ+j32ME=n2AmqWSfv7_2xnMGBe5FZewT0dQOCC3akOy1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5] AVRCP: rename avrcp_header to avc_header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Sep 12, 2011 at 4:10 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>> -       int sk;
>> +                                                       AVC_HEADER_LENGTH];
>> +       int sk = g_io_channel_unix_get_fd(control->io);
>
> You are re-introducing a bug here. Please see "dec26ee Fix fd usage
> when not connected"

Must have reintroduced it when I was rebasing it, gonna fix it.

>
>> +       struct avrcp_spec_avc_pdu *pdu = (void *) avc + AVC_HEADER_LENGTH;
>
> We might want to change this to:
>
> struct avrcp_spec_avc_pdu *pdu = (avrcp_spec_avc_pdu *)(avc +
> AVC_HEADER_LENGTH);
>
> This way we kill some warnings on ARM: arithmetic with void pointer

Don't remember seeing any problem with it, but anyway it is not
something Im introducing.

-- 
Luiz Augusto von Dentz
