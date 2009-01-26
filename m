Return-Path: <cyrus@holtmann.org>
Message-ID: <497DC12D.2090005@suse.de>
Date: Mon, 26 Jan 2009 14:57:01 +0100
From: Tom Patzig <tpatzig@suse.de>
Reply-To: tpatzig@suse.de
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: app doesn't recieve signal DeviceDisappeared
References: <49696D00.9030604@gmail.com>	 <1232292554.5095.26.camel@californication> <49739C4F.10905@gmail.com>	 <4974D9E1.7070003@suse.de> <2d5a2c100901231411y10d4a5aay45e30eca619088ed@mail.gmail.com>
In-Reply-To: <2d5a2c100901231411y10d4a5aay45e30eca619088ed@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
> It should've been fixed now. Note that you only got those signals
> while a discovery session is active (someone called
> Adapter.StartDiscovery()).
>   
Thanks a lot. Works great.
Now i just need to wait for the next bluez release, to make use of it in
KBlueLock :)

Tom
