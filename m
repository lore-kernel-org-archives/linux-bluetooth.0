Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121113154019.GA29811@x220>
References: <1351000626-22632-1-git-send-email-s.syam@samsung.com>
	<CAFBvHifFX-8vcQciLktVhUgjN7Z-QaQmST2Jbi=gKtz96iHLvg@mail.gmail.com>
	<20121113154019.GA29811@x220>
Date: Tue, 13 Nov 2012 21:57:20 +0530
Message-ID: <CAFBvHieK5Zgb+uDHQ4LqKJjXBOmx9++=hxjGqF+8q0HQidg5qA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] audio: Fix headset NULL pointer dereference
 during AT+BLDN response
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Syam Sidhardhan <syamsidhardh@gmail.com>,
	Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Nov 13, 2012 at 9:10 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Syam,
>
> On Fri, Nov 09, 2012, Syam Sidhardhan wrote:
>> On Tue, Oct 23, 2012 at 7:27 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
>> > While waiting for the AT+BLDN asynchronous response, if RFCOMM got
>> > disconnected, then respose will cause NULL pointer dereference.
>> >
>> > During headset disconnection, the headset state changes from
>> > HEADSET_STATE_CONNECTED to HEADSET_STATE_DISCONNECTED along with
>> > freeing the dev->headset. During the response, in telephony_generic_rsp
>> > its dereferencing.
>> >
>> > Log:
>> > bluetoothd[5573]: audio/headset.c:handle_event() Received AT+BLDN
>> > bluetoothd[5573]: audio/telephony.c:telephony_last_dialed_number_req()
>> >  telephony-tizen: last dialed number request
>> > bluetoothd[5573]: audio/telephony.c:dbus_method_call_send() +
>> > bluetoothd[5573]: audio/telephony.c:dbus_method_call_send() -
>> > bluetoothd[5573]: Endpoint replied with an error: org.freedesktop.DBus\
>> >  .Error.NoReply
>> > bluetoothd[5573]: audio/telephony.c:telephony_device_disconnected()
>> >  telephony-tizen: device 0x40439b60 disconnected
>> > bluetoothd[5573]: audio/headset.c:headset_set_state() State changed
>> >  /org/bluez/5573/hci0/dev_BC_47_60_F5_88_89:
>> >  HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
>> > bluetoothd[5573]: audio/media.c:headset_state_changed()
>> > bluetoothd[5573]: audio/media.c:headset_state_changed() Clear endpoint
>> >  0x40430620
>> > bluetoothd[5573]: audio/telephony.c:telephony_dial_number_reply()
>> >  redial_reply
>> > bluetoothd[5573]: audio/telephony.c:telephony_dial_number_reply()
>> >  dial_reply reply: No Call log
>> > ---
>> >  audio/headset.c |    3 +++
>> >  1 files changed, 3 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/audio/headset.c b/audio/headset.c
>> > index bd83a65..30d24cf 100644
>> > --- a/audio/headset.c
>> > +++ b/audio/headset.c
>> > @@ -689,6 +689,9 @@ static int telephony_generic_rsp(struct audio_device *device, cme_error_t err)
>> >         struct headset *hs = device->headset;
>> >         struct headset_slc *slc = hs->slc;
>> >
>> > +       if (!slc)
>> > +               return -EIO;
>> > +
>> >         if ((err != CME_ERROR_NONE) && slc->cme_enabled)
>> >                 return headset_send(hs, "\r\n+CME ERROR: %d\r\n", err);
>> >
>>
>> ping.
>
> This file doesn't exist in bluez.git anymore.
>

 Yes,  I noticed Luiz patch which removes the headset.c and other
stuff. Thank you.

Regards,
Syam.
