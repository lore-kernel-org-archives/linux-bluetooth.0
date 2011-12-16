Return-Path: <cyrus@holtmann.org>
Message-ID: <4EEB342E.7030205@bmw-carit.de>
Date: Fri, 16 Dec 2011 13:06:06 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] media: assertion to check that transport exists
References: <1323952435-3244-1-git-send-email-mikel.astiz.oss@gmail.com> <CABBYNZJ9QgLPJQoudjRGZfMF5CHV5LaHUNZf8Hcojh5bjMgaTQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ9QgLPJQoudjRGZfMF5CHV5LaHUNZf8Hcojh5bjMgaTQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 12/16/2011 09:43 AM, Luiz Augusto von Dentz wrote:
> IMO assert on daemon are not that great, it may help while developing 
> but why not run with valgrind and let it crash? 

I was not that much proposing to add the assertion, but to discuss if 
that assertion should hold or not.

Basically my question is: is it guaranteed that a transport will exist 
while a gateway is connected or playing?

If yes, I think there is a bug somewhere, because those assertions do 
fail sometimes.

I was specifically asking this regarding the internal state of the 
daemon, but the same question could be formulated for the state exposed 
in D-Bus.

Regards,
Mikel

