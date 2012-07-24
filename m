Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120724095449.GD9576@x220.ice.intel.com>
References: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
	<1343054163-19119-2-git-send-email-claudio.takahasi@openbossa.org>
	<CAJdJm_N7Z4a2p7-Ur+_kEf2Q==aL5QTYpmnRomX+LXjy1Dd37Q@mail.gmail.com>
	<20120724095449.GD9576@x220.ice.intel.com>
Date: Tue, 24 Jul 2012 10:39:11 -0300
Message-ID: <CAKT1EBdf90y_ko4MRZiTuo3F87Yxn49e0-2N5rHeNtJB+_omgg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btio: Rescue lost errorneous numbers
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Paulo Alcantara <paulo.alcantara@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Lizardo:

On Tue, Jul 24, 2012 at 6:54 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Mon, Jul 23, 2012, Anderson Lizardo wrote:
>> On Mon, Jul 23, 2012 at 10:36 AM, Claudio Takahasi
>> <claudio.takahasi@openbossa.org> wrote:
>> >  #define ERROR_FAILED(gerr, str, err) \
>> > -               g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, \
>> > +               g_set_error(gerr, BT_IO_ERROR, err, \
>> >                                 str ": %s (%d)", strerror(err), err)
>> > [...]
>> >                 if (err < 0)
>> > -                       g_set_error(&gerr, BT_IO_ERROR,
>> > -                                       BT_IO_ERROR_CONNECT_FAILED, "%s (%d)",
>> > -                                       strerror(-err), -err);
>> > -       } else if (cond & (G_IO_HUP | G_IO_ERR))
>> > -               g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
>> > -                               "HUP or ERR on socket");
>> > +                       g_set_error(&gerr, BT_IO_ERROR, -err, "%s (%d)",
>> > +                                                       strerror(-err), -err);
>>
>> why not use the ERROR_FAILED() macro here?
>>
>> >         if (err < 0) {
>> > -               g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
>> > -                               "connect: %s (%d)", strerror(-err), -err);
>> > +               g_set_error(gerr, BT_IO_ERROR, -err, "connect: %s (%d)",
>> > +                                                       strerror(-err), -err);
>>
>> and here?
>
> Good point. Unfortunately I didn't notice this before applying so please
> (Claudio) send a fix on top of your patch.
>
> Johan

ok. I will send a patch to fix it.

BR,
Claudio
