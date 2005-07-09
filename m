Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42D0329D.7090500@phealy.com>
From: "Patrick W. Healy" <phealy@phealy.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: diNovo/MX900 problem with hidd
References: <42CF0E8E.4040602@phealy.com> <loom.20050709T112217-147@post.gmane.org> <42CFD081.90800@phealy.com>
In-Reply-To: <42CFD081.90800@phealy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sat, 09 Jul 2005 15:25:01 -0500

Hmm. Noticed this on boot:
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev

Interesting, anyone?

Patrick W. Healy wrote:

> You know, one thing I just realized I forgot to mention...
>
> When I do get it to pair (which I apparently can't right now), hidd 
> --show lists it as a "boot mode device" even though 
> /var/log/daemon.log shows it as a Logitech MX900.
>
> I have tried it with auth/encrypt on, although I don't think they're 
> on as of the hciconfig -a I just sent.
>
> -- 
> Patrick Healy
>
> Dick wrote:
>
>> Patrick W. Healy <phealy <at> phealy.com> writes:    
>>
>>> Greetings, everyone. I'm having some issues with getting my 
>>> bluetooth    keyboard and mouse to work, and they're getting rather 
>>> frustrating.    Perhaps someone can help me.     I have a Logitech 
>>> diNovo media desktop and the matching MX900 mouse,    which I am 
>>> attempting to pair with the internal bluetooth on my Dell    
>>> Inspiron 8500. I can get them to pair successfully, and even move 
>>> and    type, but the mouse movement is extremely jerky and useless, 
>>> while the    keyboard types erratically and quite often repeats 
>>> keystrokes.     I'm using a 2.6.12 kernel and the latest bluez in 
>>> debian unstable (hcid    2.15) along with all the bluetooth modules 
>>> compiled and ready.     I also usually receive a message saying 
>>> "Can't create HID control    channel: Invalid exchange", along with 
>>> input output errors and errors    about the file descriptor being in 
>>> a bad state. Sometimes the pin auth    system comes up, sometimes it 
>>> doesn't.     Any help? I'd be happy to provide any additional 
>>> information needed.     
>>
>>   I've got a Logitech dinovo and it works like a charm on my Dell 
>> Latitude D800,   I've had some bad experience with an external 
>> sitecom dongle (laggy mouse)     You should enable auth and encrypt 
>> in hcid.conf, or enable it manually with   hciconfig hci0 auth 
>> encrypt     If your keyboard / mouse are already associated you 
>> should move the mouse   around for a while to reconnect and keep 
>> pressing enter on the keyboard until   it connects. If that failes 
>> you should press the connect buttons and start   scanning with hidd 
>> --search. I'm using kbluepin as pin helper, so I must have a  running 
>> X server for the association. Your error messages might be related 
>> to  that (a failing pin helper).   
>> I'm really happy with my dinovo and bluez, it's way better than the  
>> apple/widcomm/microsoft bluetooth stacks and I hope this helps.
>> greetings, Dick
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by the 'Do More With Dual!' webinar 
>> happening
>> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
>> core and dual graphics technology at this free one hour event hosted 
>> by HP, AMD, and NVIDIA.  To register visit 
>> http://www.hp.com/go/dualwebinar
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>  
>>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar 
> happening
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
> core and dual graphics technology at this free one hour event hosted 
> by HP, AMD, and NVIDIA.  To register visit 
> http://www.hp.com/go/dualwebinar
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
