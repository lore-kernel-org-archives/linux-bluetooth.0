Return-Path: <cyrus@holtmann.org>
From: "Caleb Reinhold" <creinhold@lampreynetworks.com>
To: "'Anderson Lizardo'" <anderson.lizardo@openbossa.org>
Cc: "'BlueZ development'" <linux-bluetooth@vger.kernel.org>
References: <000201cf21ed$d18f02d0$74ad0870$@lampreynetworks.com>	<CAJdJm_PEQEmCz1owo8MZ+29R-O5u8qm8x85WgeuKy9U1x74zGw@mail.gmail.com>	<000001cf238d$a774e310$f65ea930$@lampreynetworks.com> <CAJdJm_OeMUO5Qj3Amg7ADtkJRsRBpoixD2MEBBWHUA3V1M1OqA@mail.gmail.com>
In-Reply-To: <CAJdJm_OeMUO5Qj3Amg7ADtkJRsRBpoixD2MEBBWHUA3V1M1OqA@mail.gmail.com>
Subject: RE: possible bug in blueZ 5.8 gatt tool or library
Date: Fri, 7 Feb 2014 18:34:18 -0500
Message-ID: <000601cf245d$26769da0$7363d8e0$@lampreynetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>If I remember correctly, the issue is in the kernel: if connect() is called
when security level is medium, 
>the socket only gets POLLOUT once SMP pairing finishes, and any ATT PDU
received during that time is lost.

This is useful and interesting to know.

>Note that it's almost certain that your device is sending the indication
without requiring encryption. 
>Otherwise, it would have sent a Security Request (which triggers a Pairing
Request from the Linux side) 
>and wait for the encryption to be enabled before sending the indication. If
that was the case, 
>the kernel would deliver the ATT PDU to gatttool after encryption is
enabled and it would work as expected.

It seems our device is indeed sending the indication without requiring
encryption. The suggestion of updating the central device to start with low
security and then change to medium security is producing the desired
behavior. Thank you for your time and assistance.

Regards,

Caleb Reinhold

