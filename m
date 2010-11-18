Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101117165248.GB21729@vigoh>
References: <1289394446-14021-1-git-send-email-pavan_savoy@ti.com>
	<20101116225418.GA15101@vigoh>
	<AANLkTi=TxKKxjLdK-6Jwu9oBCiGHXJ8UxrAQH+C82wNK@mail.gmail.com>
	<AANLkTi=NH8gbW8iCKOQN0bmbL=nqewsZkUik+VkvWUgi@mail.gmail.com>
	<20101117165248.GB21729@vigoh>
Date: Thu, 18 Nov 2010 10:48:50 +0530
Message-ID: <AANLkTi=W1+ZFSDLDyt_+4NMbaaJikr25NkPtT9iYDv_H@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@sify.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Vitaly Wool <vitalywool@gmail.com>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 17, 2010 at 10:22 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Pavan,
>
> * Pavan Savoy <pavan_savoy@sify.com> [2010-11-17 11:13:26 +0530]:
>
>> On Wed, Nov 17, 2010 at 4:50 AM, Vitaly Wool <vitalywool@gmail.com> wrot=
e:
>> >>> + =C2=A0 =C2=A0 /* Registration with ST layer is successful,
>> >>> + =C2=A0 =C2=A0 =C2=A0* hardware is ready to accept commands from HC=
I core.
>> >>> + =C2=A0 =C2=A0 =C2=A0*/
>> >>> + =C2=A0 =C2=A0 if (test_and_set_bit(HCI_RUNNING, &hdev->flags)) {
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bit(HCI_RUNNING, &=
hdev->flags);
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D st_unregister(ST=
_BT);
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 BT_ERR("st_unregister() failed with error %d", err);
>> >>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst->st_write =3D NULL;
>> >>> + =C2=A0 =C2=A0 }
>> >>
>> >>
>> >> What are you trying to do here? test_and_set_bit() result doesn't say
>> >> nothing about error and you shall put test_and_set_bit should be in t=
he
>> >> beginning, to know if your device is already opened or not and then
>> >> clear_bit if some error ocurrs during the function.
>> >>
>> >
>> > Yeap, this piece of code beats me is well. Why is it an error if this
>> > bit wasn't already set?
>>
>> Vitaly, Gustavo,
>>
>> I suppose I never understood HCI_RUNNING flag that way, as in an error
>> check mechanism to avoid multiple hci0 ups.
>>
>> What I understood was that HCI_RUNNING suggested as to when hci0 was
>> ready to be used. With this understanding, I wanted to make sure I
>> downloaded the firmware for the chip before I proclaim to the world
>> that the hci0 is ready to be used, as in HCI_RUNNING.
>>
>> For example, I didn't want my _send_frame to be called before I did
>> the firmware download - since firmware download takes time - 45kb
>> send/wait commands :(
>>
>> But I suppose I now understand - What I would rather do is test_bit in
>> the beginning of function and do a set_bit at the end of function -
>> does this make sense ?
>
> It does, but does it as test_and_set and then clear if error as we do in
> other drivers.

Ok, I understand, will do it this way.
However, still I am not too convinced - I honestly don't want to set
HCI_RUNNING before firmware download required for WiLink happens - and
this happens inside the st_register function here.

So the question again, How can I ensure _send_frame is not called when
firmware download is in progress - one of the major reasons why I
delayed the setting of HCI_RUNNING.

As mentioned before I will go ahead and create the patch - But would
still like to have an answer to this.


> Gustavo F. Padovan
> http://profusion.mobi
>
