Return-Path: <cyrus@holtmann.org>
Message-ID: <492EBFC5.4090209@koala.ie>
Date: Thu, 27 Nov 2008 15:41:57 +0000
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (help requested)
References: <492E6E6A.80509@koala.ie>  <492E7D86.8030007@powercraft.nl>	 <1227784243.27994.1770.camel@cookie.hadess.net>	 <492E81B1.5020709@powercraft.nl> <1227785410.27994.1792.camel@cookie.hadess.net>
In-Reply-To: <1227785410.27994.1792.camel@cookie.hadess.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> It's working, it can talk to the computer and generates input layer
> events. Everything on top is minor niggles, and integration. And that
> doesn't just happen out of thin air.
>   
i am running code from git which i fetched yesterday
so i have all the patches i believe

what do i have to do the generate input events?
i'm running bluetoothd. do i need to run hid2hci and if so, should the 
option be -0 or -1?

i have bluez-gnome installed. is there any documentation to tell me how 
to run them?
when i run bluetooth-wizard the list of devices is empty


evtest shows no events being generated

i only get an entry in /dev/input/ when i go hidd --search
is there some other way of doing that?


thanks in advance
--
simon
