Return-Path: <cyrus@holtmann.org>
Message-ID: <53678FEF.4050104@gmail.com>
Date: Mon, 05 May 2014 15:19:43 +0200
From: Sergio Ruiz <sejoruiz@gmail.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Problems running the tests in BlueZ 5.18
References: <1399056781.24457.6.camel@SejoLaptop> <20140505073728.GA24502@t440s.lan>
In-Reply-To: <20140505073728.GA24502@t440s.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan.

On 05/05/14 09:37, Johan Hedberg wrote:
> Hi Sejo,
>
> First thing that comes to mind: have you passed --enable-experimental to
> configure when building BlueZ, and have you passed -E to bluetoothd when
> running it? At least the former is needed for the thermometer plugin
> (about the latter I'm not completely sure).
>
> Johan
First, I'd like to thank you for your answer, it solved the problems I 
was having.
The thing is that now I can only run the tests when I log in as root. 
Despite is not a big problem, I'd like to know if there is a way of 
executing the tests without having to grant root permissions (I'm 
worried about security issues on the system) Is it enough to add the 
current user to the lp group? Or maybe I need to modify the policies 
that are set in bluetooth.conf? (by the way, now I don't have a proper 
bluetooth.conf file, so I'm not sure where are those policies set now)
Finally, I'm still not able to run the proximity test. It points to the 
same problem (the interface org.bluez.ProximityMonitor1 doesn't exist) 
I'm not going to use this service, and since I haven't seen anything 
related to the test in bluetooth.conf, I have assumed that is not 
completely implemented, but still I'd like to help if some testing is 
needed.

Thank you again for your help.
