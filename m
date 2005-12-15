Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Remote name delay
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0512150817w6fc28193xe6a09d28cf1cab7a@mail.gmail.com>
References: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
	 <e1effdeb0512020321g2b492f1cl5c553d7c3b24bfb8@mail.gmail.com>
	 <1133523028.20834.8.camel@blade>
	 <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
	 <1133548573.20834.83.camel@blade>
	 <e1effdeb0512131359x7ff7a330j435a8bde0779e958@mail.gmail.com>
	 <1134511532.24447.18.camel@blade>
	 <e1effdeb0512141035w5cc40fach9d77ead5df00cf2@mail.gmail.com>
	 <20051214215318.GA25332@localhost.localdomain>
	 <1134624339.5198.18.camel@localhost>
	 <e1effdeb0512150817w6fc28193xe6a09d28cf1cab7a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134676035.12505.26.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 15 Dec 2005 20:47:15 +0100

Hi Claudio,

> After your feedbacks, I think it's better remove the
> "GetProperty('info')" in order to avoid confusion. We can create a new
> method called "Info(void)" to retrieve read-only properties returning:
> Address: String
> Manufacturer: String
> HCI Version: String, format TBD
> LMP Version: String, format TBD
> 
> We don't need a fild to retrieve the device status. The device
> status(UP/DOWN) signal can be tracked all the time. Keep in mind that,
> for multiple adapter scenarios will be more difficult  track the
> UP/DOWN signals. Currently, it's possible recover the device status
> using the DevList, but it's little bit expensive request/parsing all
> arguments. When the adapter is DOWN, change the adapter property will
> fail(Probably due a operation timeout), for this case get the device
> status is useful. These are the reasons why I would like receive the
> status in the "Info(void)" reply message.
> 
> The final decision is yours! :) If we consider it necessary we can add
> it in the future without problems.

at the moment I don't have any favor in any direction. Implement one and
then we see how it goes.

> For Read/Write properties:
> - auth
> - connectable
> - discoverable
> - encrypt
> - name
> - inqmode

Remove "auth" and "encrypt" from this list. I am not going to support
Security Mode 3 settings over D-Bus. They are crap anyway and hopefully
at somepoint I can convince everybody that Security Mode 3 alone makes
no sense at all.

I also don't see any need for the inquiry mode setting. Since it is all
transparent, the hcid should simply set the highest available inquiry
mode on startup and then send inquiry result signals as usual.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
