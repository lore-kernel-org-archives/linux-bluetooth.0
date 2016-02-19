Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_Documentation_f=c3=bcr_bluetooth_low_energy?=
To: linux-bluetooth@vger.kernel.org
References: <56C5938F.6070504@rie.eu>
From: =?UTF-8?Q?J=c3=bcrgen_Benjamin_Ronshausen?= <b.r@rie.eu>
Message-ID: <56C6E696.6030803@rie.eu>
Date: Fri, 19 Feb 2016 10:55:34 +0100
MIME-Version: 1.0
In-Reply-To: <56C5938F.6070504@rie.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 18.02.2016 um 10:49 schrieb Jürgen Benjamin Ronshausen:
> Hello,
>
> i am working with Bluez 4.96, kernel 3.2 on embedded ARM and i try to
> figure bluetooth low energy out.
>
> I looked at the code behind hcitool lescan. I wonder is there a
> documentation for the low energy commands?
>
> I want to know when beacons are around.
>
> My understandig is open bluetooth socket, specify scan parameters,
> enable scan, set filter for socket and then poll the socket.
>
> And if i want the signal quality i have to connect to the beacon first.
>
> Can someone point me to the docs, so i can educate myself please.
>
> Thanks
>
> Regards
>
> Benjamin
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Found it Bluetooth 4.0 core specs and so on
