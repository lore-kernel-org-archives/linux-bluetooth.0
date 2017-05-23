Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c41a61c1-73f9-3e9a-ae18-c778a7db09f9@rug.nl>
References: <c41a61c1-73f9-3e9a-ae18-c778a7db09f9@rug.nl>
From: Barry Byford <31baz66@gmail.com>
Date: Tue, 23 May 2017 20:21:47 +0100
Message-ID: <CAAu3APZXiidEnqO0XbS=+oAp0nLzxY2wFfpRFXiL=98Psw+C+Q@mail.gmail.com>
Subject: Re: How to create multiple rfcomm devices with a set name
To: "s.achterop@rug.nl" <s.achterop@rug.nl>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Sietse,

On 21 May 2017 at 15:35, s.achterop@rug.nl <s.achterop@rug.nl> wrote:
>   Dear list,
>
> I created a number of robot-vehicles that are controlled using
> bluetooth/rfcomm.
> They are all controlled via a single PC that uses different /dev/rfcommx
> devices.
>
> Earlier I used /etc/bluetooth/rfcomm.conf with lines such as:
>     rfcomm117 {bind yes; device 10:00:E8:6C:EC:98; channel 1; comment
> "dtpa_117"; }
> The name of the robot is dtpa_117, and by connecting to rfcomm117 I know I
> am talking via rfcomm to dtpa_117.
>
> Now with debian/stretch and ubuntu/16.04 (and rfcomm.conf not working
> anymore) i need something simular.
> My question is how do I create a rfcomm-device that matches the above rule.
> I only can create rfcomm0 devices.

Not sure I have all the answers to your questions. I think you need to
use Profile API.
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/profile-api.txt

There is an example in bluez/test:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-profile

I've also got an example using it with the Serial Port Profile:
https://gist.github.com/ukBaz/217875c83c2535d22a16ba38fc8f2a91

Hope that helps move you forward.

>
> My second question is how to create these devices automatically, using the
> information from the rfcomm.conf file.
> Can this be done via udev rules? Or via a systemd service?
> I already searched quite a lot in the mailing list and on the net, but now
> got more or less stuck.
>
>   Hopefully someone can give me a pointer on these two questions,
>      Thanks in advance,
>          Sietse Achterop
>          University of Groningen, The Netherlands.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
