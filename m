Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>
References: <000601cffdb2$4e3e8580$eabb9080$@samsung.com>
 <CABBYNZJrH0pw5trYQu__ndOEHX8_=jT97E0fspd8=r1iPxOr6g@mail.gmail.com>
In-reply-to: <CABBYNZJrH0pw5trYQu__ndOEHX8_=jT97E0fspd8=r1iPxOr6g@mail.gmail.com>
Subject: RE: Query regarding sdptool
Date: Wed, 12 Nov 2014 18:25:23 +0530
Message-id: <001501cffe77$f6a0cb50$e3e261f0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Tuesday, November 11, 2014 8:03 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda; cpgs@samsung.com;
> Dmitry Kasatkin
> Subject: Re: Query regarding sdptool
> 
> Hi Gowtham,
> 
> On Tue, Nov 11, 2014 at 3:20 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Hi All,
> >
> > I am currently testing sdptool.
> > The issues I am facing are,
> >
> > 1) When I run ./sdptool del PBAP, I am getting the below error:
> > " No local SDP server!"
> >
> > 2) When I run ./sdptool get PBAP, I am getting the below error:
> > "Failed to connect to SDP server on FF:FF:FF:00:00:00: Connection refused"
> >
> > 3) when I run ./sdptool add PBAP, Nothing is printing, I don't know
> > whether it is added or not.
> >
> > Bluetoothd is running and hci0 is up. Is there any file/script that I
> > need to run to make Local SDP server UP?
> 
> First of all you are not suppose to interact with SDP database using sdptool,
> these commands have been deprecated long long time ago. If you want to
> test just registering and removing a record it is probably better to use
> test/test-profile. If you want to check local records with sdptool you need to
> run bluetooth with -C/--compat option and root permissions e.g. sudo
> sdptool browse local.
> 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html


Thanks for your information.
Btw I have added the MAP service implementation in sdptool (add, del, get). Just now I tested it, it's working fine for all cases.
Soon I will be sending it.

Regards,
Gowtham Anandha Babu

