Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 3 Nov 2009 11:19:03 +0530
Message-ID: <ba5648fa0911022149y544fcfbcsd81a68a731f0604c@mail.gmail.com>
Subject: Attending skype calls from bluetooth headset
From: bluezprofile kernel <bluezprofile@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi ,

I am trying to attend skype calls from bluetooth headset.
I am hearing the ringtone but I am not able to answer the call by
pressing the call button in the headset.

Control comes to function telephony_key_press_req() in
audio/telephone_dummy.c [bluez 4.32] when call button in the headset
is pressed.
Any idea how to communicate this event to skype so that the call can
be answered?

Regards,
Bala.
