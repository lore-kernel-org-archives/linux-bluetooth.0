Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <429491E7.4090205@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth remote control
References: <429345A5.8080007@xmission.com> <1116954490.30044.157.camel@pegasus>
In-Reply-To: <1116954490.30044.157.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 25 May 2005 08:55:35 -0600

Guys,

I was thinking we needed a daemon that could talk to a "lot" of the 
remote-control capable devices out there. There are so many protocols:

  - avrcp (newer headsets)
  - ericsson (AT commands)
  - bemused (symbian app, java app)
  - hid (newer ericssons)

I was thinking we would need avrcp eventually for good headset support. 
Maybe the way to go is to add it to a receiver that can do one of these 
other protocols to give it broader coverage. HID could probably be 
dropped off the list of requirements as long as the older ericsson 
protocol is available on those devices.

Brad

Marcel Holtmann wrote:
> Hi Brad,
> 
> 
>>I've looked at what is out there for using a phone as a remote.
>>
>>Virtually everything requires a Sony/Ericsson. Are the Ericssons using 
>>some kind of standardized protocol for remote control that no one else 
>>has implemented or is it a proprietary thing?
>>
>>If it's well-documented, the extensible phones (symbian/java) should be 
>>able to load an app to use it (or maybe it's been done)
> 
> 
> starting with the K700i you can use HID for the remote. For the older
> ones you need a special AT command set. There are some implementation
> around, but non official that I included in BlueZ.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
