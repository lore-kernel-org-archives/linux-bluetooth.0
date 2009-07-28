Return-Path: <cyrus@holtmann.org>
Message-ID: <4A6E523E.6000802@dtsp.co.nz>
Date: Tue, 28 Jul 2009 13:19:58 +1200
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Gnome applet failing with current BlueZ?
References: <4A6E3161.7010105@dtsp.co.nz> <1248742400.23466.11069.camel@localhost.localdomain>
In-Reply-To: <1248742400.23466.11069.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Tue, 2009-07-28 at 10:59 +1200, David Sainty wrote:
>   
>> Hi all,
>>
>> Using BlueZ 4.46 and Gnome Bluetooth 2.27.8, the applet icon fails to 
>> appear.  If I pull the USB adapter out and in the icon appears, but with 
>> a little red cross, and it isn't very functional.
>>     
>
> Is bluetoothd running?
> <snip>
>   

Yes, and otherwise functional.  For example, I'm sending this reply over 
a bluetooth GPRS connection, and at the same time can see the 
non-functional bluetooth-applet icon with the little red/white cross.

Running bluetoothd in debug mode didn't seem to display any useful 
information relating to the applet.

>> I'm not sure when this stopped working, having got suitably confused 
>> over whether to use bluez-gnome or gnome-bluetooth I've ended up using 
>> neither for some time :)  bluez-gnome doesn't work either though.
>>     
>
> I'm not sure what confusion there should be. Use gnome-bluetooth.
>   

Well that clears that up :)  But it isn't that obvious from the state of 
the various web pages.

