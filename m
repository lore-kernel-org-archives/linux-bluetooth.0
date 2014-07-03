Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Subject: Re: LE mouse reconnect problem
From: d.eriksson@me.com
In-reply-to: <9D9BAF08-F0CE-4A5A-B8E7-039DE916D93E@holtmann.org>
Date: Thu, 03 Jul 2014 18:40:45 +0200
Cc: Ryan Press <ryan@presslab.us>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-id: <993441F6-4EC2-4A4A-B9E0-18EE88F51ACB@me.com>
References: 
 <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com>
 <CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com>
 <CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com>
 <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com>
 <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com>
 <CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com>
 <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com>
 <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com>
 <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com>
 <20140629051442.GA31085@t440s.P-661HNU-F1> <20140629052949.GA32130@t440s>
 <E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org>
 <CABx3TkUP3Y9nJJk=u2ghFnunQRh9x-v6PG_ncyiM+mUqaoRtWg@mail.gmail.com>
 <5A1EE16D-11BB-414E-B572-92FBF305B4E5@holtmann.org>
 <35F01C64-F255-433B-A07A-1AD84CA6574A@me.com>
 <9D9BAF08-F0CE-4A5A-B8E7-039DE916D93E@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Sounds great. I really wanted the passive scan option as well. 
Would bluetooth-next work under 3.13?

Ehrm, where can I read up a bit on the plans/news for bluetooth-next and more info on the ideas of user vs kernel space?


best David

On 03 Jul 2014, at 17:41, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi David,
> 
>> Somewhat hijacking this thread as we've been working on similar issues. 
>> In the Nordic Semi HID code they by default set 5sec for the "FIRST_CONN_PARAMS_UPDATE_DELAY". As a temporary fix we just se this to 50msec to force a quicker re-connect.
>> 
>> We're doing our pairing using mgmt, could there be something we do wrong on our end causing the CCCDs not being stored in our nrf51822, and/or on the linux side?
> 
> try the latest bluetooth-next and bluetoothd. With the passive scanning and remembering of the connection parameters this should also be instant now. The advantage is that we start out with the correct parameters in the first place and thus the HID devices does not have to change them.
> 
> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
