Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj0Yyu7Ot6xzCxTh0puAuVeV-jBuspSDMLxg_R0Y4V068zHhg@mail.gmail.com>
References: <CAMj0Yyu7Ot6xzCxTh0puAuVeV-jBuspSDMLxg_R0Y4V068zHhg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Jul 2016 11:20:11 +0300
Message-ID: <CABBYNZJnSZtmEkBb8T4urYhHw2+pqAKu77d_g3_eJ1nw=02D7A@mail.gmail.com>
Subject: Re: BT PAN Connection - NAP with PANU ?
To: Ajay Parashar <ajay.parasha@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Sat, Jul 23, 2016 at 9:39 PM, Ajay Parashar <ajay.parasha@gmail.com> wrote:
> Hi,
>
> I am using bluez 5.35 and performing one POC with NAP and PANU communication.
> I want to connect PANU with NAP, for this i executed below tasks
>
> 1) Created a bridge successfully with Ubuntu 15.10.
> 2) Executed /test/test-nap script and i can see that NAP has established.
>
> 3) I am not getting how to start PANU (client) so that it can be
> connected with NAP (as defined in above step 2) and start
> communicating each other.

How about doc/network-api.txt:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/network-api.txt

e.g: org.bluez.Network1.Connect("panu")

-- 
Luiz Augusto von Dentz
