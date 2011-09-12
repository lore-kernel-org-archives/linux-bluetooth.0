Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201109121537.13920.szymon.janc@tieto.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
	<1315826997-13818-2-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v4-Rik3EtFhf7Q-YP8Fu2+6TU0FjH4WkkGHqtyu4PBKpQ@mail.gmail.com>
	<201109121537.13920.szymon.janc@tieto.com>
Date: Mon, 12 Sep 2011 17:56:46 +0300
Message-ID: <CABBYNZL9LAadUvWPmOTA+0gPxjanNEwZXEndtHzfL7J4s=fLiQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5] AVRCP: rename avrcp_header to avc_header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Sep 12, 2011 at 4:37 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> Hi Luiz
>
>> >        sk = g_io_channel_unix_get_fd(control->io);
>> > @@ -1451,19 +1451,19 @@ static struct pdu_handler {
>> >  /* handle vendordep pdu inside an avctp packet */
>> >  static int handle_vendordep_pdu(struct control *control,
>> >                                        struct avctp_header *avctp,
>> > -                                       struct avrcp_header *avrcp,
>> > +                                       struct avc_header *avc,
>> >                                        int operand_count)
>> >  {
>> >        struct pdu_handler *handler;
>> > -       struct avrcp_spec_avc_pdu *pdu = (void *) avrcp + AVRCP_HEADER_LENGTH;
>> > +       struct avrcp_spec_avc_pdu *pdu = (void *) avc + AVC_HEADER_LENGTH;
>>
>> We might want to change this to:
>>
>> struct avrcp_spec_avc_pdu *pdu = (avrcp_spec_avc_pdu *)(avc +
>> AVC_HEADER_LENGTH);
>
> I don't think this is correct, that would result in jumping
> 5 * (sizeof (struct avc_header)) bytes..

I fail to see how the multiplication got into you equation, but anyway
I would prefer using something like this (void *)
&avc[AVC_HEADER_LENGTH], but that should be a different patch.

>> This way we kill some warnings on ARM: arithmetic with void pointer
>
> This should happen only if compiling with -Wpointer-arith or -pedantic.

I don't think we use those.

-- 
Luiz Augusto von Dentz
