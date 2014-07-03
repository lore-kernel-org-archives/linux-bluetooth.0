Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: LE mouse reconnect problem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <35F01C64-F255-433B-A07A-1AD84CA6574A@me.com>
Date: Thu, 3 Jul 2014 17:41:58 +0200
Cc: Ryan Press <ryan@presslab.us>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <9D9BAF08-F0CE-4A5A-B8E7-039DE916D93E@holtmann.org>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com> <CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com> <CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com> <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com> <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com> <CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com> <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com> <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com> <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com> <20140629051442.GA31085@t440s.P-661HNU-F1> <20140629052949.GA32130@t440s> <E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org> <CABx3TkUP3Y9nJJk=u2ghFnunQRh9x-v6PG_ncyiM+mUqaoRtWg@mail.gmail.com> <5A1EE16D-11BB-414E-B572-92FBF305B4E5@holtmann.org> <35F01C64-F255-433B-A07A-1AD84CA6574A@me.com>
To: d.eriksson@me.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> Somewhat hijacking this thread as we've been working on similar issues. 
> In the Nordic Semi HID code they by default set 5sec for the "FIRST_CONN_PARAMS_UPDATE_DELAY". As a temporary fix we just se this to 50msec to force a quicker re-connect.
> 
> We're doing our pairing using mgmt, could there be something we do wrong on our end causing the CCCDs not being stored in our nrf51822, and/or on the linux side?

try the latest bluetooth-next and bluetoothd. With the passive scanning and remembering of the connection parameters this should also be instant now. The advantage is that we start out with the correct parameters in the first place and thus the HID devices does not have to change them.

Regards

Marcel

