Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ] core: Reduce RSSI delta threshold for RSSI property updates on Device1.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25SU4CMDJGukOpAzP7ZSgV3qLWBWx7+3+e7wHzX=EoL=ZA@mail.gmail.com>
Date: Tue, 30 Sep 2014 19:04:46 +0200
Cc: Szymon Janc <szymon.janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <E68A0F43-AD5C-4ED5-8724-3E43D064F5BA@holtmann.org>
References: <1412028964-5298-1-git-send-email-armansito@chromium.org> <12072518.xz8sZz3RZr@uw000953> <CAHrH25SU4CMDJGukOpAzP7ZSgV3qLWBWx7+3+e7wHzX=EoL=ZA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> I'm not sure if having this so small is good... ie those few devices I have
>> they tend to have ~4 dBm RSSI oscillation when just lying next to each other
>> on the desk.
>> 
>>>              DBG("rssi %d delta %d", rssi, delta);
>>> 
> 
> Yeah, I'm not exactly sure if 2 is the right value to use here, though
> 8 is definitely too large. I basically want to be able to detect a
> user walking away / coming back within a short distance and I saw
> variations around 4-5 dBm there. Would 4 be a better threshold?

the reason why this threshold exists in the first place is that when you show the pairing list in your basic UI that the entries not keep jumping around like crazy. When we added this code 8 dBm made sense for that. That allows that you select an entry in the devices list successfully by touch or mouse. Since sorting close by devices at the top makes more sense than doing things alphabetical.

Regards

Marcel

