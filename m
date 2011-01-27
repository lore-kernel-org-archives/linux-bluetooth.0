Return-Path: <cyrus@holtmann.org>
From: "Inga Stotland" <ingas@codeaurora.org>
To: "'Erin Yueh'" <erinyueh@gmail.com>
Cc: "'Brian Gix'" <bgix@codeaurora.org>,
	<linux-bluetooth@vger.kernel.org>
References: <1295654876.1774.24.camel@ubuntuLab1> <AANLkTi=gLKMvWuUeyjqGBQuWd5ztjjr10d44H4A1fFfZ@mail.gmail.com>
In-Reply-To: <AANLkTi=gLKMvWuUeyjqGBQuWd5ztjjr10d44H4A1fFfZ@mail.gmail.com>
Subject: RE: Attribute Server and Client TODOs
Date: Thu, 27 Jan 2011 11:30:02 -0800
Message-ID: <000001cbbe58$982b5fd0$c8821f70$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Erin,

> Also, one of my compatriots is telling me that she cannot get the GATT
> Client D-Bus interface to work.  I don't know if this is a simple lack
> of Introspection Data (required by d-feet), or if there is a build or
> configuration parameter that needs to be setup.  I have just been using
> the gatttool to run my tests, and not going through D-Bus.  If anybody
> has been using D-Bus for GATT Client testing, I would be interested in
> finding out if there is some setup requirements that I am missing.
>
I only modified EnableLE and AttributeServer two values in main.conf and
add --enable-attribute on building bluez. Then, it can work. I can use dbus-send
to query data. I also wrote the notes about setting up gatttool in bluez over
BR/EDR.
http://i-miss-erin.blogspot.com/2010/12/gatttool-in-bluez-over-bredr.html

> Thanks for your time.
>
>
> --
> Brian Gix
Thanks,
Erin Yueh

Thank you for your response about enabling GATT over D-Bus.
I was following the instructions from your notes. 
However, when trying to test D-Bus operations for GATT, I cannot seem to get
org.bluez.Characteristic interface to register... 
Have you been able to get GATT D-Bus interface to work just with BR/EDR (no LE)?

Thanks,

Inga Stotland

ingas@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum



