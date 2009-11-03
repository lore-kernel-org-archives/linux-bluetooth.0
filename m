Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20091103082143.GA21755@jh-x301>
References: <ba5648fa0911022149y544fcfbcsd81a68a731f0604c@mail.gmail.com>
	 <20091103082143.GA21755@jh-x301>
Date: Tue, 3 Nov 2009 14:41:33 +0530
Message-ID: <8b5debfa0911030111g29c88d2n496dd3dedcce9760@mail.gmail.com>
Subject: Re: Attending skype calls from bluetooth headset
From: alok barsode <alokbarsode@gmail.com>
To: bluezprofile kernel <bluezprofile@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

On Tue, Nov 3, 2009 at 1:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bala,
>
> (lkml left out from the recipients since this is pretty obviously
> off-topic there)
>
> On Tue, Nov 03, 2009, Bala wrote:
>> I am trying to attend skype calls from bluetooth headset.
>> I am hearing the ringtone but I am not able to answer the call by
>> pressing the call button in the headset.
>>
>> Control comes to function telephony_key_press_req() in
>> audio/telephone_dummy.c [bluez 4.32] when call button in the headset
>> is pressed.
>> Any idea how to communicate this event to skype so that the call can
>> be answered?
>
> As you see from audio/headset.c the event will also emit a
> "AnswerRequested" D-Bus signal. So all you need to do is get the source
> code for skype and fix it to listen for and react to this signal. Oh wait,
> skype is closed source ;)
> However, if the rumors are true we might see an open source skype UI for
> Linux soon and then the issue could really be solved. This is btw assuming
> that skype doesn't already have some API for external call control. If it
> does, you might be able to hack together a telephony-skype.c which calls
> into this API.

This might help.
https://developer.skype.com/Docs/ApiDoc/FrontPage

>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Cheers,
Alok.
