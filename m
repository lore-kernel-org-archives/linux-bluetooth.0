Return-Path: <cyrus@holtmann.org>
Message-ID: <49191908.1050903@nokia.com>
Date: Tue, 11 Nov 2008 07:32:56 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>
CC: Bastien Nocera <hadess@hadess.net>,
        BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Add support for pairing a few GPS devices
References: <1224798847.2895.224.camel@cookie.hadess.net> <1225137122.7157.32.camel@californication>
In-Reply-To: <1225137122.7157.32.camel@californication>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

ext Marcel Holtmann wrote:
> Hi Bastien,
> 
>> Add support for hard-coded pincodes for a few GPS devices, one being
>> mine, the other being mentioned by Ralph Loader in
>> https://bugzilla.redhat.com/show_bug.cgi?id=464446
> 
> patch has been applied. Thanks.

I have never followed bluez-gnome developement and I might have some
gaps in knowlegde of made decisions.

Is it really intentional not to have user specified passkey as an
option? Of course there can be a list of "known pincodes" but frankly
I don't believe all the codes will be there in some point. At least
the list should be editable by the user?

-- 
Ville
