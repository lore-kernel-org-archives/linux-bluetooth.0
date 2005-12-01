Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <438F054D.3030808@eridani.co.uk>
From: Michael McConnell <soruk@eridani.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] VOIP over Bluetooth-Bluez? Is it possible
References: <HCEOIFALKKLBLJPENPNOAEFKCAAA.khaled@ipbill.com>
In-Reply-To: <HCEOIFALKKLBLJPENPNOAEFKCAAA.khaled@ipbill.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 01 Dec 2005 14:14:37 +0000

Khaled wrote:
> Hi Michael,
> 
> How did you get IP setup over bluetooth?
> What sound configuration did you setup?
> OSS, ALSA?

pand at the linux end (I'm not in front of my system atm so can't look 
up the specifics), WinXP has built-in PAN support, which it offered me 
when I plugged in my USB BT dongle.

No OSS or ALSA in this instance (though on my Linux partition on the 
laptop ALSA is running as supplied in the kernel, but the sound is very 
choppy in Skype, even on my fixed-line connection) as I was running 
Skype under WinXP on the laptop.

> I hope this isn't off-the-topic but Im having trouble getting IP to work
> over bluetooth; SCO and ACL come into play and Ive been reading all over the
> place and perhaps am a little confused right now!

I haven't tried attaching a BT headset to my laptop yet. I use a cabled 
headset/microphone.

-- Michael

>>-----Original Message-----
>>From: bluez-users-admin@lists.sourceforge.net
>>[mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Michael
>>McConnell
>>Sent: 01 December 2005 13:41
>>To: bluez-users@lists.sourceforge.net
>>Subject: Re: [Bluez-users] VOIP over Bluetooth-Bluez? Is it possible
>>
>>
>>Mohan K wrote:
>>
>>>Hi Michael,
>>>
>>>Did u connected the 2 PC's over Bluetooth and make calls between two?
>>>If not, how could you tell that as a VOIP over Bluetooth, right?
>>>
>>>If I am anything wrong, please correct me.
>>
>>,------.                 ,---------.
>>|Laptop|<--[Bluetooth]-->|Linux box|
>>`------'                 `---------'
>>                               |
>>                               | (Internet)
>>                               |
>>                          ,-----------.
>>                          |Friend's PC|
>>                          `-----------'
>>
>>The laptop was connected to the Internet using IP over Bluetooth.
>>Over this connection, Skype was used to chat with my friend.
>>
>>Hope that clarifies.
>>
>>-- Michael
>>
>>
>>>On 12/1/05, Michael McConnell <soruk@eridani.co.uk> wrote:
>>>
>>>
>>>>Mohan K wrote:
>>>>
>>>>
>>>>>Hi All,
>>>>>
>>>>>Is it possible to integrate VOIP and Bluetooth using Bluez?
>>>>>
>>>>>Advanced thanks for your comments.
>>>>
>>>>I don't see why not.
>>>>
>>>>Indeed last night my WinXP laptop was connected via Bluetooth to my
>>>>Linux desktop running Bluez, and I was in a call with a friend over
>>>>Skype. It worked rather well.
>>>>
>>>>--
>>>>-- Michael "Soruk" McConnell
>>>>  Eridani Star System
>>>>
>>>>  MailStripper - http://mailstripper.eridani.co.uk/
>>>>  Mail Me Anywhere - http://www.mailmeanywhere.com/

-- 
-- Michael "Soruk" McConnell
    Eridani Star System

    MailStripper - http://mailstripper.eridani.co.uk/
    Mail Me Anywhere - http://www.mailmeanywhere.com/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
