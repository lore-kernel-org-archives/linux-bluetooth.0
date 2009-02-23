Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1235161095.24255.21.camel@californication>
References: <ac8af0be0902200541p170966b6v8bbcf89ab04e129a@mail.gmail.com>
	 <1235161095.24255.21.camel@californication>
Date: Mon, 23 Feb 2009 15:06:47 +0800
Message-ID: <ac8af0be0902222306p1e69e76fm2dc065b17133b87d@mail.gmail.com>
Subject: Re: [PATCH 1/4] add the D-Bus interface definition for HFP Audio
	gateway -- take 2 -- resend
From: Zhao Forrest <forrest.zhao@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>> +
>> +Gateway hierarchy
>> +===================
>> +
>> +Service              org.bluez
>> +Interface    org.bluez.Gateway
>> +Object path  [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>
> we might wanna call it HeadsetGateway since profiles like DUN etc. also
> have Gateway defined.

OK.
>
>> +This interface is available for remote devices which can function in the Audio
>> +Gateway role of the HFP profiles.
>> +
>> +Methods              void Connect()
>> +
>> +                     Connect to the AG service on the remote device.
>> +
>> +             void Disconnect()
>> +             boolean IsConnected()
>
> These two need to have descriptions.

OK.
>
>> +             void AnswerCall()
>> +
>> +                     It has to called only after Ring signal received.
>> +
>> +             void CancelCurrentCall()
>> +
>> +                     Cancel call which is running now. This one does nothing
>> +                     with any 3-way situation incl. RaH. Just plain old PDH.
>
> I would call that TerminateCall.

OK.
>
>> +             void Call(string number)
>> +
>> +                     Dial a number 'number'. No number processing is done
>> +                     thus if AG would reject to dial it don't blame me :)
>> +
>> +             string GetOperatorName()
>
> Missing description.

Will add it.
>
>> +             void VoiceRecognitionActivate()
>> +                     in development
>> +             void VoiceRecognitionDeactivate()
>> +                     in development
>
> Needs clear description or just leave it out. Also this looks more like
> it should be done via SetProperty().
>
>> +             string GetNumberForLastVoiceTag()
>> +
>> +                     Ask AG to provide a phone number. It looks like AG shell
>> +                     in turn ask user to choose one. Idea behind this is VR
>> +                     on the HF side.
>
> If we leave voice recognition out for now, then we should also skip
> these method.

OK.
>
>> +             void SendDTMF(string digits)
>> +
>> +                     Will send each digit in the 'digits' sequentially. Would
>> +                     send nothing if there is non-dtmf digit.
>> +
>> +             void SendMicrophoneGain(uint8 gain)
>> +             void SendSpeakerGain(uint8 gain)
>> +
>> +                     Feel them useless but really easy to implement :)
>
> If they are useless and not implemented now, leave them out. Adding API
> is easier than removing API.

OK.
>
>> +             string[] GetSubscriberNumbers()
>> +
>> +                     Get all the numbers of AG
>
> Shouldn't we use GetProperties() for this? Or does this actually end up
> in exchanging AT commands. How often does this change. Can we assume we
> only do this once and then be able to cache them?

OK. I'll use GetProperties() for this. At least according to HFP spec we can't
assume that we could do this once and cache them.
>
>> +Signals
>> +             void Connected(uint32 ag_features)
>> +
>> +                     Connection successfully esteblished. 'ag_features' are
>> +                     ORed features:
>> +                             0x001 Three-way calling
>> +                             0x002 Echo cancelling and/or noice reduction
>> +                                     function
>> +                             0x004 Voice recognition function
>> +                             0x008 In-band ring tone capability
>> +                             0x010 Attach a number to a voice tag
>> +                             0x020 Ability to reject a call
>> +                             0x040 Enhanced call status
>> +                             0x080 Enhanced call control
>> +                             0x100 Extended Error Result Cod
>
> I really don't like having the features in hex codes. Can't we use the
> same strings the actual AT command set uses.
>
> Also why do we have to have these via Connected() callback. Do they
> actually ever change. If not we can hide this nicely. What is the
> advantage of the application to see them?

OK. I'll hide them. This information is not much use to application.
>
>> +             void Disconnected()
>> +
>> +             void Ring(string number)
>> +
>> +                     Someone's calling from 'number'.
>> +                     Caller number is provided as received from AG.
>> +
>> +             void StatusUpdate(string indicator_name, uint32 indicator_value)
>> +
>> +                     Indicator 'indicator_name' changed its value to
>> +                     'indicator_value'.
>> +                     System (call, callsetup, etc.) statuses are not signalled.
>
> Turing them into properties and using PropertyChanged() looks more
> natural to me.

OK.
>
>> +             void CallCancelled()
>> +
>> +                     Call failed to set up. It means that we tried to call
>> +                     someone or someone tried to call us but call was not
>> +                     accepted.
>
> Would call that CallTerminated()
>
>> +             void CallStart()
>> +
>> +                     Call set up successfully.
>> +
>> +             void CallEnd()
>> +
>> +                     Call was started and now ended. In contrast with
>> +                     CallCancelled where call didn't started
>
> That is CallStarted() and CallEnded().
>
> Do we really need three signals to do this? Any better ideas?

I think CallTerminated(), CallStarted() and CallEnded() are needed to notify
the application of call status cahnge. One alternative way of doing this is
to change them to properties and use PropertyChanged() to notify application
of call status change. Please let me know if you have other advice.
>
>> +             void VoiceRecognitionActive()
>> +             void VoiceRecognitionInactive()
>> +                     in development
>> +
>> +             void MicrophoneGain(uint8 gain)
>> +             void SpeakerGain(uint8 gain)
>> +                     AG sent us new gain.
>
> If we don't make use of these, then there should be not present in the
> API at this moment.
>
OK.

Thanks,
Forrest
